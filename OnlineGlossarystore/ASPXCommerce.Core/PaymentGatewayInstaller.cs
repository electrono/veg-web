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
using System.Text;
using SageFrame.Web;
using System.Web;
using System.IO;
using RegisterModule;
using System.Collections;
using System.Xml;
using System.Data;
using SageFrame.Web.Utilities;
using System.Web.UI.WebControls;
using SageFrame.ModuleControls;
using System.Data.SqlClient;

namespace ASPXCommerce.Core
{

    public class PaymentGatewayInstaller : BaseAdministrationUserControl
    {
        string Exceptions = string.Empty;
        SQLHandler sq = new SQLHandler();
        PaymentGateWayModuleInfo module = new PaymentGateWayModuleInfo();
       // int update = 0;
        public enum ControlType
        {
            View = 1,
            Edit = 2,
            Setting = 3
        }
        public PaymentGatewayInstaller()
        {

        }
        public ArrayList Step0CheckLogic(FileUpload fileModule)
        {
            //PaymentGateWayModuleInfo module = new PaymentGateWayModuleInfo();
            
            int ReturnValue = 0;
            try
            {
                if (fileModule.HasFile)//check for Empty entry
                {
                    if (IsVAlidZipContentType(fileModule.FileName))//Check if valid Zip file submitted
                    {
                        string path = HttpContext.Current.Server.MapPath("~/");
                        string temPath = SageFrame.Core.RegisterModule.Common.TemporaryFolder;
                        string destPath = Path.Combine(path, temPath);
                        if (!Directory.Exists(destPath))
                            Directory.CreateDirectory(destPath);

                        string filePath = destPath + "\\" + fileModule.FileName;
                        fileModule.SaveAs(filePath);
                        string ExtractedPath = string.Empty;
                        ZipUtil.UnZipFiles(filePath, destPath, ref ExtractedPath, SageFrame.Core.RegisterModule.Common.Password, SageFrame.Core.RegisterModule.Common.RemoveZipFile);
                        module.TempFolderPath = ExtractedPath;
                        fileModule.FileContent.Dispose();
                        if (!string.IsNullOrEmpty(module.TempFolderPath) && Directory.Exists(module.TempFolderPath))
                        {
                            switch (Step1CheckLogic(module.TempFolderPath, module))
                            {
                                case 0://No manifest file
                                    DeleteTempDirectory(module.TempFolderPath);
                                    ReturnValue = 3;
                                    break;
                                case -1://Invalid Manifest file
                                    DeleteTempDirectory(module.TempFolderPath);
                                    ReturnValue = 4;
                                    break;
                                case 1://Already exist
                                    ReturnValue = 2;
                                    break;
                                case 2://Fresh Installation
                                    ReturnValue = 1;
                                    break;
                            }
                        }
                        else
                        {
                            ReturnValue = 0;
                        }
                    }
                    else
                    {
                        ReturnValue = -1;//"Invalid Zip file submited to upload!";
                    }
                }
                else
                {
                    ReturnValue = 0;// "No package file is submited to upload!";
                }
            }
            catch
            {
                ReturnValue = -1;
            }
            ArrayList arrColl = new ArrayList();
            arrColl.Add(ReturnValue);
            arrColl.Add(module);
            return arrColl;
        }

        public bool checkValidManifestFile(XmlElement root, PaymentGateWayModuleInfo module)
        {
            if (root.Name == "sageframe")//need to change the root node for valid manifest file at root node  
            {
                string PackageType = root.GetAttribute("type"); //root.NodeType
                //module.PackageType = PackageType;
                switch (PackageType.ToLower())
                {
                    //need to check for many cases for like skin /..
                    case "paymentgateway":
                        return true;
                }
            }
            return false;
        }

