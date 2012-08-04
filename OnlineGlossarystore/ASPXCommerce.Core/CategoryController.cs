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
using System.ComponentModel;

namespace ASPXCommerce.Core
{
    public class CategoryController
    {
        public CategoryInfo SaveCategory(Int32 storeID, Int32 portalID, Int32 categoryID, Int32 parentID, ASPXNameValue[] formVars, string selectedItems, string userName, string culture, int categoryLargeThumbImage, int categoryMediumThumbImage, int categorySmallThumbImage)
        {
            try
            {
                CategoryInfo categoryInfo = new CategoryInfo();
                FormValidation formValidation = new FormValidation();
                List<CategoryAttributeInfo> listCategoryAttributes = new List<CategoryAttributeInfo>();
                categoryInfo.CategoryID = categoryID;
                categoryInfo.ParentID = parentID;
                categoryInfo.IsShowInCatalog = true;
                categoryInfo.IsShowInMenu = true;
                categoryInfo.IsShowInSearch = true;
                categoryInfo.PortalID = portalID;
                categoryInfo.StoreID = storeID;
                categoryInfo.ActiveFrom = new DateTime(1970, 1, 1);
                categoryInfo.ActiveTo = new DateTime(2999, 12, 30);
                bool toInsertIntoDB = true;
                bool isFormValid = true;
                //int _imageCounter = 0;
                string _imageVar = string.Empty;
                int _imageCounterFirst = 0;

                for (int i = 0; i < formVars.Length; i++)
                {
                    int inputTypeID;
                    int validationTypeID;
                    string attribName = formVars[i].name;
                    string attribValue = formVars[i].value;
                    string jsonResult = formVars[i].name.Replace('-', ' ');
                    string[] jsonVar = jsonResult.Split('_');

                    CategoryAttributeInfo categoryAttribute = new CategoryAttributeInfo();
                    categoryAttribute.AttributeID = int.Parse(jsonVar[0]);
                    inputTypeID = int.Parse(jsonVar[1]);
                    validationTypeID = int.Parse(jsonVar[2]);
                    if (inputTypeID == 1)
                    {
                        if (validationTypeID == 3)
                        {
                            if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                            {
                                categoryAttribute.InputTypeID = inputTypeID;
                                categoryAttribute.ValidationTypeID = validationTypeID;
                                categoryAttribute.DECIMALValue = decimal.Parse(attribValue);
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else if (validationTypeID == 5)
                        {
                            if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                            {
                                categoryAttribute.InputTypeID = inputTypeID;
                                categoryAttribute.ValidationTypeID = validationTypeID;
                                categoryAttribute.INTValue = Int32.Parse(attribValue);
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                        else
                        {
                            if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                            {
                                categoryAttribute.InputTypeID = inputTypeID;
                                categoryAttribute.ValidationTypeID = validationTypeID;
                                categoryAttribute.NVARCHARValue = attribValue;
                            }
                            else
                            {
                                isFormValid = false;
                                break;
                            }
                        }
                    }
                    else if (inputTypeID == 2)
                    {
                        if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                        {
                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            categoryAttribute.TEXTValue = attribValue;
                        }
                        else
                        {
                            isFormValid = false;
                            break;
                        }
                    }
                    else if (inputTypeID == 3)
                    {
                        if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                        {
                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            if (!string.IsNullOrEmpty(attribValue))
                            {
                                categoryAttribute.DATEValue = DateTime.Parse(attribValue);
                            }
                        }
                        else
                        {
                            isFormValid = false;
                            break;
                        }
                    }
                    else if (inputTypeID == 4)
                    {
                        if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                        {
                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            if (!string.IsNullOrEmpty(attribValue))
                            {
                                categoryAttribute.BooleanValue = (attribValue == "1" ||
                                                                  attribValue.ToLower() == "true")
                                                                     ? true
                                                                     : false;
                            }
                            else
                            {
                                categoryAttribute.BooleanValue = false;
                            }
                        }
                        else
                        {
                            isFormValid = false;
                            break;
                        }
                    }
                    else if (inputTypeID == 5 || inputTypeID == 6 || inputTypeID == 9 || inputTypeID == 10 ||
                             inputTypeID == 11 || inputTypeID == 12)
                    {
                        if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                        {
                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            categoryAttribute.OPTIONValues = attribValue;
                        }
                        else
                        {
                            isFormValid = false;
                            break;
                        }
                    }
                    else if (inputTypeID == 7)
                    {
                        if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
                        {
                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            categoryAttribute.DECIMALValue = decimal.Parse(attribValue);
                        }
                        else
                        {
                            isFormValid = false;
                            break;
                        }
                    }
                    else if (inputTypeID == 8)
                    {
                        if (_imageCounterFirst % 2 == 0)
                        {
                            toInsertIntoDB = false;
                            if (!string.IsNullOrEmpty(attribValue) && attribValue.ToLower() != "undefined")
                            {
                                if (formValidation.ValidateValue(attribName, validationTypeID, attribValue))
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

                            categoryAttribute.InputTypeID = inputTypeID;
                            categoryAttribute.ValidationTypeID = validationTypeID;
                            //_imageVar = _imageVar.Replace("../", "");

                            if (attribValue != _imageVar)
                            {
                                _imageVar = _imageVar.Replace("/", "\\");
                                //attribValue = attribValue.Replace("../", "");
                                attribValue = attribValue.Replace("/", "\\");

                                string tempFolder = @"Upload\temp";
                                FileHelperController fileObj = new FileHelperController();
                                attribValue = fileObj.MoveFileToModuleFolder(tempFolder, attribValue, _imageVar,categoryLargeThumbImage,categoryMediumThumbImage,categorySmallThumbImage,
                                                                             @"Modules\ASPXCommerce\ASPXCategoryManagement\uploads\",
                                                                             categoryID, "cat_");
                                categoryAttribute.FILEValue = attribValue;
                            }
                            //else if (_imageVar == "")
                            //{
                            //    categoryAttribute.FILEValue = _imageVar;
                            //}
                            else
                            {
                                categoryAttribute.FILEValue = attribValue;
                            }
                        }
                        _imageCounterFirst++;
                    }
                    if (toInsertIntoDB)
                    {
                        listCategoryAttributes.Add(categoryAttribute);
                    }
                }

                if (isFormValid)
                {
                    CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
                    categoryInfo = categorySqlProvider.CategoryAddUpdate(categoryInfo, selectedItems, listCategoryAttributes, userName, culture);
                }
                else
                {
                    throw new Exception("Form is not valid one");
                }
                return categoryInfo;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}