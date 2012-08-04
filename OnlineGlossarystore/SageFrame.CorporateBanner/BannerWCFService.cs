using System;
using System.Web;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using SageFrame.Web;
using SageFrame.Web.Utilities;
using System.IO;
using System.Text;
using SageFrame.CorporateBanner;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]

public class BannerWCFService
{
    // Add [WebGet] attribute to use HTTP GET
    [OperationContract]
    public void DoWork()
    {
        // Add your operation implementation here
        return;
    }

    [OperationContract]
    [WebInvoke(Method = "POST", ResponseFormat = WebMessageFormat.Json)]
    public List<BannerInfo> GetBannersInfo(Int32 userModuleID, Int32 portalID, bool showInActive)
    {
        try
        {
        List<BannerInfo> bannersInfo = new List<BannerInfo>();
        BannerSqlProvider objSql = new BannerSqlProvider();
        bannersInfo = objSql.GetAllCorporateBanners(userModuleID, portalID, showInActive);
        return bannersInfo;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}