        public bool IsModuleExist(string moduleName,string folderName,string friendlyName,int storeID,int portalID)
        {
            try
            {
                SqlConnection SQLConn = new SqlConnection(SystemSetting.SageFrameConnectionString);
                SqlCommand SQLCmd = new SqlCommand();
                SqlDataAdapter SQLAdapter = new SqlDataAdapter();
                DataSet SQLds = new DataSet();
                SQLCmd.Connection = SQLConn;
                SQLCmd.CommandText = "[dbo].[usp_ASPX_CheckPaymentGatewayTypeName]";
                SQLCmd.CommandType = CommandType.StoredProcedure;              
                SQLCmd.Parameters.AddWithValue("@PaymentGatewayTypeName", moduleName);
                SQLCmd.Parameters.AddWithValue("@FolderName", folderName);
                SQLCmd.Parameters.AddWithValue("@FriendlyName", friendlyName);
                SQLCmd.Parameters.AddWithValue("@StoreID", storeID);
                SQLCmd.Parameters.AddWithValue("@PortalID", portalID);
                SQLAdapter.SelectCommand = SQLCmd;
                SQLConn.Open();
                SqlDataReader dr = null;
                
                dr = SQLCmd.ExecuteReader();
             
               
                if (dr.Read())
                {
                    module.PaymentGatewayTypeID =int.Parse(dr["PaymentGatewayTypeID"].ToString());
                    return true;
                  

                }
                else
                {
                    return false;
                }
            }
            catch (Exception e)
            {
                throw e;
            }

        }


        public int Step1CheckLogic(string TempUnzippedPath, PaymentGateWayModuleInfo module)
        {
            if (checkFormanifestFile(TempUnzippedPath, module) != "")
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(TempUnzippedPath + '\\' + module.ManifestFile);
                XmlElement root = doc.DocumentElement;
                if (checkValidManifestFile(root, module))
                {
                    XmlNodeList xnList = doc.SelectNodes("sageframe/folders/folder");
                    foreach (XmlNode xn in xnList)
                    {
                        module.PaymentGatewayTypeName = xn["paymentgatewayname"].InnerXml.ToString();
                        module.FolderName = xn["foldername"].InnerXml.ToString();
                        module.FriendlyName = xn["friendlyname"].InnerXml.ToString();   
                        module.Description = xn["description"].InnerXml.ToString();  
                        module.Version = xn["version"].InnerXml.ToString();  
                        module.Name = xn["name"].InnerXml.ToString();
                        module.StoreID = GetStoreID;//int.Parse(xn["storeid"].InnerXml.ToString());
                        module.PortalID = GetPortalID;//int.Parse(xn["portalid"].InnerXml.ToString());
                        module.CultureName = xn["culturename"].InnerXml.ToString();

                        if (!String.IsNullOrEmpty(module.PaymentGatewayTypeName) && IsModuleExist(module.PaymentGatewayTypeName.ToLower(), module.FolderName.ToString(), module.FriendlyName.ToString(),int.Parse(GetStoreID.ToString()),int.Parse(GetPortalID.ToString())))
                        {
                            string path = HttpContext.Current.Server.MapPath("~/");
                            string targetPath = path + SageFrame.Core.RegisterModule.Common.ModuleFolder + '\\' + module.FolderName;
                            module.InstalledFolderPath = targetPath;
                           // DeleteTempDirectory(TempUnzippedPath);
                            return 1;//Already exist
                        }
                        else
                        {
                            return 2;//Not Exists
                        }
                    }
                }
                else
                {
                    return -1;//Invalid Manifest file
                }
            }
            return 0;//No manifest file
        }

        public string checkFormanifestFile(string TempUnzippedPath, PaymentGateWayModuleInfo module)
        {
            DirectoryInfo dir = new DirectoryInfo(TempUnzippedPath);
            foreach (FileInfo f in dir.GetFiles("*.*"))
            {
                if (f.Extension.ToLower() == ".sfe")
                {
                    module.ManifestFile = f.Name;
                    return module.ManifestFile;
                }
                else
                {
                    module.ManifestFile = "";
                }
            }
            return module.ManifestFile;
        }
       

        private bool IsVAlidZipContentType(string p)
        {
            // extract and store the file extension into another variable
            String fileExtension = p.Substring(p.Length - 3, 3);
            // array of allowed file type extensions
            string[] validFileExtensions = { "zip" };
            var flag = false;
            // loop over the valid file extensions to compare them with uploaded file
            for (var index = 0; index < validFileExtensions.Length; index++)
            {
                if (fileExtension.ToLower() == validFileExtensions[index].ToString().ToLower())
                {
                    flag = true;
                }
            }
            return flag;
        }

