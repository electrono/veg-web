using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Text;
using System.IO;
using SageFrame.CorporateBanner;
using SageFrame.Core.Pages;

public partial class Modules_SageFrameCorporateBanner_BannerEdit : BaseAdministrationUserControl
{
    protected void Page_Init(object sender, EventArgs e)
    {
        string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalVariables", " var loadingImagePath='" + ResolveUrl(modulePath + "images/loading.gif") + "';var closingImagePath='" + ResolveUrl(modulePath + "images/closelabel.gif") + "';", true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {               
                IncludeResources();
                AddImageUrl();                
                BindBannerGrid();
                PanelVisibility(true, false);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void IncludeResources()
    {
        //ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/module.css") 
        IncludeCssFile(ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/css/lightbox.css"));
        IncludeScriptFile(ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/prototype.js"));
        IncludeScriptFile(ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/scriptaculous.js?load=effects,builder"));
        IncludeScriptFile(ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/lightbox.js"));
    }

    private void AddImageUrl()
    {
        imbSave.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
        imbAddBanner.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
        imbCancel.ImageUrl = GetTemplateImageUrl("imgcancel.png", true);
    }

    private void ClearForm()
    {
        txtBannerTitle.Text = string.Empty;
        txtBannerDescription.Content = string.Empty;
        txtBannerNavigationTitle.Text = string.Empty;
        txtImageToolTip.Text = string.Empty;
        ddlReadMorePage.SelectedIndex = -1;
        txtReadButtonText.Text = string.Empty;
        txtDisplayOrder.Text = string.Empty;
        chkIsActive.Checked = true;
        imgEditNavImage.ImageUrl = string.Empty;
        imgEditNavImage.Visible = false;
        imgEditBannerImage.ImageUrl = string.Empty;
        imgEditBannerImage.Visible = false;
    }

    private void BindBannerGrid()
    {
        try
        {
            BannerSqlProvider bannerHandler = new BannerSqlProvider();
            gdvManageBanner.DataSource = bannerHandler.GetAllCorporateBanners(Int32.Parse(SageUserModuleID), GetPortalID, true); ;
            gdvManageBanner.DataBind();
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }

    }

    private void PanelVisibility(bool BannerInGrid, bool BannerForm)
    {
        pnlBannerInGrid.Visible = BannerInGrid;
        pnlBannerEditForm.Visible = BannerForm;
    }

    protected void imbAddBanner_Click(object sender, ImageClickEventArgs e)
    {
        ClearForm();
        Session["EditBannerID"] = null;
        PanelVisibility(false, true);
        BindPageDropDown();
    }

    private void BindPageDropDown()
    {
        try
        {
            PagesDataContext db = new PagesDataContext(SystemSetting.SageFrameConnectionString);
            var LINQParentPages = db.sp_PagePortalGetByCustomPrefix("---", true, false, GetPortalID, GetUsername, null, null);
            ddlReadMorePage.Items.Clear();
            ddlReadMorePage.DataSource = LINQParentPages;
            ddlReadMorePage.DataTextField = "LevelPageName";
            ddlReadMorePage.DataValueField = "SEOName";
            ddlReadMorePage.DataBind();
            ddlReadMorePage.Items.Insert(0, new ListItem("<Not Specified>", "-1"));
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void imbSave_Click(object sender, ImageClickEventArgs e)
    {
        SaveImage();             
    }

    protected void gdvManageBanner_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvManageBanner.PageIndex = e.NewPageIndex;
        BindBannerGrid();
    }

    protected void gdvManageBanner_PageIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gdvManageBanner_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gdvManageBanner_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }

    protected void gdvManageBanner_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    protected void gdvManageBanner_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }

    protected void gdvManageBanner_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            ImageButton btnDelete = (ImageButton)e.Row.FindControl("imbDelete");
            btnDelete.Attributes.Add("onclick", "javascript:return confirm('" + SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "AreYouSureToDelete") + "')");

            HiddenField hdnImage = (HiddenField)e.Row.FindControl("hdnImage");
            string[] hiddenArgs = hdnImage.Value.Split(new char[] { ',' });
            string imgBanner = hiddenArgs[0].ToString();
            string imgAlt = hiddenArgs[1].ToString();
            string imgNavigation = hiddenArgs[2].ToString();
            Literal litNavigationImage = (Literal)e.Row.FindControl("litNavigationImage");
            litNavigationImage.Text = AddLightBoxWrapper(imgNavigation, imgAlt, false);

            Literal litBannerImage = (Literal)e.Row.FindControl("litBannerImage");
            litBannerImage.Text = AddLightBoxWrapper(imgBanner, imgAlt, true);
        }
    }

    protected void gdvManageBanner_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int BannerId = int.Parse(e.CommandArgument.ToString());
            switch (e.CommandName)
            {
                case "Edit":
                    BindPageDropDown();
                    EditByID(BannerId);
                    PanelVisibility(false, true);
                    break;
                case "Delete":
                    DeleteByID(BannerId);                    
                    break;
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void EditByID(int BannerId)
    {
        string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        BannerInfo bannerObj = new BannerInfo();
        BannerSqlProvider sqlObj = new BannerSqlProvider();
        bannerObj = sqlObj.GetCorporateBannerDetailsByBannerID(BannerId, GetPortalID);
        if (bannerObj != null)
        {
            txtBannerTitle.Text = bannerObj.Title;
            txtBannerDescription.Content = bannerObj.Description;
            txtBannerNavigationTitle.Text = bannerObj.NavigationTitle;
            txtImageToolTip.Text = bannerObj.ImageToolTip;
            ddlReadMorePage.SelectedIndex = ddlReadMorePage.Items.IndexOf(ddlReadMorePage.Items.FindByValue(bannerObj.ReadMorePage.ToString()));
            txtReadButtonText.Text = bannerObj.ReadButtonText;
            txtDisplayOrder.Text = bannerObj.BannerOrder.ToString();
            chkIsActive.Checked = bool.Parse(bannerObj.IsActive.ToString());
            imgEditNavImage.ImageUrl = modulePath + "uploads/NavigationImages/Small/" + bannerObj.NavigationImage;
            imgEditNavImage.Visible = true;
            imgEditBannerImage.ImageUrl = modulePath + "uploads/Banners/Small/" + bannerObj.BannerImage;
            imgEditBannerImage.Visible = true;
            Session["EditBannerID"] = BannerId;            
        }
    }

    private void DeleteByID(int BannerId)
    {
        try
        {
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            BannerInfo bannerObj = new BannerInfo();
            BannerSqlProvider sqlObj = new BannerSqlProvider();
            sqlObj.CorporateBannerDeleteByBannerID(BannerId, GetPortalID, GetUsername);
            ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "BannerDeletedSuccessfully"), "", SageMessageType.Success);
            BindBannerGrid();
            Session["EditBannerID"] = null;
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    
    protected string AddLightBoxWrapper(string image, string imgAlt, bool isBanner)
    {
        StringBuilder strImagePath = new StringBuilder();
        try
        {
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            string imgPath = string.Empty;
            if (isBanner)
            {
                imgPath = "<a href=\"" + modulePath + "uploads/Banners/" + image + "\" rel=\"lightbox\"><img src=\"" + modulePath + "uploads/Banners/Small/" + image + "\"  alt=\"" + imgAlt + "\" Height=\"100\" Width=\"100\" /></a>";
            }
            else{
                imgPath = "<a href=\"" + modulePath + "uploads/NavigationImages/" + image + "\" rel=\"lightbox\"><img src=\"" + modulePath + "uploads/NavigationImages/Small/" + image + "\"  alt=\"" + imgAlt + "\" Height=\"100\" Width=\"100\" /></a>";
            }            
            strImagePath.Append("<div class=\"cssClassPhotoWrapper\">");
            strImagePath.Append(imgPath);
            strImagePath.Append("</div>");
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
        return strImagePath.ToString();
    }     

    private void SaveImage()
    {
        try
        {
            string message = string.Empty;
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            if (ddlReadMorePage.SelectedIndex != 0)
            {                
                BannerInfo bannerObj = new BannerInfo();
                BannerSqlProvider sqlObj = new BannerSqlProvider();

                //BannerController bc = new BannerController();               
                int BannerID = 0;
                if (Session["EditBannerID"] != null)
                {
                    BannerID = Int32.Parse(Session["EditBannerID"].ToString());
                    message = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "BannerUpdatedSuccessfully");
                }
                else
                {
                    message = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "BannerSavedSuccessfully");
                }

                string navigationImgPath = ResolveUrl(this.AppRelativeTemplateSourceDirectory + "uploads/NavigationImages");
                string bannerImgPath = ResolveUrl(this.AppRelativeTemplateSourceDirectory + "uploads/Banners");
                string navigationImage = ImageUpload(fluBannerNavigationImage, imgEditNavImage, navigationImgPath);
                string bannerImage = ImageUpload(fluBannerImage, imgEditBannerImage, bannerImgPath);

                if (navigationImage != "" && bannerImage != "")
                {
                    sqlObj.CorporateBannerAddUpdate(BannerID, Int32.Parse(SageUserModuleID), txtBannerTitle.Text.Trim(),
                        txtBannerDescription.Content.Trim(), txtBannerNavigationTitle.Text.Trim(), navigationImage,
                        int.Parse(txtDisplayOrder.Text.Trim()), bannerImage, txtImageToolTip.Text.Trim(),
                        txtReadButtonText.Text.Trim(), ddlReadMorePage.SelectedItem.Value, chkIsActive.Checked, DateTime.Now,
                        GetPortalID, GetUsername);
                    BindBannerGrid();
                    PanelVisibility(true, false);
                    Session["EditBannerID"] = null;
                    ClearForm();
                    ShowMessage(SageMessageTitle.Information.ToString(), message, "", SageMessageType.Success);
                }
                else if (navigationImage == "" || bannerImage == "" && Session["EditBannerID"] == null)
                {
                    message = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "SelectBothImage");
                    ShowMessage(SageMessageTitle.Notification.ToString(), message, "", SageMessageType.Alert);
                }
            }
            else
            {
                message = SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/SageFrameCorporateBanner/ModuleLocalText", "SelectThePageFirst");
                ShowMessage(SageMessageTitle.Notification.ToString(), message, "", SageMessageType.Alert);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private string ImageUpload(FileUpload fluImage, Image imgEdit, string SaveImgPath)
    {
        string strFileName = string.Empty;
        if (fluImage.HasFile)
        {            
            SaveImgPath = Server.MapPath(SaveImgPath);
            if (!Directory.Exists(SaveImgPath))
                Directory.CreateDirectory(SaveImgPath);

            string UploadedImage = fluImage.PostedFile.FileName;
            FileInfo objFin = new FileInfo(UploadedImage);
            string FileExtension = objFin.Extension;//UploadedImage.Remove(UploadedImage.LastIndexOf("."));
            string VertualUrl0 = SaveImgPath + "\\Large";
            //VertualUrl0 = Server.MapPath(VertualUrl0);
            if (!Directory.Exists(VertualUrl0))
                Directory.CreateDirectory(VertualUrl0);


            strFileName = PictureManager.GetFileName("img_");
            Random rnd = new Random();
            strFileName += rnd.Next(111111, 999999).ToString() + FileExtension;

            VertualUrl0 = VertualUrl0 + "\\" + strFileName;
            string VertualUrl1 = SaveImgPath + "\\Medium";
            //VertualUrl1 = Server.MapPath(VertualUrl1);
            if (!Directory.Exists(VertualUrl1))
                Directory.CreateDirectory(VertualUrl1);

            VertualUrl1 = VertualUrl1 + "\\" + strFileName;
            string VertualUrl2 = SaveImgPath + "\\Small";
            //VertualUrl2 = Server.MapPath(VertualUrl2);
            if (!Directory.Exists(VertualUrl2))
                Directory.CreateDirectory(VertualUrl2);

            VertualUrl2 = VertualUrl2 + "\\" + strFileName;

            SaveImgPath += "\\" + strFileName;
            fluImage.SaveAs(SaveImgPath);
            PictureManager.CreateThmnail(SaveImgPath, 400, VertualUrl0);
            PictureManager.CreateThmnail(SaveImgPath, 250, VertualUrl1);
            PictureManager.CreateThmnail(SaveImgPath, 175, VertualUrl2);           
        }
        else
        {
            if (Session["EditBannerID"] != null)
            {
                //int BannerID = 0;
                //BannerID = Int32.Parse(Session["EditBannerID"].ToString());
                if (imgEdit.ImageUrl != string.Empty)
                {
                    string imgUrl = imgEdit.ImageUrl;
                    strFileName = imgUrl.Substring(imgUrl.LastIndexOf("/") + 1);                    
                }
            }
        }
        return strFileName;
    }

    protected void imbCancel_Click(object sender, ImageClickEventArgs e)
    {
        PanelVisibility(true, false);
        ClearForm();
        Session["EditBannerID"] = null;
    }
}
