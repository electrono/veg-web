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
using System.Text;
using SageFrame.Web.Utilities;
using System.Data;
using System.Data.SqlClient;
using SageFrame.Web;
using System.Web.Script.Serialization;

namespace ASPXCommerce.Core
{
    public class PriceRuleSqlProvider
    {
        public string ConnectionString
        {
            get { return SystemSetting.SageFrameConnectionString; }
        }
        public List<PortalInfo> GetPortalSeoName(int portalID, string userName)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            return sqlHandler.ExecuteAsList<PortalInfo>("sp_PortalGetByPortalID", paramList);
        }
        public List<PortalRole> GetPortalRoles(int portalID, bool isAll, string userName)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@IsAll", isAll));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            return sqlHandler.ExecuteAsList<PortalRole>("sp_PortalRoleList", paramList);
        }


        #region Catalog Pricing Rule
        public List<PricingRuleAttributeInfo> GetPricingRuleAttributes(int portalID, int storeID, string userName, string cultureName)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return sqlHandler.ExecuteAsList<PricingRuleAttributeInfo>("usp_ASPX_GetPricingRuleAttr", paramList);
        }

        public DataSet GetCatalogPricingRule(Int32 catalogPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CatalogPriceRuleID", catalogPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", culture));
            DataSet ds = sqlHandler.ExecuteAsDataSet("usp_ASPX_GetPricingRuleInfoByID", paramList);
            return ds;
        }

        public List<CatalogPriceRulePaging> GetCatalogPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@offset", offset));
            paramList.Add(new KeyValuePair<string, object>("@limit", limit));
            paramList.Add(new KeyValuePair<string, object>("@RuleName", ruleName));
            paramList.Add(new KeyValuePair<string, object>("@StartDate", startDate));
            paramList.Add(new KeyValuePair<string, object>("@EndDate", endDate));
            paramList.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            paramList.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", culture));
            List<CatalogPriceRulePaging> lstCatalogPriceRule = sqlHandler.ExecuteAsList<CatalogPriceRulePaging>("usp_ASPX_GetPricingRules", paramList);
            return lstCatalogPriceRule;
        }

        public int CatalogPriceRuleAdd(CatalogPriceRule catalogPriceRule, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleID", catalogPriceRule.CatalogPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleName", catalogPriceRule.CatalogPriceRuleName));
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleDescription", catalogPriceRule.CatalogPriceRuleDescription));
            sqlCommand.Parameters.Add(new SqlParameter("@Apply", catalogPriceRule.Apply));
            sqlCommand.Parameters.Add(new SqlParameter("@Value", catalogPriceRule.Value));
            sqlCommand.Parameters.Add(new SqlParameter("@IsFurtherProcessing", catalogPriceRule.IsFurtherProcessing));
            sqlCommand.Parameters.Add(new SqlParameter("@FromDate", catalogPriceRule.FromDate));
            sqlCommand.Parameters.Add(new SqlParameter("@ToDate", catalogPriceRule.ToDate));
            sqlCommand.Parameters.Add(new SqlParameter("@Priority", catalogPriceRule.Priority));
            sqlCommand.Parameters.Add(new SqlParameter("@IsActive", catalogPriceRule.IsActive));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogPriceRuleAdd";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }

        public int CatalogPriceRuleConditionAdd(CatalogPriceRuleCondition catalogPriceRuleCondition, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleID", catalogPriceRuleCondition.CatalogPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@IsAll", catalogPriceRuleCondition.IsAll));
            sqlCommand.Parameters.Add(new SqlParameter("@IsTrue", catalogPriceRuleCondition.IsTrue));
            sqlCommand.Parameters.Add(new SqlParameter("@ParentID", catalogPriceRuleCondition.ParentID));
            sqlCommand.Parameters.Add(new SqlParameter("@IsActive", true));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogPriceRuleConditionAdd";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                if (Convert.ToInt16(val) > 0)
                {
                    int catalogConditionDetailID = -1;
                    PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
                    foreach (CatalogConditionDetail catalogConditionDetail in catalogPriceRuleCondition.CatalogConditionDetail)
                    {
                        if (catalogConditionDetail != null)
                        {
                            catalogConditionDetail.CatalogPriceRuleConditionID = Convert.ToInt16(val);
                            catalogConditionDetail.CatalogPriceRuleID = catalogPriceRuleCondition.CatalogPriceRuleID;
                            catalogConditionDetailID =
                                priceRuleSqlProvider.CatalogConditionDetailAdd(catalogConditionDetail, storeID, portalID,
                                                                               userName, culture);
                            if (!(catalogConditionDetailID > 0))
                            {
                            }
                        }
                    }
                }
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }           
        }

        public int CatalogPriceRuleRoleAdd(CatalogPriceRuleRole catalogPriceRuleRole, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleID", catalogPriceRuleRole.CatalogPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@RoleID", catalogPriceRuleRole.RoleID));
            sqlCommand.Parameters.Add(new SqlParameter("@IsActive", true));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogPriceRuleRoleAdd";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }

        public int CatalogConditionDetailAdd(CatalogConditionDetail catalogConditionDetail, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleConditionID", catalogConditionDetail.CatalogPriceRuleConditionID));
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleID", catalogConditionDetail.CatalogPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@AttributeID", catalogConditionDetail.AttributeID));
            sqlCommand.Parameters.Add(new SqlParameter("@RuleOperatorID", catalogConditionDetail.RuleOperatorID));
            sqlCommand.Parameters.Add(new SqlParameter("@Value", catalogConditionDetail.Value));
            sqlCommand.Parameters.Add(new SqlParameter("@Priority", catalogConditionDetail.Priority));
            sqlCommand.Parameters.Add(new SqlParameter("@IsActive", true));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogConditionDetailAdd";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }

        public int CatalogPriceRuleDelete(int catalogPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {

            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRuleID", catalogPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogPriceRuleDelete";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }

        public int CatalogPriceRulesMultipleDelete(string catRulesIds, int storeID, int portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CatalogPriceRulesIDs", catRulesIds));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CatalogPriceRulesDeleteMultiple";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        #endregion

        #region Cart Pricing rule

        public List<CartPricingRuleAttributeInfo> GetCartPricingRuleAttributes(int portalID, int storeID, string userName, string cultureName)
        {
            List<CartPricingRuleAttributeInfo> lst = new List<CartPricingRuleAttributeInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            lst = sqlHandler.ExecuteAsList<CartPricingRuleAttributeInfo>("usp_ASPX_GetCartPricingRuleAttr", paramList);
            return lst;
        }

        public DataSet GetCartPricingRule(Int32 cartPriceRuleID, Int32 portalID, string userName, string culture)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", culture));
            DataSet ds = sqlHandler.ExecuteAsDataSet("usp_ASPX_GetCartPricingRuleInfoByID", paramList);
            return ds;
        }

        public DataSet GetCartPriceRule(Int32 cartPriceRuleID, Int32 portalID, string userName, string culture)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", culture));
            DataSet ds = sqlHandler.ExecuteAsDataSet("[dbo].[usp_ASPX_GetCartPricingRule]", paramList);
            return ds;
        }

        public DataTable GetPriceRuleConditions(Int32 cartPriceRuleID, Int32 portalID, string userName)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            DataSet ds = sqlHandler.ExecuteAsDataSet("[dbo].[usp_ASPX_GetPricingRuleConditions]", paramList);
            return ds.Tables[0];
        }
        public List<CartPriceRuleCondition> GetCartPriceRuleConditions(Int32? ruleConditionID, Int32 portalID)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            return sqlHandler.ExecuteAsList<CartPriceRuleCondition>("[dbo].[usp_ASPX_GetCartPriceConditions]", paramList);
        }
        public List<ProductAttributeRuleCondition> GetCartPriceProductAttributeConditions(Int32? ruleConditionID, Int32 portalID)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            return sqlHandler.ExecuteAsList<ProductAttributeRuleCondition>("[dbo].[usp_ASPX_GetProductAttributeCombinations]", paramList);
        }
        public List<ProductSubSelectionRuleCondition> GetCartPriceSubSelections(Int32? ruleConditionID, Int32 portalID)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            return sqlHandler.ExecuteAsList<ProductSubSelectionRuleCondition>("[dbo].[usp_ASPX_GetProductSubSelections]", paramList);
        }

        public List<CartConditionDetail> GetCartPriceRuleConditionDetails(Int32 cartPriceRuleID,Int32? ruleConditionID, Int32 portalID, string userName)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            return sqlHandler.ExecuteAsList<CartConditionDetail>("[dbo].[usp_ASPX_CartPriceRuleConditionDetails]", paramList);
        }


        public List<CartPriceRulePaging> GetCartPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@offset", offset));
            paramList.Add(new KeyValuePair<string, object>("@limit", limit));
            paramList.Add(new KeyValuePair<string, object>("@RuleName", ruleName));
            paramList.Add(new KeyValuePair<string, object>("@StartDate", startDate));
            paramList.Add(new KeyValuePair<string, object>("@EndDate", endDate));
            paramList.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            paramList.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramList.Add(new KeyValuePair<string, object>("@Username", userName));
            paramList.Add(new KeyValuePair<string, object>("@CultureName", culture));
            List<CartPriceRulePaging> lstCartPriceRule = sqlHandler.ExecuteAsList<CartPriceRulePaging>("usp_ASPX_GetCartPrincingRules", paramList);
            return lstCartPriceRule;
        }

        public int CartPriceRuleAdd(CartPriceRule cartPriceRule,SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleName", cartPriceRule.CartPriceRuleName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleDescription", cartPriceRule.CartPriceRuleDescription));
            ParaMeter.Add(new KeyValuePair<string, object>("@Apply", cartPriceRule.Apply));
            ParaMeter.Add(new KeyValuePair<string, object>("@Value", cartPriceRule.Value));
            ParaMeter.Add(new KeyValuePair<string, object>("@ApplytoShippingAmount", cartPriceRule.ApplytoShippingAmount));
            ParaMeter.Add(new KeyValuePair<string, object>("@DiscountQuantity", cartPriceRule.DiscountQuantity));
            ParaMeter.Add(new KeyValuePair<string, object>("@DiscountStep", cartPriceRule.DiscountStep));
            ParaMeter.Add(new KeyValuePair<string, object>("@FreeShipping", cartPriceRule.FreeShipping));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsFurtherProcessing", cartPriceRule.IsFurtherProcessing));
            ParaMeter.Add(new KeyValuePair<string, object>("@FromDate", cartPriceRule.FromDate));
            ParaMeter.Add(new KeyValuePair<string, object>("@ToDate", cartPriceRule.ToDate));
            ParaMeter.Add(new KeyValuePair<string, object>("@Priority", cartPriceRule.Priority));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", cartPriceRule.IsActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", culture));
           
            try
            {
                SQLHandler sqlH = new SQLHandler();

                if (cartPriceRule.CartPriceRuleID > 0)
                    DeleteCartPricingRuleForEdit(Tran, cartPriceRule.CartPriceRuleID, portalID);
               
                return sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "usp_ASPX_CartPriceRuleAdd", ParaMeter, "@CartPriceRuleID");
                
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void DeleteCartPricingRuleForEdit(SqlTransaction tran, Int32 cartPriceRuleID, Int32 portalID)
        {
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> paramList = new List<KeyValuePair<string, object>>();
            paramList.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
            paramList.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            sqlHandler.ExecuteNonQuery(tran,CommandType.StoredProcedure,"usp_ASPX_DeleteCartPriceForEdit", paramList);
        }


        public int RuleConditionAdd(List<RuleCondition> lstRuleCondition,int cartPriceRuleID,object parentID ,SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            try
            {
                int ruleConditionID = 0;
                int count = 0;
                int rcID = 0;
                List<object> lstParent = new JavaScriptSerializer().ConvertToType<List<object>>(parentID);

                foreach (RuleCondition objRuleCondition in lstRuleCondition)
                {
                    if (count == 1 && ruleConditionID > 1)
                        rcID = ruleConditionID - 1;

                    List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                    ParaMeter.Add(new KeyValuePair<string, object>("@RuleConditionType",objRuleCondition.RuleConditionType));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ParentID",
                                                                   rcID + int.Parse(lstParent[count].ToString())));
                    ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));

                    SQLHandler sqlH = new SQLHandler();
                    ruleConditionID = sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure,"[dbo].[usp_ASPX_RuleConditionAdd]",ParaMeter, "@RuleConditionID");

                    if (objRuleCondition.RuleConditionType == "CC" && objRuleCondition.lstCartPriceRuleConditions != null && objRuleCondition.lstCartPriceRuleConditions.Count>0)
                    {
                        CartPriceRuleConditionAdd(objRuleCondition.lstCartPriceRuleConditions, cartPriceRuleID, ruleConditionID, Tran, portalID, userName, culture);
                    }
                    else if (objRuleCondition.RuleConditionType == "PAC" && objRuleCondition.lstProductAttributeRuleConditions != null &&  objRuleCondition.lstProductAttributeRuleConditions.Count>0)
                    {
                        ProductAttributeRuleConditionAdd(objRuleCondition.lstProductAttributeRuleConditions, cartPriceRuleID, ruleConditionID, Tran, portalID, userName, culture);
                    }
                    else if (objRuleCondition.RuleConditionType == "PS" && objRuleCondition.lstProductSublectionRuleConditions != null && objRuleCondition.lstProductSublectionRuleConditions.Count>0)
                    {
                        SubselectionRuleConditionAdd(objRuleCondition.lstProductSublectionRuleConditions, cartPriceRuleID, ruleConditionID, Tran, portalID, userName, culture);
                    }

                    count++;
                }
                return ruleConditionID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

         public int GetCartPriceRuleConditions( )
        {
            SQLHandler sqlHandler = new SQLHandler();
            return sqlHandler.ExecuteAsScalar<int>("[dbo].[usp_ASPX_GetRuleConditions]");
        }
        
        public void CartPriceRuleConditionAdd(List<CartPriceRuleCondition> lstCartPriceRuleCondition, int cartPriceRuleID,int ruleConditionID, SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsAll", lstCartPriceRuleCondition[0].IsAll));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsTrue", lstCartPriceRuleCondition[0].IsTrue));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           
            SQLHandler sqlH = new SQLHandler();
            try
            {
                sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "[dbo].[usp_ASPX_CartPriceRuleConditionAdd]", ParaMeter);
                if (lstCartPriceRuleCondition[0].lstCartConditionDetails != null && lstCartPriceRuleCondition[0].lstCartConditionDetails.Count > 0)
                {
                    CartConditionDetailAdd(lstCartPriceRuleCondition[0].lstCartConditionDetails,
                                           ruleConditionID, cartPriceRuleID, Tran, portalID,
                                           userName, culture);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void ProductAttributeRuleConditionAdd(List<ProductAttributeRuleCondition> lstPACRuleCondition, int cartPriceRuleID, int ruleConditionID, SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsAll", lstPACRuleCondition[0].IsAll));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsFound", lstPACRuleCondition[0].IsFound));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));

            SQLHandler sqlH = new SQLHandler();
            try
            {
                sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "[dbo].[usp_ASPX_ProductAttributeRuleConditionAdd]", ParaMeter);
                if (lstPACRuleCondition[0].lstCartConditionDetails != null && lstPACRuleCondition[0].lstCartConditionDetails.Count > 0)
                {
                    CartConditionDetailAdd(lstPACRuleCondition[0].lstCartConditionDetails,
                                           ruleConditionID, cartPriceRuleID, Tran, portalID,
                                           userName, culture);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        
        public void SubselectionRuleConditionAdd(List<ProductSubSelectionRuleCondition> lstPSRuleCondition, int cartPriceRuleID, int ruleConditionID, SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsAll", lstPSRuleCondition[0].IsAll));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsQuantity", lstPSRuleCondition[0].IsQuantity));
            ParaMeter.Add(new KeyValuePair<string, object>("@Value", lstPSRuleCondition[0].Value));
            ParaMeter.Add(new KeyValuePair<string, object>("@RuleOperatorID", lstPSRuleCondition[0].RuleOperatorID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           
            SQLHandler sqlH = new SQLHandler();
            try
            {
                sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "[dbo].[usp_ASPX_ProductSubSelectionRuleConditionAdd]", ParaMeter);
                if (lstPSRuleCondition[0].lstCartConditionDetails != null && lstPSRuleCondition[0].lstCartConditionDetails.Count > 0)
                {
                    CartConditionDetailAdd(lstPSRuleCondition[0].lstCartConditionDetails,
                                           ruleConditionID, cartPriceRuleID, Tran, portalID,
                                           userName, culture);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void CartConditionDetailAdd(List<CartConditionDetail> lstCartConditionDetail, int? ruleConditionID, int cartPriceRuleID, SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            try
            {
                foreach (CartConditionDetail objCartConditionDetail in lstCartConditionDetail)
                {
                    if (objCartConditionDetail != null)
                    {
                        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                        ParaMeter.Add(new KeyValuePair<string, object>("@RuleConditionID", ruleConditionID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@AttributeID",
                                                                       objCartConditionDetail.AttributeID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@RuleOperatorID",
                                                                       objCartConditionDetail.RuleOperatorID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@Value", objCartConditionDetail.Value));
                        ParaMeter.Add(new KeyValuePair<string, object>("@Priority", objCartConditionDetail.Priority));
                        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", true));
                        ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
                        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", culture));

                        SQLHandler sqlH = new SQLHandler();
                        sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure,
                                             "[dbo].[usp_ASPX_CartConditionDetailAdd]", ParaMeter);
                    }
                }
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void CartPriceRuleRoleAdd(CartPriceRuleRole cartPriceRuleRole,SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleRole.CartPriceRuleID));
            ParaMeter.Add(new KeyValuePair<string, object>("@RoleID", cartPriceRuleRole.RoleID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", true));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", culture));
            SQLHandler sqlH =new SQLHandler();
            try
            {
                sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "[dbo].[usp_ASPX_CartPriceRuleRoleAdd]", ParaMeter);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void CartPriceRuleStoreAdd(CartPriceRuleStore cartPriceRuleStore,SqlTransaction Tran, Int32 portalID, string userName, string culture)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartPriceRuleID", cartPriceRuleStore.CartPriceRuleID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", cartPriceRuleStore.StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", true));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", culture));
            
            try
            {
                SQLHandler sqlH = new SQLHandler();
                sqlH.ExecuteNonQuery(Tran, CommandType.StoredProcedure, "usp_ASPX_CartPriceRuleStoreAdd", ParaMeter);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public int CartPriceRuleDelete(int cartPriceRuleID, Int32 portalID, Int32 storeID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CartPriceRuleID", cartPriceRuleID));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CartPriceRuleDelete";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
          
        public int CartPriceRulesMultipleDelete(string cartRulesIds, int storeID, int portalID, string userName, string culture)
        {
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Parameters.Add(new SqlParameter("@CartPriceRulesIDs", cartRulesIds));
            sqlCommand.Parameters.Add(new SqlParameter("@StoreID", storeID));
            sqlCommand.Parameters.Add(new SqlParameter("@PortalID", portalID));
            sqlCommand.Parameters.Add(new SqlParameter("@Username", userName));
            sqlCommand.Parameters.Add(new SqlParameter("@CultureName", culture));
            sqlCommand.CommandText = "usp_ASPX_CartPriceRulesDeleteMultiple";
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlConnection sqlConnection = new SqlConnection(ConnectionString);
            try
            {
                sqlCommand.Connection = sqlConnection;
                sqlConnection.Open();
                object val = sqlCommand.ExecuteScalar();
                return Convert.ToInt16(val);
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        #endregion
    }
}
