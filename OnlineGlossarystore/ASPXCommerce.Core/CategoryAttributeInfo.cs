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
using System.Web;
using System.Runtime.Serialization;
using System.Collections;

[DataContract]
public class CategoryAttributeInfo
{
    private Int32 _CategoryID;
    private Int32 _ParentID;
    private Int32 _CategoryLevel;
    private Int32 _AttributeID;
    private string _AttributeName;
    private Int32 _InputTypeID;
    private Int32 _ValidationTypeID;
    private bool _IsUnique;
    private bool _IsRequired;
    private string _NVARCHARValue;
    private string _TEXTValue;
    private bool _BooleanValue;
    private Int32 _INTValue;
    private System.Nullable<DateTime> _DATEValue;
    private System.Nullable<decimal> _DECIMALValue;
    private string _FILEValue;
    private string _OPTIONValues;
    [DataMember]
    public Int32 CategoryID
    {
        get
        {
            return this._CategoryID;
        }
        set
        {
            if ((this._CategoryID != value))
            {
                this._CategoryID = value;
            }
        }
    }

    [DataMember]
    public Int32 ParentID
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
    [DataMember]
    public Int32 CategoryLevel
    {
        get
        {
            return this._CategoryLevel;
        }
        set
        {
            if ((this._CategoryLevel != value))
            {
                this._CategoryLevel = value;
            }
        }
    }

    [DataMember]
    public Int32 AttributeID
    {
        get
        {
            return this._AttributeID;
        }
        set
        {
            if ((this._AttributeID != value))
            {
                this._AttributeID = value;
            }
        }
    }

    [DataMember]
    public string AttributeName
    {
        get
        {
            return this._AttributeName;
        }
        set
        {
            if ((this._AttributeName != value))
            {
                this._AttributeName = value;
            }
        }
    }

    [DataMember]
    public Int32 InputTypeID
    {
        get
        {
            return this._InputTypeID;
        }
        set
        {
            if ((this._InputTypeID != value))
            {
                this._InputTypeID = value;
            }
        }
    }

    [DataMember]
    public Int32 ValidationTypeID
    {
        get
        {
            return this._ValidationTypeID;
        }
        set
        {
            if ((this._ValidationTypeID != value))
            {
                this._ValidationTypeID = value;
            }
        }
    }

    [DataMember]
    public bool IsUnique
    {
        get
        {
            return this._IsUnique;
        }
        set
        {
            this._IsUnique = value;
        }
    }

    [DataMember]
    public bool IsRequired
    {
        get
        {
            return this._IsRequired;
        }
        set
        {
            this._IsRequired = value;
        }
    }

    [DataMember]
    public string NVARCHARValue
    {
        get
        {
            return this._NVARCHARValue;
        }
        set
        {
            this._NVARCHARValue = value;
        }
    }

    [DataMember]
    public string TEXTValue
    {
        get
        {
            return this._TEXTValue;
        }
        set
        {
            if ((this._TEXTValue != value))
            {
                this._TEXTValue = value;
            }
        }
    }

    [DataMember]
    public bool BooleanValue
    {
        get
        {
            return this._BooleanValue;
        }
        set
        {
            if ((this._BooleanValue != value))
            {
                this._BooleanValue = value;
            }
        }
    }

    [DataMember]
    public Int32 INTValue
    {
        get
        {
            return this._INTValue;
        }
        set
        {
            if ((this._INTValue != value))
            {
                this._INTValue = value;
            }
        }
    }

    [DataMember]
    public System.Nullable<DateTime> DATEValue
    {
        get
        {
            return this._DATEValue;
        }
        set
        {
            if ((this._DATEValue != value))
            {
                this._DATEValue = value;
            }
        }
    }

    [DataMember]
    public System.Nullable<decimal> DECIMALValue
    {
        get
        {
            return this._DECIMALValue;
        }
        set
        {
            if ((this._DECIMALValue != value))
            {
                this._DECIMALValue = value;
            }
        }
    }

    [DataMember]
    public string FILEValue
    {
        get
        {
            return this._FILEValue;
        }
        set
        {
            if ((this._FILEValue != value))
            {
                this._FILEValue = value;
            }
        }
    }

    [DataMember]
    public string OPTIONValues
    {
        get
        {
            return this._OPTIONValues;
        }
        set
        {
            if ((this._OPTIONValues != value))
            {
                this._OPTIONValues = value;
            }
        }
    }
}