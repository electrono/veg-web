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

namespace SageFrame.Core.SageFrame.RolesManagement
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
	public partial class RolesManagementDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    #endregion
		
		public RolesManagementDataContext() : 
				base(global::SageFrame.RolesManagement.Properties.Settings.Default.SageFrameConnectionString, mappingSource)
		{
			OnCreated();
		}
		
		public RolesManagementDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public RolesManagementDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public RolesManagementDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public RolesManagementDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_SageFrameRolesList")]
		public ISingleResult<sp_SageFrameRolesListResult> sp_SageFrameRolesList()
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())));
			return ((ISingleResult<sp_SageFrameRolesListResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_PortalRoleAdd")]
		public int sp_PortalRoleAdd([global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalRoleID", DbType="Int")] ref System.Nullable<int> portalRoleID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="RoleName", DbType="NVarChar(256)")] string roleName, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="IsActive", DbType="Bit")] System.Nullable<bool> isActive, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="AddedOn", DbType="DateTime")] System.Nullable<System.DateTime> addedOn, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="AddedBy", DbType="NVarChar(256)")] string addedBy)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), portalRoleID, portalID, roleName, isActive, addedOn, addedBy);
			portalRoleID = ((System.Nullable<int>)(result.GetParameterValue(0)));
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_DeleteRole")]
		public int sp_DeleteRole([global::System.Data.Linq.Mapping.ParameterAttribute(Name="RoleName", DbType="NVarChar(256)")] string roleName)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), roleName);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_PortalRoleDelete")]
		public int sp_PortalRoleDelete([global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="RoleName", DbType="NVarChar(256)")] string roleName)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), portalID, roleName);
			return ((int)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_PortalRoleList")]
		public ISingleResult<sp_PortalRoleListResult> sp_PortalRoleList([global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="IsAll", DbType="Bit")] System.Nullable<bool> isAll, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="Username", DbType="NVarChar(256)")] string username)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), portalID, isAll, username);
			return ((ISingleResult<sp_PortalRoleListResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_RoleGetByUsername")]
		public ISingleResult<sp_RoleGetByUsernameResult> sp_RoleGetByUsername([global::System.Data.Linq.Mapping.ParameterAttribute(Name="Username", DbType="NVarChar(256)")] string username, [global::System.Data.Linq.Mapping.ParameterAttribute(Name="PortalID", DbType="Int")] System.Nullable<int> portalID)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), username, portalID);
			return ((ISingleResult<sp_RoleGetByUsernameResult>)(result.ReturnValue));
		}
		
		[global::System.Data.Linq.Mapping.FunctionAttribute(Name="dbo.sp_GetRoleIDByRoleName")]
		public ISingleResult<sp_GetRoleIDByRoleNameResult> sp_GetRoleIDByRoleName([global::System.Data.Linq.Mapping.ParameterAttribute(Name="RoleName", DbType="VarChar(256)")] string roleName)
		{
			IExecuteResult result = this.ExecuteMethodCall(this, ((MethodInfo)(MethodInfo.GetCurrentMethod())), roleName);
			return ((ISingleResult<sp_GetRoleIDByRoleNameResult>)(result.ReturnValue));
		}
	}
	
	public partial class sp_SageFrameRolesListResult
	{
		
		private System.Guid _ApplicationId;
		
		private System.Guid _RoleId;
		
		private string _RoleName;
		
		private string _LoweredRoleName;
		
		private string _Description;
		
		public sp_SageFrameRolesListResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ApplicationId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid ApplicationId
		{
			get
			{
				return this._ApplicationId;
			}
			set
			{
				if ((this._ApplicationId != value))
				{
					this._ApplicationId = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid RoleId
		{
			get
			{
				return this._RoleId;
			}
			set
			{
				if ((this._RoleId != value))
				{
					this._RoleId = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string RoleName
		{
			get
			{
				return this._RoleName;
			}
			set
			{
				if ((this._RoleName != value))
				{
					this._RoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LoweredRoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string LoweredRoleName
		{
			get
			{
				return this._LoweredRoleName;
			}
			set
			{
				if ((this._LoweredRoleName != value))
				{
					this._LoweredRoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="NVarChar(256)")]
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
	
	public partial class sp_PortalRoleListResult
	{
		
		private int _PortalRoleID;
		
		private int _PortalID;
		
		private System.Guid _RoleID;
		
		private System.Guid _ApplicationId;
		
		private System.Guid _RoleId1;
		
		private string _RoleName;
		
		private string _LoweredRoleName;
		
		private string _Description;
		
		private System.Nullable<bool> _IsActive;
		
		private System.Nullable<bool> _IsDeleted;
		
		private System.Nullable<bool> _IsModified;
		
		private System.Nullable<System.DateTime> _AddedOn;
		
		private System.Nullable<System.DateTime> _UpdatedOn;
		
		private System.Nullable<System.DateTime> _DeletedOn;
		
		private string _AddedBy;
		
		private string _UpdatedBy;
		
		private string _DeletedBy;
		
		public sp_PortalRoleListResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PortalRoleID", DbType="Int NOT NULL")]
		public int PortalRoleID
		{
			get
			{
				return this._PortalRoleID;
			}
			set
			{
				if ((this._PortalRoleID != value))
				{
					this._PortalRoleID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_PortalID", DbType="Int NOT NULL")]
		public int PortalID
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
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleID", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid RoleID
		{
			get
			{
				return this._RoleID;
			}
			set
			{
				if ((this._RoleID != value))
				{
					this._RoleID = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ApplicationId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid ApplicationId
		{
			get
			{
				return this._ApplicationId;
			}
			set
			{
				if ((this._ApplicationId != value))
				{
					this._ApplicationId = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleId1", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid RoleId1
		{
			get
			{
				return this._RoleId1;
			}
			set
			{
				if ((this._RoleId1 != value))
				{
					this._RoleId1 = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string RoleName
		{
			get
			{
				return this._RoleName;
			}
			set
			{
				if ((this._RoleName != value))
				{
					this._RoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LoweredRoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string LoweredRoleName
		{
			get
			{
				return this._LoweredRoleName;
			}
			set
			{
				if ((this._LoweredRoleName != value))
				{
					this._LoweredRoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="NVarChar(256)")]
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
	
	public partial class sp_RoleGetByUsernameResult
	{
		
		private System.Guid _RoleId;
		
		public sp_RoleGetByUsernameResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid RoleId
		{
			get
			{
				return this._RoleId;
			}
			set
			{
				if ((this._RoleId != value))
				{
					this._RoleId = value;
				}
			}
		}
	}
	
	public partial class sp_GetRoleIDByRoleNameResult
	{
		
		private System.Guid _ApplicationId;
		
		private System.Guid _RoleId;
		
		private string _RoleName;
		
		private string _LoweredRoleName;
		
		private string _Description;
		
		public sp_GetRoleIDByRoleNameResult()
		{
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_ApplicationId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid ApplicationId
		{
			get
			{
				return this._ApplicationId;
			}
			set
			{
				if ((this._ApplicationId != value))
				{
					this._ApplicationId = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleId", DbType="UniqueIdentifier NOT NULL")]
		public System.Guid RoleId
		{
			get
			{
				return this._RoleId;
			}
			set
			{
				if ((this._RoleId != value))
				{
					this._RoleId = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_RoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string RoleName
		{
			get
			{
				return this._RoleName;
			}
			set
			{
				if ((this._RoleName != value))
				{
					this._RoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_LoweredRoleName", DbType="NVarChar(256) NOT NULL", CanBeNull=false)]
		public string LoweredRoleName
		{
			get
			{
				return this._LoweredRoleName;
			}
			set
			{
				if ((this._LoweredRoleName != value))
				{
					this._LoweredRoleName = value;
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_Description", DbType="NVarChar(256)")]
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