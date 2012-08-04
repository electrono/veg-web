﻿/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.dialog.add('scaytcheck', function(a) {
    var b = true, c, d = CKEDITOR.document, e = [], f, g = [], h = 0, i = ['dic_create,dic_restore', 'dic_rename,dic_delete'], j = ['mixedCase', 'mixedWithDigits', 'allCaps', 'ignoreDomainNames'];

    function k() {
        return document.forms.optionsbar.options;
    }

    ;

    function l() {
        return document.forms.languagesbar.scayt_lang;
    }

    ;

    function m(y, z) {
        if (!y) return;
        var A = y.length;
        if (A == undefined) {
            y.checked = y.value == z.toString();
            return;
        }
        for (var B = 0; B < A; B++) {
            y[B].checked = false;
            if (y[B].value == z.toString()) y[B].checked = true;
        }
    }

    ;
    var n = a.lang.scayt, o = [{ id: 'options', label: n.optionsTab, elements: [{ type: 'html', id: 'options', html: '<form name="optionsbar"><div class="inner_options">\t<div class="messagebox"></div>\t<div style="display:none;">\t\t<input type="checkbox" name="options"  id="allCaps" />\t\t<label for="allCaps" id="label_allCaps"></label>\t</div>\t<div style="display:none;">\t\t<input name="options" type="checkbox"  id="ignoreDomainNames" />\t\t<label for="ignoreDomainNames" id="label_ignoreDomainNames"></label>\t</div>\t<div style="display:none;">\t<input name="options" type="checkbox"  id="mixedCase" />\t\t<label for="mixedCase" id="label_mixedCase"></label>\t</div>\t<div style="display:none;">\t\t<input name="options" type="checkbox"  id="mixedWithDigits" />\t\t<label for="mixedWithDigits" id="label_mixedWithDigits"></label>\t</div></div></form>' }] }, { id: 'langs', label: n.languagesTab, elements: [{ type: 'html', id: 'langs', html: '<form name="languagesbar"><div class="inner_langs">\t<div class="messagebox"></div>\t   <div style="float:left;width:45%;margin-left:5px;" id="scayt_lcol" ></div>   <div style="float:left;width:45%;margin-left:15px;" id="scayt_rcol"></div></div></form>' }] }, { id: 'dictionaries', label: n.dictionariesTab, elements: [{ type: 'html', style: '', id: 'dictionaries', html: '<form name="dictionarybar"><div class="inner_dictionary" style="text-align:left; white-space:normal; width:320px; overflow: hidden;">\t<div style="margin:5px auto; width:80%;white-space:normal; overflow:hidden;" id="dic_message"> </div>\t<div style="margin:5px auto; width:80%;white-space:normal;">        <span class="cke_dialog_ui_labeled_label" >Dictionary name</span><br>\t\t<span class="cke_dialog_ui_labeled_content" >\t\t\t<div class="cke_dialog_ui_input_text">\t\t\t\t<input id="dic_name" type="text" class="cke_dialog_ui_input_text"/>\t\t</div></span></div>\t\t<div style="margin:5px auto; width:80%;white-space:normal;">\t\t\t<a style="display:none;" class="cke_dialog_ui_button" href="javascript:void(0)" id="dic_create">\t\t\t\t</a>\t\t\t<a  style="display:none;" class="cke_dialog_ui_button" href="javascript:void(0)" id="dic_delete">\t\t\t\t</a>\t\t\t<a  style="display:none;" class="cke_dialog_ui_button" href="javascript:void(0)" id="dic_rename">\t\t\t\t</a>\t\t\t<a  style="display:none;" class="cke_dialog_ui_button" href="javascript:void(0)" id="dic_restore">\t\t\t\t</a>\t\t</div>\t<div style="margin:5px auto; width:95%;white-space:normal;" id="dic_info"></div></div></form>' }] }, { id: 'about', label: n.aboutTab, elements: [{ type: 'html', id: 'about', style: 'margin: 5px 5px;', html: '<div id="scayt_about"></div>' }] }], p = {
        title: n.title,
        minWidth: 360,
        minHeight: 220,
        onShow: function() {
            var y = this;
            y.data = a.fire('scaytDialog', { });
            y.options = y.data.scayt_control.option();
            y.sLang = y.data.scayt_control.sLang;
            if (!y.data || !y.data.scayt || !y.data.scayt_control) {
                alert('Error loading application service');
                y.hide();
                return;
            }
            var z = 0;
            if (b)
                y.data.scayt.getCaption(a.langCode || 'en', function(A) {
                    if (z++ > 0) return;
                    c = A;
                    r.apply(y);
                    s.apply(y);
                    b = false;
                });
            else s.apply(y);
            y.selectPage(y.data.tab);
        },
        onOk: function() {
            var y = this.data.scayt_control;
            y.option(this.options);
            var z = this.chosed_lang;
            y.setLang(z);
            y.refresh();
        },
        onCancel: function() {
            var y = k();
            for (var z in y) y[z].checked = false;
            m(l(), '');
        },
        contents: g
    }, q = CKEDITOR.plugins.scayt.getScayt(a);
    e = CKEDITOR.plugins.scayt.uiTabs;
    for (f in e) {
        if (e[f] == 1) g[g.length] = o[f];
    }
    if (e[2] == 1) h = 1;
    var r = function() {
        var y = this, z = y.data.scayt.getLangList(), A = ['dic_create', 'dic_delete', 'dic_rename', 'dic_restore'], B = j, C;
        if (h) {
            for (C = 0; C < A.length; C++) {
                var D = A[C];
                d.getById(D).setHtml('<span class="cke_dialog_ui_button">' + c['button_' + D] + '</span>');
            }
            d.getById('dic_info').setHtml(c.dic_info);
        }
        if (e[0] == 1)
            for (C in B) {
                var E = 'label_' + B[C], F = d.getById(E);
                if ('undefined' != typeof F && 'undefined' != typeof c[E] && 'undefined' != typeof y.options[B[C]]) {
                    F.setHtml(c[E]);
                    var G = F.getParent();
                    G.$.style.display = 'block';
                }
            }
        var H = '<p><img src="' + window.scayt.getAboutInfo().logoURL + '" /></p>' + '<p>' + c.version + window.scayt.getAboutInfo().version.toString() + '</p>' + '<p>' + c.about_throwt_copy + '</p>';
        d.getById('scayt_about').setHtml(H);
        var I = function(S, T) {
            var U = d.createElement('label');
            U.setAttribute('for', 'cke_option' + S);
            U.setHtml(T[S]);
            if (y.sLang == S) y.chosed_lang = S;
            var V = d.createElement('div'), W = CKEDITOR.dom.element.createFromHtml('<input id="cke_option' + S + '" type="radio" ' + (y.sLang == S ? 'checked="checked"' : '') + ' value="' + S + '" name="scayt_lang" />');
            W.on('click', function() {
                this.$.checked = true;
                y.chosed_lang = S;
            });
            V.append(W);
            V.append(U);
            return { lang: T[S], code: S, radio: V };
        }, J = [];
        if (e[1] == 1) {
            for (C in z.rtl) J[J.length] = I(C, z.ltr);
            for (C in z.ltr) J[J.length] = I(C, z.ltr);
            J.sort(function(S, T) { return T.lang > S.lang ? -1 : 1; });
            var K = d.getById('scayt_lcol'), L = d.getById('scayt_rcol');
            for (C = 0; C < J.length; C++) {
                var M = C < J.length / 2 ? K : L;
                M.append(J[C].radio);
            }
        }
        var N = { };
        N.dic_create = function(S, T, U) {
            var V = U[0] + ',' + U[1], W = c.err_dic_create, X = c.succ_dic_create;
            window.scayt.createUserDictionary(T, function(Y) {
                w(V);
                v(U[1]);
                X = X.replace('%s', Y.dname);
                u(X);
            }, function(Y) {
                W = W.replace('%s', Y.dname);
                t(W + '( ' + (Y.message || '') + ')');
            });
        };
        N.dic_rename = function(S, T) {
            var U = c.err_dic_rename || '', V = c.succ_dic_rename || '';
            window.scayt.renameUserDictionary(T, function(W) {
                V = V.replace('%s', W.dname);
                x(T);
                u(V);
            }, function(W) {
                U = U.replace('%s', W.dname);
                x(T);
                t(U + '( ' + (W.message || '') + ' )');
            });
        };
        N.dic_delete = function(S, T, U) {
            var V = U[0] + ',' + U[1], W = c.err_dic_delete, X = c.succ_dic_delete;
            window.scayt.deleteUserDictionary(function(Y) {
                X = X.replace('%s', Y.dname);
                w(V);
                v(U[0]);
                x('');
                u(X);
            }, function(Y) {
                W = W.replace('%s', Y.dname);
                t(W);
            });
        };
        N.dic_restore = y.dic_restore || (function(S, T, U) {
            var V = U[0] + ',' + U[1], W = c.err_dic_restore, X = c.succ_dic_restore;
            window.scayt.restoreUserDictionary(T, function(Y) {
                X = X.replace('%s', Y.dname);
                w(V);
                v(U[1]);
                u(X);
            }, function(Y) {
                W = W.replace('%s', Y.dname);
                t(W);
            });
        });

        function O(S) {
            var T = d.getById('dic_name').getValue();
            if (!T) {
                t(' Dictionary name should not be empty. ');
                return false;
            }
            try {
                var U = id = S.data.getTarget().getParent(), V = U.getId();
                N[V].apply(null, [U, T, i]);
            } catch(W) {
                t(' Dictionary error. ');
            }
            return true;
        }

        ;
        var P = (i[0] + ',' + i[1]).split(','), Q;
        for (C = 0, Q = P.length; C < Q; C += 1) {
            var R = d.getById(P[C]);
            if (R) R.on('click', O, this);
        }
    }, s = function() {
        var y = this;
        if (e[0] == 1) {
            var z = k();
            for (var A = 0, B = z.length; A < B; A++) {
                var C = z[A].id, D = d.getById(C);
                if (D) {
                    z[A].checked = false;
                    if (y.options[C] == 1) z[A].checked = true;
                    if (b) D.on('click', function() { y.options[this.getId()] = this.$.checked ? 1 : 0; });
                }
            }
        }
        if (e[1] == 1) {
            var E = d.getById('cke_option' + y.sLang);
            m(E.$, y.sLang);
        }
        if (h) {
            window.scayt.getNameUserDictionary(function(F) {
                var G = F.dname;
                w(i[0] + ',' + i[1]);
                if (G) {
                    d.getById('dic_name').setValue(G);
                    v(i[1]);
                } else v(i[0]);
            }, function() { d.getById('dic_name').setValue(''); });
            u('');
        }
    };

    function t(y) {
        d.getById('dic_message').setHtml('<span style="color:red;">' + y + '</span>');
    }

    ;

    function u(y) {
        d.getById('dic_message').setHtml('<span style="color:blue;">' + y + '</span>');
    }

    ;

    function v(y) {
        y = String(y);
        var z = y.split(',');
        for (var A = 0, B = z.length; A < B; A += 1) d.getById(z[A]).$.style.display = 'inline';
    }

    ;

    function w(y) {
        y = String(y);
        var z = y.split(',');
        for (var A = 0, B = z.length; A < B; A += 1) d.getById(z[A]).$.style.display = 'none';
    }

    ;

    function x(y) {
        d.getById('dic_name').$.value = y;
    }

    ;
    return p;
});