        private int checkControlType(string _controlType)
        {
            int returnValue = 0;
            switch (_controlType)
            {
                case "View":
                    returnValue = (int)ControlType.View;
                    break;
                case "Edit":
                    returnValue = (int)ControlType.Edit;
                    break;
                case "Setting":
                    returnValue = (int)ControlType.Setting;
                    break;
                default:
                    returnValue = 0;
                    break;
            }
            return returnValue;
        }

        public void PaymentGatewayRollBack(int PaymentGatewayTypeID, int PortalID, int StoreID)
        {
            try
            {
                SqlConnection SQLConn = new SqlConnection(SystemSetting.SageFrameConnectionString);
                SqlCommand SQLCmd = new SqlCommand();
                SQLCmd.Connection = SQLConn;
                SQLCmd.CommandText = "dbo.sp_PaymentGatewayRollBack";
                SQLCmd.CommandType = CommandType.StoredProcedure;
                SQLCmd.Parameters.Add(new SqlParameter("@PaymentGatewayTypeID", PaymentGatewayTypeID));
                SQLCmd.Parameters.Add(new SqlParameter("@PortalID", PortalID));
                SQLCmd.Parameters.Add(new SqlParameter("@StoreID", StoreID));
                SQLConn.Open();
                SQLCmd.ExecuteNonQuery();
                SQLConn.Close();
            }
            catch (Exception e)
            {
                ProcessException(e);
            }
        }

        public string ReadSQLFile(string TempUnzippedPath, string _sqlProvidername)
        {
            string Exceptions = string.Empty;
            try
            {
                StreamReader objReader = new StreamReader(TempUnzippedPath + '\\' + _sqlProvidername);
                string sLine = "";
                string scriptDetails = "";
                ArrayList arrText = new ArrayList();

                while (sLine != null)
                {
                    sLine = objReader.ReadLine();
                    if (sLine != null)
                        arrText.Add(sLine);
                }
                objReader.Close();
                foreach (string sOutput in arrText)
                {
                    scriptDetails += sOutput + "\r\n";
                }
                SQLHandler sqlHandler = new SQLHandler();
                Exceptions = sqlHandler.ExecuteScript(scriptDetails, true);
            }
            catch (Exception ex)
            {
                Exceptions += ex.Message.ToString();
            }
            return Exceptions;
        }



