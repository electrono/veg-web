﻿/*
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
using System.Data.SqlClient;
using System.Text;
using SageFrame.Web;
using System.Data;
using SageFrame.Web.Utilities;
using System.Web.Script.Serialization;

namespace ASPXCommerce.Core
{
    public class PriceRuleController
    {
        public List<PortalRole> GetPortalRoles(int portalID, bool isAll, string userName)
        {
            string rolePrefix = string.Empty;
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            List<PortalInfo> portalInfoList = priceRuleSqlProvider.GetPortalSeoName(portalID, userName);
            if (portalInfoList.Count > 0)
            {
                rolePrefix = portalInfoList[0].SEOName.Trim() + "_";
            }

            List<PortalRole> portalRoleList = priceRuleSqlProvider.GetPortalRoles(portalID, isAll, userName);
            foreach (PortalRole pr in portalRoleList)
            {
                bool isSystemRole = false;
                foreach (string sysRole in SystemSetting.SYSTEM_ROLES)
                {
                    if (sysRole.ToLower() == pr.RoleName.ToLower())
                    {
                        isSystemRole = true;
                    }
                }
                if (!isSystemRole)
                {
                    pr.RoleName = pr.RoleName.Replace(rolePrefix, "");
                }
            }
            return portalRoleList;
        }

        public List<PricingRuleAttributeInfo> GetPricingRuleAttributes(int portalID, int storeID, string userName, string cultureName)
        {
            List<PricingRuleAttributeInfo> listPricingRuleAttributeInfo = new List<PricingRuleAttributeInfo>();

            return listPricingRuleAttributeInfo;
        }

        public List<CatalogPriceRulePaging> GetCatalogPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            List<CatalogPriceRulePaging> lstCatalogPriceRule = priceRuleSqlProvider.GetCatalogPricingRules(ruleName, startDate, endDate,isActive, storeID, portalID, userName, culture, offset, limit);
            return lstCatalogPriceRule;
        }

        public CatalogPricingRuleInfo GetCatalogPricingRule(Int32 catalogPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            DataSet ds = new DataSet();
            ds = priceRuleSqlProvider.GetCatalogPricingRule(catalogPriceRuleID, storeID, portalID, userName, culture);
            DataTable dtCatalogPricingRule = ds.Tables[0];
            DataTable dtCatalogPriceRuleCondition = ds.Tables[1];
            DataTable dtCatalogConditionDetails = ds.Tables[2];
            DataTable dtCatalogPriceRuleRoles = ds.Tables[3];
            List<CatalogPriceRule> lstCatalogPriceRule = new List<CatalogPriceRule>();
            lstCatalogPriceRule = DataSourceHelper.FillCollection<CatalogPriceRule>(dtCatalogPricingRule);

            List<CatalogPriceRuleCondition> lstCatalogPriceRuleCondition = new List<CatalogPriceRuleCondition>();
            lstCatalogPriceRuleCondition = DataSourceHelper.FillCollection<CatalogPriceRuleCondition>(dtCatalogPriceRuleCondition);

            List<CatalogPriceRuleRole> lstCatalogPriceRuleRole = new List<CatalogPriceRuleRole>();
            lstCatalogPriceRuleRole = DataSourceHelper.FillCollection<CatalogPriceRuleRole>(dtCatalogPriceRuleRoles);

            List<CatalogConditionDetail> lstCatalogConditionDetail = new List<CatalogConditionDetail>();
            lstCatalogConditionDetail = DataSourceHelper.FillCollection<CatalogConditionDetail>(dtCatalogConditionDetails);

            CatalogPricingRuleInfo catalogPricingRuleInfo = new CatalogPricingRuleInfo();
            CatalogPriceRule catalogPriceRule = lstCatalogPriceRule[0];
            catalogPricingRuleInfo.CatalogPriceRule = catalogPriceRule;
            List<CatalogPriceRuleCondition> lstCPRC = new List<CatalogPriceRuleCondition>();
            foreach (CatalogPriceRuleCondition catalogPriceRuleCondition in lstCatalogPriceRuleCondition)
            {
                List<CatalogConditionDetail> lstCCD = new List<CatalogConditionDetail>();
                foreach (CatalogConditionDetail catalogConditionDetail in lstCatalogConditionDetail)
                {
                    if (catalogPriceRuleCondition.CatalogPriceRuleConditionID == catalogConditionDetail.CatalogPriceRuleConditionID)
                    {
                        lstCCD.Add(catalogConditionDetail);
                    }
                }
                catalogPriceRuleCondition.CatalogConditionDetail = lstCCD;
                lstCPRC.Add(catalogPriceRuleCondition);
            }
            catalogPricingRuleInfo.CatalogPriceRuleConditions = lstCPRC;

            List<CatalogPriceRuleRole> lstCPRR = new List<CatalogPriceRuleRole>();
            foreach (CatalogPriceRuleRole catalogPriceRuleRole in lstCatalogPriceRuleRole)
            {
                if (catalogPriceRuleRole.CatalogPriceRuleID == catalogPriceRule.CatalogPriceRuleID)
                {
                    lstCPRR.Add(catalogPriceRuleRole);
                }
            }
            catalogPricingRuleInfo.CatalogPriceRuleRoles = lstCPRR;

            return catalogPricingRuleInfo;
        }

        public int SaveCatalogPricingRule(CatalogPricingRuleInfo objCatalogPricingRuleInfo, Int32 storeID, Int32 portalID, string userName, string culture, object parentID)
        {

            int catalogPriceRuleID = -1;
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            catalogPriceRuleID = priceRuleSqlProvider.CatalogPriceRuleAdd(objCatalogPricingRuleInfo.CatalogPriceRule, storeID, portalID, userName, culture);

            if (catalogPriceRuleID > 0)
            {
                int count = 0;
                int cpID = 0;
                int catalogConditionID = 0;
                List<object> lstParent = new JavaScriptSerializer().ConvertToType<List<object>>(parentID);

                foreach (CatalogPriceRuleCondition catalogPriceRuleCondition in objCatalogPricingRuleInfo.CatalogPriceRuleConditions)
                {
                    if (count == 1 && catalogConditionID > 1)
                        cpID = catalogConditionID - 1;
                    catalogPriceRuleCondition.ParentID = cpID + int.Parse(lstParent[count].ToString());
                    catalogPriceRuleCondition.CatalogPriceRuleID = catalogPriceRuleID;
                    catalogConditionID = priceRuleSqlProvider.CatalogPriceRuleConditionAdd(catalogPriceRuleCondition, storeID,
                                                                      portalID, userName, culture);
                    count++;
                }

                int catalogPriceRuleRoleID = -1;
                foreach (CatalogPriceRuleRole catalogPriceRuleRole in objCatalogPricingRuleInfo.CatalogPriceRuleRoles)
                {
                    catalogPriceRuleRole.CatalogPriceRuleID = catalogPriceRuleID;
                    catalogPriceRuleRoleID = priceRuleSqlProvider.CatalogPriceRuleRoleAdd(catalogPriceRuleRole, storeID, portalID, userName, culture);
                }
            }
            return 1;
        }
        
        public int CatalogPriceRuleDelete(int catalogPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            return priceRuleSqlProvider.CatalogPriceRuleDelete(catalogPriceRuleID, storeID, portalID, userName, culture);
        }

        public int CatalogPriceMultipleRulesDelete(string catRulesIds, int storeID, int portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            return priceRuleSqlProvider.CatalogPriceRulesMultipleDelete(catRulesIds, storeID, portalID, userName, culture);
        }

        public int SaveCartPricingRule(CartPricingRuleInfo objCartPriceRule, Int32 storeID, Int32 portalID, string userName, string culture, object parentID)
        {
            SQLHandler sqlH = new SQLHandler();
            SqlTransaction tran;
            tran = (SqlTransaction) sqlH.GetTransaction();
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            try
            {
                int cartPriceRuleID = -1;
                cartPriceRuleID = priceRuleSqlProvider.CartPriceRuleAdd(objCartPriceRule.CartPriceRule, tran, portalID,userName, culture);

                priceRuleSqlProvider.RuleConditionAdd(objCartPriceRule.lstRuleCondition,cartPriceRuleID,parentID, tran, portalID, userName,culture);

                foreach (CartPriceRuleRole cartPriceRuleRole in objCartPriceRule.lstCartPriceRuleRoles)
                {
                    cartPriceRuleRole.CartPriceRuleID = cartPriceRuleID;
                    priceRuleSqlProvider.CartPriceRuleRoleAdd(cartPriceRuleRole, tran, portalID, userName,culture);
                }

                foreach (CartPriceRuleStore cartPriceRuleStore in objCartPriceRule.lstCartPriceRuleStores)
                {
                    cartPriceRuleStore.CartPriceRuleID = cartPriceRuleID;
                    priceRuleSqlProvider.CartPriceRuleStoreAdd(cartPriceRuleStore, tran, portalID, userName,culture);
                }
                tran.Commit();
                return cartPriceRuleID;
            }

            catch (SqlException sqlEX)
            {
                tran.Rollback();
                throw new ArgumentException(sqlEX.Message);
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }
        }

        public int CartPriceRuleDelete(int cartPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            return priceRuleSqlProvider.CartPriceRuleDelete(cartPriceRuleID,  portalID,storeID, userName, culture);
        }

        public int CartPriceMultipleRulesDelete(string cartRulesIds, int storeID, int portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            return priceRuleSqlProvider.CartPriceRulesMultipleDelete(cartRulesIds, storeID, portalID, userName, culture);
        }
        
        public List<CartPriceRulePaging> GetCartPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            List<CartPriceRulePaging> lstCartPriceRule = priceRuleSqlProvider.GetCartPricingRules(ruleName, startDate, endDate, isActive, storeID, portalID, userName, culture, offset, limit);
            
            return lstCartPriceRule;
        }

        public CartPricingRuleInfo GetCartPriceRules(Int32 cartPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            PriceRuleSqlProvider priceRuleSqlProvider = new PriceRuleSqlProvider();
            CartPricingRuleInfo cartPricingRuleInfo = new CartPricingRuleInfo();

            DataSet ds = new DataSet();
            ds = priceRuleSqlProvider.GetCartPriceRule(cartPriceRuleID, portalID, userName, culture);
            DataTable dtCartPricingRule = ds.Tables[0];
            DataTable dtRuleConditions = ds.Tables[1];
            DataTable dtCartPriceRuleRoles = ds.Tables[2];
            DataTable dtCartPriceRuleStores = ds.Tables[3];

            List<CartPriceRule> lstCartPriceRule = new List<CartPriceRule>();
            lstCartPriceRule = DataSourceHelper.FillCollection<CartPriceRule>(dtCartPricingRule);
            List<RuleCondition> lstRuleConditions = new List<RuleCondition>();
            lstRuleConditions = DataSourceHelper.FillCollection<RuleCondition>(dtRuleConditions);
            List<CartPriceRuleRole> lstCartPriceRuleRole = new List<CartPriceRuleRole>();
            lstCartPriceRuleRole = DataSourceHelper.FillCollection<CartPriceRuleRole>(dtCartPriceRuleRoles);
            List<CartPriceRuleStore> lstCartPriceRuleStore = new List<CartPriceRuleStore>();
            lstCartPriceRuleStore = DataSourceHelper.FillCollection<CartPriceRuleStore>(dtCartPriceRuleStores);

            cartPricingRuleInfo.CartPriceRule = lstCartPriceRule[0];
            List<RuleCondition> lstRC = new List<RuleCondition>();
            foreach (RuleCondition rc in lstRuleConditions)
            {
                RuleCondition objRC = new RuleCondition();
                objRC.ParentID = rc.ParentID;
                objRC.RuleConditionID = rc.RuleConditionID;
                objRC.RuleConditionType = rc.RuleConditionType;
                objRC.CartPriceRuleID = rc.CartPriceRuleID;

                if (rc.RuleConditionType.ToUpper().Trim() == "PAC".ToUpper().Trim())
                {
                    objRC.lstProductAttributeRuleConditions =
                        priceRuleSqlProvider.GetCartPriceProductAttributeConditions(rc.RuleConditionID, portalID);
                    objRC.lstProductAttributeRuleConditions[0].lstCartConditionDetails =
                        priceRuleSqlProvider.GetCartPriceRuleConditionDetails(rc.CartPriceRuleID,rc.RuleConditionID, portalID, userName);
                    lstRC.Add(objRC);
                }
                else if (rc.RuleConditionType.ToUpper().Trim() == "PS".ToUpper().Trim())
                {
                    objRC.lstProductSublectionRuleConditions =
                        priceRuleSqlProvider.GetCartPriceSubSelections(rc.RuleConditionID, portalID);
                    objRC.lstProductSublectionRuleConditions[0].lstCartConditionDetails =
                       priceRuleSqlProvider.GetCartPriceRuleConditionDetails(rc.CartPriceRuleID, rc.RuleConditionID, portalID, userName);
                    lstRC.Add(objRC);

                }
                else if (rc.RuleConditionType.ToUpper().Trim() == "CC".ToUpper().Trim())
                {
                    objRC.lstCartPriceRuleConditions =
                        priceRuleSqlProvider.GetCartPriceRuleConditions(rc.RuleConditionID, portalID);
                    objRC.lstCartPriceRuleConditions[0].lstCartConditionDetails =
                       priceRuleSqlProvider.GetCartPriceRuleConditionDetails(rc.CartPriceRuleID, rc.RuleConditionID, portalID, userName);
                    lstRC.Add(objRC);
                }
            }
            cartPricingRuleInfo.lstRuleCondition = lstRC;
            cartPricingRuleInfo.lstCartPriceRuleRoles = lstCartPriceRuleRole;
            cartPricingRuleInfo.lstCartPriceRuleStores = lstCartPriceRuleStore;

            return cartPricingRuleInfo;
        }
    }
}