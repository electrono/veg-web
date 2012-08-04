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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Data;
using iTextSharp.text.factories;



public partial class Modules_ASPXInvoiceManagement_InvoiceManagement : BaseAdministrationUserControl
{
    public int storeID, portalID;
    public string userName, cultureName;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                userName = GetUsername;
                cultureName = GetCurrentCultureName;
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
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

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("csv", ResolveUrl("~/js/ExportToCSV/table2CSV.js"));
        Page.ClientScript.RegisterClientScriptInclude("currency", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency-1.4.0.js"));
        Page.ClientScript.RegisterClientScriptInclude("currencyall", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency.all.js"));

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string table = HdnValue.Value;
            ExportToExcel(ref table, "MyReport_Invoice");
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    public void ExportToExcel(ref string table, string fileName)
    {
        table = table.Replace("&gt;", ">");
        table = table.Replace("&lt;", "<");
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
        HttpContext.Current.Response.ContentType = "application/xls";
        HttpContext.Current.Response.Write(table);
        HttpContext.Current.Response.End();
    }

    protected void btnSavePdf_Click(object sender, EventArgs e)
    {
        try
        {
            string table = HdnValue.Value;
            SaveToPDF(ref table, "MyReport_Invoice");
            // ExportDataToPDFTable();
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    public void SaveToPDF(ref string table, string fileName)
    {
        table = table.Replace("&gt;", ">");
        table = table.Replace("&lt;", "<");
        table = table.Replace("<table>", "");
        table = table.Replace("</tr></table>", "");
        table = table.Replace("<tr><th>", "");
        //table = table.Replace("</th><th>","#");
        table = table.Replace("</th></tr>", "#");
        table = table.Replace("<tr><td>", "");
        table = table.Replace("</td></tr>", "#");
        string[] data = table.Split('#');

        string[] columns = data[0].Replace("</th><th>", "#").Split('#');

        Document doc = new Document(iTextSharp.text.PageSize.A4, 10f, 10f, 10f, 0f);// new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
        try
        {
            
              Response.ContentType = "application/pdf";
              Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".pdf");
             

              string pdfFilePath = "c:\\pdf\\" + fileName + '_' + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".pdf";
              PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream(pdfFilePath, FileMode.Create));

             PdfWriter writer = PdfWriter.GetInstance(doc, Response.OutputStream);
           //  Phrase phrase = new iTextSharp.text.Phrase(DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss") + " GMT");
            
            doc.Open();//Open Document to write
            Font font8 = FontFactory.GetFont("ARIAL", 7);

            Paragraph paragraph = new Paragraph("Invoice Detail");
            Paragraph p = new Paragraph("Invoice Detail", FontFactory.GetFont(FontFactory.HELVETICA, 16, Font.BOLDITALIC, new BaseColor(0, 0, 255)));
            p.Alignment = Element.ALIGN_CENTER;

            PdfPTable PdfTable = new PdfPTable(columns.Length);
            PdfPCell PdfPCell = new PdfPCell();
           
            Font mainFont2 = new Font(Font.FontFamily.TIMES_ROMAN, 9);
            Font mainFont = FontFactory.GetFont(FontFactory.TIMES_ROMAN, 10, Font.BOLD, BaseColor.BLACK);

            for (int i = 0; i < columns.Length; i++)
            {
                PdfPCell = new PdfPCell(new Phrase(new Chunk(columns[i], mainFont)));
                PdfPCell.BackgroundColor = new BaseColor(204, 204, 204);
                PdfPCell.FixedHeight = 15.0f;
                PdfPCell.HorizontalAlignment = Element.ALIGN_LEFT;
                PdfPCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                PdfPCell.Border = Rectangle.NO_BORDER;
                PdfTable.AddCell(PdfPCell);

            }
            for (int rows = 1; rows < data.Length - 1; rows++)
            {
                ArrayList field = new ArrayList();
                string[] values = data[rows].Replace("</td><td>", "#").Split('#');
                field.Add(values);

                for (int column = 0; column < columns.Length; column++)
                {
                    PdfPCell = new PdfPCell(new Phrase(new Chunk(values[column].ToString(), mainFont2)));
                    PdfPCell.HorizontalAlignment = Element.ALIGN_LEFT;
                    PdfPCell.VerticalAlignment = Element.ALIGN_MIDDLE;
                    PdfPCell.Border = Rectangle.NO_BORDER;
                    PdfTable.AddCell(PdfPCell);
                }
            }
            PdfTable.SpacingBefore = 15f;
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(Request.MapPath("~/Templates/" + TemplateName + "/images/aspxcommerce.png"));

            logo.Alignment = iTextSharp.text.Image.ALIGN_LEFT;
            logo.ScalePercent(50f);
            doc.Add(logo);

            //doc.Add(paragraph);
            doc.Add(p);
            doc.Add(PdfTable); // add pdf table to the document
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            //Close document and writer
            doc.Close();

        }
    }
    

    protected void btnSavePDFForm2_Click(object sender, EventArgs e)
    {
        string tableContent = HdnValue.Value;

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=" + "MyReport_Invoice_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".pdf");

        Document doc = new Document(iTextSharp.text.PageSize.A4, 40, 10f, 42, 10);// new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
       // pdfPage page = new pdfPage();
        PdfWriter writer = PdfWriter.GetInstance(doc,Response.OutputStream);
        //writer.PageEvent = page;
        doc.Open();

        //--- start of header----
       // Paragraph pa = new Paragraph("Invoice");
        PdfPTable headerTbl = new PdfPTable(2);
        headerTbl.SetWidths(new int[2]{10,15});
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
        // cellH.Border = Rectangle.BOTTOM_BORDER;// for underline below logo
        headerTbl.AddCell(cellH);

        //--for second cell ----------
        Paragraph pa = new Paragraph("Invoice", FontFactory.GetFont(FontFactory.TIMES_ROMAN, 16, Font.BOLD, new BaseColor(0, 0, 255)));     
        PdfPCell cell2 = new PdfPCell(pa);
        pa.Alignment = Element.ALIGN_BOTTOM;
        cell2.AddElement(pa);
        //cell2.HorizontalAlignment = Element.ALIGN_BASELINE;
        
        cell2.Border = Rectangle.NO_BORDER;
       // cell2.Border = Rectangle.BOTTOM_BORDER;// for underline below logo
        headerTbl.AddCell(cell2);    
        

        headerTbl.WriteSelectedRows(0, -1, 0, (doc.PageSize.Height - 10), writer.DirectContent);

        //---end of header

        // -- portion for footer--------
        PdfPTable footerTbl = new PdfPTable(1);
        footerTbl.TotalWidth = doc.PageSize.Width;
        footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;
        Paragraph para = new Paragraph("AspxCommerce Copyright © 2011", FontFactory.GetFont(FontFactory.TIMES_ROMAN, 9, Font.NORMAL, new BaseColor(0, 0, 255)));
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
}
