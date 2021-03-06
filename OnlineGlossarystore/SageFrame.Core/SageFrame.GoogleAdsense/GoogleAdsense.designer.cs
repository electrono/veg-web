﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.239
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SageFrame.Core.SageFrame.GoogleAdsense
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
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="SageFrame")]
	public partial class GoogleAdsenseDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    #endregion
		
		public GoogleAdsenseDataContext() : 
				base(global::SageFrame.GoogleAdsense.Properties.Settings.Default.SageFrameConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleAdsenseDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleAdsenseDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleAdsenseDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public GoogleAdsenseDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_AdSenseSettingsCount")]
		public int sp_AdSenseSettingsCount([global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleCount", DbType="Int")] ref System.Nullable<int> userModuleCount)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), userModuleID, portalID, userModuleCount);
			userModuleCount = ((System.Nullable<int>)(result.GetParameterValue(2)));
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_AdSenseSettingsGetByUserModuleID")]
		public ISingleResult<sp_AdSenseSettingsGetByUserModuleIDResult> sp_AdSenseSettingsGetByUserModuleID([global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), userModuleID, portalID);
			return ((ISingleResult<sp_AdSenseSettingsGetByUserModuleIDResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_AdSenseAddUpdate")]
		public int sp_AdSenseAddUpdate([global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="SettingName", DbType="NVarChar(50)")] string settingName, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="SettingValue", DbType="NVarChar(256)")] string settingValue, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="IsActive", DbType="Bit")] System.Nullable<bool> isActive, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="UpdatedBy", DbType="NVarChar(256)")] string updatedBy, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="UpdateFlag", DbType="Bit")] System.Nullable<bool> updateFlag)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), userModuleID, settingName, settingValue, isActive, portalID, updatedBy, updateFlag);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_CheckUserModulePermissionByPermissionKey")]
		public int sp_CheckUserModulePermissionByPermissionKey([global::System.Data.Linq.Mapping.ParameterAttribute(Name="PermissionKey", DbType="NVarChar(100)")] string permissionKey, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="Username", DbType="NVarChar(256)")] string username, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), permissionKey, userModuleID, username, portalID);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_AdSenseCount")]
		public int sp_AdSenseCount([global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleCount", DbType="Int")] ref System.Nullable<int> userModuleCount)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), userModuleID, portalID, userModuleCount);
			userModuleCount = ((System.Nullable<int>)(result.GetParameterValue(2)));
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_AdSenseDelete")]
		public int sp_AdSenseDelete([global::System.Data.Linq.Mapping.ParameterAttribute(Name="UserModuleID", DbType="Int")] System.Nullable<int> userModuleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), userModuleID, portalID);
			return ((int)(result.ReturnValue));
		}
	}
	
	public partial class sp_AdSenseSettingsGetByUserModuleIDResult
	{
		
		private int _UserModuleID;
		
		private string _SettingName;
		
		private string _SettingValue;
		
		private System.Nullable<bool> _IsActive;
		
		private System.Nullable<bool> _IsDeleted;
		
		private System.Nullable<bool> _IsModified;
		
		private System.Nullable<System.DateTime> _AddedOn;
		
		private System.Nullable<System.DateTime> _UpdatedOn;
		
		private System.Nullable<System.DateTime> _DeletedOn;
		
		private System.Nullable<int> _PortalID;
		
		private string _AddedBy;
		
		private string _UpdatedBy;
		
		private string _DeletedBy;
		
		public sp_AdSenseSettingsGetByUserModuleIDResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UserModuleID", DbType="Int NOT NULL")]
		public int UserModuleID
		{
			get
			{
				return this._UserModuleID;
			}
			set
			{
				if ((this._UserModuleID != value))
				{
					this._UserModuleID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_SettingName", DbType="NVarChar(50) NOT NULL", CanBeNull=false)]
		public string SettingName
		{
			get
			{
				return this._SettingName;
			}
			set
			{
				if ((this._SettingName != value))
				{
					this._SettingName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_SettingValue", DbType="NVarChar(2000)")]
		public string SettingValue
		{
			get
			{
				return this._SettingValue;
			}
			set
			{
				if ((this._SettingValue != value))
				{
					this._SettingValue = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IsActive", DbType="Bit")]
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IsDeleted", DbType="Bit")]
		public System.Nullable<bool> IsDeleted
		{
			get
			{
				return this._IsDeleted;
			}
			set
			{
				if ((this._IsDeleted != value))
				{
					this._IsDeleted = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_IsModified", DbType="Bit")]
		public System.Nullable<bool> IsModified
		{
			get
			{
				return this._IsModified;
			}
			set
			{
				if ((this._IsModified != value))
				{
					this._IsModified = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AddedOn", DbType="DateTime")]
		public System.Nullable<System.DateTime> AddedOn
		{
			get
			{
				return this._AddedOn;
			}
			set
			{
				if ((this._AddedOn != value))
				{
					this._AddedOn = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UpdatedOn", DbType="DateTime")]
		public System.Nullable<System.DateTime> UpdatedOn
		{
			get
			{
				return this._UpdatedOn;
			}
			set
			{
				if ((this._UpdatedOn != value))
				{
					this._UpdatedOn = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DeletedOn", DbType="DateTime")]
		public System.Nullable<System.DateTime> DeletedOn
		{
			get
			{
				return this._DeletedOn;
			}
			set
			{
				if ((this._DeletedOn != value))
				{
					this._DeletedOn = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PortalID", DbType="Int")]
		public System.Nullable<int> PortalID
		{
			get
			{
				return this._PortalID;
			}
			set
			{
				if ((this._PortalID != value))
				{
					this._PortalID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_AddedBy", DbType="NVarChar(256)")]
		public string AddedBy
		{
			get
			{
				return this._AddedBy;
			}
			set
			{
				if ((this._AddedBy != value))
				{
					this._AddedBy = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_UpdatedBy", DbType="NVarChar(256)")]
		public string UpdatedBy
		{
			get
			{
				return this._UpdatedBy;
			}
			set
			{
				if ((this._UpdatedBy != value))
				{
					this._UpdatedBy = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DeletedBy", DbType="NVarChar(256)")]
		public string DeletedBy
		{
			get
			{
				return this._DeletedBy;
			}
			set
			{
				if ((this._DeletedBy != value))
				{
					this._DeletedBy = value;
				}
			}
		}
	}
}
#pragma warning restore 1591
