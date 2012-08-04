﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3053
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SageFrame.SiteMap
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[System.Data.Linq.Mapping.DatabaseAttribute(Name="SageFrameIntegration")]
	public partial class SiteMapDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    #endregion
		
		public SiteMapDataContext() : 
				base(global::SageFrame.Core.Properties.Settings.Default.SageFrameIntegrationConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public SiteMapDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SiteMapDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SiteMapDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SiteMapDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[Function(Name="dbo.sp_GetSiteMapNodeWithRolesByParentNodeID")]
		public ISingleResult<sp_GetSiteMapNodeWithRolesByParentNodeIDResult> sp_GetSiteMapNodeWithRolesByParentNodeID([Parameter(Name="ParentNodeID", DbType="Int")] System.Nullable<int> parentNodeID, [Parameter(Name="Username", DbType="NVarChar(256)")] string username, [Parameter(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), parentNodeID, username, portalID);
			return ((ISingleResult<sp_GetSiteMapNodeWithRolesByParentNodeIDResult>)(result.ReturnValue));
		}
		
		[Function(Name="dbo.sp_GetSiteMapNodeByParentNodeID")]
		public ISingleResult<sp_GetSiteMapNodeByParentNodeIDResult> sp_GetSiteMapNodeByParentNodeID([Parameter(Name="ParentNodeID", DbType="Int")] System.Nullable<int> parentNodeID, [Parameter(Name="Username", DbType="NVarChar(256)")] string username, [Parameter(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), parentNodeID, username, portalID);
			return ((ISingleResult<sp_GetSiteMapNodeByParentNodeIDResult>)(result.ReturnValue));
		}
		
		[Function(Name="dbo.sp_GetAdminSiteMapNodeWithRolesByParentNodeID")]
		public ISingleResult<sp_GetAdminSiteMapNodeWithRolesByParentNodeIDResult> sp_GetAdminSiteMapNodeWithRolesByParentNodeID([Parameter(Name="ParentNodeID", DbType="Int")] System.Nullable<int> parentNodeID, [Parameter(Name="Username", DbType="NVarChar(256)")] string username, [Parameter(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), parentNodeID, username, portalID);
			return ((ISingleResult<sp_GetAdminSiteMapNodeWithRolesByParentNodeIDResult>)(result.ReturnValue));
		}
		
		[Function(Name="dbo.sp_GetFooterSiteMapNodeWithRolesByParentNodeID")]
		public ISingleResult<sp_GetFooterSiteMapNodeWithRolesByParentNodeIDResult> sp_GetFooterSiteMapNodeWithRolesByParentNodeID([Parameter(Name="ParentNodeID", DbType="Int")] System.Nullable<int> parentNodeID, [Parameter(Name="Username", DbType="NVarChar(256)")] string username, [Parameter(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), parentNodeID, username, portalID);
			return ((ISingleResult<sp_GetFooterSiteMapNodeWithRolesByParentNodeIDResult>)(result.ReturnValue));
		}
		
		[Function(Name="dbo.usp_GetAllPages")]
		public ISingleResult<usp_GetAllPagesResult> usp_GetAllPages([Parameter(Name="IsActive", DbType="Bit")] System.Nullable<bool> isActive, [Parameter(Name="IsDeleted", DbType="Bit")] System.Nullable<bool> isDeleted, [Parameter(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [Parameter(Name="Username", DbType="NVarChar(256)")] string username)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), isActive, isDeleted, portalID, username);
			return ((ISingleResult<usp_GetAllPagesResult>)(result.ReturnValue));
		}
	}
	
	public partial class sp_GetSiteMapNodeWithRolesByParentNodeIDResult
	{
		
		private int _PageID;
		
		private System.Nullable<int> _PageOrder;
		
		private string _PageName;
		
		private System.Nullable<bool> _IsVisible;
		
		private System.Nullable<int> _ParentID;
		
		private System.Nullable<int> _Level;
		
		private string _IconFile;
		
		private System.Nullable<bool> _DisableLink;
		
		private string _Title;
		
		private string _Description;
		
		private string _KeyWords;
		
		private string _Url;
		
		private string _TabPath;
		
		private System.Nullable<System.DateTime> _StartDate;
		
		private System.Nullable<System.DateTime> _EndDate;
		
		private System.Nullable<decimal> _RefreshInterval;
		
		private string _PageHeadText;
		
		private bool _IsSecure;
		
		private System.Nullable<bool> _IsActive;
		
		private string _PageRoles;
		
		public sp_GetSiteMapNodeWithRolesByParentNodeIDResult()
		{
		}
		
		[Column(Storage="_PageID", DbType="Int NOT NULL")]
		public int PageID
		{
			get
			{
				return this._PageID;
			}
			set
			{
				if ((this._PageID != value))
				{
					this._PageID = value;
				}
			}
		}
		
		[Column(Storage="_PageOrder", DbType="Int")]
		public System.Nullable<int> PageOrder
		{
			get
			{
				return this._PageOrder;
			}
			set
			{
				if ((this._PageOrder != value))
				{
					this._PageOrder = value;
				}
			}
		}
		
		[Column(Storage="_PageName", DbType="NVarChar(100)")]
		public string PageName
		{
			get
			{
				return this._PageName;
			}
			set
			{
				if ((this._PageName != value))
				{
					this._PageName = value;
				}
			}
		}
		
		[Column(Storage="_IsVisible", DbType="Bit")]
		public System.Nullable<bool> IsVisible
		{
			get
			{
				return this._IsVisible;
			}
			set
			{
				if ((this._IsVisible != value))
				{
					this._IsVisible = value;
				}
			}
		}
		
		[Column(Storage="_ParentID", DbType="Int")]
		public System.Nullable<int> ParentID
		{
			get
			{
				return this._ParentID;
			}
			set
			{
				if ((this._ParentID != value))
				{
					this._ParentID = value;
				}
			}
		}
		
		[Column(Name="[Level]", Storage="_Level", DbType="Int")]
		public System.Nullable<int> Level
		{
			get
			{
				return this._Level;
			}
			set
			{
				if ((this._Level != value))
				{
					this._Level = value;
				}
			}
		}
		
		[Column(Storage="_IconFile", DbType="NVarChar(100)")]
		public string IconFile
		{
			get
			{
				return this._IconFile;
			}
			set
			{
				if ((this._IconFile != value))
				{
					this._IconFile = value;
				}
			}
		}
		
		[Column(Storage="_DisableLink", DbType="Bit")]
		public System.Nullable<bool> DisableLink
		{
			get
			{
				return this._DisableLink;
			}
			set
			{
				if ((this._DisableLink != value))
				{
					this._DisableLink = value;
				}
			}
		}
		
		[Column(Storage="_Title", DbType="NVarChar(200)")]
		public string Title
		{
			get
			{
				return this._Title;
			}
			set
			{
				if ((this._Title != value))
				{
					this._Title = value;
				}
			}
		}
		
		[Column(Storage="_Description", DbType="NVarChar(500)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}
		
		[Column(Storage="_KeyWords", DbType="NVarChar(500)")]
		public string KeyWords
		{
			get
			{
				return this._KeyWords;
			}
			set
			{
				if ((this._KeyWords != value))
				{
					this._KeyWords = value;
				}
			}
		}
		
		[Column(Storage="_Url", DbType="NVarChar(260)")]
		public string Url
		{
			get
			{
				return this._Url;
			}
			set
			{
				if ((this._Url != value))
				{
					this._Url = value;
				}
			}
		}
		
		[Column(Storage="_TabPath", DbType="NVarChar(255)")]
		public string TabPath
		{
			get
			{
				return this._TabPath;
			}
			set
			{
				if ((this._TabPath != value))
				{
					this._TabPath = value;
				}
			}
		}
		
		[Column(Storage="_StartDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> StartDate
		{
			get
			{
				return this._StartDate;
			}
			set
			{
				if ((this._StartDate != value))
				{
					this._StartDate = value;
				}
			}
		}
		
		[Column(Storage="_EndDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> EndDate
		{
			get
			{
				return this._EndDate;
			}
			set
			{
				if ((this._EndDate != value))
				{
					this._EndDate = value;
				}
			}
		}
		
		[Column(Storage="_RefreshInterval", DbType="Decimal(0,0)")]
		public System.Nullable<decimal> RefreshInterval
		{
			get
			{
				return this._RefreshInterval;
			}
			set
			{
				if ((this._RefreshInterval != value))
				{
					this._RefreshInterval = value;
				}
			}
		}
		
		[Column(Storage="_PageHeadText", DbType="NVarChar(500)")]
		public string PageHeadText
		{
			get
			{
				return this._PageHeadText;
			}
			set
			{
				if ((this._PageHeadText != value))
				{
					this._PageHeadText = value;
				}
			}
		}
		
		[Column(Storage="_IsSecure", DbType="Bit NOT NULL")]
		public bool IsSecure
		{
			get
			{
				return this._IsSecure;
			}
			set
			{
				if ((this._IsSecure != value))
				{
					this._IsSecure = value;
				}
			}
		}
		
		[Column(Storage="_IsActive", DbType="Bit")]
		public System.Nullable<bool> IsActive
		{
			get
			{
				return this._IsActive;
			}
			set
			{
				if ((this._IsActive != value))
				{
					this._IsActive = value;
				}
			}
		}
		
		[Column(Storage="_PageRoles", DbType="NVarChar(1000)")]
		public string PageRoles
		{
			get
			{
				return this._PageRoles;
			}
			set
			{
				if ((this._PageRoles != value))
				{
					this._PageRoles = value;
				}
			}
		}
	}
	
	public partial class sp_GetSiteMapNodeByParentNodeIDResult
	{
		
		private int _PageID;
		
		private System.Nullable<int> _PageOrder;
		
		private string _PageName;
		
		private System.Nullable<bool> _IsVisible;
		
		private System.Nullable<int> _ParentID;
		
		private System.Nullable<int> _Level;
		
		private string _IconFile;
		
		private System.Nullable<bool> _DisableLink;
		
		private string _Title;
		
		private string _Description;
		
		private string _KeyWords;
		
		private string _Url;
		
		private string _TabPath;
		
		private System.Nullable<System.DateTime> _StartDate;
		
		private System.Nullable<System.DateTime> _EndDate;
		
		private System.Nullable<decimal> _RefreshInterval;
		
		private string _PageHeadText;
		
		private bool _IsSecure;
		
		private System.Nullable<bool> _IsActive;
		
		private string _PageRoles;
		
		public sp_GetSiteMapNodeByParentNodeIDResult()
		{
		}
		
		[Column(Storage="_PageID", DbType="Int NOT NULL")]
		public int PageID
		{
			get
			{
				return this._PageID;
			}
			set
			{
				if ((this._PageID != value))
				{
					this._PageID = value;
				}
			}
		}
		
		[Column(Storage="_PageOrder", DbType="Int")]
		public System.Nullable<int> PageOrder
		{
			get
			{
				return this._PageOrder;
			}
			set
			{
				if ((this._PageOrder != value))
				{
					this._PageOrder = value;
				}
			}
		}
		
		[Column(Storage="_PageName", DbType="NVarChar(100)")]
		public string PageName
		{
			get
			{
				return this._PageName;
			}
			set
			{
				if ((this._PageName != value))
				{
					this._PageName = value;
				}
			}
		}
		
		[Column(Storage="_IsVisible", DbType="Bit")]
		public System.Nullable<bool> IsVisible
		{
			get
			{
				return this._IsVisible;
			}
			set
			{
				if ((this._IsVisible != value))
				{
					this._IsVisible = value;
				}
			}
		}
		
		[Column(Storage="_ParentID", DbType="Int")]
		public System.Nullable<int> ParentID
		{
			get
			{
				return this._ParentID;
			}
			set
			{
				if ((this._ParentID != value))
				{
					this._ParentID = value;
				}
			}
		}
		
		[Column(Name="[Level]", Storage="_Level", DbType="Int")]
		public System.Nullable<int> Level
		{
			get
			{
				return this._Level;
			}
			set
			{
				if ((this._Level != value))
				{
					this._Level = value;
				}
			}
		}
		
		[Column(Storage="_IconFile", DbType="NVarChar(100)")]
		public string IconFile
		{
			get
			{
				return this._IconFile;
			}
			set
			{
				if ((this._IconFile != value))
				{
					this._IconFile = value;
				}
			}
		}
		
		[Column(Storage="_DisableLink", DbType="Bit")]
		public System.Nullable<bool> DisableLink
		{
			get
			{
				return this._DisableLink;
			}
			set
			{
				if ((this._DisableLink != value))
				{
					this._DisableLink = value;
				}
			}
		}
		
		[Column(Storage="_Title", DbType="NVarChar(200)")]
		public string Title
		{
			get
			{
				return this._Title;
			}
			set
			{
				if ((this._Title != value))
				{
					this._Title = value;
				}
			}
		}
		
		[Column(Storage="_Description", DbType="NVarChar(500)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}
		
		[Column(Storage="_KeyWords", DbType="NVarChar(500)")]
		public string KeyWords
		{
			get
			{
				return this._KeyWords;
			}
			set
			{
				if ((this._KeyWords != value))
				{
					this._KeyWords = value;
				}
			}
		}
		
		[Column(Storage="_Url", DbType="NVarChar(260)")]
		public string Url
		{
			get
			{
				return this._Url;
			}
			set
			{
				if ((this._Url != value))
				{
					this._Url = value;
				}
			}
		}
		
		[Column(Storage="_TabPath", DbType="NVarChar(255)")]
		public string TabPath
		{
			get
			{
				return this._TabPath;
			}
			set
			{
				if ((this._TabPath != value))
				{
					this._TabPath = value;
				}
			}
		}
		
		[Column(Storage="_StartDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> StartDate
		{
			get
			{
				return this._StartDate;
			}
			set
			{
				if ((this._StartDate != value))
				{
					this._StartDate = value;
				}
			}
		}
		
		[Column(Storage="_EndDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> EndDate
		{
			get
			{
				return this._EndDate;
			}
			set
			{
				if ((this._EndDate != value))
				{
					this._EndDate = value;
				}
			}
		}
		
		[Column(Storage="_RefreshInterval", DbType="Decimal(0,0)")]
		public System.Nullable<decimal> RefreshInterval
		{
			get
			{
				return this._RefreshInterval;
			}
			set
			{
				if ((this._RefreshInterval != value))
				{
					this._RefreshInterval = value;
				}
			}
		}
		
		[Column(Storage="_PageHeadText", DbType="NVarChar(500)")]
		public string PageHeadText
		{
			get
			{
				return this._PageHeadText;
			}
			set
			{
				if ((this._PageHeadText != value))
				{
					this._PageHeadText = value;
				}
			}
		}
		
		[Column(Storage="_IsSecure", DbType="Bit NOT NULL")]
		public bool IsSecure
		{
			get
			{
				return this._IsSecure;
			}
			set
			{
				if ((this._IsSecure != value))
				{
					this._IsSecure = value;
				}
			}
		}
		
		[Column(Storage="_IsActive", DbType="Bit")]
		public System.Nullable<bool> IsActive
		{
			get
			{
				return this._IsActive;
			}
			set
			{
				if ((this._IsActive != value))
				{
					this._IsActive = value;
				}
			}
		}
		
		[Column(Storage="_PageRoles", DbType="NVarChar(1000)")]
		public string PageRoles
		{
			get
			{
				return this._PageRoles;
			}
			set
			{
				if ((this._PageRoles != value))
				{
					this._PageRoles = value;
				}
			}
		}
	}
	
	public partial class sp_GetAdminSiteMapNodeWithRolesByParentNodeIDResult
	{
		
		private int _PageID;
		
		private System.Nullable<int> _PageOrder;
		
		private string _PageName;
		
		private System.Nullable<bool> _IsVisible;
		
		private System.Nullable<int> _ParentID;
		
		private System.Nullable<int> _Level;
		
		private string _IconFile;
		
		private System.Nullable<bool> _DisableLink;
		
		private string _Title;
		
		private string _Description;
		
		private string _KeyWords;
		
		private string _Url;
		
		private string _TabPath;
		
		private System.Nullable<System.DateTime> _StartDate;
		
		private System.Nullable<System.DateTime> _EndDate;
		
		private System.Nullable<decimal> _RefreshInterval;
		
		private string _PageHeadText;
		
		private bool _IsSecure;
		
		private System.Nullable<bool> _IsActive;
		
		private string _PageRoles;
		
		public sp_GetAdminSiteMapNodeWithRolesByParentNodeIDResult()
		{
		}
		
		[Column(Storage="_PageID", DbType="Int NOT NULL")]
		public int PageID
		{
			get
			{
				return this._PageID;
			}
			set
			{
				if ((this._PageID != value))
				{
					this._PageID = value;
				}
			}
		}
		
		[Column(Storage="_PageOrder", DbType="Int")]
		public System.Nullable<int> PageOrder
		{
			get
			{
				return this._PageOrder;
			}
			set
			{
				if ((this._PageOrder != value))
				{
					this._PageOrder = value;
				}
			}
		}
		
		[Column(Storage="_PageName", DbType="NVarChar(100)")]
		public string PageName
		{
			get
			{
				return this._PageName;
			}
			set
			{
				if ((this._PageName != value))
				{
					this._PageName = value;
				}
			}
		}
		
		[Column(Storage="_IsVisible", DbType="Bit")]
		public System.Nullable<bool> IsVisible
		{
			get
			{
				return this._IsVisible;
			}
			set
			{
				if ((this._IsVisible != value))
				{
					this._IsVisible = value;
				}
			}
		}
		
		[Column(Storage="_ParentID", DbType="Int")]
		public System.Nullable<int> ParentID
		{
			get
			{
				return this._ParentID;
			}
			set
			{
				if ((this._ParentID != value))
				{
					this._ParentID = value;
				}
			}
		}
		
		[Column(Name="[Level]", Storage="_Level", DbType="Int")]
		public System.Nullable<int> Level
		{
			get
			{
				return this._Level;
			}
			set
			{
				if ((this._Level != value))
				{
					this._Level = value;
				}
			}
		}
		
		[Column(Storage="_IconFile", DbType="NVarChar(100)")]
		public string IconFile
		{
			get
			{
				return this._IconFile;
			}
			set
			{
				if ((this._IconFile != value))
				{
					this._IconFile = value;
				}
			}
		}
		
		[Column(Storage="_DisableLink", DbType="Bit")]
		public System.Nullable<bool> DisableLink
		{
			get
			{
				return this._DisableLink;
			}
			set
			{
				if ((this._DisableLink != value))
				{
					this._DisableLink = value;
				}
			}
		}
		
		[Column(Storage="_Title", DbType="NVarChar(200)")]
		public string Title
		{
			get
			{
				return this._Title;
			}
			set
			{
				if ((this._Title != value))
				{
					this._Title = value;
				}
			}
		}
		
		[Column(Storage="_Description", DbType="NVarChar(500)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}
		
		[Column(Storage="_KeyWords", DbType="NVarChar(500)")]
		public string KeyWords
		{
			get
			{
				return this._KeyWords;
			}
			set
			{
				if ((this._KeyWords != value))
				{
					this._KeyWords = value;
				}
			}
		}
		
		[Column(Storage="_Url", DbType="NVarChar(260)")]
		public string Url
		{
			get
			{
				return this._Url;
			}
			set
			{
				if ((this._Url != value))
				{
					this._Url = value;
				}
			}
		}
		
		[Column(Storage="_TabPath", DbType="NVarChar(255)")]
		public string TabPath
		{
			get
			{
				return this._TabPath;
			}
			set
			{
				if ((this._TabPath != value))
				{
					this._TabPath = value;
				}
			}
		}
		
		[Column(Storage="_StartDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> StartDate
		{
			get
			{
				return this._StartDate;
			}
			set
			{
				if ((this._StartDate != value))
				{
					this._StartDate = value;
				}
			}
		}
		
		[Column(Storage="_EndDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> EndDate
		{
			get
			{
				return this._EndDate;
			}
			set
			{
				if ((this._EndDate != value))
				{
					this._EndDate = value;
				}
			}
		}
		
		[Column(Storage="_RefreshInterval", DbType="Decimal(0,0)")]
		public System.Nullable<decimal> RefreshInterval
		{
			get
			{
				return this._RefreshInterval;
			}
			set
			{
				if ((this._RefreshInterval != value))
				{
					this._RefreshInterval = value;
				}
			}
		}
		
		[Column(Storage="_PageHeadText", DbType="NVarChar(500)")]
		public string PageHeadText
		{
			get
			{
				return this._PageHeadText;
			}
			set
			{
				if ((this._PageHeadText != value))
				{
					this._PageHeadText = value;
				}
			}
		}
		
		[Column(Storage="_IsSecure", DbType="Bit NOT NULL")]
		public bool IsSecure
		{
			get
			{
				return this._IsSecure;
			}
			set
			{
				if ((this._IsSecure != value))
				{
					this._IsSecure = value;
				}
			}
		}
		
		[Column(Storage="_IsActive", DbType="Bit")]
		public System.Nullable<bool> IsActive
		{
			get
			{
				return this._IsActive;
			}
			set
			{
				if ((this._IsActive != value))
				{
					this._IsActive = value;
				}
			}
		}
		
		[Column(Storage="_PageRoles", DbType="NVarChar(1000)")]
		public string PageRoles
		{
			get
			{
				return this._PageRoles;
			}
			set
			{
				if ((this._PageRoles != value))
				{
					this._PageRoles = value;
				}
			}
		}
	}
	
	public partial class sp_GetFooterSiteMapNodeWithRolesByParentNodeIDResult
	{
		
		private int _PageID;
		
		private System.Nullable<int> _PageOrder;
		
		private string _PageName;
		
		private System.Nullable<bool> _IsVisible;
		
		private System.Nullable<int> _ParentID;
		
		private System.Nullable<int> _Level;
		
		private string _IconFile;
		
		private System.Nullable<bool> _DisableLink;
		
		private string _Title;
		
		private string _Description;
		
		private string _KeyWords;
		
		private string _Url;
		
		private string _TabPath;
		
		private System.Nullable<System.DateTime> _StartDate;
		
		private System.Nullable<System.DateTime> _EndDate;
		
		private System.Nullable<decimal> _RefreshInterval;
		
		private string _PageHeadText;
		
		private bool _IsSecure;
		
		private System.Nullable<bool> _IsActive;
		
		private string _PageRoles;
		
		public sp_GetFooterSiteMapNodeWithRolesByParentNodeIDResult()
		{
		}
		
		[Column(Storage="_PageID", DbType="Int NOT NULL")]
		public int PageID
		{
			get
			{
				return this._PageID;
			}
			set
			{
				if ((this._PageID != value))
				{
					this._PageID = value;
				}
			}
		}
		
		[Column(Storage="_PageOrder", DbType="Int")]
		public System.Nullable<int> PageOrder
		{
			get
			{
				return this._PageOrder;
			}
			set
			{
				if ((this._PageOrder != value))
				{
					this._PageOrder = value;
				}
			}
		}
		
		[Column(Storage="_PageName", DbType="NVarChar(100)")]
		public string PageName
		{
			get
			{
				return this._PageName;
			}
			set
			{
				if ((this._PageName != value))
				{
					this._PageName = value;
				}
			}
		}
		
		[Column(Storage="_IsVisible", DbType="Bit")]
		public System.Nullable<bool> IsVisible
		{
			get
			{
				return this._IsVisible;
			}
			set
			{
				if ((this._IsVisible != value))
				{
					this._IsVisible = value;
				}
			}
		}
		
		[Column(Storage="_ParentID", DbType="Int")]
		public System.Nullable<int> ParentID
		{
			get
			{
				return this._ParentID;
			}
			set
			{
				if ((this._ParentID != value))
				{
					this._ParentID = value;
				}
			}
		}
		
		[Column(Name="[Level]", Storage="_Level", DbType="Int")]
		public System.Nullable<int> Level
		{
			get
			{
				return this._Level;
			}
			set
			{
				if ((this._Level != value))
				{
					this._Level = value;
				}
			}
		}
		
		[Column(Storage="_IconFile", DbType="NVarChar(100)")]
		public string IconFile
		{
			get
			{
				return this._IconFile;
			}
			set
			{
				if ((this._IconFile != value))
				{
					this._IconFile = value;
				}
			}
		}
		
		[Column(Storage="_DisableLink", DbType="Bit")]
		public System.Nullable<bool> DisableLink
		{
			get
			{
				return this._DisableLink;
			}
			set
			{
				if ((this._DisableLink != value))
				{
					this._DisableLink = value;
				}
			}
		}
		
		[Column(Storage="_Title", DbType="NVarChar(200)")]
		public string Title
		{
			get
			{
				return this._Title;
			}
			set
			{
				if ((this._Title != value))
				{
					this._Title = value;
				}
			}
		}
		
		[Column(Storage="_Description", DbType="NVarChar(500)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}
		
		[Column(Storage="_KeyWords", DbType="NVarChar(500)")]
		public string KeyWords
		{
			get
			{
				return this._KeyWords;
			}
			set
			{
				if ((this._KeyWords != value))
				{
					this._KeyWords = value;
				}
			}
		}
		
		[Column(Storage="_Url", DbType="NVarChar(460)")]
		public string Url
		{
			get
			{
				return this._Url;
			}
			set
			{
				if ((this._Url != value))
				{
					this._Url = value;
				}
			}
		}
		
		[Column(Storage="_TabPath", DbType="NVarChar(255)")]
		public string TabPath
		{
			get
			{
				return this._TabPath;
			}
			set
			{
				if ((this._TabPath != value))
				{
					this._TabPath = value;
				}
			}
		}
		
		[Column(Storage="_StartDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> StartDate
		{
			get
			{
				return this._StartDate;
			}
			set
			{
				if ((this._StartDate != value))
				{
					this._StartDate = value;
				}
			}
		}
		
		[Column(Storage="_EndDate", DbType="DateTime")]
		public System.Nullable<System.DateTime> EndDate
		{
			get
			{
				return this._EndDate;
			}
			set
			{
				if ((this._EndDate != value))
				{
					this._EndDate = value;
				}
			}
		}
		
		[Column(Storage="_RefreshInterval", DbType="Decimal(0,0)")]
		public System.Nullable<decimal> RefreshInterval
		{
			get
			{
				return this._RefreshInterval;
			}
			set
			{
				if ((this._RefreshInterval != value))
				{
					this._RefreshInterval = value;
				}
			}
		}
		
		[Column(Storage="_PageHeadText", DbType="NVarChar(500)")]
		public string PageHeadText
		{
			get
			{
				return this._PageHeadText;
			}
			set
			{
				if ((this._PageHeadText != value))
				{
					this._PageHeadText = value;
				}
			}
		}
		
		[Column(Storage="_IsSecure", DbType="Bit NOT NULL")]
		public bool IsSecure
		{
			get
			{
				return this._IsSecure;
			}
			set
			{
				if ((this._IsSecure != value))
				{
					this._IsSecure = value;
				}
			}
		}
		
		[Column(Storage="_IsActive", DbType="Bit")]
		public System.Nullable<bool> IsActive
		{
			get
			{
				return this._IsActive;
			}
			set
			{
				if ((this._IsActive != value))
				{
					this._IsActive = value;
				}
			}
		}
		
		[Column(Storage="_PageRoles", DbType="NVarChar(1000)")]
		public string PageRoles
		{
			get
			{
				return this._PageRoles;
			}
			set
			{
				if ((this._PageRoles != value))
				{
					this._PageRoles = value;
				}
			}
		}
	}
	
	public partial class usp_GetAllPagesResult
	{
		
		private string _SEOName;
		
		private string _PageName;
		
		private string _Description;
		
		public usp_GetAllPagesResult()
		{
		}
		
		[Column(Storage="_SEOName", DbType="NVarChar(100)")]
		public string SEOName
		{
			get
			{
				return this._SEOName;
			}
			set
			{
				if ((this._SEOName != value))
				{
					this._SEOName = value;
				}
			}
		}
		
		[Column(Storage="_PageName", DbType="NVarChar(100)")]
		public string PageName
		{
			get
			{
				return this._PageName;
			}
			set
			{
				if ((this._PageName != value))
				{
					this._PageName = value;
				}
			}
		}
		
		[Column(Storage="_Description", DbType="NVarChar(500)")]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
