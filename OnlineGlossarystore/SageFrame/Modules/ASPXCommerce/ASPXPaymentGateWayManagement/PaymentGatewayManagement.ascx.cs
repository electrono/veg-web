/*
AspxCommerce® - http://www.aspxcommerce.com
Copyright (c) 20011-2012 by AspxCommerce
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using ASPXCommerce.Core;
using System.Xml;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Web.UI.HtmlControls;
using System.Data;
using iTextSharp.text.factories;

public partial class Modules_PaymentGatewayManagement_PaymentGatewayManagement : BaseAdministrationUserControl
{
    PaymentGatewayInstaller installhelp = new PaymentGatewayInstaller();
    PaymentGateWayModuleInfo paymentModule = new PaymentGateWayModuleInfo();
    string Exceptions = string.Empty;
    public int storeID, portalID;
    public string userName, cultureName;
    public int errorCode = 0;

    protected void page_init(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalServicePath", " var aspxservicePath='" + ResolveUrl("~/") + "Modules/ASPXCommerce/ASPXCommerceServices/" + "';", true);
            
            lblRepairInstallHelp.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "WarningMessageWillDeleteAllFiles");
            chkRepairInstall.Checked = true;
            //chkRepairInstall.Enabled = false;
            pnlRepair.Visible = true;

            InitializeJS();
            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/PopUp/style.css");
            foreach (string css in cssList)
            {
                strTemplatePath = css;
                IncludeCssFile(strTemplatePath);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            storeID = GetStoreID;
            portalID = GetPortalID;
            userName = GetUsername;
            cultureName = GetCurrentCultureName;
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
    }

    #region Install New GateWay
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        try
        {
            ArrayList arrColl = installhelp.Step0CheckLogic(fuPGModule);
            int ReturnValue;
            if (arrColl != null && arrColl.Count > 0)
            {
                ReturnValue = (int)arrColl[0];
                paymentModule = (PaymentGateWayModuleInfo)arrColl[1];
                ViewState["PaymentGateway"] = paymentModule.PaymentGatewayTypeID.ToString();
                if (ReturnValue == 0)
                {
                    // ViewState["PaymentGateway"] = null;
                    ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "YouNeedToSelectAFileToUploadFirst"), "", SageMessageType.Alert);
                    lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "YouNeedToSelectAFileToUploadFirst");
                    lblLoadMessage.Visible = true;
                    errorCode = 1;
                    return;
                }
                else if (ReturnValue == -1)
                {
                    // ViewState["PaymentGateway"] = null;
                    ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "InvalidFileExtension") + this.fuPGModule.FileName, "", SageMessageType.Alert);
                    lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "InvalidFileExtension") + this.fuPGModule.FileName;
                    lblLoadMessage.Visible = true;
                    errorCode = 1;
                    return;
                }
                else if (ReturnValue == 1)
                {
                    //paymentModule = (PaymentGateWayModuleInfo)ViewState["PaymentGateway"];
                    //if (paymentModule != null)
                    //{
                    installhelp.InstallPackage(paymentModule, 0);
                    ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "PaymentGatewayInstalledSuccessfully"), "", SageMessageType.Success);
                    errorCode = 0;
                    return;
                    //}
                }
                else if (ReturnValue == 2)
                {
                    if (chkRepairInstall.Checked == true)
                    {
                        //paymentModule = (PaymentGateWayModuleInfo)ViewState["PaymentGateway"];
                        int gatewayID = int.Parse(ViewState["PaymentGateway"].ToString());
                        if (paymentModule != null)
                        {
                            UninstallPaymentGateway(paymentModule, true, gatewayID);
                            ViewState["PaymentGateway"] = null;
                            ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "PaymentGatewayInstalledSuccessfully"), "", SageMessageType.Success);
                            errorCode = 0;
                            return;
                        }
                    }
                    else
                    {
                        //ViewState["PaymentGateway"] = null;                    
                        ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "AlreadyExistPaymentGateway"), "", SageMessageType.Alert);
                        lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "AlreadyExistPaymentGateway");
                        lblLoadMessage.Visible = true;
                        errorCode = 1;
                        return;
                    }
                }
                else if (ReturnValue == 3)
                {
                    // ViewState["PaymentGateway"] = null;
                    ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThisPackageIsNotValid"), "", SageMessageType.Alert);
                    lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThisPackageIsNotValid");
                    lblLoadMessage.Visible = true;
                    errorCode = 1;
                    return;
                }
                else if (ReturnValue == 4)
                {
                    // ViewState["PaymentGateway"] = null;
                    ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThisPackageDoesNotAppearToBeValid"), "", SageMessageType.Alert);
                    lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThisPackageDoesNotAppearToBeValid");
                    lblLoadMessage.Visible = true;
                    errorCode = 1;
                    return;
                }
                else
                {
                    // ViewState["PaymentGateway"] = null;
                    ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThereIsErrorWhileInstallingThisModule"), "", SageMessageType.Error);
                    lblLoadMessage.Text = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "ThereIsErrorWhileInstallingThisModule");
                    lblLoadMessage.Visible = true;
                    errorCode = 1;
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    #endregion

    #region Uninstall Existing Payment Gateway

    private void UninstallPaymentGateway(PaymentGateWayModuleInfo paymentGateWay, bool deleteModuleFolder, int gatewayID)
    {
        PaymentGatewayInstaller installerClass = new PaymentGatewayInstaller();
        string path = HttpContext.Current.Server.MapPath("~/");

        //checked if directory exist for current Payment Gateway foldername
        string paymentGatewayFolderPath = paymentGateWay.InstalledFolderPath;
        if (!string.IsNullOrEmpty(paymentGatewayFolderPath))
        {
            if (Directory.Exists(paymentGatewayFolderPath))
            {
                //check for valid .sfe file exist or not
                XmlDocument doc = new XmlDocument();
                doc.Load(paymentGatewayFolderPath + '\\' + paymentGateWay.ManifestFile);

                try
                {
                    if (paymentGateWay.PaymentGatewayTypeID > 0)
                    {
                        //Run script  
                        ReadUninstallScriptAndDLLFiles(doc, paymentGatewayFolderPath, installerClass);
                        //Rollback PaymentGatewayTypeID
                        //installerClass.PaymentGatewayRollBack(paymentGateWay.PaymentGatewayTypeID, GetPortalID, GetStoreID);
                        if (deleteModuleFolder == true)
                        {
                            //Delete Payment GateWay's Original Folder
                            installerClass.DeleteTempDirectory(paymentGateWay.InstalledFolderPath);
                        }
                        installhelp.InstallPackage(paymentModule, gatewayID);
                    }
                }
                catch (Exception ex)
                {
                    Exceptions = ex.Message;
                }
            }
            else
            {
                ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/ASPXCommerce/ASPXPaymentGateWayManagement/ModuleLocalText", "PaymentGatewayFolderDoesnotExist"), "", SageMessageType.Error);
            }
        }
    }

    private void ReadUninstallScriptAndDLLFiles(XmlDocument doc, string paymentGatewayFolderPath, PaymentGatewayInstaller installerClass)
    {
        XmlElement root = doc.DocumentElement;
        if (!String.IsNullOrEmpty(root.ToString()))
        {
            ArrayList dllFiles = new ArrayList();
            string _unistallScriptFile = string.Empty;
            XmlNodeList xnFileList = doc.SelectNodes("sageframe/folders/folder/files/file");
            if (xnFileList.Count != 0)
            {
                foreach (XmlNode xn in xnFileList)
                {
                    string _fileName = xn["name"].InnerXml;
                    try
                    {
                        #region CheckAlldllFiles
                        if (!String.IsNullOrEmpty(_fileName) && _fileName.Contains(".dll"))
                        {
                            dllFiles.Add(_fileName);
                        }
                        #endregion
                        #region ReadUninstall SQL FileName
                        if (!String.IsNullOrEmpty(_fileName) && _fileName.Contains("Uninstall.SqlDataProvider"))
                        {
                            _unistallScriptFile = _fileName;
                        }
                        #endregion
                    }
                    catch (Exception ex)
                    {
                        Exceptions = ex.Message;
                    }
                }
                if (_unistallScriptFile != "")
                {
                    RunUninstallScript(_unistallScriptFile, paymentGatewayFolderPath, installerClass);
                }
                DeleteAllDllsFromBin(dllFiles, paymentGatewayFolderPath);
            }
        }
    }

    private void RunUninstallScript(string _unistallScriptFile, string paymentGatewayFolderPath, PaymentGatewayInstaller installerClass)
    {
        Exceptions = installerClass.ReadSQLFile(paymentGatewayFolderPath, _unistallScriptFile);
    }

    private void DeleteAllDllsFromBin(ArrayList dllFiles, string paymentGatewayFolderPath)
    {
        try
        {
            string path = HttpContext.Current.Server.MapPath("~/");

            foreach (string dll in dllFiles)
            {
                string targetdllPath = path + SageFrame.Core.RegisterModule.Common.DLLTargetPath + '\\' + dll;
                FileInfo imgInfo = new FileInfo(targetdllPath);
                if (imgInfo != null)
                {
                    imgInfo.Delete();
                }
            }
        }
        catch (Exception ex)
        {
            Exceptions = ex.Message;
        }
    }

    #endregion

    protected void btnSavePDFForm2_Click(object sender, EventArgs e)
    {
        try
        {
            string tableContent = HdnValue.Value;

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + "MyReport_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".pdf");

            Document doc = new Document(iTextSharp.text.PageSize.A4, 40, 10f, 42, 10);// new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
            // pdfPage page = new pdfPage();
            PdfWriter writer = PdfWriter.GetInstance(doc, Response.OutputStream);
            //writer.PageEvent = page;
            doc.Open();

            //--- start of header----
            // Paragraph pa = new Paragraph("Invoice");
            PdfPTable headerTbl = new PdfPTable(2);
            headerTbl.SetWidths(new int[2] { 10, 15 });
            //headerTbl.DefaultCell.Border = Rectangle.NO_BORDER;
            headerTbl.TotalWidth = doc.PageSize.Width;
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(Request.MapPath("~/Templates/" + TemplateName + "/images/aspxcommerce.png"));
            logo.ScalePercent(50f);
            PdfPCell cellH = new PdfPCell(logo);
            cellH.AddElement(logo);
            cellH.HorizontalAlignment = Element.ALIGN_LEFT;
            cellH.PaddingLeft = 40;
            // cellH.Width = 10;
            cellH.Border = Rectangle.NO_BORDER;
            cellH.Border = Rectangle.BOTTOM_BORDER;
            headerTbl.AddCell(cellH);

            //--for second cell ----------
            Paragraph pa = new Paragraph("Invoice", FontFactory.GetFont(FontFactory.TIMES_ROMAN, 16, Font.BOLD, new BaseColor(0, 0, 255)));
            PdfPCell cell2 = new PdfPCell(pa);
            pa.Alignment = Element.ALIGN_BOTTOM;
            cell2.AddElement(pa);
            //cell2.HorizontalAlignment = Element.ALIGN_BASELINE;

            cell2.Border = Rectangle.NO_BORDER;
            cell2.Border = Rectangle.BOTTOM_BORDER;
            headerTbl.AddCell(cell2);


            headerTbl.WriteSelectedRows(0, -1, 0, (doc.PageSize.Height - 10), writer.DirectContent);

            //---end of header

            // -- portion for footer--------
            PdfPTable footerTbl = new PdfPTable(1);
            footerTbl.TotalWidth = doc.PageSize.Width;
            footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;
            Paragraph para = new Paragraph("ASPXCommerce CopyRight 2011", FontFactory.GetFont(FontFactory.TIMES_ROMAN, 9, Font.NORMAL, new BaseColor(0, 0, 255)));
            PdfPCell cell = new PdfPCell(para);
            cell = new PdfPCell(para);
            cell.HorizontalAlignment = Element.ALIGN_CENTER;
            cell.Border = Rectangle.NO_BORDER;
            cell.PaddingRight = 15;
            footerTbl.AddCell(cell);
            footerTbl.WriteSelectedRows(0, -1, 0, (doc.BottomMargin + 20), writer.DirectContent);
            //---- end of footer ------------


            //iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(Request.MapPath("Templates/ASPXCommerce/images/aspxcommerce.png"));
            //logo.Alignment = iTextSharp.text.Image.ALIGN_TOP;
            //logo.ScalePercent(50f);
            //doc.Add(logo);

            // iTextSharp.text.html.simpleparser.StyleSheet styles = new iTextSharp.text.html.simpleparser.StyleSheet();
            iTextSharp.text.html.simpleparser.HTMLWorker hw = new iTextSharp.text.html.simpleparser.HTMLWorker(doc);
            hw.Parse(new StringReader(tableContent));

            doc.Close();
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}