        public void InstallPackage(PaymentGateWayModuleInfo module,int update)
        {
            XmlDocument doc = new XmlDocument();
            ArrayList dllFiles = new ArrayList();
            string _unistallScriptFile = string.Empty;
            doc.Load(module.TempFolderPath + '\\' + module.ManifestFile);
            XmlElement root = doc.DocumentElement;
            if (!String.IsNullOrEmpty(root.ToString()))
            {
                XmlNodeList xnList = doc.SelectNodes("sageframe/folders/folder");
                foreach (XmlNode xn in xnList)
                {
                    #region Module Exist check
                    try
                    {
                        #region "Module Creation Logic"
                        SQLHandler sqhl = new SQLHandler();
                        SqlConnection SQLConn = new SqlConnection(SystemSetting.SageFrameConnectionString);
                        SqlCommand SQLCmd = new SqlCommand();
                        int ReturnValue = -1;
                        SQLCmd.Connection = SQLConn;
                        SQLCmd.CommandText = "[dbo].[usp_ASPX_PaymentGatewayTypeAdd]";
                        SQLCmd.CommandType = CommandType.StoredProcedure;
                        SQLCmd.Parameters.Add(new SqlParameter("@PaymentGatewayTypeName", module.PaymentGatewayTypeName));
                        SQLCmd.Parameters.Add(new SqlParameter("@StoreID", module.StoreID));
                        SQLCmd.Parameters.Add(new SqlParameter("@PortalID", module.PortalID));
                        SQLCmd.Parameters.Add(new SqlParameter("@FolderName", module.FolderName));
                        SQLCmd.Parameters.Add(new SqlParameter("@FriendlyName", module.FriendlyName));
                        SQLCmd.Parameters.Add(new SqlParameter("@CultureName", module.CultureName));
                        SQLCmd.Parameters.Add(new SqlParameter("@Description", module.Description));
                        SQLCmd.Parameters.Add(new SqlParameter("@Version", module.Version));
                        SQLCmd.Parameters.Add(new SqlParameter("@AddedBy", GetUsername));
                        SQLCmd.Parameters.Add(new SqlParameter("@Update", update));
                        SQLCmd.Parameters.Add(new SqlParameter("@NewModuleId", SqlDbType.Int));
                        SQLCmd.Parameters["@NewModuleId"].Direction = ParameterDirection.Output;

                        SQLConn.Open();
                        SQLCmd.ExecuteNonQuery();
                        if (update==0)
                        {
                            ReturnValue = (int)SQLCmd.Parameters["@NewModuleId"].Value;
                            module.PaymentGatewayTypeID = ReturnValue;
                        }
                        SQLConn.Close();

                        XmlNodeList xnList5 = doc.SelectNodes("sageframe/folders/folder/modules/module/controls/control");
                        int displayOrder = 0;
                        foreach (XmlNode xn5 in xnList5)
                        {
                            displayOrder++;
                            string _ctlKey = xn5["key"].InnerXml.ToString();
                            string _ctlSource = xn5["src"].InnerXml.ToString();
                            string _ctlTitle = xn5["title"].InnerXml.ToString();
                            string _ctlType = xn5["type"].InnerXml.ToString();
                            int ctlType = checkControlType(_ctlType);
                             string _ctlHelpUrl = xn5["helpurl"].InnerXml.ToString();
                             string _ctlSupportPR = xn5["supportspartialrendering"].InnerXml.ToString();
             

                            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
                            paramCol.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", module.PaymentGatewayTypeID));
                            paramCol.Add(new KeyValuePair<string, object>("@ControlName", _ctlKey));
                            paramCol.Add(new KeyValuePair<string, object>("@ControlType", ctlType));
                            paramCol.Add(new KeyValuePair<string, object>("@ControlSource", _ctlSource));
                            paramCol.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));                            
                            paramCol.Add(new KeyValuePair<string, object>("@StoreID", module.StoreID));
                            paramCol.Add(new KeyValuePair<string, object>("@PortalID", module.PortalID));
                            paramCol.Add(new KeyValuePair<string, object>("@CultureName", module.CultureName));
                            paramCol.Add(new KeyValuePair<string, object>("@AddedBy", GetUsername));
                            paramCol.Add(new KeyValuePair<string, object>("@Update", update));
                            paramCol.Add(new KeyValuePair<string, object>("@HelpUrl", _ctlHelpUrl));                           
                            paramCol.Add(new KeyValuePair<string, object>("@SupportsPartialRendering", bool.Parse( _ctlSupportPR.ToString())));
                            sq.ExecuteNonQuery("[dbo].[usp_ASPX_PaymentGateWayControlAdd]", paramCol);
                        }

                        XmlNodeList xnList2 = doc.SelectNodes("sageframe/folders/folder/settings/setting");
                        int onetime = 0;
                        foreach (XmlNode xn2 in xnList2)
                        {
                            onetime++;
                            string _settingkey = xn2["key"].InnerXml.ToString();
                            string _settingvalue = xn2["value"].InnerXml.ToString();
                            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
                            paramCol.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", module.PaymentGatewayTypeID));
                            paramCol.Add(new KeyValuePair<string, object>("@StoreID", module.StoreID));
                            paramCol.Add(new KeyValuePair<string, object>("@PortalID", module.PortalID));
                            paramCol.Add(new KeyValuePair<string, object>("@SettingKey", _settingkey));
                            paramCol.Add(new KeyValuePair<string, object>("@SettingValue", _settingvalue));
                            paramCol.Add(new KeyValuePair<string, object>("@AddedBy", GetUsername));
                            paramCol.Add(new KeyValuePair<string, object>("@Update", update));
                            paramCol.Add(new KeyValuePair<string, object>("@onetime", onetime));
                            sq.ExecuteNonQuery("[dbo].[usp_ASPX_PaymentGateWaySettingByKeyAdd]", paramCol);
                        }

                        XmlNodeList xnList3 = doc.SelectNodes("sageframe/folders/folder/files/file");
                        if (xnList3.Count != 0)
                        {
                            foreach (XmlNode xn3 in xnList3)
                            {
                                string _fileName = xn3["name"].InnerXml;
                                try
                                {
                                    #region CheckValidDataSqlProvider
                                    if (!String.IsNullOrEmpty(_fileName) && _fileName.Contains(module.Version + ".SqlDataProvider"))
                                    {
                                        Exceptions = ReadSQLFile(module.TempFolderPath, _fileName);
                                    }
                                    #endregion

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
                                    Exceptions += ex.Message;
                                    break;
                                }
                            }
                        }

                        if (Exceptions != string.Empty)
                        {
                            if (module.PaymentGatewayTypeID.ToString() != null && module.PaymentGatewayTypeID > 0)
                            {
                                //Run unstallScript
                                if (_unistallScriptFile != "")
                                {
                                    Exceptions = ReadSQLFile(module.TempFolderPath, _unistallScriptFile);
                                }
                                //Delete Module info from data base
                                PaymentGatewayRollBack(module.PaymentGatewayTypeID, GetPortalID, module.StoreID);
                                module.PaymentGatewayTypeID = -1;
                            }
                        }
                        #endregion
                    }
                    catch
                    {
                        if (module.PaymentGatewayTypeID.ToString() != null && module.PaymentGatewayTypeID > 0)
                        {
                            //Run unstallScript
                            if (_unistallScriptFile != "")
                            {
                                Exceptions = ReadSQLFile(module.TempFolderPath, _unistallScriptFile);
                            }
                            //Delete Module info from data base
                            if (update == 0)
                            {
                               PaymentGatewayRollBack(module.PaymentGatewayTypeID, GetPortalID, module.StoreID);
                            }
                            module.PaymentGatewayTypeID = -1;
                        }
                    }
                    #endregion
                }
            }

            if (module.PaymentGatewayTypeID.ToString() != null && module.PaymentGatewayTypeID > 0 && Exceptions == string.Empty)
            {
                string path = HttpContext.Current.Server.MapPath("~/");
                string FlPath = module.FolderName.ToString().Replace("/","\\"); 
                string targetPath = path + SageFrame.Core.RegisterModule.Common.ModuleFolder + '\\' + FlPath;
                CopyDirectory(module.TempFolderPath, targetPath);
                for (int i = 0; i < dllFiles.Count; i++)
                {
                    string sourcedllFile = module.TempFolderPath + '\\' + dllFiles[i].ToString();
                    string targetdllPath = path + SageFrame.Core.RegisterModule.Common.DLLTargetPath + '\\' + dllFiles[i].ToString();
                    File.Copy(sourcedllFile, targetdllPath, true);
                    //File.Move();
                }
            }
            DeleteTempDirectory(module.TempFolderPath);
        }

        private void CopyDirectory(string SourceDirectory, string DestinationDirectory)
        {
            if (Directory.Exists(SourceDirectory))
            {
                string[] files = Directory.GetFiles(SourceDirectory);
                if (!Directory.Exists(DestinationDirectory))
                {
                    Directory.CreateDirectory(DestinationDirectory);
                }
                foreach (string s in files)
                {
                    string fileName = Path.GetFileName(s);
                    string destFile = Path.Combine(DestinationDirectory, ParseFileNameWithoutPath(fileName));
                    File.Copy(s, destFile, true);
                }
                string[] directories = Directory.GetDirectories(SourceDirectory);
                foreach (string d in directories)
                {
                    char splitter = '\\';
                    string[] directory = d.Split(splitter);
                    string directoryName = directory[directory.Length - 1];
                    string destDirectory = Path.Combine(DestinationDirectory, directoryName);
                    CopyDirectory(d, destDirectory);
                }
            }
        }

        private string ParseFileNameWithoutPath(string path)
        {
            if (path != null && path != string.Empty)
            {
                char seperator = '\\';
                string[] file = path.Split(seperator);
                return file[file.Length - 1];
            }
            return string.Empty;
        }

        public void DeleteTempDirectory(string TempDirectory)
        {
            try
            {
                if (!string.IsNullOrEmpty(TempDirectory))
                {
                    if (Directory.Exists(TempDirectory))
                        Directory.Delete(TempDirectory, true);
                }
            }
            catch (IOException ex)
            {
                throw ex;//cant delete folder
            }
        }
    }
}
