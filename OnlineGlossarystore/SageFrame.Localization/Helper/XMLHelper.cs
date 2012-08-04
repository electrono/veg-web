﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Web.Hosting;

namespace SageFrame.Localization
{
    public class XMLHelper
    {
        public static XmlWriterSettings GetXmlWriterSettings()
        {
            XmlWriterSettings settings = new XmlWriterSettings();
            //settings.ConformanceLevel = conformance;
            settings.OmitXmlDeclaration = true;
            settings.Indent = true;
            return settings;
        }
         public static PackageInfo GetPackageManifest(string path)
        {
            PackageInfo package = new PackageInfo();           
            XmlDocument doc = new XmlDocument();
                doc.Load(path);   
                XmlNode root = doc.DocumentElement;
                XmlNodeList xnList = doc.SelectNodes("sageframe/packages/package");
                foreach (XmlNode xn in xnList)
                {
                   
                    package.Description = xn["description"].InnerXml.ToString();
                    package.Version = xn.Attributes["version"].InnerText.ToString();
                    package.OwnerName = xn["owner"].ChildNodes[0].InnerXml.ToString();
                    package.Organistaion = xn["owner"].ChildNodes[1].InnerXml.ToString();
                    package.URL = xn["owner"].ChildNodes[2].InnerXml.ToString();
                    package.Email = xn["owner"].ChildNodes[3].InnerXml.ToString();
                    package.ReleaseNotes = xn["releasenotes"].InnerXml.ToString();
                    package.License = xn["license"].InnerXml.ToString();
                }
            
            
            return package;
            
            
        }
    }
}
