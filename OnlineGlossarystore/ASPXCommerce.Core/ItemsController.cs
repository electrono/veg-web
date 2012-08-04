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
using System.Text;

namespace ASPXCommerce.Core
{
    public class ItemsController
    {
        #region Constructor
        public ItemsController()
        {
        }
        #endregion

        public int SaveUpdateItemAndAttributes(int itemID, int itemTypeID, int attributeSetID, int storeID, int portalID, string userName, string culture, int taxClassID, string categoriesIDs, string relatedItemsIDs, string upSellItemsIDs, string crossSellItemsIDs, string downloadItemsValue, ASPXNameValue[] formVars)
        {
            bool isModified = false;
            bool updateFlag = false;
            if (itemID > 0)
            {
                isModified = true;
                updateFlag = true;
            }
            int itemLargeThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemLargeThumbnailImageSize, storeID,
                                                                                                portalID, culture));
            int itemMediumThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemMediumThumbnailImageSize,
                                                                                                 storeID, portalID, culture));
            int itemSmallThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemSmallThumbnailImageSize, storeID,
                                                                                                portalID, culture));
            int _attributeID = 0;
            int _inputTypeID = 0;
            int _ValidationTypeID = 8;
            int _attributeSetGroupID = 0;
            bool _isIncludeInPriceRule = false;
            bool _isIncludeInPromotions = false;
            int _displayOrder = 0;

            string sku = "";
            string activeFrom = "";
            string activeTo = "";
            string hidePrice = "";
            string isHideInRSS = "";
            string isHideToAnonymous = "";

            bool toInsertIntoDB = true;
            bool isFormValid = true;
            string _imageVar = string.Empty;
            int _imageCounterFirst = 0;

            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();

            for (int i = 0; i < formVars.Length; i++)
            {
                string attribValue = formVars[i].value;
                //string jsonResult = formVars[i].name.Replace('%', '_');
                string jsonResult = formVars[i].name.Replace('-', ' ');
                string[] jsonVar = jsonResult.Split('_');
                FormValidation formValidation = new FormValidation();

                if (jsonVar.Length > 1)
                {
                    _attributeID = Int32.Parse(jsonVar[0]);
                    _inputTypeID = Int32.Parse(jsonVar[1]);
                    _ValidationTypeID = Int32.Parse(jsonVar[2]);
                    _attributeSetGroupID = Int32.Parse(jsonVar[4]);
                    _isIncludeInPriceRule = bool.Parse(jsonVar[5]);
                    _isIncludeInPromotions = bool.Parse(jsonVar[6]);
                    _displayOrder = Int32.Parse(jsonVar[7]);

                    //Save To Database 1. [aspx_Items] 2. Others 
                    if (_attributeID == 4)
                    {
                        sku = formVars[i].value;
                    }
                    else if (_attributeID == 22)
                    {
                        activeFrom = formVars[i].value;
                    }
                    else if (_attributeID == 23)
                    {
                        activeTo = formVars[i].value;
                    }
                    else if (_attributeID == 26)
                    {
                        hidePrice = formVars[i].value;
                    }
                    else if (_attributeID == 27)
                    {
                        isHideInRSS = formVars[i].value;
                    }
                    else if (_attributeID == 28)
                    {
                        isHideToAnonymous = formVars[i].value;
                    }


                    if (itemID == 0 && updateFlag == false)
                    {
                        itemID = obj.AddItem(itemID, itemTypeID, attributeSetID, taxClassID, storeID, portalID, userName, culture, true, isModified,
                            sku, activeFrom, activeTo, hidePrice, isHideInRSS, isHideToAnonymous, categoriesIDs, relatedItemsIDs, upSellItemsIDs, crossSellItemsIDs, downloadItemsValue, updateFlag);
                    }
                    else if (itemID > 0 && i == formVars.Length - 1)
                    {
                        itemID = obj.AddItem(itemID, itemTypeID, attributeSetID, taxClassID, storeID, portalID, userName, culture, true, isModified,
                            sku, activeFrom, activeTo, hidePrice, isHideInRSS, isHideToAnonymous, categoriesIDs, relatedItemsIDs, upSellItemsIDs, crossSellItemsIDs, downloadItemsValue, updateFlag);
                    }

                    if (itemID > 0)
                    {
                        if (_inputTypeID == 1)
                        {
                            if (_ValidationTypeID == 3)
                            {
                                if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                                {
                                    attribValue = formVars[i].value;
                                }
                                else
                                {
                                    isFormValid = false;
                                    break;
                                }
                            }
                            else if (_ValidationTypeID == 5)
                            {
                                if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                                {
                                    attribValue = formVars[i].value;
                                }
                                else
                                {
                                    isFormValid = false;
                                    break;
                                }
                            }
                            else
                            {
                                if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                                {
                                    attribValue = formVars[i].value;
                                }
                                else
                                {
                                    isFormValid = false;
                                    break;
                                }
                            }
                        }
                        else if (_inputTypeID == 2)
                        {
                            if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                            {
                                attribValue = formVars[i].value;
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else if (_inputTypeID == 3)
                        {
                            if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                            {
                                if (!string.IsNullOrEmpty(formVars[i].value))
                                {
                                    attribValue = formVars[i].value;
                                }
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else if (_inputTypeID == 4)
                        {
                            if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                            {
                                if (!string.IsNullOrEmpty(formVars[i].value))
                                {
                                    attribValue = formVars[i].value;
                                }
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else if (_inputTypeID == 5 || _inputTypeID == 6 || _inputTypeID == 9 || _inputTypeID == 10 ||
                                 _inputTypeID == 11 || _inputTypeID == 12)
                        {
                            if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                            {
                                attribValue = formVars[i].value;
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else if (_inputTypeID == 7)
                        {
                            if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                            {
                                attribValue = formVars[i].value;
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }

                        else if (_inputTypeID == 8)
                        {
                            if (_imageCounterFirst % 2 == 0)
                            {
                                toInsertIntoDB = false;
                                if (!string.IsNullOrEmpty(formVars[i].value) && formVars[i].value.ToLower() != "undefined")
                                {
                                    if (formValidation.ValidateValue(formVars[i].name, _ValidationTypeID, formVars[i].value))
                                    {
                                        _imageVar = attribValue;
                                    }
                                    else
                                    {
                                        isFormValid = false;
                                        break;
                                    }
                                }
                                else
                                {
                                    _imageVar = "";
                                }
                            }
                            else
                            {
                                toInsertIntoDB = true;

                                if (attribValue != _imageVar)
                                {
                                    //_imageVar = _imageVar.Replace("../", "");
                                    _imageVar = _imageVar.Replace("/", "\\");
                                    //attribValue = attribValue.Replace("../", "");
                                    attribValue = attribValue.Replace("/", "\\");

                                    string tempFolder = @"Upload\temp";
                                    FileHelperController fileObj = new FileHelperController();
                                    attribValue = fileObj.MoveFileToModuleFolder(tempFolder, attribValue, _imageVar, itemLargeThumbNailSize, itemMediumThumbNailSize,  itemSmallThumbNailSize, @"Modules\ASPXCommerce\ASPXItemsManagement\uploads\", itemID, "item_");
                                }
                            }
                            _imageCounterFirst++;
                        }
                    }
                    if (isFormValid && toInsertIntoDB)
                    {
                        obj.SaveUpdateItemAttributes(itemID, attributeSetID, storeID, portalID, userName, culture, true, isModified, attribValue,
                            _attributeID, _inputTypeID, _ValidationTypeID, _attributeSetGroupID, _isIncludeInPriceRule, _isIncludeInPromotions,
                            _displayOrder);
                    }
                }
            }
            return itemID;
        }
    }
}
