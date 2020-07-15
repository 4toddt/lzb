/*
 ============== DO NOT ALTER ANYTHING BELOW THIS LINE ! ============

 Adobe Visitor API for JavaScript version: 1.8.0
 Copyright 1996-2015 Adobe, Inc. All Rights Reserved
 More info available at http://www.omniture.com
*/
function Visitor(e, t) {
    if (!e) throw "Visitor requires Adobe Marketing Cloud Org ID";
    var n = this;
    n.version = "1.8.0";
    var a = window,
        i = a.Visitor;
    i.version = n.version, a.s_c_in || (a.s_c_il = [], a.s_c_in = 0), n._c = "Visitor", n._il = a.s_c_il, n._in = a.s_c_in, n._il[n._in] = n, a.s_c_in++, n.la = { Ha: [] };
    var r = a.document,
        s = i.Db;
    s || (s = null);
    var o = i.Eb;
    o || (o = void 0);
    var c = i.Pa;
    c || (c = !0);
    var l = i.Na;
    l || (l = !1), n.ha = function(e) {
        var t, n = 0;
        if (e)
            for (t = 0; t < e.length; t++) n = (n << 5) - n + e.charCodeAt(t), n &= n;
        return n
    }, n.r = function(e, t) {
        var n, a, i = "0123456789",
            r = "",
            s = "",
            o = 8,
            l = 10,
            d = 10;
        if (t === u && (T.isClientSideMarketingCloudVisitorID = c), 1 == e) { for (i += "ABCDEF", n = 0; 16 > n; n++) a = Math.floor(Math.random() * o), r += i.substring(a, a + 1), a = Math.floor(Math.random() * o), s += i.substring(a, a + 1), o = 16; return r + "-" + s }
        for (n = 0; 19 > n; n++) a = Math.floor(Math.random() * l), r += i.substring(a, a + 1), 0 == n && 9 == a ? l = 3 : (1 == n || 2 == n) && 10 != l && 2 > a ? l = 10 : 2 < n && (l = 10), a = Math.floor(Math.random() * d), s += i.substring(a, a + 1), 0 == n && 9 == a ? d = 3 : (1 == n || 2 == n) && 10 != d && 2 > a ? d = 10 : 2 < n && (d = 10);
        return r + s
    }, n.Ta = function() {
        var e;
        if (!e && a.location && (e = a.location.hostname), e)
            if (/^[0-9.]+$/.test(e)) e = "";
            else {
                var t = e.split("."),
                    n = t.length - 1,
                    i = n - 1;
                if (1 < n && 2 >= t[n].length && (2 == t[n - 1].length || 0 > ",ac,ad,ae,af,ag,ai,al,am,an,ao,aq,ar,as,at,au,aw,ax,az,ba,bb,be,bf,bg,bh,bi,bj,bm,bo,br,bs,bt,bv,bw,by,bz,ca,cc,cd,cf,cg,ch,ci,cl,cm,cn,co,cr,cu,cv,cw,cx,cz,de,dj,dk,dm,do,dz,ec,ee,eg,es,et,eu,fi,fm,fo,fr,ga,gb,gd,ge,gf,gg,gh,gi,gl,gm,gn,gp,gq,gr,gs,gt,gw,gy,hk,hm,hn,hr,ht,hu,id,ie,im,in,io,iq,ir,is,it,je,jo,jp,kg,ki,km,kn,kp,kr,ky,kz,la,lb,lc,li,lk,lr,ls,lt,lu,lv,ly,ma,mc,md,me,mg,mh,mk,ml,mn,mo,mp,mq,mr,ms,mt,mu,mv,mw,mx,my,na,nc,ne,nf,ng,nl,no,nr,nu,nz,om,pa,pe,pf,ph,pk,pl,pm,pn,pr,ps,pt,pw,py,qa,re,ro,rs,ru,rw,sa,sb,sc,sd,se,sg,sh,si,sj,sk,sl,sm,sn,so,sr,st,su,sv,sx,sy,sz,tc,td,tf,tg,th,tj,tk,tl,tm,tn,to,tp,tr,tt,tv,tw,tz,ua,ug,uk,us,uy,uz,va,vc,ve,vg,vi,vn,vu,wf,ws,yt,".indexOf("," + t[n] + ",")) && i--, 0 < i)
                    for (e = ""; n >= i;) e = t[n] + (e ? "." : "") + e, n--
            }
        return e
    }, n.cookieRead = function(e) {
        e = encodeURIComponent(e);
        var t = (";" + r.cookie).split(" ").join(";"),
            n = t.indexOf(";" + e + "="),
            a = 0 > n ? n : t.indexOf(";", n + 1);
        return 0 > n ? "" : decodeURIComponent(t.substring(n + 2 + e.length, 0 > a ? t.length : a))
    }, n.cookieWrite = function(e, t, a) { t = "" + t; var i, s = (s = n.cookieLifetime) ? ("" + s).toUpperCase() : ""; return a && "SESSION" != s && "NONE" != s ? (i = "" != t ? parseInt(s || 0, 10) : -60) ? (a = new Date).setTime(a.getTime() + 1e3 * i) : 1 == a && (i = (a = new Date).getYear(), a.setYear(i + 2 + (1900 > i ? 1900 : 0))) : a = 0, e && "NONE" != s ? (r.cookie = encodeURIComponent(e) + "=" + encodeURIComponent(t) + "; path=/;" + (a ? " expires=" + a.toGMTString() + ";" : "") + (n.cookieDomain ? " domain=" + n.cookieDomain + ";" : ""), n.cookieRead(e) == t) : 0 }, n.h = s, n.L = function(e, t) { try { "function" == typeof e ? e.apply(a, t) : e[1].apply(e[0], t) } catch (n) {} }, n.Ya = function(e, t) { t && (n.h == s && (n.h = {}), n.h[e] == o && (n.h[e] = []), n.h[e].push(t)) }, n.q = function(e, t) {
        if (n.h != s) {
            var a = n.h[e];
            if (a)
                for (; 0 < a.length;) n.L(a.shift(), t)
        }
    }, n.w = function(e, t, n, a) { if (n = encodeURIComponent(t) + "=" + encodeURIComponent(n), t = L.wb(e), -1 === (e = L.ob(e)).indexOf("?")) return e + "?" + n + t; var i = e.split("?"); return (e = i[0] + "?") + (a = L.ab(i[1], n, a)) + t }, n.Sa = function(e, t) { var n = RegExp("[\\?&#]" + t + "=([^&#]*)").exec(e); if (n && n.length) return decodeURIComponent(n[1]) }, n.Xa = function() {
        var e = s,
            t = a.location.href;
        try {
            var i = n.Sa(t, P.ba);
            if (i) {
                e = {};
                for (var r = i.split("|"), o = (t = 0, r.length); t < o; t++) {
                    var c = r[t].split("=");
                    e[c[0]] = decodeURIComponent(c[1])
                }
            }
            return e
        } catch (l) {}
    }, n.Qa = function() {
        var e = n.Xa();
        if (e) {
            var t = e[u],
                a = n.setMarketingCloudVisitorID;
            t && t.match(P.v) && a(t), n.j(k, -1), e = e[b], t = n.setAnalyticsVisitorID, e && e.match(P.v) && t(e)
        }
    }, n.l = s, n.Va = function(e, t, a, i) { t = n.w(t, "d_fieldgroup", e, 1), i.url = n.w(i.url, "d_fieldgroup", e, 1), i.m = n.w(i.m, "d_fieldgroup", e, 1), T.c[e] = c, i === Object(i) && i.m && "XMLHttpRequest" === n.na.F.G ? n.na.kb(i, a, e) : n.useCORSOnly || n.ka(e, t, a) }, n.ka = function(e, t, a) {
        var o, d = 0,
            u = 0;
        if (t && r) {
            for (o = 0; !d && 2 > o;) {
                try { d = (d = r.getElementsByTagName(0 < o ? "HEAD" : "head")) && 0 < d.length ? d[0] : 0 } catch (g) { d = 0 }
                o++
            }
            if (!d) try { r.body && (d = r.body) } catch (l) { d = 0 }
            if (d)
                for (o = 0; !u && 2 > o;) {
                    try { u = r.createElement(0 < o ? "SCRIPT" : "script") } catch (i) { u = 0 }
                    o++
                }
        }
        t && d && u ? (u.type = "text/javascript", u.src = t, d.firstChild ? d.insertBefore(u, d.firstChild) : d.appendChild(u), d = n.loadTimeout, I.c[e] = { requestStart: I.o(), url: t, wa: d, ua: I.Aa(), va: 0 }, a && (n.l == s && (n.l = {}), n.l[e] = setTimeout(function() { a(c) }, d)), n.la.Ha.push(t)) : a && a()
    }, n.Ra = function(e) { n.l != s && n.l[e] && (clearTimeout(n.l[e]), n.l[e] = 0) }, n.ia = l, n.ja = l, n.isAllowed = function() { return !n.ia && (n.ia = c, n.cookieRead(n.cookieName) || n.cookieWrite(n.cookieName, "T", 1)) && (n.ja = c), n.ja }, n.b = s, n.e = s;
    var d = i.Vb;
    d || (d = "MC");
    var u = i.ac;
    u || (u = "MCMID");
    var g = i.Wb;
    g || (g = "MCCIDH");
    var m = i.Zb;
    m || (m = "MCSYNCS");
    var p = i.$b;
    p || (p = "MCSYNCSOP");
    var f = i.Xb;
    f || (f = "MCIDTS");
    var h = i.Yb;
    h || (h = "MCOPTOUT");
    var v = i.Tb;
    v || (v = "A");
    var b = i.Qb;
    b || (b = "MCAID");
    var y = i.Ub;
    y || (y = "AAM");
    var S = i.Sb;
    S || (S = "MCAAMLH");
    var k = i.Rb;
    k || (k = "MCAAMB");
    var w = i.bc;
    w || (w = "NONE"), n.N = 0, n.ga = function() {
        if (!n.N) {
            var e = n.version;
            n.audienceManagerServer && (e += "|" + n.audienceManagerServer), n.audienceManagerServerSecure && (e += "|" + n.audienceManagerServerSecure), n.N = n.ha(e)
        }
        return n.N
    }, n.ma = l, n.f = function() {
        if (!n.ma) {
            n.ma = c;
            var e, t, a, i, r = n.ga(),
                o = l,
                d = n.cookieRead(n.cookieName),
                u = new Date;
            if (n.b == s && (n.b = {}), d && "T" != d)
                for ((d = d.split("|"))[0].match(/^[\-0-9]+$/) && (parseInt(d[0], 10) != r && (o = c), d.shift()), 1 == d.length % 2 && d.pop(), r = 0; r < d.length; r += 2) t = (e = d[r].split("-"))[0], a = d[r + 1], 1 < e.length ? (i = parseInt(e[1], 10), e = 0 < e[1].indexOf("s")) : (i = 0, e = l), o && (t == g && (a = ""), 0 < i && (i = u.getTime() / 1e3 - 60)), t && a && (n.d(t, a, 1), 0 < i && (n.b["expire" + t] = i + (e ? "s" : ""), u.getTime() >= 1e3 * i || e && !n.cookieRead(n.sessionCookieName))) && (n.e || (n.e = {}), n.e[t] = c);
            !n.a(b) && (d = n.cookieRead("s_vi")) && (1 < (d = d.split("|")).length && 0 <= d[0].indexOf("v1") && (0 <= (r = (a = d[1]).indexOf("[")) && (a = a.substring(0, r)), a && a.match(P.v) && n.d(b, a)))
        }
    }, n.$a = function() {
        var e, t, a = n.ga();
        for (e in n.b) !Object.prototype[e] && n.b[e] && "expire" != e.substring(0, 6) && (t = n.b[e], a += (a ? "|" : "") + e + (n.b["expire" + e] ? "-" + n.b["expire" + e] : "") + "|" + t);
        n.cookieWrite(n.cookieName, a, 1)
    }, n.a = function(e, t) { return n.b == s || !t && n.e && n.e[e] ? s : n.b[e] }, n.d = function(e, t, a) { n.b == s && (n.b = {}), n.b[e] = t, a || n.$a() }, n.Ua = function(e, t) { var a = n.a(e, t); return a ? a.split("*") : s }, n.Za = function(e, t, a) { n.d(e, t ? t.join("*") : "", a) }, n.Kb = function(e, t) { var a = n.Ua(e, t); if (a) { var i, r = {}; for (i = 0; i < a.length; i += 2) r[a[i]] = a[i + 1]; return r } return s }, n.Mb = function(e, t, a) {
        var i, r = s;
        if (t)
            for (i in r = [], t) Object.prototype[i] || (r.push(i), r.push(t[i]));
        n.Za(e, r, a)
    }, n.j = function(e, t, a) {
        var i = new Date;
        i.setTime(i.getTime() + 1e3 * t), n.b == s && (n.b = {}), n.b["expire" + e] = Math.floor(i.getTime() / 1e3) + (a ? "s" : ""), 0 > t ? (n.e || (n.e = {}), n.e[e] = c) : n.e && (n.e[e] = l), a && (n.cookieRead(n.sessionCookieName) || n.cookieWrite(n.sessionCookieName, "1"))
    }, n.fa = function(e) { return e && ("object" == typeof e && (e = e.d_mid ? e.d_mid : e.visitorID ? e.visitorID : e.id ? e.id : e.uuid ? e.uuid : "" + e), e && ("NOTARGET" == (e = e.toUpperCase()) && (e = w)), !e || e != w && !e.match(P.v)) && (e = ""), e }, n.k = function(e, t) {
        if (n.Ra(e), n.i != s && (n.i[e] = l), I.c[e] && (I.c[e].Bb = I.o(), I.K(e)), T.c[e] && T.Ja(e, l), e == d) {
            T.isClientSideMarketingCloudVisitorID !== c && (T.isClientSideMarketingCloudVisitorID = l);
            var a = n.a(u);
            if (!a) {
                if (!(a = "object" == typeof t && t.mid ? t.mid : n.fa(t))) {
                    if (n.D) return void n.getAnalyticsVisitorID(s, l, c);
                    a = n.r(0, u)
                }
                n.d(u, a)
            }
            a && a != w || (a = ""), "object" == typeof t && ((t.d_region || t.dcs_region || t.d_blob || t.blob) && n.k(y, t), n.D && t.mid && n.k(v, { id: t.id })), n.q(u, [a])
        }
        if (e == y && "object" == typeof t) {
            a = 604800, t.id_sync_ttl != o && t.id_sync_ttl && (a = parseInt(t.id_sync_ttl, 10));
            var i = n.a(S);
            i || ((i = t.d_region) || (i = t.dcs_region), i && (n.j(S, a), n.d(S, i))), i || (i = ""), n.q(S, [i]), i = n.a(k), (t.d_blob || t.blob) && ((i = t.d_blob) || (i = t.blob), n.j(k, a), n.d(k, i)), i || (i = ""), n.q(k, [i]), !t.error_msg && n.B && n.d(g, n.B)
        }
        var r;
        (e == v && ((a = n.a(b)) || ((a = n.fa(t)) ? a !== w && n.j(k, -1) : a = w, n.d(b, a)), a && a != w || (a = ""), n.q(b, [a])), n.idSyncDisableSyncs ? D.Ba = c : (D.Ba = l, (a = {}).ibs = t.ibs, a.subdomain = t.subdomain, D.xb(a)), t === Object(t)) && (n.isAllowed() && (r = n.a(h)), r || (r = w, t.d_optout && t.d_optout instanceof Array && (r = t.d_optout.join(",")), a = parseInt(t.d_ottl, 10), isNaN(a) && (a = 7200), n.j(h, a, c), n.d(h, r)), n.q(h, [r]))
    }, n.i = s, n.s = function(e, t, a, i, r) {
        var o, l = "",
            g = L.qb(e);
        return !n.isAllowed() || (n.f(), l = n.a(e), n.disableThirdPartyCalls && !l && (e === u ? (l = n.r(0, u), n.setMarketingCloudVisitorID(l)) : e === b && !g && (l = "", n.setAnalyticsVisitorID(l))), l || n.disableThirdPartyCalls && !g) || (e == u || e == h ? o = d : e == S || e == k ? o = y : e == b && (o = v), !o) ? (e != u && e != b || l != w || (l = "", i = c), a && i && n.L(a, [l]), l) : (!t || n.i != s && n.i[o] || (n.i == s && (n.i = {}), n.i[o] = c, n.Va(o, t, function(t, a) {
            if (!n.a(e))
                if (I.c[o] && (I.c[o].timeout = I.o(), I.c[o].pb = !!t, I.K(o)), a !== Object(a) || n.useCORSOnly) {
                    t && T.Ja(o, c);
                    var i = "";
                    e == u ? i = n.r(0, u) : o == y && (i = { error_msg: "timeout" }), n.k(o, i)
                } else n.ka(o, a.url, a.I)
        }, r)), n.Ya(e, a), t || n.k(o, { id: w }), "")
    }, n._setMarketingCloudFields = function(e) { n.f(), n.k(d, e) }, n.setMarketingCloudVisitorID = function(e) { n._setMarketingCloudFields(e) }, n.D = l, n.getMarketingCloudVisitorID = function(e, t) { if (n.isAllowed()) { n.marketingCloudServer && 0 > n.marketingCloudServer.indexOf(".demdex.net") && (n.D = c); var a = n.A("_setMarketingCloudFields"); return n.s(u, a.url, e, t, a) } return "" }, n.Wa = function() { n.getAudienceManagerBlob() }, i.AuthState = { UNKNOWN: 0, AUTHENTICATED: 1, LOGGED_OUT: 2 }, n.z = {}, n.ea = l, n.B = "", n.setCustomerIDs = function(e) {
        if (n.isAllowed() && e) {
            var t, a;
            for (t in n.f(), e)
                if (!Object.prototype[t] && (a = e[t]))
                    if ("object" == typeof a) {
                        var i = {};
                        a.id && (i.id = a.id), a.authState != o && (i.authState = a.authState), n.z[t] = i
                    } else n.z[t] = { id: a };
            e = n.getCustomerIDs(), i = n.a(g);
            var r = "";
            for (t in i || (i = 0), e) Object.prototype[t] || (r += (r ? "|" : "") + t + "|" + ((a = e[t]).id ? a.id : "") + (a.authState ? a.authState : ""));
            n.B = n.ha(r), n.B != i && (n.ea = c, n.Wa())
        }
    }, n.getCustomerIDs = function() { n.f(); var e, t, a = {}; for (e in n.z) Object.prototype[e] || (t = n.z[e], a[e] || (a[e] = {}), t.id && (a[e].id = t.id), a[e].authState = t.authState != o ? t.authState : i.AuthState.UNKNOWN); return a }, n._setAnalyticsFields = function(e) { n.f(), n.k(v, e) }, n.setAnalyticsVisitorID = function(e) { n._setAnalyticsFields(e) }, n.getAnalyticsVisitorID = function(e, t, a) {
        if (n.isAllowed()) {
            var i = "";
            if (a || (i = n.getMarketingCloudVisitorID(function() { n.getAnalyticsVisitorID(e, c) })), i || a) {
                var r = a ? n.marketingCloudServer : n.trackingServer,
                    s = "";
                n.loadSSL && (a ? n.marketingCloudServerSecure && (r = n.marketingCloudServerSecure) : n.trackingServerSecure && (r = n.trackingServerSecure));
                var o = {};
                if (r) {
                    r = "http" + (n.loadSSL ? "s" : "") + "://" + r + "/id", i = "d_visid_ver=" + n.version + "&mcorgid=" + encodeURIComponent(n.marketingCloudOrgID) + (i ? "&mid=" + encodeURIComponent(i) : "") + (n.idSyncDisable3rdPartySyncing ? "&d_coppa=true" : "");
                    var l = ["s_c_il", n._in, "_set" + (a ? "MarketingCloud" : "Analytics") + "Fields"];
                    s = r + "?" + i + "&callback=s_c_il%5B" + n._in + "%5D._set" + (a ? "MarketingCloud" : "Analytics") + "Fields";
                    o.m = r + "?" + i, o.ra = l
                }
                return o.url = s, n.s(a ? u : b, s, e, t, o)
            }
        }
        return ""
    }, n._setAudienceManagerFields = function(e) { n.f(), n.k(y, e) }, n.A = function(e) {
        var t = n.audienceManagerServer,
            a = "",
            i = n.a(u),
            r = n.a(k, c),
            s = (s = n.a(b)) && s != w ? "&d_cid_ic=AVID%01" + encodeURIComponent(s) : "";
        if (n.loadSSL && n.audienceManagerServerSecure && (t = n.audienceManagerServerSecure), t) {
            var o, l;
            if (a = n.getCustomerIDs())
                for (o in a) Object.prototype[o] || (l = a[o], s += "&d_cid_ic=" + encodeURIComponent(o) + "%01" + encodeURIComponent(l.id ? l.id : "") + (l.authState ? "%01" + l.authState : ""));
            return e || (e = "_setAudienceManagerFields"), t = "http" + (n.loadSSL ? "s" : "") + "://" + t + "/id", i = "d_visid_ver=" + n.version + "&d_rtbd=json&d_ver=2" + (!i && n.D ? "&d_verify=1" : "") + "&d_orgid=" + encodeURIComponent(n.marketingCloudOrgID) + "&d_nsid=" + (n.idSyncContainerID || 0) + (i ? "&d_mid=" + encodeURIComponent(i) : "") + (n.idSyncDisable3rdPartySyncing ? "&d_coppa=true" : "") + (r ? "&d_blob=" + encodeURIComponent(r) : "") + s, r = ["s_c_il", n._in, e], { url: a = t + "?" + i + "&d_cb=s_c_il%5B" + n._in + "%5D." + e, m: t + "?" + i, ra: r }
        }
        return { url: a }
    }, n.getAudienceManagerLocationHint = function(e, t) { if (n.isAllowed() && n.getMarketingCloudVisitorID(function() { n.getAudienceManagerLocationHint(e, c) })) { var a = n.a(b); if (a || (a = n.getAnalyticsVisitorID(function() { n.getAudienceManagerLocationHint(e, c) })), a) return a = n.A(), n.s(S, a.url, e, t, a) } return "" }, n.getAudienceManagerBlob = function(e, t) { if (n.isAllowed() && n.getMarketingCloudVisitorID(function() { n.getAudienceManagerBlob(e, c) }) && ((a = n.a(b)) || (a = n.getAnalyticsVisitorID(function() { n.getAudienceManagerBlob(e, c) })), a)) { var a, i = (a = n.A()).url; return n.ea && n.j(k, -1), n.s(k, i, e, t, a) } return "" }, n.t = "", n.C = {}, n.O = "", n.P = {}, n.getSupplementalDataID = function(e, t) {!n.t && !t && (n.t = n.r(1)); var a = n.t; return n.O && !n.P[e] ? (a = n.O, n.P[e] = c) : a && (n.C[e] && (n.O = n.t, n.P = n.C, n.t = a = t ? "" : n.r(1), n.C = {}), a && (n.C[e] = c)), a }, i.OptOut = { GLOBAL: "global" }, n.getOptOut = function(e, t) { if (n.isAllowed()) { var a = n.A("_setMarketingCloudFields"); return n.s(h, a.url, e, t, a) } return "" }, n.isOptedOut = function(e, t, a) { return n.isAllowed() ? (t || (t = i.OptOut.GLOBAL), (a = n.getOptOut(function(a) { n.L(e, [a == i.OptOut.GLOBAL || 0 <= a.indexOf(t)]) }, a)) ? a == i.OptOut.GLOBAL || 0 <= a.indexOf(t) : s) : l }, n.appendVisitorIDsTo = function(e) {
        for (var t = P.ba, a = [
                [u, n.a(u)],
                [b, n.a(b)]
            ], i = "", r = 0, o = a.length; r < o; r++) {
            var l, d = (l = a[r])[0];
            (l = l[1]) != s && l !== w && (i = i ? i += "|" : i, i += d + "=" + encodeURIComponent(l))
        }
        try { return n.w(e, t, i) } catch (c) { return e }
    };
    var P = { p: !!a.postMessage, Ma: 1, da: 864e5, ba: "adobe_mc", v: /^[0-9a-fA-F\-]+$/ };
    n.Fb = P, n.pa = {
        postMessage: function(e, t, n) {
            var a = 1;
            t && (P.p ? n.postMessage(e, t.replace(/([^:]+:\/\/[^\/]+).*/, "$1")) : t && (n.location = t.replace(/#.*$/, "") + "#" + +new Date + a++ + "&" + e))
        },
        X: function(e, t) {
            var n;
            try {
                P.p && (e && (n = function(n) {
                    if ("string" == typeof t && n.origin !== t || "[object Function]" === Object.prototype.toString.call(t) && !1 === t(n.origin)) return !1;
                    e(n)
                }), window.addEventListener ? window[e ? "addEventListener" : "removeEventListener"]("message", n, !1) : window[e ? "attachEvent" : "detachEvent"]("onmessage", n))
            } catch (a) {}
        }
    };
    var L = {
        Q: r.addEventListener ? function(e, t, n) { e.addEventListener(t, function(e) { "function" == typeof n && n(e) }, l) } : r.attachEvent ? function(e, t, n) { e.attachEvent("on" + t, function(e) { "function" == typeof n && n(e) }) } : void 0,
        map: function(e, t) {
            if (Array.prototype.map) return e.map(t);
            if (void 0 === e || e === s) throw new TypeError;
            var n = Object(e),
                a = n.length >>> 0;
            if ("function" != typeof t) throw new TypeError;
            for (var i = Array(a), r = 0; r < a; r++) r in n && (i[r] = t.call(t, n[r], r, n));
            return i
        },
        jb: function(e, t) { return this.map(e, function(e) { return encodeURIComponent(e) }).join(t) },
        wb: function(e) { var t = e.indexOf("#"); return 0 < t ? e.substr(t) : "" },
        ob: function(e) { var t = e.indexOf("#"); return 0 < t ? e.substr(0, t) : e },
        ab: function(e, t, n) { return e = e.split("&"), n = n != s ? n : e.length, e.splice(n, 0, t), e.join("&") },
        qb: function(e, t, a) { return e !== b ? l : (t || (t = n.trackingServer), a || (a = n.trackingServerSecure), "string" == typeof(e = n.loadSSL ? a : t) && e.length ? 0 > e.indexOf("2o7.net") && 0 > e.indexOf("omtrdc.net") : l) }
    };
    n.Lb = L;
    var C, _, E = {
        F: (C = "none", _ = c, "undefined" != typeof XMLHttpRequest && XMLHttpRequest === Object(XMLHttpRequest) && ("withCredentials" in new XMLHttpRequest ? C = "XMLHttpRequest" : new Function("/*@cc_on return /^10/.test(@_jscript_version) @*/")() ? C = "XMLHttpRequest" : "undefined" != typeof XDomainRequest && XDomainRequest === Object(XDomainRequest) && (_ = l), 0 < Object.prototype.toString.call(window.Cb).indexOf("Constructor") && (_ = l)), { G: C, Ob: _ }),
        lb: function() { return "none" === this.F.G ? s : new window[this.F.G] },
        kb: function(e, t, a) {
            var i = this;
            t && (e.I = t);
            try {
                var r = this.lb();
                r.open("get", e.m + "&ts=" + (new Date).getTime(), c), "XMLHttpRequest" === this.F.G && (r.withCredentials = c, r.timeout = n.loadTimeout, r.setRequestHeader("Content-Type", "application/x-www-form-urlencoded"), r.onreadystatechange = function() {
                    if (4 === this.readyState && 200 === this.status) e: {
                        var t;
                        try { if ((t = JSON.parse(this.responseText)) !== Object(t)) { i.n(e, s, "Response is not JSON"); break e } } catch (a) { i.n(e, a, "Error parsing response as JSON"); break e }
                        try {
                            for (var n = e.ra, r = window, o = 0; o < n.length; o++) r = r[n[o]];
                            r(t)
                        } catch (l) { i.n(e, l, "Error forming callback function") }
                    }
                }), r.onerror = function(t) { i.n(e, t, "onerror") }, r.ontimeout = function(t) { i.n(e, t, "ontimeout") }, r.send(), I.c[a] = { requestStart: I.o(), url: e.m, wa: r.timeout, ua: I.Aa(), va: 1 }, n.la.Ha.push(e.m)
            } catch (o) { this.n(e, o, "try-catch") }
        },
        n: function(e, t, a) { n.CORSErrors.push({ Pb: e, error: t, description: a }), e.I && ("ontimeout" === a ? e.I(c) : e.I(l, e)) }
    };
    n.na = E;
    var D = {
        Oa: 3e4,
        ca: 649,
        La: l,
        id: s,
        W: [],
        T: s,
        za: function(e) { if ("string" == typeof e) return (e = e.split("/"))[0] + "//" + e[2] },
        g: s,
        url: s,
        mb: function() {
            var e = "http://fast.",
                t = "?d_nsid=" + n.idSyncContainerID + "#" + encodeURIComponent(r.location.href);
            return this.g || (this.g = "nosubdomainreturned"), n.loadSSL && (e = n.idSyncSSLUseAkamai ? "https://fast." : "https://"), e = e + this.g + ".demdex.net/dest5.html" + t, this.T = this.za(e), this.id = "destination_publishing_iframe_" + this.g + "_" + n.idSyncContainerID, e
        },
        eb: function() { var e = "?d_nsid=" + n.idSyncContainerID + "#" + encodeURIComponent(r.location.href); "string" == typeof n.M && n.M.length && (this.id = "destination_publishing_iframe_" + (new Date).getTime() + "_" + n.idSyncContainerID, this.T = this.za(n.M), this.url = n.M + e) },
        Ba: s,
        xa: l,
        Z: l,
        H: s,
        cc: s,
        vb: s,
        dc: s,
        Y: l,
        J: [],
        tb: [],
        ub: [],
        Da: P.p ? 15 : 100,
        U: [],
        rb: [],
        sa: c,
        Ga: l,
        Fa: function() { return !n.idSyncDisable3rdPartySyncing && (this.xa || n.Hb) && this.g && "nosubdomainreturned" !== this.g && this.url && !this.Z },
        R: function() {
            function e() {
                (a = document.createElement("iframe")).sandbox = "allow-scripts allow-same-origin", a.title = "Adobe ID Syncing iFrame", a.id = n.id, a.style.cssText = "display: none; width: 0; height: 0;", a.src = n.url, n.vb = c, t(), document.body.appendChild(a)
            }

            function t() { L.Q(a, "load", function() { a.className = "aamIframeLoaded", n.H = c, n.u() }) }
            this.Z = c;
            var n = this,
                a = document.getElementById(this.id);
            a ? "IFRAME" !== a.nodeName ? (this.id += "_2", e()) : "aamIframeLoaded" !== a.className ? t() : (this.H = c, this.Ca = a, this.u()) : e(), this.Ca = a
        },
        u: function(e) {
            var t = this;
            e === Object(e) && (this.U.push(e), this.yb(e)), (this.Ga || !P.p || this.H) && this.U.length && (this.K(this.U.shift()), this.u()), !n.idSyncDisableSyncs && this.H && this.J.length && !this.Y && (this.La || (this.La = c, setTimeout(function() { t.Da = P.p ? 15 : 150 }, this.Oa)), this.Y = c, this.Ia())
        },
        yb: function(e) {
            var t, n, a;
            if ((t = e.ibs) && t instanceof Array && (n = t.length))
                for (e = 0; e < n; e++)(a = t[e]).syncOnPage && this.ta(a, "", "syncOnPage")
        },
        K: function(e) {
            var t, n, a, i, r, s = encodeURIComponent;
            if ((t = e.ibs) && t instanceof Array && (n = t.length))
                for (a = 0; a < n; a++) i = t[a], r = [s("ibs"), s(i.id || ""), s(i.tag || ""), L.jb(i.url || [], ","), s(i.ttl || ""), "", "", i.fireURLSync ? "true" : "false"], i.syncOnPage || (this.sa ? this.qa(r.join("|")) : i.fireURLSync && this.ta(i, r.join("|")));
            this.rb.push(e)
        },
        ta: function(e, t, a) {
            var i = (a = "syncOnPage" === a ? c : l) ? p : m;
            n.f();
            var r = n.a(i),
                s = l,
                o = l,
                d = Math.ceil((new Date).getTime() / P.da);
            r ? (r = r.split("*"), s = (o = this.zb(r, e.id, d)).hb, o = o.ib, (!s || !o) && this.ya(a, e, t, r, i, d)) : (r = [], this.ya(a, e, t, r, i, d))
        },
        zb: function(e, t, n) {
            var a, i, r, s = l,
                o = l;
            for (i = 0; i < e.length; i++) a = e[i], r = parseInt(a.split("-")[1], 10), a.match("^" + t + "-") ? (s = c, n < r ? o = c : (e.splice(i, 1), i--)) : n >= r && (e.splice(i, 1), i--);
            return { hb: s, ib: o }
        },
        sb: function(e) {
            if (e.join("*").length > this.ca)
                for (e.sort(function(e, t) { return parseInt(e.split("-")[1], 10) - parseInt(t.split("-")[1], 10) }); e.join("*").length > this.ca;) e.shift()
        },
        ya: function(e, t, a, i, r, o) {
            var c = this;
            if (e) {
                if ("img" === t.tag) {
                    var l, d, u;
                    e = t.url, a = n.loadSSL ? "https:" : "http:";
                    for (i = 0, l = e.length; i < l; i++) {
                        d = e[i], u = /^\/\//.test(d);
                        var g = new Image;
                        L.Q(g, "load", function(e, t, a, i) {
                            return function() {
                                c.W[e] = s, n.f();
                                var o, l, d, u, g = [];
                                if (o = n.a(r))
                                    for (l = 0, d = (o = o.split("*")).length; l < d; l++)(u = o[l]).match("^" + t.id + "-") || g.push(u);
                                c.Ka(g, t, a, i)
                            }
                        }(this.W.length, t, r, o)), g.src = (u ? a : "") + d, this.W.push(g)
                    }
                }
            } else this.qa(a), this.Ka(i, t, r, o)
        },
        qa: function(e) {
            var t = encodeURIComponent;
            this.J.push((n.Ib ? t("---destpub-debug---") : t("---destpub---")) + e)
        },
        Ka: function(e, t, a, i) { e.push(t.id + "-" + (i + Math.ceil(t.ttl / 60 / 24))), this.sb(e), n.d(a, e.join("*")) },
        Ia: function() {
            var e, t = this;
            this.J.length ? (e = this.J.shift(), n.pa.postMessage(e, this.url, this.Ca.contentWindow), this.tb.push(e), setTimeout(function() { t.Ia() }, this.Da)) : this.Y = l
        },
        X: function(e) { var t = /^---destpub-to-parent---/; "string" == typeof e && t.test(e) && ("canSetThirdPartyCookies" === (t = e.replace(t, "").split("|"))[0] && (this.sa = "true" === t[1] ? c : l, this.Ga = c, this.u()), this.ub.push(e)) },
        xb: function(e) {
            (this.url === s || e.subdomain && "nosubdomainreturned" === this.g) && (this.g = "string" == typeof n.oa && n.oa.length ? n.oa : e.subdomain || "", this.url = this.mb()), e.ibs instanceof Array && e.ibs.length && (this.xa = c), this.Fa() && (n.idSyncAttachIframeOnWindowLoad ? (i.aa || "complete" === r.readyState || "loaded" === r.readyState) && this.R() : this.bb()), "function" == typeof n.idSyncIDCallResult ? n.idSyncIDCallResult(e) : this.u(e), "function" == typeof n.idSyncAfterIDCallResult && n.idSyncAfterIDCallResult(e)
        },
        cb: function(e, t) { return n.Jb || !e || t - e > P.Ma },
        bb: function() {
            function e() { t.Z || (document.body ? t.R() : setTimeout(e, 30)) }
            var t = this;
            e()
        }
    };
    n.Gb = D, n.timeoutMetricsLog = [];
    var I = {
        gb: window.performance && window.performance.timing ? 1 : 0,
        Ea: window.performance && window.performance.timing ? window.performance.timing : s,
        $: s,
        S: s,
        c: {},
        V: [],
        send: function(e) {
            if (n.takeTimeoutMetrics && e === Object(e)) {
                var t, a = [],
                    i = encodeURIComponent;
                for (t in e) e.hasOwnProperty(t) && a.push(i(t) + "=" + i(e[t]));
                e = "http" + (n.loadSSL ? "s" : "") + "://dpm.demdex.net/event?d_visid_ver=" + n.version + "&d_visid_stg_timeout=" + n.loadTimeout + "&" + a.join("&") + "&d_orgid=" + i(n.marketingCloudOrgID) + "&d_timingapi=" + this.gb + "&d_winload=" + this.nb() + "&d_ld=" + this.o(), (new Image).src = e, n.timeoutMetricsLog.push(e)
            }
        },
        nb: function() { return this.S === s && (this.S = this.Ea ? this.$ - this.Ea.navigationStart : this.$ - i.fb), this.S },
        o: function() { return (new Date).getTime() },
        K: function(e) {
            var t = this.c[e],
                n = {};
            n.d_visid_stg_timeout_captured = t.wa, n.d_visid_cors = t.va, n.d_fieldgroup = e, n.d_settimeout_overriden = t.ua, t.timeout ? t.pb ? (n.d_visid_timedout = 1, n.d_visid_timeout = t.timeout - t.requestStart, n.d_visid_response = -1) : (n.d_visid_timedout = "n/a", n.d_visid_timeout = "n/a", n.d_visid_response = "n/a") : (n.d_visid_timedout = 0, n.d_visid_timeout = -1, n.d_visid_response = t.Bb - t.requestStart), n.d_visid_url = t.url, i.aa ? this.send(n) : this.V.push(n), delete this.c[e]
        },
        Ab: function() { for (var e = 0, t = this.V.length; e < t; e++) this.send(this.V[e]) },
        Aa: function() { return "function" == typeof setTimeout.toString ? -1 < setTimeout.toString().indexOf("[native code]") ? 0 : 1 : -1 }
    };
    n.Nb = I;
    var T = {
        isClientSideMarketingCloudVisitorID: s,
        MCIDCallTimedOut: s,
        AnalyticsIDCallTimedOut: s,
        AAMIDCallTimedOut: s,
        c: {},
        Ja: function(e, t) {
            switch (e) {
                case d:
                    t === l ? this.MCIDCallTimedOut !== c && (this.MCIDCallTimedOut = l) : this.MCIDCallTimedOut = t;
                    break;
                case v:
                    t === l ? this.AnalyticsIDCallTimedOut !== c && (this.AnalyticsIDCallTimedOut = l) : this.AnalyticsIDCallTimedOut = t;
                    break;
                case y:
                    t === l ? this.AAMIDCallTimedOut !== c && (this.AAMIDCallTimedOut = l) : this.AAMIDCallTimedOut = t
            }
        }
    };
    if (n.isClientSideMarketingCloudVisitorID = function() { return T.isClientSideMarketingCloudVisitorID }, n.MCIDCallTimedOut = function() { return T.MCIDCallTimedOut }, n.AnalyticsIDCallTimedOut = function() { return T.AnalyticsIDCallTimedOut }, n.AAMIDCallTimedOut = function() { return T.AAMIDCallTimedOut }, n.idSyncGetOnPageSyncInfo = function() { return n.f(), n.a(p) }, 0 > e.indexOf("@") && (e += "@AdobeOrg"), n.marketingCloudOrgID = e, n.cookieName = "AMCV_" + e, n.sessionCookieName = "AMCVS_" + e, n.cookieDomain = n.Ta(), n.cookieDomain == a.location.hostname && (n.cookieDomain = ""), n.loadSSL = 0 <= a.location.protocol.toLowerCase().indexOf("https"), n.loadTimeout = 3e4, n.CORSErrors = [], n.marketingCloudServer = n.audienceManagerServer = "dpm.demdex.net", n.Qa(), t && "object" == typeof t) {
        for (var V in t) !Object.prototype[V] && (n[V] = t[V]);
        n.idSyncContainerID = n.idSyncContainerID || 0, n.f(), E = n.a(f), V = Math.ceil((new Date).getTime() / P.da), !n.idSyncDisableSyncs && D.cb(E, V) && (n.j(k, -1), n.d(f, V)), n.getMarketingCloudVisitorID(), n.getAudienceManagerLocationHint(), n.getAudienceManagerBlob()
    }
    if (!n.idSyncDisableSyncs) {
        D.eb(), L.Q(window, "load", function() {
            i.aa = c, I.$ = I.o(), I.Ab();
            var e = D;
            e.Fa() && e.R()
        });
        try { n.pa.X(function(e) { D.X(e.data) }, D.T) } catch (x) {}
    }
}
Visitor.getInstance = function(e, t) {
        var n, a, i = window.s_c_il;
        if (0 > e.indexOf("@") && (e += "@AdobeOrg"), i)
            for (a = 0; a < i.length; a++)
                if ((n = i[a]) && "Visitor" == n._c && n.marketingCloudOrgID == e) return n;
        return new Visitor(e, t)
    },
    function() {
        function e() { t.aa = n }
        var t = window.Visitor,
            n = t.Pa,
            a = t.Na;
        n || (n = !0), a || (a = !1), window.addEventListener ? window.addEventListener("load", e) : window.attachEvent && window.attachEvent("onload", e), t.fb = (new Date).getTime()
    }(),
    // All code and conventions are protected by copyright
    function(e, t, n) {
        function a() { this.rules = E.filter(E.rules, function(e) { return "elementexists" === e.event }) }

        function i() { E.getToolsByType("nielsen").length > 0 && E.domReady(E.bind(this.initialize, this)) }

        function r() { E.addEventHandler(e, "orientationchange", r.orientationChange) }

        function s() {
            var e = this.eventRegex = /^hover\(([0-9]+)\)$/,
                t = this.rules = [];
            E.each(E.rules, function(n) { n.event.match(e) && t.push([Number(n.event.match(e)[1]), n.selector]) })
        }

        function o() {
            this.defineEvents(), this.visibilityApiHasPriority = !0, t.addEventListener ? this.setVisibilityApiPriority(!1) : this.attachDetachOlderEventListeners(!0, t, "focusout");
            E.bindEvent("aftertoolinit", function() { E.fireEvent(E.visibility.isHidden() ? "tabblur" : "tabfocus") })
        }

        function c() { this.lastURL = E.URL(), this._fireIfURIChanged = E.bind(this.fireIfURIChanged, this), this._onPopState = E.bind(this.onPopState, this), this._onHashChange = E.bind(this.onHashChange, this), this._pushState = E.bind(this.pushState, this), this._replaceState = E.bind(this.replaceState, this), this.initialize() }

        function l() { this.rules = E.filter(E.rules, function(e) { return "videoplayed" === e.event.substring(0, 11) }), this.eventHandler = E.bind(this.onUpdateTime, this) }

        function d(e) { this.delay = 250, this.FB = e, E.domReady(E.bind(function() { E.poll(E.bind(this.initialize, this), this.delay, 8) }, this)) }

        function u(t) { E.domReady(E.bind(function() { this.twttr = t || e.twttr, this.initialize() }, this)) }

        function g(t) { t = t || E.rules, this.rules = E.filter(t, function(e) { return "inview" === e.event }), this.elements = [], this.eventHandler = E.bind(this.track, this), E.addEventHandler(e, "scroll", this.eventHandler), E.addEventHandler(e, "load", this.eventHandler) }

        function m() {
            var e = E.filter(E.rules, function(e) { return 0 === e.event.indexOf("dataelementchange") });
            this.dataElementsNames = E.map(e, function(e) { return e.event.match(/dataelementchange\((.*)\)/i)[1] }, this), this.initPolling()
        }

        function p(e) { E.BaseTool.call(this, e), this.name = e.name || "VisitorID", this.initialize() }

        function f(e) { E.BaseTool.call(this, e), this.name = e.name || "Basic" }

        function h(e) { E.BaseTool.call(this, e), this.styleElements = {}, this.targetPageParamsStore = {} }

        function v(e) { E.BaseTool.call(this, e) }

        function b(e) { E.BaseTool.call(this, e) }

        function y(e) { E.BaseTool.call(this, e), this.varBindings = {}, this.events = [], this.products = [], this.customSetupFuns = [] }

        function S() { E.BaseTool.call(this), this.asyncScriptCallbackQueue = [], this.argsForBlockingScripts = [] }

        function k(e) { E.BaseTool.call(this, e), this.defineListeners(), this.beaconMethod = "plainBeacon", this.adapt = new k.DataAdapters, this.dataProvider = new k.DataProvider.Aggregate }
        var w, P, L, C = Object.prototype.toString,
            _ = e._satellite && e._satellite.override,
            E = {
                initialized: !1,
                $data: function(e, t, a) {
                    if (e) {
                        var i = "__satellite__",
                            r = E.dataCache,
                            s = e[i];
                        s || (s = e[i] = E.uuid++);
                        var o = r[s];
                        if (o || (o = r[s] = {}), a === n) return o[t];
                        o[t] = a
                    }
                },
                uuid: 1,
                dataCache: {},
                keys: function(e) { var t = []; for (var n in e) e.hasOwnProperty(n) && t.push(n); return t },
                values: function(e) { var t = []; for (var n in e) e.hasOwnProperty(n) && t.push(e[n]); return t },
                isArray: Array.isArray || function(e) { return "[object Array]" === C.apply(e) },
                isObject: function(e) { return null != e && !E.isArray(e) && "object" == typeof e },
                isString: function(e) { return "string" == typeof e },
                isNumber: function(e) { return "[object Number]" === C.apply(e) && !E.isNaN(e) },
                isNaN: function(e) { return e != e },
                isRegex: function(e) { return e instanceof RegExp },
                isLinkTag: function(e) { return !(!e || !e.nodeName || "a" !== e.nodeName.toLowerCase()) },
                each: function(e, t, n) { for (var a = 0, i = e.length; a < i; a++) t.call(n, e[a], a, e) },
                map: function(e, t, n) { for (var a = [], i = 0, r = e.length; i < r; i++) a.push(t.call(n, e[i], i, e)); return a },
                filter: function(e, t, n) {
                    for (var a = [], i = 0, r = e.length; i < r; i++) {
                        var s = e[i];
                        t.call(n, s, i, e) && a.push(s)
                    }
                    return a
                },
                any: function(e, t, n) { for (var a = 0, i = e.length; a < i; a++) { var r = e[a]; if (t.call(n, r, a, e)) return !0 } return !1 },
                every: function(e, t, n) {
                    for (var a = !0, i = 0, r = e.length; i < r; i++) {
                        var s = e[i];
                        a = a && t.call(n, s, i, e)
                    }
                    return a
                },
                contains: function(e, t) { return -1 !== E.indexOf(e, t) },
                indexOf: function(e, t) {
                    if (e.indexOf) return e.indexOf(t);
                    for (var n = e.length; n--;)
                        if (t === e[n]) return n;
                    return -1
                },
                find: function(e, t, n) { if (!e) return null; for (var a = 0, i = e.length; a < i; a++) { var r = e[a]; if (t.call(n, r, a, e)) return r } return null },
                textMatch: function(e, t) { if (null == t) throw new Error("Illegal Argument: Pattern is not present"); return null != e && ("string" == typeof t ? e === t : t instanceof RegExp && t.test(e)) },
                stringify: function(e, t) {
                    if (t = t || [], E.isObject(e)) {
                        if (E.contains(t, e)) return "<Cycle>";
                        t.push(e)
                    }
                    if (E.isArray(e)) return "[" + E.map(e, function(e) { return E.stringify(e, t) }).join(",") + "]";
                    if (E.isString(e)) return '"' + String(e) + '"';
                    if (E.isObject(e)) { var n = []; for (var a in e) e.hasOwnProperty(a) && n.push(a + ": " + E.stringify(e[a], t)); return "{" + n.join(", ") + "}" }
                    return String(e)
                },
                trim: function(e) { return null == e ? null : e.trim ? e.trim() : e.replace(/^ */, "").replace(/ *$/, "") },
                bind: function(e, t) { return function() { return e.apply(t, arguments) } },
                throttle: function(e, t) {
                    var n = null;
                    return function() {
                        var a = this,
                            i = arguments;
                        clearTimeout(n), n = setTimeout(function() { e.apply(a, i) }, t)
                    }
                },
                domReady: function(e) {
                    function n(e) { for (g = 1; e = i.shift();) e() }
                    var a, i = [],
                        r = !1,
                        s = t,
                        o = s.documentElement,
                        c = o.doScroll,
                        l = "DOMContentLoaded",
                        d = "addEventListener",
                        u = "onreadystatechange",
                        g = /^loade|^c/.test(s.readyState);
                    return s[d] && s[d](l, a = function() { s.removeEventListener(l, a, r), n() }, r), c && s.attachEvent(u, a = function() { /^c/.test(s.readyState) && (s.detachEvent(u, a), n()) }), e = c ? function(t) {
                        self != top ? g ? t() : i.push(t) : function() {
                            try { o.doScroll("left") } catch (n) { return setTimeout(function() { e(t) }, 50) }
                            t()
                        }()
                    } : function(e) { g ? e() : i.push(e) }
                }(),
                loadScript: function(e, n) {
                    var a = t.createElement("script");
                    E.scriptOnLoad(e, a, n), a.src = e, t.getElementsByTagName("head")[0].appendChild(a)
                },
                scriptOnLoad: function(e, t, n) {
                    function a(e) { e && E.logError(e), n && n(e) }
                    "onload" in t ? (t.onload = function() { a() }, t.onerror = function() { a(new Error("Failed to load script " + e)) }) : "readyState" in t && (t.onreadystatechange = function() { var e = t.readyState; "loaded" !== e && "complete" !== e || (t.onreadystatechange = null, a()) })
                },
                loadScriptOnce: function(e, t) { E.loadedScriptRegistry[e] || E.loadScript(e, function(n) { n || (E.loadedScriptRegistry[e] = !0), t && t(n) }) },
                loadedScriptRegistry: {},
                loadScriptSync: function(e) { t.write ? E.domReadyFired ? E.notify('Cannot load sync the "' + e + '" script after DOM Ready.', 1) : (e.indexOf('"') > -1 && (e = encodeURI(e)), t.write('<script src="' + e + '"></script>')) : E.notify('Cannot load sync the "' + e + '" script because "document.write" is not available', 1) },
                pushAsyncScript: function(e) { E.tools["default"].pushAsyncScript(e) },
                pushBlockingScript: function(e) { E.tools["default"].pushBlockingScript(e) },
                addEventHandler: e.addEventListener ? function(e, t, n) { e.addEventListener(t, n, !1) } : function(e, t, n) { e.attachEvent("on" + t, n) },
                removeEventHandler: e.removeEventListener ? function(e, t, n) { e.removeEventListener(t, n, !1) } : function(e, t, n) { e.detachEvent("on" + t, n) },
                preventDefault: e.addEventListener ? function(e) { e.preventDefault() } : function(e) { e.returnValue = !1 },
                stopPropagation: function(e) { e.cancelBubble = !0, e.stopPropagation && e.stopPropagation() },
                containsElement: function(e, t) { return e.contains ? e.contains(t) : !!(16 & e.compareDocumentPosition(t)) },
                matchesCss: function(n) {
                    function a(e, t) { var n = t.tagName; return !!n && e.toLowerCase() === n.toLowerCase() }
                    var i = n.matchesSelector || n.mozMatchesSelector || n.webkitMatchesSelector || n.oMatchesSelector || n.msMatchesSelector;
                    return i ? function(n, a) { if (a === t || a === e) return !1; try { return i.call(a, n) } catch (r) { return !1 } } : n.querySelectorAll ? function(e, t) {
                        if (!t.parentNode) return !1;
                        if (e.match(/^[a-z]+$/i)) return a(e, t);
                        try {
                            for (var n = t.parentNode.querySelectorAll(e), i = n.length; i--;)
                                if (n[i] === t) return !0
                        } catch (r) {}
                        return !1
                    } : function(e, t) { if (e.match(/^[a-z]+$/i)) return a(e, t); try { return E.Sizzle.matches(e, [t]).length > 0 } catch (n) { return !1 } }
                }(t.documentElement),
                cssQuery: (w = t, w.querySelectorAll ? function(e, t) {
                    var n;
                    try { n = w.querySelectorAll(e) } catch (a) { n = [] }
                    t(n)
                } : function(e, t) {
                    if (E.Sizzle) {
                        var n;
                        try { n = E.Sizzle(e) } catch (a) { n = [] }
                        t(n)
                    } else E.sizzleQueue.push([e, t])
                }),
                hasAttr: function(e, t) { return e.hasAttribute ? e.hasAttribute(t) : e[t] !== n },
                inherit: function(e, t) {
                    var n = function() {};
                    n.prototype = t.prototype, e.prototype = new n, e.prototype.constructor = e
                },
                extend: function(e, t) { for (var n in t) t.hasOwnProperty(n) && (e[n] = t[n]) },
                toArray: function() {
                    try {
                        var e = Array.prototype.slice;
                        return e.call(t.documentElement.childNodes, 0)[0].nodeType,
                            function(t) { return e.call(t, 0) }
                    } catch (n) { return function(e) { for (var t = [], n = 0, a = e.length; n < a; n++) t.push(e[n]); return t } }
                }(),
                equalsIgnoreCase: function(e, t) { return null == e ? null == t : null != t && String(e).toLowerCase() === String(t).toLowerCase() },
                poll: function(e, t, n) {
                    function a() { E.isNumber(n) && i++ >= n || e() || setTimeout(a, t) }
                    var i = 0;
                    t = t || 1e3, a()
                },
                escapeForHtml: function(e) { return e ? String(e).replace(/\&/g, "&amp;").replace(/\</g, "&lt;").replace(/\>/g, "&gt;").replace(/\"/g, "&quot;").replace(/\'/g, "&#x27;").replace(/\//g, "&#x2F;") : e }
            };
        E.availableTools = {}, E.availableEventEmitters = [], E.fireOnceEvents = ["condition", "elementexists"], E.initEventEmitters = function() { E.eventEmitters = E.map(E.availableEventEmitters, function(e) { return new e }) }, E.eventEmitterBackgroundTasks = function() { E.each(E.eventEmitters, function(e) { "backgroundTasks" in e && e.backgroundTasks() }) }, E.initTools = function(e) {
                var t = { "default": new S },
                    n = E.settings.euCookieName || "sat_track";
                for (var a in e)
                    if (e.hasOwnProperty(a)) {
                        var i, r, s;
                        if ((i = e[a]).euCookie)
                            if ("true" !== E.readCookie(n)) continue;
                        if (!(r = E.availableTools[i.engine])) { var o = []; for (var c in E.availableTools) E.availableTools.hasOwnProperty(c) && o.push(c); throw new Error("No tool engine named " + i.engine + ", available: " + o.join(",") + ".") }(s = new r(i)).id = a, t[a] = s
                    }
                return t
            }, E.preprocessArguments = function(e, t, n, a, i) {
                function r(e) { return a && E.isString(e) ? e.toLowerCase() : e }

                function s(e) {
                    var c = {};
                    for (var l in e)
                        if (e.hasOwnProperty(l)) {
                            var d = e[l];
                            E.isObject(d) ? c[l] = s(d) : E.isArray(d) ? c[l] = o(d, a) : c[l] = r(E.replace(d, t, n, i))
                        }
                    return c
                }

                function o(e) {
                    for (var a = [], i = 0, o = e.length; i < o; i++) {
                        var c = e[i];
                        E.isString(c) ? c = r(E.replace(c, t, n)) : c && c.constructor === Object && (c = s(c)), a.push(c)
                    }
                    return a
                }
                return e ? o(e, a) : e
            }, E.execute = function(e, t, n, a) {
                function i(i) { var r = a[i || "default"]; if (r) try { r.triggerCommand(e, t, n) } catch (s) { E.logError(s) } }
                if (!_satellite.settings.hideActivity)
                    if (a = a || E.tools, e.engine) {
                        var r = e.engine;
                        for (var s in a)
                            if (a.hasOwnProperty(s)) {
                                var o = a[s];
                                o.settings && o.settings.engine === r && i(s)
                            }
                    } else e.tool instanceof Array ? E.each(e.tool, function(e) { i(e) }) : i(e.tool)
            }, E.Logger = {
                outputEnabled: !1,
                messages: [],
                keepLimit: 100,
                flushed: !1,
                LEVELS: [null, null, "log", "info", "warn", "error"],
                message: function(e, t) {
                    var n = this.LEVELS[t] || "log";
                    this.messages.push([n, e]), this.messages.length > this.keepLimit && this.messages.shift(), this.outputEnabled && this.echo(n, e)
                },
                getHistory: function() { return this.messages },
                clearHistory: function() { this.messages = [] },
                setOutputState: function(e) { this.outputEnabled != e && (this.outputEnabled = e, e ? this.flush() : this.flushed = !1) },
                echo: function(t, n) { e.console && e.console[t]("SATELLITE: " + n) },
                flush: function() { this.flushed || (E.each(this.messages, function(e) {!0 !== e[2] && (this.echo(e[0], e[1]), e[2] = !0) }, this), this.flushed = !0) }
            }, E.notify = E.bind(E.Logger.message, E.Logger), E.cleanText = function(e) { return null == e ? null : E.trim(e).replace(/\s+/g, " ") }, E.cleanText.legacy = function(e) { return null == e ? null : E.trim(e).replace(/\s{2,}/g, " ").replace(/[^\000-\177]*/g, "") }, E.text = function(e) { return e.textContent || e.innerText }, E.specialProperties = { text: E.text, cleanText: function(e) { return E.cleanText(E.text(e)) } }, E.getObjectProperty = function(e, t, a) {
                for (var i, r = t.split("."), s = e, o = E.specialProperties, c = 0, l = r.length; c < l; c++) {
                    if (null == s) return n;
                    var d = r[c];
                    if (a && "@" === d.charAt(0)) s = o[d.slice(1)](s);
                    else if (s.getAttribute && (i = d.match(/^getAttribute\((.+)\)$/))) {
                        var u = i[1];
                        s = s.getAttribute(u)
                    } else s = s[d]
                }
                return s
            }, E.getToolsByType = function(e) {
                if (!e) throw new Error("Tool type is missing");
                var t = [];
                for (var n in E.tools)
                    if (E.tools.hasOwnProperty(n)) {
                        var a = E.tools[n];
                        a.settings && a.settings.engine === e && t.push(a)
                    }
                return t
            }, E.setVar = function() {
                var e = E.data.customVars;
                if (null == e && (E.data.customVars = {}, e = E.data.customVars), "string" == typeof arguments[0]) e[arguments[0]] = arguments[1];
                else if (arguments[0]) { var t = arguments[0]; for (var n in t) t.hasOwnProperty(n) && (e[n] = t[n]) }
            }, E.dataElementSafe = function(e, t) { if (arguments.length > 2) { var n = arguments[2]; "pageview" === t ? E.dataElementSafe.pageviewCache[e] = n : "session" === t ? E.setCookie("_sdsat_" + e, n) : "visitor" === t && E.setCookie("_sdsat_" + e, n, 730) } else { if ("pageview" === t) return E.dataElementSafe.pageviewCache[e]; if ("session" === t || "visitor" === t) return E.readCookie("_sdsat_" + e) } }, E.dataElementSafe.pageviewCache = {}, E.realGetDataElement = function(t) { var n; return t.selector ? E.hasSelector && E.cssQuery(t.selector, function(e) { if (e.length > 0) { var a = e[0]; "text" === t.property ? n = a.innerText || a.textContent : t.property in a ? n = a[t.property] : E.hasAttr(a, t.property) && (n = a.getAttribute(t.property)) } }) : t.queryParam ? n = t.ignoreCase ? E.getQueryParamCaseInsensitive(t.queryParam) : E.getQueryParam(t.queryParam) : t.cookie ? n = E.readCookie(t.cookie) : t.jsVariable ? n = E.getObjectProperty(e, t.jsVariable) : t.customJS ? n = t.customJS() : t.contextHub && (n = t.contextHub()), E.isString(n) && t.cleanText && (n = E.cleanText(n)), n }, E.getDataElement = function(e, t, a) { if (null == (a = a || E.dataElements[e])) return E.settings.undefinedVarsReturnEmpty ? "" : null; var i = E.realGetDataElement(a); return i === n && a.storeLength ? i = E.dataElementSafe(e, a.storeLength) : i !== n && a.storeLength && E.dataElementSafe(e, a.storeLength, i), i || t || (i = a["default"] || ""), E.isString(i) && a.forceLowerCase && (i = i.toLowerCase()), i }, E.getVar = function(a, i, r) {
                var s, o, c = E.data.customVars,
                    l = r ? r.target || r.srcElement : null,
                    d = { uri: E.URI(), protocol: t.location.protocol, hostname: t.location.hostname };
                if (E.dataElements && a in E.dataElements) return E.getDataElement(a);
                if ((o = d[a.toLowerCase()]) === n)
                    if ("this." === a.substring(0, 5)) a = a.slice(5), o = E.getObjectProperty(i, a, !0);
                    else if ("event." === a.substring(0, 6)) a = a.slice(6), o = E.getObjectProperty(r, a);
                else if ("target." === a.substring(0, 7)) a = a.slice(7), o = E.getObjectProperty(l, a);
                else if ("window." === a.substring(0, 7)) a = a.slice(7), o = E.getObjectProperty(e, a);
                else if ("param." === a.substring(0, 6)) a = a.slice(6), o = E.getQueryParam(a);
                else if (s = a.match(/^rand([0-9]+)$/)) {
                    var u = Number(s[1]),
                        g = (Math.random() * (Math.pow(10, u) - 1)).toFixed(0);
                    o = Array(u - g.length + 1).join("0") + g
                } else o = E.getObjectProperty(c, a);
                return o
            }, E.getVars = function(e, t, n) { var a = {}; return E.each(e, function(e) { a[e] = E.getVar(e, t, n) }), a }, E.replace = function(e, t, n, a) { return "string" != typeof e ? e : e.replace(/%(.*?)%/g, function(e, i) { var r = E.getVar(i, t, n); return null == r ? E.settings.undefinedVarsReturnEmpty ? "" : e : a ? E.escapeForHtml(r) : r }) }, E.escapeHtmlParams = function(e) { return e.escapeHtml = !0, e }, E.searchVariables = function(e, t, n) {
                if (!e || 0 === e.length) return "";
                for (var a = [], i = 0, r = e.length; i < r; i++) {
                    var s = e[i],
                        o = E.getVar(s, t, n);
                    a.push(s + "=" + escape(o))
                }
                return "?" + a.join("&")
            }, E.fireRule = function(e, t, n) {
                var a = e.trigger;
                if (a) {
                    for (var i = 0, r = a.length; i < r; i++) {
                        var s = a[i];
                        E.execute(s, t, n)
                    }
                    E.contains(E.fireOnceEvents, e.event) && (e.expired = !0)
                }
            }, E.isLinked = function(e) {
                for (var t = e; t; t = t.parentNode)
                    if (E.isLinkTag(t)) return !0;
                return !1
            }, E.firePageLoadEvent = function(e) {
                for (var n = t.location, a = { type: e, target: n }, i = E.pageLoadRules, r = E.evtHandlers[a.type], s = i.length; s--;) {
                    var o = i[s];
                    E.ruleMatches(o, a, n) && (E.notify('Rule "' + o.name + '" fired.', 1), E.fireRule(o, n, a))
                }
                for (var c in E.tools)
                    if (E.tools.hasOwnProperty(c)) {
                        var l = E.tools[c];
                        l.endPLPhase && l.endPLPhase(e)
                    }
                r && E.each(r, function(e) { e(a) })
            }, E.track = function(e) {
                e = e.replace(/^\s*/, "").replace(/\s*$/, "");
                for (var t = 0; t < E.directCallRules.length; t++) { var n = E.directCallRules[t]; if (n.name === e) return E.notify('Direct call Rule "' + e + '" fired.', 1), void E.fireRule(n, location, { type: e }) }
                E.notify('Direct call Rule "' + e + '" not found.', 1)
            }, E.basePath = function() { return E.data.host ? ("https:" === t.location.protocol ? "https://" + E.data.host.https : "http://" + E.data.host.http) + "/" : this.settings.basePath }, E.setLocation = function(t) { e.location = t }, E.parseQueryParams = function(e) {
                var t = function(e) { var t = e; try { t = decodeURIComponent(e) } catch (n) {} return t };
                if ("" === e || !1 === E.isString(e)) return {};
                0 === e.indexOf("?") && (e = e.substring(1));
                var n = {},
                    a = e.split("&");
                return E.each(a, function(e) {
                    (e = e.split("="))[1] && (n[t(e[0])] = t(e[1]))
                }), n
            }, E.getCaseSensitivityQueryParamsMap = function(e) {
                var t = E.parseQueryParams(e),
                    n = {};
                for (var a in t) t.hasOwnProperty(a) && (n[a.toLowerCase()] = t[a]);
                return { normal: t, caseInsensitive: n }
            }, E.updateQueryParams = function() { E.QueryParams = E.getCaseSensitivityQueryParamsMap(e.location.search) }, E.updateQueryParams(), E.getQueryParam = function(e) { return E.QueryParams.normal[e] }, E.getQueryParamCaseInsensitive = function(e) { return E.QueryParams.caseInsensitive[e.toLowerCase()] }, E.encodeObjectToURI = function(e) { if (!1 === E.isObject(e)) return ""; var t = []; for (var n in e) e.hasOwnProperty(n) && t.push(encodeURIComponent(n) + "=" + encodeURIComponent(e[n])); return t.join("&") }, E.readCookie = function(e) {
                for (var a = e + "=", i = t.cookie.split(";"), r = 0; r < i.length; r++) {
                    for (var s = i[r];
                        " " == s.charAt(0);) s = s.substring(1, s.length);
                    if (0 === s.indexOf(a)) return s.substring(a.length, s.length)
                }
                return n
            }, E.setCookie = function(e, n, a) {
                var i;
                if (a) {
                    var r = new Date;
                    r.setTime(r.getTime() + 24 * a * 60 * 60 * 1e3), i = "; expires=" + r.toGMTString()
                } else i = "";
                t.cookie = e + "=" + n + i + "; path=/"
            }, E.removeCookie = function(e) { E.setCookie(e, "", -1) }, E.getElementProperty = function(e, t) { if ("@" === t.charAt(0)) { var a = E.specialProperties[t.substring(1)]; if (a) return a(e) } return "innerText" === t ? E.text(e) : t in e ? e[t] : e.getAttribute ? e.getAttribute(t) : n }, E.propertiesMatch = function(e, t) {
                if (e)
                    for (var n in e)
                        if (e.hasOwnProperty(n)) {
                            var a = e[n],
                                i = E.getElementProperty(t, n);
                            if ("string" == typeof a && a !== i) return !1;
                            if (a instanceof RegExp && !a.test(i)) return !1
                        }
                return !0
            }, E.isRightClick = function(e) { var t; return e.which ? t = 3 == e.which : e.button && (t = 2 == e.button), t }, E.ruleMatches = function(e, t, n, a) {
                var i = e.condition,
                    r = e.conditions,
                    s = e.property,
                    o = t.type,
                    c = e.value,
                    l = t.target || t.srcElement,
                    d = n === l;
                if (e.event !== o && ("custom" !== e.event || e.customEvent !== o)) return !1;
                if (!E.ruleInScope(e)) return !1;
                if ("click" === e.event && E.isRightClick(t)) return !1;
                if (e.isDefault && a > 0) return !1;
                if (e.expired) return !1;
                if ("inview" === o && t.inviewDelay !== e.inviewDelay) return !1;
                if (!d && (!1 === e.bubbleFireIfParent || 0 !== a && !1 === e.bubbleFireIfChildFired)) return !1;
                if (e.selector && !E.matchesCss(e.selector, n)) return !1;
                if (!E.propertiesMatch(s, n)) return !1;
                if (null != c)
                    if ("string" == typeof c) { if (c !== n.value) return !1 } else if (!c.test(n.value)) return !1;
                if (i) try { if (!i.call(n, t, l)) return E.notify('Condition for rule "' + e.name + '" not met.', 1), !1 } catch (g) { return E.notify('Condition for rule "' + e.name + '" not met. Error: ' + g.message, 1), !1 }
                if (r) { var u = E.find(r, function(a) { try { return !a.call(n, t, l) } catch (g) { return E.notify('Condition for rule "' + e.name + '" not met. Error: ' + g.message, 1), !0 } }); if (u) return E.notify("Condition " + u.toString() + ' for rule "' + e.name + '" not met.', 1), !1 }
                return !0
            }, E.evtHandlers = {}, E.bindEvent = function(e, t) {
                var n = E.evtHandlers;
                n[e] || (n[e] = []), n[e].push(t)
            }, E.whenEvent = E.bindEvent, E.unbindEvent = function(e, t) {
                var n = E.evtHandlers;
                if (n[e]) {
                    var a = E.indexOf(n[e], t);
                    n[e].splice(a, 1)
                }
            }, E.bindEventOnce = function(e, t) {
                var n = function() { E.unbindEvent(e, n), t.apply(null, arguments) };
                E.bindEvent(e, n)
            }, E.isVMLPoisoned = function(e) { if (!e) return !1; try { e.nodeName } catch (t) { if ("Attribute only valid on v:image" === t.message) return !0 } return !1 }, E.handleEvent = function(e) {
                if (!E.$data(e, "eventProcessed")) {
                    var t = e.type.toLowerCase(),
                        n = e.target || e.srcElement,
                        a = 0,
                        i = E.rules,
                        r = (E.tools, E.evtHandlers[e.type]);
                    if (E.isVMLPoisoned(n)) E.notify("detected " + t + " on poisoned VML element, skipping.", 1);
                    else {
                        r && E.each(r, function(t) { t(e) }), n && n.nodeName ? E.notify("detected " + t + " on " + n.nodeName, 1) : E.notify("detected " + t, 1);
                        for (var s = n; s; s = s.parentNode) { var o = !1; if (E.each(i, function(t) { E.ruleMatches(t, e, s, a) && (E.notify('Rule "' + t.name + '" fired.', 1), E.fireRule(t, s, e), a++, t.bubbleStop && (o = !0)) }), o) break }
                        E.$data(e, "eventProcessed", !0)
                    }
                }
            }, E.onEvent = t.querySelectorAll ? function(e) { E.handleEvent(e) } : (P = [], (L = function(e) { e.selector ? P.push(e) : E.handleEvent(e) }).pendingEvents = P, L), E.fireEvent = function(e, t) { E.onEvent({ type: e, target: t }) }, E.registerEvents = function(e, t) {
                for (var n = t.length - 1; n >= 0; n--) {
                    var a = t[n];
                    E.$data(e, a + ".tracked") || (E.addEventHandler(e, a, E.onEvent), E.$data(e, a + ".tracked", !0))
                }
            }, E.registerEventsForTags = function(e, n) {
                for (var a = e.length - 1; a >= 0; a--)
                    for (var i = e[a], r = t.getElementsByTagName(i), s = r.length - 1; s >= 0; s--) E.registerEvents(r[s], n)
            }, E.setListeners = function() {
                var e = ["click", "submit"];
                E.each(E.rules, function(t) { "custom" === t.event && t.hasOwnProperty("customEvent") && !E.contains(e, t.customEvent) && e.push(t.customEvent) }), E.registerEvents(t, e)
            }, E.getUniqueRuleEvents = function() { return E._uniqueRuleEvents || (E._uniqueRuleEvents = [], E.each(E.rules, function(e) {-1 === E.indexOf(E._uniqueRuleEvents, e.event) && E._uniqueRuleEvents.push(e.event) })), E._uniqueRuleEvents }, E.setFormListeners = function() {
                if (!E._relevantFormEvents) {
                    var e = ["change", "focus", "blur", "keypress"];
                    E._relevantFormEvents = E.filter(E.getUniqueRuleEvents(), function(t) { return -1 !== E.indexOf(e, t) })
                }
                E._relevantFormEvents.length && E.registerEventsForTags(["input", "select", "textarea", "button"], E._relevantFormEvents)
            }, E.setVideoListeners = function() {
                if (!E._relevantVideoEvents) {
                    var e = ["play", "pause", "ended", "volumechange", "stalled", "loadeddata"];
                    E._relevantVideoEvents = E.filter(E.getUniqueRuleEvents(), function(t) { return -1 !== E.indexOf(e, t) })
                }
                E._relevantVideoEvents.length && E.registerEventsForTags(["video"], E._relevantVideoEvents)
            }, E.readStoredSetting = function(t) { try { return t = "sdsat_" + t, e.localStorage.getItem(t) } catch (n) { return E.notify("Cannot read stored setting from localStorage: " + n.message, 2), null } }, E.loadStoredSettings = function() {
                var e = E.readStoredSetting("debug"),
                    t = E.readStoredSetting("hide_activity");
                e && (E.settings.notifications = "true" === e), t && (E.settings.hideActivity = "true" === t)
            }, E.isRuleActive = function(e, t) {
                function n(e, t) { return t = i(t, { hour: e[m](), minute: e[p]() }), Math.floor(Math.abs((e.getTime() - t.getTime()) / 864e5)) }

                function a(e, t) {
                    function n(e) { return 12 * e[u]() + e[g]() }
                    return Math.abs(n(e) - n(t))
                }

                function i(e, t) {
                    var n = new Date(e.getTime());
                    for (var a in t)
                        if (t.hasOwnProperty(a)) {
                            var i = t[a];
                            switch (a) {
                                case "hour":
                                    n[f](i);
                                    break;
                                case "minute":
                                    n[h](i);
                                    break;
                                case "date":
                                    n[v](i)
                            }
                        }
                    return n
                }

                function r(e, t) { return 60 * e[m]() + e[p]() > 60 * t[m]() + t[p]() }

                function s(e, t) { return 60 * e[m]() + e[p]() < 60 * t[m]() + t[p]() }
                var o = e.schedule;
                if (!o) return !0;
                var c = o.utc,
                    l = c ? "getUTCDate" : "getDate",
                    d = c ? "getUTCDay" : "getDay",
                    u = c ? "getUTCFullYear" : "getFullYear",
                    g = c ? "getUTCMonth" : "getMonth",
                    m = c ? "getUTCHours" : "getHours",
                    p = c ? "getUTCMinutes" : "getMinutes",
                    f = c ? "setUTCHours" : "setHours",
                    h = c ? "setUTCMinutes" : "setMinutes",
                    v = c ? "setUTCDate" : "setDate";
                if (t = t || new Date, o.repeat) {
                    if (r(o.start, t)) return !1;
                    if (s(o.end, t)) return !1;
                    if (t < o.start) return !1;
                    if (o.endRepeat && t >= o.endRepeat) return !1;
                    if ("daily" === o.repeat) {
                        if (o.repeatEvery)
                            if (n(o.start, t) % o.repeatEvery != 0) return !1
                    } else if ("weekly" === o.repeat) {
                        if (o.days) { if (!E.contains(o.days, t[d]())) return !1 } else if (o.start[d]() !== t[d]()) return !1;
                        if (o.repeatEvery)
                            if (n(o.start, t) % (7 * o.repeatEvery) != 0) return !1
                    } else if ("monthly" === o.repeat) {
                        if (o.repeatEvery)
                            if (a(o.start, t) % o.repeatEvery != 0) return !1;
                        if (o.nthWeek && o.mthDay) { if (o.mthDay !== t[d]()) return !1; var b = Math.floor((t[l]() - t[d]() + 1) / 7); if (o.nthWeek !== b) return !1 } else if (o.start[l]() !== t[l]()) return !1
                    } else if ("yearly" === o.repeat) {
                        if (o.start[g]() !== t[g]()) return !1;
                        if (o.start[l]() !== t[l]()) return !1;
                        if (o.repeatEvery)
                            if (Math.abs(o.start[u]() - t[u]()) % o.repeatEvery != 0) return !1
                    }
                } else { if (o.start > t) return !1; if (o.end < t) return !1 }
                return !0
            }, E.isOutboundLink = function(e) {
                if (!e.getAttribute("href")) return !1;
                var t = e.hostname,
                    n = (e.href, e.protocol);
                return ("http:" === n || "https:" === n) && (!E.any(E.settings.domainList, function(e) { return E.isSubdomainOf(t, e) }) && t !== location.hostname)
            }, E.isLinkerLink = function(e) { return !(!e.getAttribute || !e.getAttribute("href")) && (E.hasMultipleDomains() && e.hostname != location.hostname && !e.href.match(/^javascript/i) && !E.isOutboundLink(e)) }, E.isSubdomainOf = function(e, t) { if (e === t) return !0; var n = e.length - t.length; return n > 0 && E.equalsIgnoreCase(e.substring(n), t) }, E.getVisitorId = function() { var e = E.getToolsByType("visitor_id"); return 0 === e.length ? null : e[0].getInstance() }, E.URI = function() { var e = t.location.pathname + t.location.search; return E.settings.forceLowerCase && (e = e.toLowerCase()), e }, E.URL = function() { var e = t.location.href; return E.settings.forceLowerCase && (e = e.toLowerCase()), e }, E.filterRules = function() {
                function e(e) { return !!E.isRuleActive(e) }
                E.rules = E.filter(E.rules, e), E.pageLoadRules = E.filter(E.pageLoadRules, e)
            }, E.ruleInScope = function(e, n) {
                function a(e, t) {
                    function n(e) { return t.match(e) }
                    var a = e.include,
                        r = e.exclude;
                    if (a && i(a, t)) return !0;
                    if (r) { if (E.isString(r) && r === t) return !0; if (E.isArray(r) && E.any(r, n)) return !0; if (E.isRegex(r) && n(r)) return !0 }
                    return !1
                }

                function i(e, t) {
                    function n(e) { return t.match(e) }
                    return !(!E.isString(e) || e === t) || (!(!E.isArray(e) || E.any(e, n)) || !(!E.isRegex(e) || n(e)))
                }
                n = n || t.location;
                var r = e.scope;
                if (!r) return !0;
                var s = r.URI,
                    o = r.subdomains,
                    c = r.domains,
                    l = r.protocols,
                    d = r.hashes;
                return (!s || !a(s, n.pathname + n.search)) && ((!o || !a(o, n.hostname)) && ((!c || !i(c, n.hostname)) && ((!l || !i(l, n.protocol)) && (!d || !a(d, n.hash)))))
            }, E.backgroundTasks = function() {
                new Date;
                E.setFormListeners(), E.setVideoListeners(), E.loadStoredSettings(), E.registerNewElementsForDynamicRules(), E.eventEmitterBackgroundTasks();
                new Date
            }, E.registerNewElementsForDynamicRules = function() {
                function e(t, n) {
                    var a = e.cache[t];
                    if (a) return n(a);
                    E.cssQuery(t, function(a) { e.cache[t] = a, n(a) })
                }
                e.cache = {}, E.each(E.dynamicRules, function(t) {
                    e(t.selector, function(e) {
                        E.each(e, function(e) {
                            var n = "custom" === t.event ? t.customEvent : t.event;
                            E.$data(e, "dynamicRules.seen." + n) || (E.$data(e, "dynamicRules.seen." + n, !0), E.propertiesMatch(t.property, e) && E.registerEvents(e, [n]))
                        })
                    })
                })
            }, E.ensureCSSSelector = function() {
                t.querySelectorAll ? E.hasSelector = !0 : (E.loadingSizzle = !0, E.sizzleQueue = [], E.loadScript(E.basePath() + "selector.js", function() {
                    if (E.Sizzle) {
                        var e = E.onEvent.pendingEvents;
                        E.each(e, function(e) { E.handleEvent(e) }, this), E.onEvent = E.handleEvent, E.hasSelector = !0, delete E.loadingSizzle, E.each(E.sizzleQueue, function(e) { E.cssQuery(e[0], e[1]) }), delete E.sizzleQueue
                    } else E.logError(new Error("Failed to load selector.js"))
                }))
            }, E.errors = [], E.logError = function(e) { E.errors.push(e), E.notify(e.name + " - " + e.message, 5) }, E.pageBottom = function() { E.initialized && (E.pageBottomFired = !0, E.firePageLoadEvent("pagebottom")) }, E.stagingLibraryOverride = function() {
                if ("true" === E.readStoredSetting("stagingLibrary")) {
                    for (var e, n, a, i = t.getElementsByTagName("script"), r = /^(.*)satelliteLib-([a-f0-9]{40})\.js$/, s = /^(.*)satelliteLib-([a-f0-9]{40})-staging\.js$/, o = 0, c = i.length; o < c && (!(a = i[o].getAttribute("src")) || (e || (e = a.match(r)), n || (n = a.match(s)), !n)); o++);
                    if (e && !n) {
                        var l = e[1] + "satelliteLib-" + e[2] + "-staging.js";
                        if (t.write) t.write('<script src="' + l + '"></script>');
                        else {
                            var d = t.createElement("script");
                            d.src = l, t.head.appendChild(d)
                        }
                        return !0
                    }
                }
                return !1
            }, E.checkAsyncInclude = function() { e.satellite_asyncLoad && E.notify('You may be using the async installation of Satellite. In-page HTML and the "pagebottom" event will not work. Please update your Satellite installation for these features.', 5) }, E.hasMultipleDomains = function() { return !!E.settings.domainList && E.settings.domainList.length > 1 }, E.handleOverrides = function() {
                if (_)
                    for (var e in _) _.hasOwnProperty(e) && (E.data[e] = _[e])
            }, E.privacyManagerParams = function() {
                var e = {};
                E.extend(e, E.settings.privacyManagement);
                var t = [];
                for (var n in E.tools)
                    if (E.tools.hasOwnProperty(n)) {
                        var a = E.tools[n],
                            i = a.settings;
                        if (!i) continue;
                        "sc" === i.engine && t.push(a)
                    }
                var r = E.filter(E.map(t, function(e) { return e.getTrackingServer() }), function(e) { return null != e });
                e.adobeAnalyticsTrackingServers = r;
                for (var s = ["bannerText", "headline", "introductoryText", "customCSS"], o = 0; o < s.length; o++) {
                    var c = s[o],
                        l = e[c];
                    if (l)
                        if ("text" === l.type) e[c] = l.value;
                        else {
                            if ("data" !== l.type) throw new Error("Invalid type: " + l.type);
                            e[c] = E.getVar(l.value)
                        }
                }
                return e
            }, E.prepareLoadPrivacyManager = function() {
                function t(e) {
                    function t() {++r === i.length && (n(), clearTimeout(s), e()) }

                    function n() { E.each(i, function(e) { E.unbindEvent(e.id + ".load", t) }) }

                    function a() { n(), e() }
                    var i = E.filter(E.values(E.tools), function(e) { return e.settings && "sc" === e.settings.engine });
                    if (0 === i.length) return e();
                    var r = 0;
                    E.each(i, function(e) { E.bindEvent(e.id + ".load", t) });
                    var s = setTimeout(a, 5e3)
                }
                E.addEventHandler(e, "load", function() { t(E.loadPrivacyManager) })
            }, E.loadPrivacyManager = function() {
                var e = E.basePath() + "privacy_manager.js";
                E.loadScript(e, function() {
                    var e = E.privacyManager;
                    e.configure(E.privacyManagerParams()), e.openIfRequired()
                })
            }, E.init = function(t) {
                if (!E.stagingLibraryOverride()) {
                    E.configurationSettings = t;
                    var a = t.tools;
                    for (var i in delete t.tools, t) t.hasOwnProperty(i) && (E[i] = t[i]);
                    E.data.customVars === n && (E.data.customVars = {}), E.data.queryParams = E.QueryParams.normal, E.handleOverrides(), E.detectBrowserInfo(), E.trackVisitorInfo && E.trackVisitorInfo(), E.loadStoredSettings(), E.Logger.setOutputState(E.settings.notifications), E.checkAsyncInclude(), E.ensureCSSSelector(), E.filterRules(), E.dynamicRules = E.filter(E.rules, function(e) { return e.eventHandlerOnElement }), E.tools = E.initTools(a), E.initEventEmitters(), E.firePageLoadEvent("aftertoolinit"), E.settings.privacyManagement && E.prepareLoadPrivacyManager(), E.hasSelector && E.domReady(E.eventEmitterBackgroundTasks), E.setListeners(), E.domReady(function() { E.poll(function() { E.backgroundTasks() }, E.settings.recheckEvery || 3e3) }), E.domReady(function() { E.domReadyFired = !0, E.pageBottomFired || E.pageBottom(), E.firePageLoadEvent("domready") }), E.addEventHandler(e, "load", function() { E.firePageLoadEvent("windowload") }), E.firePageLoadEvent("pagetop"), E.initialized = !0
                }
            }, E.pageLoadPhases = ["aftertoolinit", "pagetop", "pagebottom", "domready", "windowload"], E.loadEventBefore = function(e, t) { return E.indexOf(E.pageLoadPhases, e) <= E.indexOf(E.pageLoadPhases, t) }, E.flushPendingCalls = function(e) {
                e.pending && (E.each(e.pending, function(t) {
                    var n = t[0],
                        a = t[1],
                        i = t[2],
                        r = t[3];
                    n in e ? e[n].apply(e, [a, i].concat(r)) : e.emit ? e.emit(n, a, i, r) : E.notify("Failed to trigger " + n + " for tool " + e.id, 1)
                }), delete e.pending)
            }, E.setDebug = function(t) { try { e.localStorage.setItem("sdsat_debug", t) } catch (n) { E.notify("Cannot set debug mode: " + n.message, 2) } }, E.getUserAgent = function() { return navigator.userAgent }, E.detectBrowserInfo = function() {
                function e(e) {
                    return function(t) {
                        for (var n in e) {
                            if (e.hasOwnProperty(n))
                                if (e[n].test(t)) return n
                        }
                        return "Unknown"
                    }
                }
                var t = e({ "IE Edge Mobile": /Windows Phone.*Edge/, "IE Edge": /Edge/, OmniWeb: /OmniWeb/, "Opera Mini": /Opera Mini/, "Opera Mobile": /Opera Mobi/, Opera: /Opera/, Chrome: /Chrome|CriOS|CrMo/, Firefox: /Firefox|FxiOS/, "IE Mobile": /IEMobile/, IE: /MSIE|Trident/, "Mobile Safari": /Mobile(\/[0-9A-z]+)? Safari/, Safari: /Safari/ }),
                    n = e({ Blackberry: /BlackBerry|BB10/, "Symbian OS": /Symbian|SymbOS/, Maemo: /Maemo/, Android: /Android/, Linux: / Linux /, Unix: /FreeBSD|OpenBSD|CrOS/, Windows: /[\( ]Windows /, iOS: /iPhone|iPad|iPod/, MacOS: /Macintosh;/ }),
                    a = e({ Nokia: /Symbian|SymbOS|Maemo/, "Windows Phone": /Windows Phone/, Blackberry: /BlackBerry|BB10/, Android: /Android/, iPad: /iPad/, iPod: /iPod/, iPhone: /iPhone/, Desktop: /.*/ }),
                    i = E.getUserAgent();
                E.browserInfo = { browser: t(i), os: n(i), deviceType: a(i) }
            }, E.isHttps = function() { return "https:" == t.location.protocol }, E.BaseTool = function(e) { this.settings = e || {}, this.forceLowerCase = E.settings.forceLowerCase, "forceLowerCase" in this.settings && (this.forceLowerCase = this.settings.forceLowerCase) }, E.BaseTool.prototype = {
                triggerCommand: function(e, t, n) {
                    var a = this.settings || {};
                    if (this.initialize && this.isQueueAvailable() && this.isQueueable(e) && n && E.loadEventBefore(n.type, a.loadOn)) this.queueCommand(e, t, n);
                    else {
                        var i = e.command,
                            r = this["$" + i],
                            s = !!r && r.escapeHtml,
                            o = E.preprocessArguments(e.arguments, t, n, this.forceLowerCase, s);
                        r ? r.apply(this, [t, n].concat(o)) : this.$missing$ ? this.$missing$(i, t, n, o) : E.notify("Failed to trigger " + i + " for tool " + this.id, 1)
                    }
                },
                endPLPhase: function() {},
                isQueueable: function(e) { return "cancelToolInit" !== e.command },
                isQueueAvailable: function() { return !this.initialized && !this.initializing },
                flushQueue: function() { this.pending && (E.each(this.pending, function(e) { this.triggerCommand.apply(this, e) }, this), this.pending = []) },
                queueCommand: function(e, t, n) { this.pending || (this.pending = []), this.pending.push([e, t, n]) },
                $cancelToolInit: function() { this._cancelToolInit = !0 }
            }, e._satellite = E, a.prototype.backgroundTasks = function() {
                E.each(this.rules, function(e) {
                    E.cssQuery(e.selector, function(e) {
                        if (e.length > 0) {
                            var t = e[0];
                            if (E.$data(t, "elementexists.seen")) return;
                            E.$data(t, "elementexists.seen", !0), E.onEvent({ type: "elementexists", target: t })
                        }
                    })
                })
            }, E.availableEventEmitters.push(a), i.prototype = {
                obue: !1,
                initialize: function() { this.attachCloseListeners() },
                obuePrevUnload: function() {},
                obuePrevBeforeUnload: function() {},
                newObueListener: function() { this.obue || (this.obue = !0, this.triggerBeacons()) },
                attachCloseListeners: function() {
                    this.prevUnload = e.onunload,
                        this.prevBeforeUnload = e.onbeforeunload, e.onunload = E.bind(function(t) { this.prevUnload && setTimeout(E.bind(function() { this.prevUnload.call(e, t) }, this), 1), this.newObueListener() }, this), e.onbeforeunload = E.bind(function(t) { this.prevBeforeUnload && setTimeout(E.bind(function() { this.prevBeforeUnload.call(e, t) }, this), 1), this.newObueListener() }, this)
                },
                triggerBeacons: function() { E.fireEvent("leave", t) }
            }, E.availableEventEmitters.push(i), r.orientationChange = function(t) {
                var n = 0 === e.orientation ? "portrait" : "landscape";
                t.orientation = n, E.onEvent(t)
            }, E.availableEventEmitters.push(r), s.prototype = {
                backgroundTasks: function() {
                    var e = this;
                    E.each(this.rules, function(t) {
                        var n = t[1],
                            a = t[0];
                        E.cssQuery(n, function(t) { E.each(t, function(t) { e.trackElement(t, a) }) })
                    }, this)
                },
                trackElement: function(e, t) {
                    var n = this,
                        a = E.$data(e, "hover.delays");
                    a ? E.contains(a, t) || a.push(t) : (E.addEventHandler(e, "mouseover", function(t) { n.onMouseOver(t, e) }), E.addEventHandler(e, "mouseout", function(t) { n.onMouseOut(t, e) }), E.$data(e, "hover.delays", [t]))
                },
                onMouseOver: function(e, t) {
                    var n = e.target || e.srcElement,
                        a = e.relatedTarget || e.fromElement;
                    (t === n || E.containsElement(t, n)) && !E.containsElement(t, a) && this.onMouseEnter(t)
                },
                onMouseEnter: function(e) {
                    var t = E.$data(e, "hover.delays"),
                        n = E.map(t, function(t) { return setTimeout(function() { E.onEvent({ type: "hover(" + t + ")", target: e }) }, t) });
                    E.$data(e, "hover.delayTimers", n)
                },
                onMouseOut: function(e, t) {
                    var n = e.target || e.srcElement,
                        a = e.relatedTarget || e.toElement;
                    (t === n || E.containsElement(t, n)) && !E.containsElement(t, a) && this.onMouseLeave(t)
                },
                onMouseLeave: function(e) {
                    var t = E.$data(e, "hover.delayTimers");
                    t && E.each(t, function(e) { clearTimeout(e) })
                }
            }, E.availableEventEmitters.push(s), o.prototype = {
                defineEvents: function() { this.oldBlurClosure = function() { E.fireEvent("tabblur", t) }, this.oldFocusClosure = E.bind(function() { this.visibilityApiHasPriority ? E.fireEvent("tabfocus", t) : null != E.visibility.getHiddenProperty() && E.visibility.isHidden() || E.fireEvent("tabfocus", t) }, this) },
                attachDetachModernEventListeners: function(e) { E[0 == e ? "removeEventHandler" : "addEventHandler"](t, E.visibility.getVisibilityEvent(), this.handleVisibilityChange) },
                attachDetachOlderEventListeners: function(t, n, a) {
                    var i = 0 == t ? "removeEventHandler" : "addEventHandler";
                    E[i](n, a, this.oldBlurClosure), E[i](e, "focus", this.oldFocusClosure)
                },
                handleVisibilityChange: function() { E.visibility.isHidden() ? E.fireEvent("tabblur", t) : E.fireEvent("tabfocus", t) },
                setVisibilityApiPriority: function(t) { this.visibilityApiHasPriority = t, this.attachDetachOlderEventListeners(!1, e, "blur"), this.attachDetachModernEventListeners(!1), t ? null != E.visibility.getHiddenProperty() ? this.attachDetachModernEventListeners(!0) : this.attachDetachOlderEventListeners(!0, e, "blur") : (this.attachDetachOlderEventListeners(!0, e, "blur"), null != E.visibility.getHiddenProperty() && this.attachDetachModernEventListeners(!0)) },
                oldBlurClosure: null,
                oldFocusClosure: null,
                visibilityApiHasPriority: !0
            }, E.availableEventEmitters.push(o), c.prototype = {
                initialize: function() { this.setupHistoryAPI(), this.setupHashChange() },
                fireIfURIChanged: function() {
                    var e = E.URL();
                    this.lastURL !== e && (this.fireEvent(), this.lastURL = e)
                },
                fireEvent: function() { E.updateQueryParams(), E.onEvent({ type: "locationchange", target: t }) },
                setupSPASupport: function() { this.setupHistoryAPI(), this.setupHashChange() },
                setupHistoryAPI: function() {
                    var t = e.history;
                    t && (t.pushState && (this.originalPushState = t.pushState, t.pushState = this._pushState), t.replaceState && (this.originalReplaceState = t.replaceState, t.replaceState = this._replaceState)), E.addEventHandler(e, "popstate", this._onPopState)
                },
                pushState: function() { var e = this.originalPushState.apply(history, arguments); return this.onPushState(), e },
                replaceState: function() { var e = this.originalReplaceState.apply(history, arguments); return this.onReplaceState(), e },
                setupHashChange: function() { E.addEventHandler(e, "hashchange", this._onHashChange) },
                onReplaceState: function() { setTimeout(this._fireIfURIChanged, 0) },
                onPushState: function() { setTimeout(this._fireIfURIChanged, 0) },
                onPopState: function() { setTimeout(this._fireIfURIChanged, 0) },
                onHashChange: function() { setTimeout(this._fireIfURIChanged, 0) },
                uninitialize: function() { this.cleanUpHistoryAPI(), this.cleanUpHashChange() },
                cleanUpHistoryAPI: function() { history.pushState === this._pushState && (history.pushState = this.originalPushState), history.replaceState === this._replaceState && (history.replaceState = this.originalReplaceState), E.removeEventHandler(e, "popstate", this._onPopState) },
                cleanUpHashChange: function() { E.removeEventHandler(e, "hashchange", this._onHashChange) }
            }, E.availableEventEmitters.push(c), l.prototype = {
                backgroundTasks: function() {
                    var e = this.eventHandler;
                    E.each(this.rules, function(t) { E.cssQuery(t.selector || "video", function(t) { E.each(t, function(t) { E.$data(t, "videoplayed.tracked") || (E.addEventHandler(t, "timeupdate", E.throttle(e, 100)), E.$data(t, "videoplayed.tracked", !0)) }) }) })
                },
                evalRule: function(e, t) {
                    var n = t.event,
                        a = e.seekable,
                        i = a.start(0),
                        r = a.end(0),
                        s = e.currentTime,
                        o = t.event.match(/^videoplayed\(([0-9]+)([s%])\)$/);
                    if (o) {
                        var c = o[2],
                            l = Number(o[1]),
                            d = "%" === c ? function() { return l <= 100 * (s - i) / (r - i) } : function() { return l <= s - i };
                        !E.$data(e, n) && d() && (E.$data(e, n, !0), E.onEvent({ type: n, target: e }))
                    }
                },
                onUpdateTime: function(e) {
                    var t = this.rules,
                        n = e.target;
                    if (n.seekable && 0 !== n.seekable.length)
                        for (var a = 0, i = t.length; a < i; a++) this.evalRule(n, t[a])
                }
            }, E.availableEventEmitters.push(l), d.prototype = { initialize: function() { if (this.FB = this.FB || e.FB, this.FB && this.FB.Event && this.FB.Event.subscribe) return this.bind(), !0 }, bind: function() { this.FB.Event.subscribe("edge.create", function() { E.notify("tracking a facebook like", 1), E.onEvent({ type: "facebook.like", target: t }) }), this.FB.Event.subscribe("edge.remove", function() { E.notify("tracking a facebook unlike", 1), E.onEvent({ type: "facebook.unlike", target: t }) }), this.FB.Event.subscribe("message.send", function() { E.notify("tracking a facebook share", 1), E.onEvent({ type: "facebook.send", target: t }) }) } }, E.availableEventEmitters.push(d), u.prototype = {
                initialize: function() {
                    var e = this.twttr;
                    e && "function" == typeof e.ready && e.ready(E.bind(this.bind, this))
                },
                bind: function() { this.twttr.events.bind("tweet", function(e) { e && (E.notify("tracking a tweet button", 1), E.onEvent({ type: "twitter.tweet", target: t })) }) }
            }, E.availableEventEmitters.push(u), g.offset = function(n) {
                var a = null,
                    i = null;
                try {
                    var r = n.getBoundingClientRect(),
                        s = t,
                        o = s.documentElement,
                        c = s.body,
                        l = e,
                        d = o.clientTop || c.clientTop || 0,
                        u = o.clientLeft || c.clientLeft || 0,
                        g = l.pageYOffset || o.scrollTop || c.scrollTop,
                        m = l.pageXOffset || o.scrollLeft || c.scrollLeft;
                    a = r.top + g - d, i = r.left + m - u
                } catch (p) {}
                return { top: a, left: i }
            }, g.getViewportHeight = function() {
                var n = e.innerHeight,
                    a = t.compatMode;
                return a && (n = "CSS1Compat" == a ? t.documentElement.clientHeight : t.body.clientHeight), n
            }, g.getScrollTop = function() { return t.documentElement.scrollTop ? t.documentElement.scrollTop : t.body.scrollTop }, g.isElementInDocument = function(e) { return t.body.contains(e) }, g.isElementInView = function(e) {
                if (!g.isElementInDocument(e)) return !1;
                var t = g.getViewportHeight(),
                    n = g.getScrollTop(),
                    a = g.offset(e).top,
                    i = e.offsetHeight;
                return null !== a && !(n > a + i || n + t < a)
            }, g.prototype = {
                backgroundTasks: function() {
                    var e = this.elements;
                    E.each(this.rules, function(t) {
                        E.cssQuery(t.selector, function(n) {
                            var a = 0;
                            E.each(n, function(t) { E.contains(e, t) || (e.push(t), a++) }), a && E.notify(t.selector + " added " + a + " elements.", 1)
                        })
                    }), this.track()
                },
                checkInView: function(e, t, n) {
                    var a = E.$data(e, "inview");
                    if (g.isElementInView(e)) {
                        a || E.$data(e, "inview", !0);
                        var i = this;
                        this.processRules(e, function(n, a, r) {
                            if (t || !n.inviewDelay) E.$data(e, a, !0), E.onEvent({ type: "inview", target: e, inviewDelay: n.inviewDelay });
                            else if (n.inviewDelay) {
                                var s = E.$data(e, r);
                                s || (s = setTimeout(function() { i.checkInView(e, !0, n.inviewDelay) }, n.inviewDelay), E.$data(e, r, s))
                            }
                        }, n)
                    } else {
                        if (!g.isElementInDocument(e)) {
                            var r = E.indexOf(this.elements, e);
                            this.elements.splice(r, 1)
                        }
                        a && E.$data(e, "inview", !1), this.processRules(e, function(t, n, a) {
                            var i = E.$data(e, a);
                            i && clearTimeout(i)
                        }, n)
                    }
                },
                track: function() { for (var e = this.elements.length - 1; e >= 0; e--) this.checkInView(this.elements[e]) },
                processRules: function(e, t, n) {
                    var a = this.rules;
                    n && (a = E.filter(this.rules, function(e) { return e.inviewDelay == n })), E.each(a, function(n, a) {
                        var i = n.inviewDelay ? "viewed_" + n.inviewDelay : "viewed",
                            r = "inview_timeout_id_" + a;
                        E.$data(e, i) || E.matchesCss(n.selector, e) && t(n, i, r)
                    })
                }
            }, E.availableEventEmitters.push(g), m.prototype.getStringifiedValue = e.JSON && e.JSON.stringify || E.stringify, m.prototype.initPolling = function() { 0 !== this.dataElementsNames.length && (this.dataElementsStore = this.getDataElementsValues(), E.poll(E.bind(this.checkDataElementValues, this), 1e3)) }, m.prototype.getDataElementsValues = function() {
                var e = {};
                return E.each(this.dataElementsNames, function(t) {
                    var n = E.getVar(t);
                    e[t] = this.getStringifiedValue(n)
                }, this), e
            }, m.prototype.checkDataElementValues = function() {
                E.each(this.dataElementsNames, E.bind(function(e) {
                    var n = this.getStringifiedValue(E.getVar(e));
                    n !== this.dataElementsStore[e] && (this.dataElementsStore[e] = n, E.onEvent({ type: "dataelementchange(" + e + ")", target: t }))
                }, this))
            }, E.availableEventEmitters.push(m),
            function() {
                function e(e) { return "_sdsat_" + e }
                E.trackVisitorInfo = function() {
                    var e = E.trackLandingPage();
                    E.trackSessionCount(e), E.trackLifetimePagesViewed(), E.trackSessionPagesViewed(), E.trackTrafficSource()
                }, E.trackLandingPage = function() {
                    var t = e("landing_page"),
                        n = E.readCookie(t);
                    return (!n || n.split("|").length < 2) && E.setCookie(t, location.href + "|" + (new Date).getTime()), !n
                }, E.visitorLandingPage = function() { var t = E.readCookie(e("landing_page")); return t ? t.split("|")[0] : null }, E.visitorLandingTime = function() { var t = E.readCookie(e("landing_page")); return t ? Number(t.split("|")[1]) : null }, E.minutesOnSite = function() { var e = (new Date).getTime(); return Math.floor((e - E.visitorLandingTime()) / 1e3 / 60) }, E.trackSessionCount = function(t) {
                    if (t) {
                        var n = E.visitorSessionCount();
                        E.setCookie(e("session_count"), n + 1, 730)
                    }
                }, E.visitorSessionCount = function() { return Number(E.readCookie(e("session_count")) || "0") }, E.isNewVisitor = function() { return 1 === E.visitorSessionCount() }, E.trackSessionPagesViewed = function() { E.setCookie(e("pages_viewed"), E.visitorSessionPagesViewed() + 1) }, E.trackLifetimePagesViewed = function() { E.setCookie(e("lt_pages_viewed"), E.visitorLifetimePagesViewed() + 1, 730) }, E.visitorLifetimePagesViewed = function() { return Number(E.readCookie(e("lt_pages_viewed")) || 0) }, E.visitorSessionPagesViewed = function() { return Number(E.readCookie(e("pages_viewed")) || "0") }, E.trackTrafficSource = function() {
                    var n = e("traffic_source");
                    E.readCookie(n) || E.setCookie(n, t.referrer)
                }, E.trafficSource = function() { return E.readCookie(e("traffic_source")) }
            }(), E.visibility = {
                isHidden: function() { var e = this.getHiddenProperty(); return !!e && t[e] },
                isVisible: function() { return !this.isHidden() },
                getHiddenProperty: function() {
                    var e = ["webkit", "moz", "ms", "o"];
                    if ("hidden" in t) return "hidden";
                    for (var n = 0; n < e.length; n++)
                        if (e[n] + "Hidden" in t) return e[n] + "Hidden";
                    return null
                },
                getVisibilityEvent: function() { var e = this.getHiddenProperty(); return e ? e.replace(/[H|h]idden/, "") + "visibilitychange" : null }
            }, E.ecommerce = {
                addItem: function() {
                    var e = [].slice.call(arguments);
                    E.onEvent({ type: "ecommerce.additem", target: e })
                },
                addTrans: function() {
                    var e = [].slice.call(arguments);
                    E.data.saleData.sale = { orderId: e[0], revenue: e[2] }, E.onEvent({ type: "ecommerce.addtrans", target: e })
                },
                trackTrans: function() { E.onEvent({ type: "ecommerce.tracktrans", target: [] }) }
            }, E.extend(p.prototype, {
                getInstance: function() { return this.instance },
                initialize: function() {
                    var e, t = this.settings;
                    E.notify("Visitor ID: Initializing tool", 1), null !== (e = this.createInstance(t.mcOrgId, t.initVars)) && (t.customerIDs && this.applyCustomerIDs(e, t.customerIDs), t.autoRequest && e.getMarketingCloudVisitorID(), this.instance = e)
                },
                createInstance: function(e, t) {
                    if (!E.isString(e)) return E.notify('Visitor ID: Cannot create instance using mcOrgId: "' + e + '"', 4), null;
                    e = E.replace(e), E.notify('Visitor ID: Create instance using mcOrgId: "' + e + '"', 1), t = this.parseValues(t);
                    var n = Visitor.getInstance(e, t);
                    return E.notify("Visitor ID: Set variables: " + E.stringify(t), 1), n
                },
                applyCustomerIDs: function(e, t) {
                    var n = this.parseIds(t);
                    e.setCustomerIDs(n), E.notify("Visitor ID: Set Customer IDs: " + E.stringify(n), 1)
                },
                parseValues: function(e) { if (!1 === E.isObject(e)) return {}; var t = {}; for (var n in e) e.hasOwnProperty(n) && (t[n] = E.replace(e[n])); return t },
                parseIds: function(e) {
                    var t = {};
                    if (!1 === E.isObject(e)) return {};
                    for (var n in e)
                        if (e.hasOwnProperty(n)) {
                            var a = E.replace(e[n].id);
                            a !== e[n].id && a && (t[n] = {}, t[n].id = a, t[n].authState = Visitor.AuthState[e[n].authState])
                        }
                    return t
                }
            }), E.availableTools.visitor_id = p, E.inherit(f, E.BaseTool), E.extend(f.prototype, {
                initialize: function() {
                    var e = this.settings;
                    if (!1 !== this.settings.initTool) {
                        var t = e.url;
                        t = "string" == typeof t ? E.basePath() + t : E.isHttps() ? t.https : t.http, E.loadScript(t, E.bind(this.onLoad, this)), this.initializing = !0
                    } else this.initialized = !0
                },
                isQueueAvailable: function() { return !this.initialized },
                onLoad: function() { this.initialized = !0, this.initializing = !1, this.settings.initialBeacon && this.settings.initialBeacon(), this.flushQueue() },
                endPLPhase: function(e) { e === this.settings.loadOn && (E.notify(this.name + ": Initializing at " + e, 1), this.initialize()) },
                $fire: function(e, t, n) { this.initializing ? this.queueCommand({ command: "fire", arguments: [n] }, e, t) : n.call(this.settings, e, t) }
            }), E.availableTools.am = f, E.availableTools.adlens = f, E.availableTools.aem = f, E.availableTools.__basic = f, E.inherit(h, E.BaseTool), E.extend(h.prototype, {
                name: "tnt",
                endPLPhase: function(e) { "aftertoolinit" === e && this.initialize() },
                initialize: function() { E.notify("Test & Target: Initializing", 1), this.initializeTargetPageParams(), this.load() },
                initializeTargetPageParams: function() { e.targetPageParams && this.updateTargetPageParams(this.parseTargetPageParamsResult(e.targetPageParams())), this.updateTargetPageParams(this.settings.pageParams), this.setTargetPageParamsFunction() },
                load: function() { var e = this.getMboxURL(this.settings.mboxURL);!1 !== this.settings.initTool ? this.settings.loadSync ? (E.loadScriptSync(e), this.onScriptLoaded()) : (E.loadScript(e, E.bind(this.onScriptLoaded, this)), this.initializing = !0) : this.initialized = !0 },
                getMboxURL: function(t) { var n = t; return E.isObject(t) && (n = "https:" === e.location.protocol ? t.https : t.http), n.match(/^https?:/) ? n : E.basePath() + n },
                onScriptLoaded: function() { E.notify("Test & Target: loaded.", 1), this.flushQueue(), this.initialized = !0, this.initializing = !1 },
                $addMbox: function(e, t, n) {
                    var a = n.mboxGoesAround,
                        i = a + "{visibility: hidden;}",
                        r = this.appendStyle(i);
                    a in this.styleElements || (this.styleElements[a] = r), this.initialized ? this.$addMBoxStep2(null, null, n) : this.initializing && this.queueCommand({ command: "addMBoxStep2", arguments: [n] }, e, t)
                },
                $addMBoxStep2: function(n, a, i) {
                    var r = this.generateID(),
                        s = this;
                    E.addEventHandler(e, "load", E.bind(function() {
                        E.cssQuery(i.mboxGoesAround, function(n) {
                            var a = n[0];
                            if (a) {
                                var o = t.createElement("div");
                                o.id = r, a.parentNode.replaceChild(o, a), o.appendChild(a), e.mboxDefine(r, i.mboxName);
                                var c = [i.mboxName];
                                i.arguments && (c = c.concat(i.arguments)), e.mboxUpdate.apply(null, c), s.reappearWhenCallComesBack(a, r, i.timeout, i)
                            }
                        })
                    }, this)), this.lastMboxID = r
                },
                $addTargetPageParams: function(e, t, n) { this.updateTargetPageParams(n) },
                generateID: function() { return "_sdsat_mbox_" + String(Math.random()).substring(2) + "_" },
                appendStyle: function(e) {
                    var n = t.getElementsByTagName("head")[0],
                        a = t.createElement("style");
                    return a.type = "text/css", a.styleSheet ? a.styleSheet.cssText = e : a.appendChild(t.createTextNode(e)), n.appendChild(a), a
                },
                reappearWhenCallComesBack: function(e, t, n, a) {
                    function i() {
                        var e = r.styleElements[a.mboxGoesAround];
                        e && (e.parentNode.removeChild(e), delete r.styleElements[a.mboxGoesAround])
                    }
                    var r = this;
                    E.cssQuery('script[src*="omtrdc.net"]', function(e) { var t = e[0]; if (t) { E.scriptOnLoad(t.src, t, function() { E.notify("Test & Target: request complete", 1), i(), clearTimeout(a) }); var a = setTimeout(function() { E.notify("Test & Target: bailing after " + n + "ms", 1), i() }, n) } else E.notify("Test & Target: failed to find T&T ajax call, bailing", 1), i() })
                },
                updateTargetPageParams: function(e) {
                    var t = {};
                    for (var n in e) e.hasOwnProperty(n) && (t[E.replace(n)] = E.replace(e[n]));
                    E.extend(this.targetPageParamsStore, t)
                },
                getTargetPageParams: function() { return this.targetPageParamsStore },
                setTargetPageParamsFunction: function() { e.targetPageParams = E.bind(this.getTargetPageParams, this) },
                parseTargetPageParamsResult: function(e) { var t = e; return E.isArray(e) && (e = e.join("&")), E.isString(e) && (t = E.parseQueryParams(e)), t }
            }), E.availableTools.tnt = h;
        var D = {
            allowLinker: function() { return E.hasMultipleDomains() },
            cookieDomain: function() {
                var t = E.settings.domainList,
                    n = E.find(t, function(t) { var n = e.location.hostname; return E.equalsIgnoreCase(n.slice(n.length - t.length), t) });
                return n ? "." + n : "auto"
            }
        };
        E.inherit(v, E.BaseTool), E.extend(v.prototype, {
            name: "GAUniversal",
            endPLPhase: function(e) { e === this.settings.loadOn && (E.notify("GAU: Initializing at " + e, 1), this.initialize(), this.flushQueue(), this.trackInitialPageView()) },
            getTrackerName: function() { return this.settings.trackerSettings.name || "" },
            isPageCodeLoadSuppressed: function() { return !1 === this.settings.initTool || !0 === this._cancelToolInit },
            initialize: function() {
                if (this.isPageCodeLoadSuppressed()) return this.initialized = !0, void E.notify("GAU: Page code not loaded (suppressed).", 1);
                var t = "ga";
                e[t] = e[t] || this.createGAObject(), e.GoogleAnalyticsObject = t, E.notify("GAU: Page code loaded.", 1), E.loadScriptOnce(this.getToolUrl());
                var n = this.settings;
                (D.allowLinker() && !1 !== n.allowLinker ? this.createAccountForLinker() : this.createAccount(), this.executeInitCommands(), n.customInit) && (!1 === (0, n.customInit)(e[t], this.getTrackerName()) && (this.suppressInitialPageView = !0));
                this.initialized = !0
            },
            createGAObject: function() { var e = function() { e.q.push(arguments) }; return e.q = [], e.l = 1 * new Date, e },
            createAccount: function() { this.create() },
            createAccountForLinker: function() {
                var e = {};
                D.allowLinker() && (e.allowLinker = !0), this.create(e), this.call("require", "linker"), this.call("linker:autoLink", this.autoLinkDomains(), !1, !0)
            },
            create: function(e) {
                var t = this.settings.trackerSettings;
                (t = E.preprocessArguments([t], location, null, this.forceLowerCase)[0]).trackingId = E.replace(this.settings.trackerSettings.trackingId, location), t.cookieDomain || (t.cookieDomain = D.cookieDomain()), E.extend(t, e || {}), this.call("create", t)
            },
            autoLinkDomains: function() { var e = location.hostname; return E.filter(E.settings.domainList, function(t) { return t !== e }) },
            executeInitCommands: function() {
                var e = this.settings;
                e.initCommands && E.each(e.initCommands, function(e) {
                    var t = e.splice(2, e.length - 2);
                    e = e.concat(E.preprocessArguments(t, location, null, this.forceLowerCase)), this.call.apply(this, e)
                }, this)
            },
            trackInitialPageView: function() { this.suppressInitialPageView || this.isPageCodeLoadSuppressed() || this.call("send", "pageview") },
            call: function() { "function" == typeof ga ? this.isCallSuppressed() || (arguments[0] = this.cmd(arguments[0]), this.log(E.toArray(arguments)), ga.apply(e, arguments)) : E.notify("GA Universal function not found!", 4) },
            isCallSuppressed: function() { return !0 === this._cancelToolInit },
            $missing$: function(e, t, n, a) { a = a || [], a = [e].concat(a), this.call.apply(this, a) },
            getToolUrl: function() {
                var e = this.settings,
                    t = E.isHttps();
                return e.url ? t ? e.url.https : e.url.http : (t ? "https://ssl" : "http://www") + ".google-analytics.com/analytics.js"
            },
            cmd: function(e) {
                var t = ["send", "set", "get"],
                    n = this.getTrackerName();
                return n && -1 !== E.indexOf(t, e) ? n + "." + e : e
            },
            log: function(e) {
                var t = "GA Universal: sent command " + e[0] + " to tracker " + (this.getTrackerName() || "default");
                if (e.length > 1) {
                    E.stringify(e.slice(1));
                    t += " with parameters " + E.stringify(e.slice(1))
                }
                t += ".", E.notify(t, 1)
            }
        }), E.availableTools.ga_universal = v, E.inherit(b, E.BaseTool), E.extend(b.prototype, {
            name: "GA",
            initialize: function() {
                var t = this.settings,
                    n = e._gaq,
                    a = t.initCommands || [],
                    i = t.customInit;
                if (n || (_gaq = []), this.isSuppressed()) E.notify("GA: page code not loaded(suppressed).", 1);
                else {
                    if (!n && !b.scriptLoaded) {
                        var r = E.isHttps(),
                            s = (r ? "https://ssl" : "http://www") + ".google-analytics.com/ga.js";
                        t.url && (s = r ? t.url.https : t.url.http), E.loadScript(s), b.scriptLoaded = !0, E.notify("GA: page code loaded.", 1)
                    }
                    t.domain;
                    var o = t.trackerName,
                        c = D.allowLinker(),
                        l = E.replace(t.account, location);
                    E.settings.domainList;
                    _gaq.push([this.cmd("setAccount"), l]), c && _gaq.push([this.cmd("setAllowLinker"), c]), _gaq.push([this.cmd("setDomainName"), D.cookieDomain()]), E.each(a, function(e) {
                        var t = [this.cmd(e[0])].concat(E.preprocessArguments(e.slice(1), location, null, this.forceLowerCase));
                        _gaq.push(t)
                    }, this), i && (this.suppressInitialPageView = !1 === i(_gaq, o)), t.pageName && this.$overrideInitialPageView(null, null, t.pageName)
                }
                this.initialized = !0, E.fireEvent(this.id + ".configure", _gaq, o)
            },
            isSuppressed: function() { return this._cancelToolInit || !1 === this.settings.initTool },
            tracker: function() { return this.settings.trackerName },
            cmd: function(e) { var t = this.tracker(); return t ? t + "._" + e : "_" + e },
            $overrideInitialPageView: function(e, t, n) { this.urlOverride = n },
            trackInitialPageView: function() {
                if (!this.isSuppressed() && !this.suppressInitialPageView)
                    if (this.urlOverride) {
                        var e = E.preprocessArguments([this.urlOverride], location, null, this.forceLowerCase);
                        this.$missing$("trackPageview", null, null, e)
                    } else this.$missing$("trackPageview")
            },
            endPLPhase: function(e) { e === this.settings.loadOn && (E.notify("GA: Initializing at " + e, 1), this.initialize(), this.flushQueue(), this.trackInitialPageView()) },
            call: function(e, t, n, a) {
                if (!this._cancelToolInit) {
                    this.settings;
                    var i = this.tracker(),
                        r = this.cmd(e);
                    a = a ? [r].concat(a) : [r];
                    _gaq.push(a), i ? E.notify("GA: sent command " + e + " to tracker " + i + (a.length > 1 ? " with parameters [" + a.slice(1).join(", ") + "]" : "") + ".", 1) : E.notify("GA: sent command " + e + (a.length > 1 ? " with parameters [" + a.slice(1).join(", ") + "]" : "") + ".", 1)
                }
            },
            $missing$: function(e, t, n, a) { this.call(e, t, n, a) },
            $postTransaction: function(t, n, a) {
                var i = E.data.customVars.transaction = e[a];
                this.call("addTrans", t, n, [i.orderID, i.affiliation, i.total, i.tax, i.shipping, i.city, i.state, i.country]), E.each(i.items, function(e) { this.call("addItem", t, n, [e.orderID, e.sku, e.product, e.category, e.unitPrice, e.quantity]) }, this), this.call("trackTrans", t, n)
            },
            delayLink: function(e, t) {
                var n = this;
                if (D.allowLinker() && e.hostname.match(this.settings.linkerDomains) && !E.isSubdomainOf(e.hostname, location.hostname)) {
                    E.preventDefault(t);
                    var a = E.settings.linkDelay || 100;
                    setTimeout(function() { n.call("link", e, t, [e.href]) }, a)
                }
            },
            popupLink: function(t, n) {
                if (e._gat) {
                    E.preventDefault(n);
                    var a = this.settings.account,
                        i = e._gat._createTracker(a)._getLinkerUrl(t.href);
                    e.open(i)
                }
            },
            $link: function(e, t) { "_blank" === e.getAttribute("target") ? this.popupLink(e, t) : this.delayLink(e, t) },
            $trackEvent: function(e, t) {
                var n = Array.prototype.slice.call(arguments, 2);
                if (n.length >= 4 && null != n[3]) {
                    var a = parseInt(n[3], 10);
                    E.isNaN(a) && (a = 1), n[3] = a
                }
                this.call("trackEvent", e, t, n)
            }
        }), E.availableTools.ga = b, E.inherit(y, E.BaseTool), E.extend(y.prototype, {
            name: "SC",
            endPLPhase: function(e) { e === this.settings.loadOn && this.initialize(e) },
            initialize: function(t) {
                if (!this._cancelToolInit)
                    if (this.settings.initVars = this.substituteVariables(this.settings.initVars, { type: t }), !1 !== this.settings.initTool) { var n = this.settings.sCodeURL || E.basePath() + "s_code.js"; "object" == typeof n && (n = "https:" === e.location.protocol ? n.https : n.http), n.match(/^https?:/) || (n = E.basePath() + n), this.settings.initVars && this.$setVars(null, null, this.settings.initVars), E.loadScript(n, E.bind(this.onSCodeLoaded, this)), this.initializing = !0 } else this.initializing = !0, this.pollForSC()
            },
            getS: function(t, n) {
                var a = n && n.hostname || e.location.hostname,
                    i = this.concatWithToolVarBindings(n && n.setVars || this.varBindings),
                    r = n && n.addEvent || this.events,
                    s = this.getAccount(a),
                    o = e.s_gi;
                if (!o) return null;
                if (this.isValidSCInstance(t) || (t = null), !s && !t) return E.notify("Adobe Analytics: tracker not initialized because account was not found", 1), null;
                t = t || o(s);
                var c = "D" + E.appVersion;
                return "undefined" != typeof t.tagContainerMarker ? t.tagContainerMarker = c : "string" == typeof t.version && t.version.substring(t.version.length - 5) !== "-" + c && (t.version += "-" + c), t.sa && !0 !== this.settings.skipSetAccount && !1 !== this.settings.initTool && t.sa(this.settings.account), this.applyVarBindingsOnTracker(t, i), r.length > 0 && (t.events = r.join(",")), E.getVisitorId() && (t.visitor = E.getVisitorId()), t
            },
            onSCodeLoaded: function(e) {
                this.initialized = !0, this.initializing = !1;
                var t = ["Adobe Analytics: loaded", e ? " (manual)" : "", "."];
                E.notify(t.join(""), 1), E.fireEvent(this.id + ".load", this.getS()), e || (this.flushQueueExceptTrackLink(), this.sendBeacon()), this.flushQueue()
            },
            getAccount: function(t) { return e.s_account ? e.s_account : t && this.settings.accountByHost && this.settings.accountByHost[t] || this.settings.account },
            getTrackingServer: function() {
                var t = this,
                    n = t.getS();
                if (n) { if (n.ssl && n.trackingServerSecure) return n.trackingServerSecure; if (n.trackingServer) return n.trackingServer }
                var a, i = t.getAccount(e.location.hostname);
                if (!i) return null;
                var r, s, o = "",
                    c = n && n.dc;
                return (r = (a = i).indexOf(",")) >= 0 && (a = a.gb(0, r)), a = a.replace(/[^A-Za-z0-9]/g, ""), o || (o = "2o7.net"), c = c ? ("" + c).toLowerCase() : "d1", "2o7.net" == o && ("d1" == c ? c = "112" : "d2" == c && (c = "122"), s = ""), r = a + "." + c + "." + s + o
            },
            sendBeacon: function() {
                var t = this.getS(e[this.settings.renameS || "s"]);
                t ? this.settings.customInit && !1 === this.settings.customInit(t) ? E.notify("Adobe Analytics: custom init suppressed beacon", 1) : (this.settings.executeCustomPageCodeFirst && this.applyVarBindingsOnTracker(t, this.varBindings), this.executeCustomSetupFuns(t), t.t(), this.clearVarBindings(), this.clearCustomSetup(), E.notify("Adobe Analytics: tracked page view", 1)) : E.notify("Adobe Analytics: page code not loaded", 1)
            },
            pollForSC: function() { E.poll(E.bind(function() { if ("function" == typeof e.s_gi) return this.onSCodeLoaded(!0), !0 }, this)) },
            flushQueueExceptTrackLink: function() {
                if (this.pending) {
                    for (var e = [], t = 0; t < this.pending.length; t++) { var n = this.pending[t]; "trackLink" === n[0].command ? e.push(n) : this.triggerCommand.apply(this, n) }
                    this.pending = e
                }
            },
            isQueueAvailable: function() { return !this.initialized },
            substituteVariables: function(e, t) {
                var n = {};
                for (var a in e)
                    if (e.hasOwnProperty(a)) {
                        var i = e[a];
                        n[a] = E.replace(i, location, t)
                    }
                return n
            },
            $setVars: function(e, t, n) {
                for (var a in n)
                    if (n.hasOwnProperty(a)) { var i = n[a]; "function" == typeof i && (i = i()), this.varBindings[a] = i }
                E.notify("Adobe Analytics: set variables.", 2)
            },
            $customSetup: function(e, t, n) { this.customSetupFuns.push(function(a) { n.call(e, t, a) }) },
            isValidSCInstance: function(e) { return !!e && "function" == typeof e.t && "function" == typeof e.tl },
            concatWithToolVarBindings: function(e) { var t = this.settings.initVars || {}; return E.map(["trackingServer", "trackingServerSecure"], function(n) { t[n] && !e[n] && (e[n] = t[n]) }), e },
            applyVarBindingsOnTracker: function(e, t) { for (var n in t) t.hasOwnProperty(n) && (e[n] = t[n]) },
            clearVarBindings: function() { this.varBindings = {} },
            clearCustomSetup: function() { this.customSetupFuns = [] },
            executeCustomSetupFuns: function(t) { E.each(this.customSetupFuns, function(n) { n.call(e, t) }) },
            $trackLink: function(e, t, n) {
                var a = (n = n || {}).type,
                    i = n.linkName;
                !i && e && e.nodeName && "a" === e.nodeName.toLowerCase() && (i = e.innerHTML), i || (i = "link clicked");
                var r = n && n.setVars,
                    s = n && n.addEvent || [],
                    o = this.getS(null, { setVars: r, addEvent: s });
                if (o) {
                    var c = o.linkTrackVars,
                        l = o.linkTrackEvents,
                        d = this.definedVarNames(r);
                    n && n.customSetup && n.customSetup.call(e, t, o), s.length > 0 && d.push("events"), o.products && d.push("products"), d = this.mergeTrackLinkVars(o.linkTrackVars, d), s = this.mergeTrackLinkVars(o.linkTrackEvents, s), o.linkTrackVars = this.getCustomLinkVarsList(d);
                    var u = E.map(s, function(e) { return e.split(":")[0] });
                    o.linkTrackEvents = this.getCustomLinkVarsList(u), o.tl(!0, a || "o", i), E.notify(["Adobe Analytics: tracked link ", "using: linkTrackVars=", E.stringify(o.linkTrackVars), "; linkTrackEvents=", E.stringify(o.linkTrackEvents)].join(""), 1), o.linkTrackVars = c, o.linkTrackEvents = l
                } else E.notify("Adobe Analytics: page code not loaded", 1)
            },
            mergeTrackLinkVars: function(e, t) { return e && (t = e.split(",").concat(t)), t },
            getCustomLinkVarsList: function(e) { var t = E.indexOf(e, "None"); return t > -1 && e.length > 1 && e.splice(t, 1), e.join(",") },
            definedVarNames: function(e) { e = e || this.varBindings; var t = []; for (var n in e) e.hasOwnProperty(n) && /^(eVar[0-9]+)|(prop[0-9]+)|(hier[0-9]+)|campaign|purchaseID|channel|server|state|zip|pageType$/.test(n) && t.push(n); return t },
            $trackPageView: function(e, t, n) {
                var a = n && n.setVars,
                    i = n && n.addEvent || [],
                    r = this.getS(null, { setVars: a, addEvent: i });
                r ? (r.linkTrackVars = "", r.linkTrackEvents = "", this.executeCustomSetupFuns(r), n && n.customSetup && n.customSetup.call(e, t, r), r.t(), this.clearVarBindings(), this.clearCustomSetup(), E.notify("Adobe Analytics: tracked page view", 1)) : E.notify("Adobe Analytics: page code not loaded", 1)
            },
            $postTransaction: function(t, n, a) {
                var i = E.data.transaction = e[a],
                    r = this.varBindings,
                    s = this.settings.fieldVarMapping;
                if (E.each(i.items, function(e) { this.products.push(e) }, this), r.products = E.map(this.products, function(e) {
                        var t = [];
                        if (s && s.item)
                            for (var n in s.item)
                                if (s.item.hasOwnProperty(n)) {
                                    var a = s.item[n];
                                    t.push(a + "=" + e[n]), "event" === a.substring(0, 5) && this.events.push(a)
                                }
                        var i = ["", e.product, e.quantity, e.unitPrice * e.quantity];
                        return t.length > 0 && i.push(t.join("|")), i.join(";")
                    }, this).join(","), s && s.transaction) {
                    var o = [];
                    for (var c in s.transaction)
                        if (s.transaction.hasOwnProperty(c)) {
                            a = s.transaction[c];
                            o.push(a + "=" + i[c]), "event" === a.substring(0, 5) && this.events.push(a)
                        }
                    r.products.length > 0 && (r.products += ","), r.products += ";;;;" + o.join("|")
                }
            },
            $addEvent: function() { for (var e = 2, t = arguments.length; e < t; e++) this.events.push(arguments[e]) },
            $addProduct: function() { for (var e = 2, t = arguments.length; e < t; e++) this.products.push(arguments[e]) }
        }), E.availableTools.sc = y, E.inherit(S, E.BaseTool), E.extend(S.prototype, {
            name: "Default",
            $loadIframe: function(t, n, a) {
                var i = a.pages,
                    r = a.loadOn,
                    s = E.bind(function() { E.each(i, function(e) { this.loadIframe(t, n, e) }, this) }, this);
                r || s(), "domready" === r && E.domReady(s), "load" === r && E.addEventHandler(e, "load", s)
            },
            loadIframe: function(e, n, a) {
                var i = t.createElement("iframe");
                i.style.display = "none";
                var r = E.data.host,
                    s = a.data,
                    o = this.scriptURL(a.src),
                    c = E.searchVariables(s, e, n);
                r && (o = E.basePath() + o), o += c, i.src = o;
                var l = t.getElementsByTagName("body")[0];
                l ? l.appendChild(i) : E.domReady(function() { t.getElementsByTagName("body")[0].appendChild(i) })
            },
            scriptURL: function(e) { return (E.settings.scriptDir || "") + e },
            $loadScript: function(t, n, a) {
                var i = a.scripts,
                    r = a.sequential,
                    s = a.loadOn,
                    o = E.bind(function() { r ? this.loadScripts(t, n, i) : E.each(i, function(e) { this.loadScripts(t, n, [e]) }, this) }, this);
                s ? "domready" === s ? E.domReady(o) : "load" === s && E.addEventHandler(e, "load", o) : o()
            },
            loadScripts: function(e, t, n) {
                function a() {
                    r.length > 0 && i && r.shift().call(e, t, s);
                    var c = n.shift();
                    if (c) {
                        var l = E.data.host,
                            d = o.scriptURL(c.src);
                        l && (d = E.basePath() + d), i = c, E.loadScript(d, a)
                    }
                }
                try {
                    n = n.slice(0);
                    var i, r = this.asyncScriptCallbackQueue,
                        s = t.target || t.srcElement,
                        o = this
                } catch (c) { console.error("scripts is", E.stringify(n)) }
                a()
            },
            $loadBlockingScript: function(e, t, n) {
                var a = n.scripts;
                n.loadOn;
                E.bind(function() { E.each(a, function(n) { this.loadBlockingScript(e, t, n) }, this) }, this)()
            },
            loadBlockingScript: function(e, t, n) {
                var a = this.scriptURL(n.src),
                    i = E.data.host,
                    r = t.target || t.srcElement;
                i && (a = E.basePath() + a), this.argsForBlockingScripts.push([e, t, r]), E.loadScriptSync(a)
            },
            pushAsyncScript: function(e) { this.asyncScriptCallbackQueue.push(e) },
            pushBlockingScript: function(e) {
                var t = this.argsForBlockingScripts.shift(),
                    n = t[0];
                e.apply(n, t.slice(1))
            },
            $writeHTML: E.escapeHtmlParams(function(e, n) {
                if (!E.domReadyFired && t.write)
                    if ("pagebottom" === n.type || "pagetop" === n.type)
                        for (var a = 2, i = arguments.length; a < i; a++) {
                            var r = arguments[a].html;
                            r = E.replace(r, e, n), t.write(r)
                        } else E.notify("You can only use writeHTML on the `pagetop` and `pagebottom` events.", 1);
                    else E.notify("Command writeHTML failed. You should try appending HTML using the async option.", 1)
            }),
            linkNeedsDelayActivate: function(t, n) {
                n = n || e;
                var a = t.tagName,
                    i = t.getAttribute("target"),
                    r = t.getAttribute("href");
                return (!a || "a" === a.toLowerCase()) && (!!r && (!i || "_blank" !== i && ("_top" === i ? n.top === n : "_parent" !== i && ("_self" === i || (!n.name || i === n.name)))))
            },
            $delayActivateLink: function(e, t) {
                if (this.linkNeedsDelayActivate(e)) {
                    E.preventDefault(t);
                    var n = E.settings.linkDelay || 100;
                    setTimeout(function() { E.setLocation(e.href) }, n)
                }
            },
            isQueueable: function(e) { return "writeHTML" !== e.command }
        }), E.availableTools["default"] = S, E.inherit(k, E.BaseTool), E.extend(k.prototype, {
            name: "Nielsen",
            endPLPhase: function(e) {
                switch (e) {
                    case "pagetop":
                        this.initialize();
                        break;
                    case "pagebottom":
                        this.enableTracking && (this.queueCommand({ command: "sendFirstBeacon", arguments: [] }), this.flushQueueWhenReady())
                }
            },
            defineListeners: function() { this.onTabFocus = E.bind(function() { this.notify("Tab visible, sending view beacon when ready", 1), this.tabEverVisible = !0, this.flushQueueWhenReady() }, this), this.onPageLeave = E.bind(function() { this.notify("isHuman? : " + this.isHuman(), 1), this.isHuman() && this.sendDurationBeacon() }, this), this.onHumanDetectionChange = E.bind(function(e) { this == e.target.target && (this.human = e.target.isHuman) }, this) },
            initialize: function() {
                this.initializeTracking(), this.initializeDataProviders(), this.initializeNonHumanDetection(), this.tabEverVisible = E.visibility.isVisible(),
                    this.tabEverVisible ? this.notify("Tab visible, sending view beacon when ready", 1) : E.bindEventOnce("tabfocus", this.onTabFocus), this.initialized = !0
            },
            initializeTracking: function() { this.initialized || (this.notify("Initializing tracking", 1), this.addRemovePageLeaveEvent(this.enableTracking), this.addRemoveHumanDetectionChangeEvent(this.enableTracking), this.initialized = !0) },
            initializeDataProviders: function() {
                var e, t = this.getAnalyticsTool();
                this.dataProvider.register(new k.DataProvider.VisitorID(E.getVisitorId())), t ? (e = new k.DataProvider.Generic("rsid", function() { return t.settings.account }), this.dataProvider.register(e)) : this.notify("Missing integration with Analytics: rsid will not be sent.")
            },
            initializeNonHumanDetection: function() { E.nonhumandetection ? (E.nonhumandetection.init(), this.setEnableNonHumanDetection(0 != this.settings.enableNonHumanDetection), this.settings.nonHumanDetectionDelay > 0 && this.setNonHumanDetectionDelay(1e3 * parseInt(this.settings.nonHumanDetectionDelay))) : this.notify("NHDM is not available.") },
            getAnalyticsTool: function() { if (this.settings.integratesWith) return E.tools[this.settings.integratesWith] },
            flushQueueWhenReady: function() { this.enableTracking && this.tabEverVisible && E.poll(E.bind(function() { if (this.isReadyToTrack()) return this.flushQueue(), !0 }, this), 100, 20) },
            isReadyToTrack: function() { return this.tabEverVisible && this.dataProvider.isReady() },
            $setVars: function(e, t, n) {
                for (var a in n) { var i = n[a]; "function" == typeof i && (i = i()), this.settings[a] = i }
                this.notify("Set variables done", 2), this.prepareContextData()
            },
            $setEnableTracking: function(e, t, n) { this.notify("Will" + (n ? "" : " not") + " track time on page", 1), this.enableTracking != n && (this.addRemovePageLeaveEvent(n), this.addRemoveHumanDetectionChangeEvent(n), this.enableTracking = n) },
            $sendFirstBeacon: function() { this.sendViewBeacon() },
            setEnableNonHumanDetection: function(e) { e ? E.nonhumandetection.register(this) : E.nonhumandetection.unregister(this) },
            setNonHumanDetectionDelay: function(e) { E.nonhumandetection.register(this, e) },
            addRemovePageLeaveEvent: function(e) { this.notify((e ? "Attach onto" : "Detach from") + " page leave event", 1), E[0 == e ? "unbindEvent" : "bindEvent"]("leave", this.onPageLeave) },
            addRemoveHumanDetectionChangeEvent: function(e) { this.notify((e ? "Attach onto" : "Detach from") + " human detection change event", 1), E[0 == e ? "unbindEvent" : "bindEvent"]("humandetection.change", this.onHumanDetectionChange) },
            sendViewBeacon: function() { this.notify("Tracked page view.", 1), this.sendBeaconWith() },
            sendDurationBeacon: function() { if (E.timetracking && "function" == typeof E.timetracking.timeOnPage && null != E.timetracking.timeOnPage()) { this.notify("Tracked close", 1), this.sendBeaconWith({ timeOnPage: Math.round(E.timetracking.timeOnPage() / 1e3), duration: "D", timer: "timer" }); var e; for (e = 0; e < this.magicConst; e++) "0" } else this.notify("Could not track close due missing time on page", 5) },
            sendBeaconWith: function(e) { this.enableTracking && this[this.beaconMethod].call(this, this.prepareUrl(e)) },
            plainBeacon: function(e) {
                var t = new Image;
                t.src = e, t.width = 1, t.height = 1, t.alt = ""
            },
            navigatorSendBeacon: function(e) { navigator.sendBeacon(e) },
            prepareUrl: function(e) { var t = this.settings; return E.extend(t, this.dataProvider.provide()), E.extend(t, e), this.preparePrefix(this.settings.collectionServer) + this.adapt.convertToURI(this.adapt.toNielsen(this.substituteVariables(t))) },
            preparePrefix: function(e) { return "//" + encodeURIComponent(e) + ".imrworldwide.com/cgi-bin/gn?" },
            substituteVariables: function(e) { var t = {}; for (var n in e) e.hasOwnProperty(n) && (t[n] = E.replace(e[n])); return t },
            prepareContextData: function() {
                if (this.getAnalyticsTool()) {
                    var e = this.settings;
                    e.sdkVersion = _satellite.publishDate, this.getAnalyticsTool().$setVars(null, null, { contextData: this.adapt.toAnalytics(this.substituteVariables(e)) })
                } else this.notify("Adobe Analytics missing.")
            },
            isHuman: function() { return this.human },
            onTabFocus: function() {},
            onPageLeave: function() {},
            onHumanDetectionChange: function() {},
            notify: function(e, t) { E.notify(this.logPrefix + e, t) },
            beaconMethod: "plainBeacon",
            adapt: null,
            enableTracking: !1,
            logPrefix: "Nielsen: ",
            tabEverVisible: !1,
            human: !0,
            magicConst: 2e6
        }), k.DataProvider = {}, k.DataProvider.Generic = function(e, t) { this.key = e, this.valueFn = t }, E.extend(k.DataProvider.Generic.prototype, { isReady: function() { return !0 }, getValue: function() { return this.valueFn() }, provide: function() { this.isReady() || k.prototype.notify("Not yet ready to provide value for: " + this.key, 5); var e = {}; return e[this.key] = this.getValue(), e } }), k.DataProvider.VisitorID = function(e, t, n) { this.key = t || "uuid", this.visitorInstance = e, this.visitorInstance && (this.visitorId = e.getMarketingCloudVisitorID([this, this._visitorIdCallback])), this.fallbackProvider = n || new k.UUID }, E.inherit(k.DataProvider.VisitorID, k.DataProvider.Generic), E.extend(k.DataProvider.VisitorID.prototype, { isReady: function() { return null === this.visitorInstance || !!this.visitorId }, getValue: function() { return this.visitorId || this.fallbackProvider.get() }, _visitorIdCallback: function(e) { this.visitorId = e } }), k.DataProvider.Aggregate = function() { this.providers = []; for (var e = 0; e < arguments.length; e++) this.register(arguments[e]) }, E.extend(k.DataProvider.Aggregate.prototype, { register: function(e) { this.providers.push(e) }, isReady: function() { return E.every(this.providers, function(e) { return e.isReady() }) }, provide: function() { var e = {}; return E.each(this.providers, function(t) { E.extend(e, t.provide()) }), e } }), k.UUID = function() {}, E.extend(k.UUID.prototype, { generate: function() { return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function(e) { var t = 16 * Math.random() | 0; return ("x" == e ? t : 3 & t | 8).toString(16) }) }, get: function() { var e = E.readCookie(this.key("uuid")); return e || (e = this.generate(), E.setCookie(this.key("uuid"), e), e) }, key: function(e) { return "_dtm_nielsen_" + e } }), k.DataAdapters = function() {}, E.extend(k.DataAdapters.prototype, {
            toNielsen: function(e) {
                var t = (new Date).getTime(),
                    a = { c6: "vc,", c13: "asid,", c15: "apn,", c27: "cln,", c32: "segA,", c33: "segB,", c34: "segC,", c35: "adrsid,", c29: "plid,", c30: "bldv,", c40: "adbid," },
                    i = { ci: e.clientId, c6: e.vcid, c13: e.appId, c15: e.appName, prv: 1, forward: 0, ad: 0, cr: e.duration || "V", rt: "text", st: "dcr", prd: "dcr", r: t, at: e.timer || "view", c16: e.sdkVersion, c27: e.timeOnPage || 0, c40: e.uuid, c35: e.rsid, ti: t, sup: 0, c32: e.segmentA, c33: e.segmentB, c34: e.segmentC, asn: e.assetName, c29: e.playerID, c30: e.buildVersion };
                for (key in i)
                    if (i[key] !== n && null != i[key] && i[key] !== n && null != i && "" != i) {
                        var r = encodeURIComponent(i[key]);
                        a.hasOwnProperty(key) && r && (r = a[key] + r), i[key] = r
                    }
                return this.filterObject(i)
            },
            toAnalytics: function(e) { return this.filterObject({ "a.nielsen.clientid": e.clientId, "a.nielsen.vcid": e.vcid, "a.nielsen.appid": e.appId, "a.nielsen.appname": e.appName, "a.nielsen.accmethod": "0", "a.nielsen.ctype": "text", "a.nielsen.sega": e.segmentA, "a.nielsen.segb": e.segmentB, "a.nielsen.segc": e.segmentC, "a.nielsen.asset": e.assetName }) },
            convertToURI: function(e) { if (!1 === E.isObject(e)) return ""; var t = []; for (var n in e) e.hasOwnProperty(n) && t.push(n + "=" + e[n]); return t.join("&") },
            filterObject: function(e) { for (var t in e) !e.hasOwnProperty(t) || null != e[t] && e[t] !== n || delete e[t]; return e }
        }), E.availableTools.nielsen = k, _satellite.init({
            tools: { a51eec319705eb43b9490f82500cd313: { engine: "sc", loadOn: "pagebottom", account: "lazboydtfullproduction", euCookie: !1, sCodeURL: "6b36885b5db2b3919b18a4f4e0755d75dfb17462/s-code-contents-39dfc559c8f5ac5962583c235001275ec5a4d3b0.js", initVars: { charSet: "UTF-8", currencyCode: "USD", cookieDomainPeriods: "2", fpCookieDomainPeriods: "2", campaign: E.getQueryParam("cid_campaign"), trackInlineStats: !1, trackDownloadLinks: !0, linkDownloadFileTypes: "avi,csv,doc,docx,eps,exe,m4v,mov,mp3,pdf,ppt,pptx,rar,svg,tab,txt,vsd,vxd,wav,wma,wmv,xls,xlsx,zip", trackExternalLinks: !0, linkInternalFilters: "javascript:,la-z-boy.com,mailto:,scene7.com,tel:", linkLeaveQueryString: !1, dynamicVariablePrefix: "D=", eVar41: "D=g", eVar42: "%Preferred Store%" }, customInit: function() { return !1 } }, "1609c65dba799b680c2cf8d1426cca88d0cc5581": { engine: "visitor_id", loadOn: "pagetop", name: "VisitorID", mcOrgId: "2783FC73566A9F0E7F000101@AdobeOrg", autoRequest: !0, initVars: { trackingServer: "lzbtrack.sc.omtrdc.net" } } },
            pageLoadRules: [{
                    name: "2018 - Design Dash - Shop This Look",
                    trigger: [{
                        command: "writeHTML",
                        arguments: [{
                            html: `
                            <!--\nStart of DoubleClick Floodlight Tag: Please do not remove\n
                            Activity name of this tag: Design Dash Shop This Look Desktop FY18\n
                            URL of the webpage where the tag is expected to be placed: http://www.lazboy.com\n
                            This tag must be placed between the <body> and </body> tags, as close as possible to the opening tag.\n
                            Creation Date: 03/22/2017\n-->\n
                            <script type="text/javascript">\n
                                var axel = Math.random() + "";\n
                                var a = axel * 10000000000000;\n
                                document.write(\'<iframe src="https://1461522.fls.doubleclick.net/activityi;src=1461522;type=fy17l00;cat=desig000;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=\' + a + \'?" width="1" height="1" frameborder="0" style="display:none"></iframe>\');\n
                            </script>\n
                            <noscript>\n
                                <iframe src="https://1461522.fls.doubleclick.net/activityi;src=1461522;type=fy17l00;cat=desig000;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1?" width="1" height="1" frameborder="0" style="display:none"></iframe>\n
                            </noscript>\n
                            <!-- End of DoubleClick Floodlight Tag: Please do not remove -->\n
                            `
                        }]
                    }],
                    scope: {
                        URI: {
                            include: ["/content/design-dash/bright-yellow-door", "/content/design-dash/somewhat-simple", "/content/design-dash/love-your-abode", "/content/design-dash/i-spy-diy", "/content/design-dash/nina-cecilia", "/content/design-dash/carla-bethany", "/content/design-dash/french-country-cottage", "/content/design-dash/xo-rachel-pitzel"]
                        }
                    },
                    event: "pagebottom"
                },
                {
                    name: "3rd Party - Book a Free In-Home Consult",
                    trigger: [{
                        command: "loadIframe",
                        arguments: [{
                            pages: [{
                                src: "satellite-5936e2f064746d51d3011415.html",
                                data: []
                            }]
                        }]
                    }],
                    scope: {
                        URI: {
                            include: [/\/personalized-design-assistance/i]
                        }
                    },
                    conditions: [function() {
                        return -1 !== t.referrer.indexOf("/content/design-services")
                    }],
                    event: "windowload"
                }, {
                    name: "3rd Pty - All Pages",
                    trigger: [{
                            command: "loadScript",
                            arguments: [{
                                sequential: !0,
                                scripts: [{
                                    src: "satellite-589a34cc64746d025c0099c3.js"
                                }]
                            }]
                        },
                        {
                            command: "loadIframe",
                            arguments: [{
                                pages: [{
                                        src: "satellite-5d77effc64746d4b950017b3.html",
                                        data: []
                                    },
                                    {
                                        src: "satellite-5a737faf64746d0bf10002e3.html",
                                        data: []
                                    }
                                ]
                            }]
                        }
                    ],
                    event: "windowload"
                },
                {
                    name: "3rd Pty - All Pages (Bottom)",
                    trigger: [{
                            command: "writeHTML",
                            arguments: [{
                                html: '<script>var ig_cid = "24796a5b18771c0233a63864310eac2c";</script>\n<script async="async" src="//inboundapi.com/ig.min.js"></script>'
                            }]
                        },
                        {
                            command: "loadScript",
                            arguments: [{
                                sequential: !1,
                                scripts: [{
                                    src: "satellite-5b86fa2864746d7c0c0003b4.js"
                                }]
                            }]
                        }
                    ],
                    event: "pagebottom"
                },
                {
                    name: "3rd Pty - BlueKai - Core Tag",
                    trigger: [{
                        command: "loadScript",
                        arguments: [{ sequential: !1, scripts: [{ src: "satellite-57ffed8e64746d5fd7003a6f.js" }] }]
                    }],
                    event: "pagebottom"
                }, { name: "3rd Pty - BlueKai - Global Page Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d5de3664746d546300203a.js" }] }] }], event: "windowload" }, { name: "3rd Pty - BlueKai - Product Page Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d73d7664746d5463002928.js" }] }] }], scope: { URI: { include: ["/p/"] } }, event: "pagebottom" }, { name: "3rd Pty - BlueKai - Site Search", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56effcac64746d08cc000d7b.js" }] }] }], scope: { URI: { include: [/^\/s\?.*/i] } }, event: "windowload" }, { name: "3rd Pty - Catalog Request - Submit Success", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57a8dc8964746d1d0100223b.html", data: [] }, { src: "satellite-5962db2764746d5067013e7e.html", data: [] }, { src: "satellite-5978817b64746d65f300118f.html", data: [] }] }] }], scope: { URI: { include: ["/content/CustomerCare/catalogs"] } }, conditions: [function() { return _satellite.textMatch(_satellite.getQueryParam("_DARGS"), /\/contactus\/productInformationCatalog.jsp/i) }], event: "windowload" }, { name: "3rd Pty - Catalog Request - Submit Success - Bottom of Page", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for Request a Catalog FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/reque0+unique'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=reque0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1;num=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->" }, { html: '<img height="1" width="1" style="border-style:none;" alt="" src="//insight.adsrvr.org/track/conv/?adv=cbvp2yq&ct=0:gsuie31&fmt=3"/>' }] }], scope: { URI: { include: ["/content/CustomerCare/catalogs"] } }, conditions: [function() { return _satellite.textMatch(_satellite.getQueryParam("_DARGS"), /\/contactus\/productInformationCatalog.jsp/i) }], event: "pagebottom" }, { name: "3rd Pty - Design Services page view", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-59a05c8764746d08f20031aa.js" }] }] }], scope: { URI: { include: ["/content/design-services"] } }, event: "windowload" }, { name: "3rd Pty - FG - Bay Area - Get Directions", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57fe604664746d38fb002346.html", data: [] }] }] }], scope: { URI: { include: [/\/storeLocator\/storeLocator.jsp\?directions=50869639$/i, /\/storeLocator\/storeLocator.jsp\?directions=50825569$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870696$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870157$/i, /\/storeLocator\/storeLocator.jsp\?directions=50869876$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870408$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870505$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870726$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870629$/i, /\/storeLocator\/storeLocator.jsp\?directions=50870718$/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Bay Area - Locations pages", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57ec0e6e64746d082c002b92.html", data: [] }, { src: "satellite-57fe5f6e64746d3901002554.html", data: [] }] }] }], scope: { URI: { include: [/\/Bay-Area\/Blossom-Hill-Road\/$/i, /\/Bay-Area\/Johnson-Drive\/$/i, /\/Bay-Area\/San-Jose\/$/i, /\/Bay-Area\/El-Camino-Real-San-Francisco\/$/i, /\/Bay-Area\/Contra-Costa-Boulevard\/$/i, /\/Bay-Area\/Dyer-Street\/$/i, /\/Bay-Area\/Christie-Ave\/$/i, /\/Bay-Area\/Fairfield\/$/i, /\/Bay-Area\/W-Shaw-Ave\/$/i, /\/Bay-Area\/Bakersfield\/$/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Bay Area - On Sale Category Pageview", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5862a23f64746d11fd000d0c.html", data: [] }] }] }], scope: { URI: { include: ["/b/_/N-1obe4n"] } }, conditions: [function() { return _satellite.textMatch(_satellite.readCookie("preferredStoreSet"), /50869639$|50870696$|50869876$|50825569$|50870157$|50870408$|50870505$|50870629$|50870718$|50870726$/i) }], event: "windowload" }, { name: "3rd Pty - FG - Bay Area - Store Info pages", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57ec116364746d28da002b17.html", data: [] }, { src: "satellite-57fe5ff764746d38fb002343.html", data: [] }] }] }], scope: { URI: { include: [/\/Bay-Area\/Blossom-Hill-Road\/Store-Info\/$/i, /\/Bay-Area\/Johnson-Drive\/Store-Info\/$/i, /\/Bay-Area\/San-Jose\/Store-Info\/$/i, /\/Bay-Area\/El-Camino-Real-San-Francisco\/Store-Info\/$/i, /\/Bay-Area\/Contra-Costa-Boulevard\/Store-Info\/$/i, /\/Bay-Area\/Dyer-Street\/Store-Info\/$/i, /\/Bay-Area\/Christie-Ave\/Store-Info\/$/i, /\/Bay-Area\/Fairfield\/Store-Info\/$/i, /\/Bay-Area\/W-Shaw-Ave\/Store-Info\/$/i, /\/Bay-Area\/Bakersfield\/Store-Info\/$/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Upstate-NY - Retargeting Code/Rewrite Code", trigger: [{ command: "writeHTML", arguments: [{ html: '<!-- Google Code for Remarketing Tag -->\n<!--------------------------------------------------\nRemarketing tags may not be associated with personally identifiable information or placed on pages related to sensitive categories. See more information and instructions on how to setup the tag on: http://google.com/ads/remarketingsetup\n--------------------------------------------------->\n<script type="text/javascript">\n/* <![CDATA[ */\nvar google_conversion_id = 957426849;\nvar google_custom_params = window.google_tag_params;\nvar google_remarketing_only = true;\n/* ]]> */\n</script>\n<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion.js">\n</script>\n<noscript>\n<div style="display:inline;">\n<img height="1" width="1" style="border-style:none;" alt="" src="//googleads.g.doubleclick.net/pagead/viewthroughconversion/957426849/?value=0&amp;guid=ON&amp;script=0"/>\n</div>\n</noscript>\n\n<!-- start number replacer -->\n<script type="text/javascript"><!--\nvs_account_id      = "CtjSaFUa6vApOgD1";\n//--></script>\n<script type="text/javascript" src="//rw1.marchex.io/euinc/number-changer.js">\n</script>\n<!-- end ad widget -->\n' }] }], scope: { URI: { include: [/\/upstate-ny/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Upstate-NY/Clay - Conversion Code", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5702c17464746d61d80017a9.html", data: [] }] }] }], scope: { URI: { include: [/\/upstate-ny\/clay\/contact/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Upstate-NY/Latham - Conversion Code", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5702c0fd64746d61d50011e1.html", data: [] }] }] }], scope: { URI: { include: [/\/upstate-ny\/latham\/contact/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG - Upstate-NY/Rochester - Conversion Code", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5702c14364746d61d50011ed.html", data: [] }] }] }], scope: { URI: { include: [/\/upstate-ny\/rochester\/contact/i] } }, event: "pagebottom" }, { name: "3rd Pty - FG Louisville", trigger: [{ command: "loadBlockingScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5dfb90e764746d5379003713.js" }] }] }], scope: { URI: { include: ["/Louisville/Louisville/"] } }, event: "pagebottom" }, { name: "3rd Pty - FG Website Main Page Viewed", trigger: [{ command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-57aa128a64746d2e35002db4.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57aa128a64746d2e35002db6.html", data: [] }, { src: "satellite-5966461664746d0ba500a327.html", data: [] }, { src: "satellite-597883fa64746d663b004f47.html", data: [] }] }] }], conditions: [function() { return _satellite.textMatch(_satellite.getVar("Page Name"), /^FG:[^:]*:[^:]+$/i) }], event: "windowload" }, { name: "3rd Pty - Facebook - Base Tracking Tag", trigger: [{ command: "writeHTML", arguments: [{ html: "<!-- Facebook Pixel Code -->\n<script>\n!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?\nn.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;\nn.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;\nt.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,\ndocument,'script','https://connect.facebook.net/en_US/fbevents.js');\n\nfbq('init', '573145442797467');\nfbq('track', \"PageView\");</script>\n<noscript><img height=\"1\" width=\"1\" style=\"display:none\"\nsrc=\"https://www.facebook.com/tr?id=573145442797467&ev=PageView&noscript=1\"\n/></noscript>\n<!-- End Facebook Pixel Code -->" }] }], event: "pagebottom" }, { name: "3rd Pty - Facebook - Billing Info Added", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56ec583564746d0520006859.js" }] }] }], scope: { URI: { include: ["/checkout/orderReview"] } }, event: "windowload" }, { name: "3rd Pty - Facebook - Checkout Started", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56ec57bb64746d05820005e0.js" }] }] }], scope: { URI: { include: ["/checkout/deliveryAndPayment"] } }, event: "windowload" }, { name: "3rd Pty - Facebook - Product Registration", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56ec567564746d058b000792.js" }] }] }], scope: { URI: { include: ["/ProductRegistration"] } }, conditions: [function() { return _satellite.textMatch(_satellite.getQueryParam("success"), "true") }], event: "windowload" }, { name: "3rd Pty - Facebook - Site Search", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56ec536f64746d79b70002b4.js" }] }] }], scope: { URI: { include: ["/s"], exclude: ["/sofas", "/sectionals"] } }, event: "windowload" }, { name: "3rd Pty - Facebook - View Content", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56ec527164746d79ae00034e.js" }] }] }], scope: { URI: { include: [/.*\/content\/.*|.*\/b\/.*|.*\/p\/.*|.*\/s.*/i] } }, event: "windowload" }, { name: "3rd Pty - Library Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-578fbee264746d0b19003e65.js" }] }] }], event: "pagetop" }, { name: "3rd Pty - On Sale Category Pageview", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5787f56f64746d0b16000d7e.html", data: [] }, { src: "satellite-5962dc4364746d56ee014c5a.html", data: [] }, { src: "satellite-5978834264746d3299029af4.html", data: [] }] }] }], scope: { URI: { include: ["/b/_/N-1obe4n"] } }, event: "windowload" }, { name: "3rd Pty - On Sale Category Pageview - Bottom of Page", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for On Sale Button FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/onsal0+standard'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=onsal0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->" }] }], scope: { URI: { include: ["/b/_/N-1obe4n"] } }, event: "pagebottom" }, { name: "3rd Pty - One Million Thanks", trigger: [{ command: "writeHTML", arguments: [{ html: '<!--\nEvent snippet for LZB Charitable Landing Page (STA) on https://www.la-z-boy.com/content/one-million-thanks: Please do not remove.\nPlace this snippet on pages with events you\'re tracking. \nCreation date: 05/06/2020\n-->\n<script>\n  gtag(\'event\', \'conversion\', {\n    \'allow_custom_scripts\': true,\n    \'send_to\': \'DC-1461522/fy17l0/lzbch0+standard\'\n  });\n</script>\n<noscript>\n<img src=""https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=lzbch0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;npa=;ord=1?"" width=""1"" height=""1"" alt=""""/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->' }] }], scope: { URI: { include: ["one-million-thanks"] } }, event: "pagebottom" }, { name: "3rd Pty - Oracle Eloqua-Tracking Tag", trigger: [{ command: "writeHTML", arguments: [{ html: "<script type=\"text/javascript\">\n\t\tvar _elqQ = _elqQ || [];\n    _elqQ.push(['elqSetSiteId', '20103530']);\n    _elqQ.push(['elqTrackPageView']);\n    \n    (function () {\n        function async_load() {\n            var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true;\n            s.src = '//img03.en25.com/i/elqCfg.min.js';\n            var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x);\n        }\n        if (window.addEventListener) window.addEventListener('DOMContentLoaded', async_load, false);\n        else if (window.attachEvent) window.attachEvent('onload', async_load); \n    })();\n</script>" }] }], event: "pagebottom" }, { name: "3rd Pty - Order Confirmation", trigger: [{ command: "writeHTML", arguments: [{ html: '<script>window.ig_async=function(){EpicIG.returnStream({"workflow":{"status":"complete"}});}</script>' }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5d77bf7364746d588100243a.js" }, { src: "satellite-58a2257964746d56fc003a74.js" }, { src: "satellite-596621c864746d506701565b.js" }, { src: "satellite-5d77bf7364746d588100243b.js" }, { src: "satellite-59ce77c064746d7562001ec8.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-596621c864746d506701565c.html", data: [] }, { src: "satellite-599b345b64746d7ade0017c3.html", data: [] }, { src: "satellite-5caf77ef64746d2ea5001cfe.html", data: [] }] }] }], scope: { URI: { include: ["/checkout/orderConfirmation"] } }, event: "pagebottom" }, { name: "3rd Pty - Order Confirmation (Top)", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5d56fca364746d2586001bc7.js" }] }] }], scope: { URI: { include: ["/checkout/orderConfirmation"] } }, event: "pagetop" }, { name: "3rd Pty - Product Category Page Viewed", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5977b20b64746d373800484f.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5787d72764746d6bee00096f.html", data: [] }, { src: "satellite-5962b23364746d0b9500857c.html", data: [] }] }] }], scope: { URI: { include: ["/b/"] } }, event: "windowload" }, { name: "3rd Pty - Product Category Page Viewed - Bottom of Page", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for Category Pages FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n    gtag('event', 'conversion', {\n      'allow_custom_scripts': true,\n      'send_to': 'DC-1461522/fy17l0/categ0+standard'\n    });\n  </script>\n  <noscript>\n  <img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=categ0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n  </noscript>\n  <!-- End of event snippet: Please do not remove -->" }] }], scope: { URI: { include: ["/b/"] } }, event: "pagebottom" }, { name: "3rd Pty - Product Detail Pages Viewed - Bottom of Page", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for Product Pages FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/produ0+standard'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=produ0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->" }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5cc8705564746d02f4000345.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5cc8705564746d02f4000343.html", data: [] }, { src: "satellite-5cc8705564746d02f4000344.html", data: [] }] }] }], scope: { URI: { include: [/\/p\//i] } }, event: "pagebottom" }, { name: "3rd Pty - RPA DoubleClick Floodlight - Global Page Load", trigger: [{ command: "writeHTML", arguments: [{ html: "<!-- \nStart of global snippet: Please do not remove\nPlace this snippet between the <head> and </head> tags on every page of your site.\n-->\n<!-- Global site tag (gtag.js) - DoubleClick -->\n<script async src=\"https://www.googletagmanager.com/gtag/js?id=DC-1461522\"></script>\n<script>\n  window.dataLayer = window.dataLayer || [];\n  function gtag(){dataLayer.push(arguments);}\n  gtag('js', new Date());\n\n  gtag('config', 'DC-1461522');\n</script>\n<!-- End of global snippet: Please do not remove -->" }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5ca512cb64746d7370002382.html", data: [] }] }] }], event: "pagetop" }, { name: "3rd Pty - Urban Attitudes Pageview", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for Urban Attitude Landing Page Desktop on https://www.la-z-boy.com/content/urban-attitudes: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 10/05/2018\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/urban0+standard'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=urban0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;tfua=;npa=;ord=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->" }] }], scope: { URI: { include: ["/content/urban-attitudes"] } }, event: "pagebottom" }, { name: "Cart Page Data Layer Load", trigger: [{ engine: "sc", command: "setVars", arguments: [{ pageName: "Cart" }] }, { engine: "sc", command: "customSetup", arguments: [function(e, t) { t.products = _satellite.getVar("Cart Products"), t.events = "scOpen" }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56931e4e64746d5bd30075d9.js" }] }] }], scope: { URI: { include: ["/checkout/cart.jsp"] } }, event: "pagebottom" }, { name: "Catalog Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-572273c364746d79400004b9.js" }] }] }], scope: { URI: { include: ["/content/CustomerCare/catalogs/"] } }, event: "pagebottom" }, { name: "Checkout Page Data Layer Load", trigger: [{ engine: "sc", command: "customSetup", arguments: [function(e, t) { t.products = _satellite.getVar("Cart Products"), t.events = "scCheckout" }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d60aff64746d57d0001c2d.js" }] }] }], scope: { URI: { include: ["/checkout/checkout.jsp"] } }, event: "pagebottom" }, { name: "Compare Page Data Layer Load", trigger: [{ engine: "sc", command: "customSetup", arguments: [function(e, t) { t.events = "event7" }] }], scope: { URI: { include: ["/comparisons/compare.jsp"] } }, event: "pagebottom" }, { name: "Create Data Layer", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5674103464746d438800affa.js" }] }] }], event: "pagetop" }, { name: "Email Personalization Analytics", trigger: [{ engine: "sc", command: "setVars", arguments: [{ eVar54: "%Personalization Category%", eVar55: "%Personalization Email Link%" }] }], scope: { URI: { include: [/link=/i] } }, event: "pagebottom" }, { name: "FAQ Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b122c164746d0e4b002975.js" }] }] }], scope: { URI: { include: ["/content/CustomerCare/FAQS/"] } }, event: "pagebottom" }, { name: "Global Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b11af364746d0e3f002e61.js" }] }] }], event: "pagebottom" }, { name: "Global Page Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b1230a64746d0e4b00297a.js" }] }] }], event: "domready" }, { name: "Google Remarketing Tag - RPA Tier 1/2", trigger: [{ command: "writeHTML", arguments: [{ html: "<!-- Global site tag (gtag.js) - Google Ads: 854923526 -->\n<script async src=\"https://www.googletagmanager.com/gtag/js?id=AW-854923526\"></script>\n<script>\n  window.dataLayer = window.dataLayer || [];\n  function gtag(){dataLayer.push(arguments)};\n  gtag ('set', 'allow_ad_personalization_signals',  false ) ;\n  gtag ('js', new Date());\n\n  gtag ('config', 'AW-854923526');\n</script>\n" }] }], event: "pagetop" }, { name: "Hotjar Tracking Code - US", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-5bd1c87064746d01db00351a.js" }] }] }], conditions: [function() { return _satellite.textMatch(_satellite.getVar("Country"), "us") }], event: "domready" }, { name: "Landing Page - Site pixel - La-Z-Boy Campaign Buyer Summary Site to Store", trigger: [{ engine: "sc", command: "setVars", arguments: [{ eVar49: "%Referrer%", eVar50: "%Landing Page%" }] }, { command: "writeHTML", arguments: [{ html: "<img alt=\"oraclests\" src='https://h.nexac.com/e/mp/g-5570.xgi?pkey=&chpcm=&chpsg=&chpcr=%Referrer%&chpck=&rand=%Random%&chpth=%Landing Page%' width='1' height='1' border='0'>\n" }] }], event: "pagebottom" }, { name: "Page View - 3D Room Planner - Landing Page", trigger: [{ engine: "sc", command: "addEvent", arguments: ["event39"] }], scope: { URI: { include: ["/content/DesignInspirations/3DRoomPlanner"] } }, event: "domready" }, { name: "Page View - Design Pages", trigger: [{ engine: "sc", command: "addEvent", arguments: ["event43"] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-599336fb64746d7960001e4c.html", data: [] }, { src: "satellite-5993394964746d4767001e4d.html", data: [] }, { src: "satellite-599336fb64746d7960001e4d.html", data: [] }] }] }], scope: { URI: { include: [/\/content\/CustomizeIt/i, /\/content\/room-inspirations/i, /\/content\/DesignInspirations/i, /\/content\/design-services/i, /\/content\/style-fit/i] } }, event: "domready" }, {
                    name: "Page View - Design Pages - Bottom of Page",
                    trigger: [{
                        command: "writeHTML",
                        arguments: [{
                            html: "<!--\nEvent snippet for Design Inspiration FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/desig0+unique'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=desig0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1;num=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->"
                        }]
                    }],
                    scope: { URI: { include: [/\/content\/style-fit/i, /\/content\/design-services/i, /\/content\/DesignInspirations/i, /\/content\/room-inspirations/i, /\/content\/CustomizeIt/i] } },
                    event: "pagebottom"
                }, { name: "Page View - Store Locator", trigger: [{ engine: "sc", command: "addEvent", arguments: ["event41"] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-57a8d17664746d692b001c04.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5962d9da64746d0b920086d7.html", data: [] }, { src: "satellite-59787ff964746d3738005563.html", data: [] }] }] }], scope: { URI: { include: ["/storeLocator/storeLocator.jsp"] } }, event: "domready" }, { name: "Page View - Store Locator - Bottom of Page", trigger: [{ command: "writeHTML", arguments: [{ html: "<!--\nEvent snippet for Store Locator FY17 on http://www.la-z-boy.com/: Please do not remove.\nPlace this snippet on pages with events you're tracking. \nCreation date: 11/29/2017\n-->\n<script>\n  gtag('event', 'conversion', {\n    'allow_custom_scripts': true,\n    'send_to': 'DC-1461522/fy17l0/store0+unique'\n  });\n</script>\n<noscript>\n<img src=\"https://ad.doubleclick.net/ddm/activity/src=1461522;type=fy17l0;cat=store0;dc_lat=;dc_rdid=;tag_for_child_directed_treatment=;ord=1;num=1?\" width=\"1\" height=\"1\" alt=\"\"/>\n</noscript>\n<!-- End of event snippet: Please do not remove -->" }] }], scope: { URI: { include: ["/storeLocator/storeLocator.jsp"] } }, event: "pagebottom" }, { name: "Page View - Style Finder", trigger: [{ engine: "sc", command: "addEvent", arguments: ["event40"] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5caf9db664746d78bd00096a.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5caf9db664746d78bd000969.html", data: [] }] }] }], scope: { URI: { include: ["/content/DesignInspirations/StyleFinder"] } }, event: "domready" }, { name: "Product Category and Search Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b1245a64746d0a88003010.js" }] }] }], scope: { URI: { include: ["/b/", "/s/", /^\/s\?.*/i, /^\/s$/i, /^\/b$/i] } }, event: "pagebottom" }, { name: "Product Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b1226e64746d0e45002e74.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-582dd91764746d065a00445a.html", data: [] }] }] }], scope: { URI: { include: ["/p/"] } }, event: "pagebottom" }, { name: "Room Inspiration Page Data Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b1235364746d0e45002e8d.js" }] }] }], scope: { URI: { include: [/\/content\/designinspirations\/roominspirations/i] } }, event: "pagebottom" }, { name: "Session Cookie Setter", conditions: [function() { return _satellite.visitorSessionCount() > 1 }], event: "pagebottom" }, { name: "Store Locator Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b1237e64746d0e45002e92.js" }] }] }], scope: { URI: { include: ["/storeLocator/"] } }, event: "pagebottom" }, { name: "Thank You Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b123a164746d0e4b002980.js" }, { src: "satellite-5763f28764746d42e9001e81.js" }, { src: "satellite-578cd23a64746d29b9001bed.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-582dd89664746d063e005894.html", data: [] }] }] }], scope: { URI: { include: ["/checkout/orderConfirmation"] } }, event: "pagebottom" }, { name: "Wishlist Page Data Layer Load", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56b123b764746d0e45002e96.js" }] }] }], scope: { URI: { include: ["/account/wish_list_items.jsp"] } }, event: "pagebottom" }, { name: "Yahoo Global Pixel", trigger: [{ command: "loadBlockingScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5c364ac564746d17ce01a33f.js" }] }] }], event: "pagetop" }
            ],
            rules: [{ name: "3rd Party - CA-  In-Home Design - Request Form Completed - June 09, 2017 07:38:41 AM", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-59a05d4264746d08f20031cc.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-593ab2f164746d3ddf001209.html", data: [] }, { src: "satellite-593ab2f164746d3ddf00120b.html", data: [] }, { src: "satellite-5962b98f64746d51d3021861.html", data: [] }, { src: "satellite-5977b2bd64746d0ba5011a57.html", data: [] }, { src: "satellite-5caba3a364746d3bcf006a07.html", data: [] }, { src: "satellite-5caf5d8064746d2ea5001ba7.html", data: [] }] }] }], scope: { URI: { include: [/\/personalized-design-assistance/i] } }, conditions: [function() { return _satellite.textMatch(_satellite.getVar("Form Submitted"), /PersonalDesignForm/i) }, function() { return _satellite.textMatch(_satellite.getVar("Country"), /ca/i) }], event: "dataelementchange(Form Submitted)", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "3rd Party - Nursery Page - Design Services Clicked", scope: { URI: { include: ["/content/nursery"] } }, selector: "a", property: { className: "design-consultation-button arrow-right" }, event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "3rd Party - Nursery Page - Learn More Clicked", scope: { URI: { include: ["/content/nursery"] } }, selector: "a", property: { className: "arrow-right dtm-click-npc" }, event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "3rd Party - Nursery Page - Shop Now Clicked", scope: { URI: { include: ["/content/nursery"] } }, selector: "a", property: { className: "arrow-right dtm-click-pdp" }, event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "3rd Party - US -  In-Home Design - Request Form Completed", trigger: [{ engine: "sc", command: "trackPageView", arguments: [{ setVars: { eVar57: "Submitted", prop18: "1" } }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-57a8ea7264746d2e380020b2.js" }, { src: "satellite-59a05d7764746d6e3a005720.js" }, { src: "satellite-5cf6e3aa64746d28f7003293.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57a8ea7264746d2e380020b4.html", data: [] }, { src: "satellite-5936ed1864746d56ee004c1c.html", data: [] }, { src: "satellite-5962b95f64746d586a00830e.html", data: [] }, { src: "satellite-5977b2a764746d0ba5011a55.html", data: [] }, { src: "satellite-5caba3e764746d7370003a7d.html", data: [] }, { src: "satellite-5caf5d0c64746d496c002cdf.html", data: [] }] }] }], scope: { URI: { include: [/\/design-request-form/i] } }, selector: "[id='dsr-submit']", event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "Create Account", selector: "create-account-form modal-jquery-validation amplifi-form", event: "submit", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "Download - Catalog", trigger: [{ command: "loadIframe", arguments: [{ pages: [{ src: "satellite-57a8dd8664746d59c4002937.html", data: [] }, { src: "satellite-57a8dd8664746d59c4002939.html", data: [] }, { src: "satellite-596641fb64746d7634007950.html", data: [] }, { src: "satellite-597881b264746d0bd4012049.html", data: [] }] }] }], selector: "a", property: { href: /StyleBook\.pdf|ReclinerCatalog\.pdf/i }, event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "Download Link", trigger: [{ command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56f0045064746d05290071c5.js" }] }] }, { command: "delayActivateLink" }], selector: "a", property: { href: /\.(?:doc|docx|eps|xls|ppt|pptx|pdf|xlsx|tab|csv|zip|txt|vsd|vxd|xml|js|css|rar|exe|wma|mov|avi|wmv|mp3|wav|m4v)($|\&|\?)/i }, event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "Drawer Button", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ type: "o", linkName: "Drawer Open", addEvent: ["event52"] }] }], selector: '[class="alive"]', event: "click", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }, { name: "Style Quiz Completion", scope: { URI: { include: ["/content/DesignInspirations/StyleFinder"] } }, selector: '[class="addthis_toolbox addthis_default_style addthis_32x32_style"]', event: "elementexists", bubbleFireIfParent: !0, bubbleFireIfChildFired: !0, bubbleStop: !1 }],
            directCallRules: [{ name: "account_created", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, addEvent: ["event1"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569916e664746d7568000228.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56effa7664746d0523007014.js" }, { src: "satellite-5787e8b464746d6bf4000c08.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5787e8b464746d6bf4000c0a.html", data: [] }, { src: "satellite-5962da6464746d3292013fa5.html", data: [] }, { src: "satellite-5caf5e8b64746d6779005638.html", data: [] }, { src: "satellite-5978803b64746d5e54006c2c.html", data: [] }] }] }] }, { name: "account_sign_in", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar36: "D=c21", prop21: "%Email Address%", prop26: "%Event Page Name%" }, addEvent: ["event2"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699170264746d73a50002de.js" }] }] }] }, { name: "autocorrect_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar39: "D=c24", prop24: "%Autocorrect%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-571937f964746d30b90003f5.js" }] }] }] }, { name: "cart_add", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, customSetup: function(e, t) { t.events = "scAdd", t.products = ";" + _satellite.getVar("Product SKU") + ";" + _satellite.getVar("Product Quantity") + ";" + _satellite.getVar("Product Price") }, addEvent: ["scAdd"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699279464746d40fe000310.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d60ac164746d57d0001bff.js" }, { src: "satellite-56ec590264746d058200060e.js" }, { src: "satellite-5787debf64746d53ab000cae.js" }, { src: "satellite-5787debf64746d53ab000cb0.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5caf5e2c64746d30a0000b7e.html", data: [] }, { src: "satellite-5962d95e64746d0a5801bb3a.html", data: [] }, { src: "satellite-59787f7e64746d6e6c011eba.html", data: [] }] }] }] }, { name: "cart_customers_also_liked", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar34: "%Product Page Product Category%:%Product Page Product Name%", prop26: "%Event Page Name%" }, addEvent: ["event22"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56991a4b64746d32e4000339.js" }] }] }] }, { name: "cart_remove", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, customSetup: function(e, t) { t.products = ";" + _satellite.getVar("Product SKU") + ";" + _satellite.getVar("Product Quantity") + ";" + _satellite.getVar("Product Price"), t.events = "scRemove" }, addEvent: ["scRemove"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569927a164746d43410003a5.js" }] }] }] }, { name: "compare_products", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar12: "%Compare Product Category%", eVar13: "%Compare Products%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569921ca64746d6f550003cc.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56effd1e64746d268b000334.js" }] }] }] }, { name: "cover_selection_rendered", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar17: "%Cover Color Group%", eVar18: "%Cover Color Grade%", eVar19: "%Cover Color Name%", eVar20: "%Cover SKU%", eVar21: "%Cover Price Group%", prop26: "%Event Page Name%" }, addEvent: ["event11"] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-57167c8964746d744800018f.js" }] }] }] }, {
                name: "custom_pageview",
                trigger: [{
                    engine: "sc",
                    command: "trackPageView",
                    arguments: [{
                        setVars: { eVar4: "%User Login Status%", eVar48: "%Monetate Campaigns%", prop1: "%Country%", prop17: "%User Status%", server: "%Server%", pageName: "%Page Name%", channel: "%Site Section%", hier1: "%Page Name%" },
                        customSetup: function(t, n) {
                            if (_satellite.textMatch(_satellite.getVar("Page Not Found"), "true") && (n.pageType = "errorPage", n.pageName = "", n.channel = "", n.server = "", n.hier1 = "errorPage"), _satellite.getQueryParam("sc") && (n.campaign = _satellite.getQueryParam("sc")), _satellite.getQueryParam("sn") && (n.eVar43 = _satellite.getQueryParam("sn")), _satellite.getQueryParam("nw") && (n.eVar44 = _satellite.getQueryParam("nw")), _satellite.getQueryParam("pd") && (n.eVar45 = _satellite.getQueryParam("pd")), _satellite.getQueryParam("dl") && (n.eVar46 = _satellite.getQueryParam("dl")), _satellite.getVar("Product SKU") && 0 == e.location.pathname.toLowerCase().indexOf("/p/") && (n.products = ";" + _satellite.getVar("Product SKU"), n.events = "prodView"), e.location.pathname.toLowerCase().indexOf("/checkout/orderconfirmation.jsp") >= 0) {
                                var a = _satellite.getVar("Cart Products");
                                _satellite.getVar("Order Number").length > 0 && (n.products = a, n.purchaseID = _satellite.getVar("Order Number"), n.transactionID = _satellite.getVar("Order Number"), n.eVar47 = _satellite.getVar("Order Number"), n.state = _satellite.getVar("State"), n.zip = _satellite.getVar("Zipcode"), a.indexOf("event44") > 0 ? n.events = "purchase,event44,event45,event46,event47" : n.events = "purchase")
                            }
                            _satellite.getVar("Menu Navigation") && (n.prop4 = _satellite.getVar("Menu Navigation"), n.prop26 = _satellite.getVar("Event Page Name")), _satellite.getVar("Narrow Search Product Category") && "Unknown" != _satellite.getVar("Narrow Search Product Category") && (n.eVar9 = _satellite.getVar("Narrow Search Product Category"), n.eVar10 = _satellite.getVar("Narrow Search Group Item"), n.eVar11 = _satellite.getVar("Narrow Search Action"), n.events ? n.events += (n.events.length > 0 ? "," : "") + "event6" : n.events = "event6", n.prop26 = _satellite.getVar("Event Page Name"))
                        }
                    }]
                }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-57d6f00764746d361c00e06a.js" }] }] }]
            }, { name: "did_you_mean_clicked", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar38: "D=c23", prop23: "%Did You Mean Clicked%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5719376664746d0ebb000408.js" }] }] }] }, { name: "did_you_mean_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar37: "%Did You Mean%", prop22: "%Did You Mean%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5719378364746d0ebb000413.js" }] }] }] }, { name: "feat_furn_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar32: "%Product Page Product Category%:%Product Page Product Name%", prop26: "%Event Page Name%" }, addEvent: ["event34"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699190264746d32e400032a.js" }] }] }] }, { name: "find_a_store_term_searched", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop14: "%Find A Store Term Searched%", prop26: "%Event Page Name%" }, addEvent: ["event33"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5698f92a64746d32ad0001c1.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d60b5064746d3757002087.js" }] }] }] }, { name: "form_submitted", trigger: [{ command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699299764746d73a50003cf.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d607b064746d57d0001bf1.js" }] }] }] }, { name: "frequently_asked_questions_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop11: "%Frequently Asked Questions Viewed%", prop26: "%Event Page Name%" }, addEvent: ["event23"] }] }] }, { name: "general_cover_search_filtered", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop12: "%General Cover Search Filtered%", prop26: "%Event Page Name%" }, addEvent: ["event25"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56991ae164746d32ad000270.js" }] }] }] }, { name: "general_cover_search_term_searched", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop13: "%General Cover Search Term Searched%", prop26: "%Event Page Name%" }, addEvent: ["event26"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56991b0464746d32aa00042f.js" }] }] }] }, { name: "top_seller", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar7: "%Top Seller Category%", eVar8: "%Top Seller Product%", prop26: "%Event Page Name%" }, addEvent: ["event5"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699173564746d7568000234.js" }] }] }] }, { name: "in_store_only", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop20: "%In Store Only Product%", prop26: "%Event Page Name%" }, addEvent: ["event35"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56f4306264746d05880028db.js" }] }] }] }, { name: "item_shared", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar14: "%Item Shared Method%", eVar15: "%Item Shared Product Category%", eVar16: "%Item Shared Product%", prop26: "%Event Page Name%" }, addEvent: ["event8"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569917e564746d6f55000315.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d6077264746d57d6001f64.js" }] }] }] }, { name: "menu_navigation", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%", prop4: "%Menu Navigation%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5698f4e864746d32aa00022d.js" }] }] }] }, { name: "options_and_upgrades_added", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar24: "%Option Details%", eVar25: "%Option Price%", prop26: "%Event Page Name%" }, addEvent: ["event13"] }] }] }, { name: "tab_usage", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop2: "%Page Tab Usage%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569ffb2364746d2db900043d.js" }] }] }] }, { name: "product_also_available", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar29: "%Product Page Product Category%:%Product Page Product Name%", prop26: "%Event Page Name%" }, addEvent: ["event21"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56991a1064746d32e4000333.js" }] }] }] }, { name: "promotion_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar1: "%Promotion Viewed%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d6071664746d57d30022ce.js" }] }] }] }, { name: "quick_look_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar5: "%Quick Look Product%", prop26: "%Event Page Name%" }, addEvent: ["event9"] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d6074464746d57d0001beb.js" }] }] }] }, { name: "room_inspiration_usage", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar30: "D=c3", prop26: "%Event Page Name%", prop3: "%Room Inspiration Usage%" }, addEvent: ["event24"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569ffce864746d42b00006fa.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d6079464746d57d6001f6e.js" }] }] }] }, { name: "search_product_clicked", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar40: "D=c25", prop25: "%Search Product Clicked%", prop26: "%Event Page Name%" } }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5719387b64746d0ec4000531.js" }] }] }] }, { name: "sectional_left_navigated", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, addEvent: ["event9"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-598ba9ff64746d5f0000141d.js" }] }] }] }, { name: "sectional_left_selected", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar27: "%Sectional Piece Style Number%:%Sectional Piece Name%", eVar28: "%Sectional Piece Price%", prop26: "%Event Page Name%" }, addEvent: ["event16"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699288e64746d73a50003b8.js" }] }] }] }, { name: "sectional_middle_navigated", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, addEvent: ["event17"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699289764746d73a50003bd.js" }] }] }] }, { name: "sectional_middle_selected", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar27: "%Sectional Piece Style Number%:%Sectional Piece Name%", eVar28: "%Sectional Piece Price%", prop26: "%Event Page Name%" }, addEvent: ["event18"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569928a564746d73a50003c0.js" }] }] }] }, { name: "sectional_preconfig_selected", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar35: "%Product Page Product Name%:%Sectional Option%", prop26: "%Event Page Name%" }, addEvent: ["event15"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699288164746d757f0003a0.js" }] }] }] }, { name: "sectional_right_navigated", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%" }, addEvent: ["event19"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569928b564746d73a50003c5.js" }] }] }] }, { name: "sectional_right_selected", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar27: "%Sectional Piece Style Number%:%Sectional Piece Name%", eVar28: "%Sectional Piece Price%", prop26: "%Event Page Name%" }, addEvent: ["event20"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569928c164746d73a50003c8.js" }] }] }] }, { name: "shop_by_usage", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { prop26: "%Event Page Name%", prop5: "%Shop By Usage%" } }] }] }, { name: "search_submitted", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar2: "%Site Search Term%", eVar6: "%Search Results Amount%", prop19: "%Site Search Term%", prop26: "%Event Page Name%" }, addEvent: ["event4"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-57222da164746d5262000197.js" }] }] }] }, { name: "subscribe_to_email", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar36: "%Email Address%", prop21: "%Email Address%", prop26: "%Event Page Name%" }, addEvent: ["event3"] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56effbcc64746d79b7000c1e.js" }, { src: "satellite-5787f2f464746d6bf1000d18.js" }, { src: "satellite-57e2d7c764746d628a0026c2.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5787f2f464746d6bf1000d1a.html", data: [] }, { src: "satellite-5962db6964746d5067013e80.html", data: [] }, { src: "satellite-5978825f64746d511e000fbb.html", data: [] }, { src: "satellite-5caf5f4c64746d30a0000b93.html", data: [] }] }] }] }, { name: "video_25", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar33: "%Video Name%", prop26: "%Event Page Name%" }, addEvent: ["event30"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56b90a6264746d38c7000526.js" }] }] }] }, { name: "video_50", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar33: "%Video Name%", prop26: "%Event Page Name%" }, addEvent: ["event31"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56b90a5764746d38c40003e3.js" }] }] }] }, { name: "video_75", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar33: "%Video Name%", prop26: "%Event Page Name%" }, addEvent: ["event32"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56b90a4d64746d38c40003df.js" }] }] }] }, { name: "video_completed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar33: "%Video Name%", prop26: "%Event Page Name%" }, addEvent: ["event29"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56b90a4364746d38c1000527.js" }] }] }] }, { name: "video_started", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar33: "%Video Name%", prop26: "%Event Page Name%" }, addEvent: ["event28"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-56b90a3864746d38c7000522.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56d607ef64746d57d6001f74.js" }, { src: "satellite-56e9b02b64746d052100540a.js" }] }] }] }, { name: "wishlist_product_add", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar23: "%Product Style and Name%", prop26: "%Event Page Name%" }, addEvent: ["event10"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-5699195364746d32ad00026c.js" }] }] }, { command: "loadScript", arguments: [{ sequential: !1, scripts: [{ src: "satellite-56effe3e64746d79b4000ac1.js" }, { src: "satellite-56f3f63d64746d0523008f54.js" }, { src: "satellite-5787eba964746d6bf4000c50.js" }] }] }, { command: "loadIframe", arguments: [{ pages: [{ src: "satellite-5caf5ebf64746d387b0007f2.html", data: [] }, { src: "satellite-5787eba964746d6bf4000c52.html", data: [] }, { src: "satellite-5962dab764746d3fce014366.html", data: [] }, { src: "satellite-5978810364746d763401016f.html", data: [] }] }] }] }, { name: "ymal_viewed", trigger: [{ engine: "sc", command: "trackLink", arguments: [{ setVars: { eVar26: "%Product Page Product Category%:%Product Page Product Name%", prop26: "%Event Page Name%" }, addEvent: ["event14"] }] }, { command: "loadScript", arguments: [{ sequential: !0, scripts: [{ src: "satellite-569919ba64746d32e400032e.js" }] }] }] }],
            settings: { trackInternalLinks: !0, libraryName: "satelliteLib-f7833623ccd47bf00c5eb512aa554cfa8eb75ab1", isStaging: !1, allowGATTcalls: !1, downloadExtensions: /\.(?:doc|docx|eps|jpg|png|svg|xls|ppt|pptx|pdf|xlsx|tab|csv|zip|txt|vsd|vxd|xml|js|css|rar|exe|wma|mov|avi|wmv|mp3|wav|m4v)($|\&|\?)/i, notifications: !1, utilVisible: !1, domainList: ["la-z-boy.com"], scriptDir: "6b36885b5db2b3919b18a4f4e0755d75dfb17462/scripts/", tagTimeout: 3e3 },
            data: { URI: t.location.pathname + t.location.search, browser: {}, cartItems: [], revenue: "", host: { http: "assets.adobedtm.com", https: "assets.adobedtm.com" } },
            dataElements: {
                Autocorrect: { customJS: function() { return lzbDesktopDataLayer.get("autocorrect") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Cart Products": { customJS: function() { return lzbDesktopDataLayer.get("cartProducts") }, storeLength: "pageview" },
                "Category Page Product Category": { selector: "h1", property: "text", storeLength: "pageview", cleanText: !0 },
                "Compare Product Category": { customJS: function() { return lzbDesktopDataLayer.get("compareProductCategory") }, storeLength: "pageview" },
                "Compare Products": { customJS: function() { return lzbDesktopDataLayer.get("compareProducts") }, storeLength: "pageview" },
                "Confirmation Email Address": { customJS: function() { if (t.getElementById("shippingEmail")) return t.getElementById("shippingEmail").value }, storeLength: "pageview" },
                "Confirmation Item One Name": { selector: "#site-wrapper > div.order-confirmation-content > div > div:nth-child(1) > div.item-details > div.product-name", property: "innerHTML", "default": "blank", storeLength: "pageview" },
                "Confirmation Items List": { customJS: function() { if (t.getElementById("itemsList")) return t.getElementById("itemsList").value }, storeLength: "pageview" },
                "Confirmation Item Three Name": { selector: "#site-wrapper > div.order-confirmation-content > div > div:nth-child(3) > div.item-details > div.product-name", property: "innerHTML", "default": "blank", storeLength: "pageview" },
                "Confirmation Item Two Name": { selector: "#site-wrapper > div.order-confirmation-content > div > div:nth-child(2) > div.item-details > div.product-name", property: "innerHTML", "default": "blank", storeLength: "pageview" },
                "Confirmation Order ID": { customJS: function() { if (t.getElementById("orderID")) return t.getElementById("orderID").value }, storeLength: "pageview" },
                "Confirmation Order Item Cost": { customJS: function() { if (t.getElementById("orderItemCost")) return t.getElementById("orderItemCost").value }, storeLength: "pageview" },
                Country: { customJS: function() { var e = t.querySelector('meta[name="DCSext.w_country_of_visitor"]'); return e && e.getAttribute("content") }, storeLength: "session", forceLowerCase: !0 },
                "Cover Color Grade": { customJS: function() { return lzbDesktopDataLayer.get("coverColorGrade") }, storeLength: "pageview" },
                "Cover Color Group": { customJS: function() { return lzbDesktopDataLayer.get("coverColorGroup") }, storeLength: "pageview" },
                "Cover Color Name": { customJS: function() { return lzbDesktopDataLayer.get("coverColorName") }, storeLength: "pageview" },
                "Cover Price Group": { customJS: function() { return lzbDesktopDataLayer.get("coverPriceGroup") }, storeLength: "pageview" },
                "Cover Selection Filtered": { customJS: function() { return lzbDesktopDataLayer.get("coverSelectionFiltered") }, storeLength: "pageview" },
                "Cover Selection Term Searched": { customJS: function() { return lzbDesktopDataLayer.get("coverSelectionTermSearched") }, storeLength: "pageview" },
                "Cover SKU": { customJS: function() { return lzbDesktopDataLayer.get("coverSKU") }, storeLength: "pageview" },
                "Did You Mean": { customJS: function() { return lzbDesktopDataLayer.get("didYouMean") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Did You Mean Clicked": { customJS: function() { return lzbDesktopDataLayer.get("didYouMeanClicked") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Email Address": { customJS: function() { return lzbDesktopDataLayer.get("emailAddress") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Event Page Name": { customJS: function() { return "undefined" == typeof lzbDesktopDataLayer ? "" : lzbDesktopDataLayer.get("eventPageName").length ? lzbDesktopDataLayer.get("eventPageName") : lzbDesktopDataLayer.get("pageName") }, storeLength: "pageview" },
                "Find A Store Term Searched": { customJS: function() { return lzbDesktopDataLayer.get("findAStoreTermSearched") }, storeLength: "pageview" },
                "Form Submitted": { customJS: function() { return "undefined" == typeof lzbDesktopDataLayer ? "" : lzbDesktopDataLayer.get("formSubmitted") }, "default": "unknown", storeLength: "pageview" },
                "Frequently Asked Questions Viewed": { customJS: function() { return lzbDesktopDataLayer.get("frequentlyAskedQuestionsViewed") }, storeLength: "pageview" },
                "General Cover Search Filtered": { customJS: function() { return lzbDesktopDataLayer.get("generalCoverSearchFiltered") }, storeLength: "pageview" },
                "General Cover Search Term Searched": { customJS: function() { return lzbDesktopDataLayer.get("generalCoverSearchTermSearched") }, storeLength: "pageview" },
                "In Store Only Product": { customJS: function() { return lzbDesktopDataLayer.get("inStoreOnlyProduct") }, storeLength: "pageview" },
                "Is Gallery": { customJS: function() { return null == t.getElementById("aspnetForm") ? "false" : "true" }, "default": "false", storeLength: "pageview" },
                "Item Shared Method": { customJS: function() { return lzbDesktopDataLayer.get("itemSharedMethod") }, storeLength: "pageview" },
                "Item Shared Product": { customJS: function() { return lzbDesktopDataLayer.get("itemSharedProduct") }, storeLength: "pageview" },
                "Item Shared Product Category": { customJS: function() { return lzbDesktopDataLayer.get("itemSharedProductCategory") }, storeLength: "pageview" },
                "Landing Page": { customJS: function() { return _satellite.getVar("window.location.href") }, storeLength: "pageview", forceLowerCase: !0 },
                "Menu Navigation": { customJS: function() { return lzbDesktopDataLayer.get("menuNavigation") }, storeLength: "pageview" },
                "Modal Submitted": { customJS: function() { return lzbDesktopDataLayer.get("modalSubmitted") }, storeLength: "pageview" },
                "Modal Viewed": { customJS: function() { return lzbDesktopDataLayer.get("modalViewed") }, storeLength: "pageview" },
                "Monetate Campaigns": {
                    customJS: function() {
                        var e = "";
                        if (monetate && monetate.campaigns)
                            for (var t = 0; t < monetate.campaigns.length; t++) e.length > 0 && (e += ","), e += monetate.campaigns[t].id + ":" + monetate.campaigns[t].key + ":" + monetate.campaigns[t].split;
                        return e
                    },
                    storeLength: "pageview"
                },
                "Narrow Search Action": { customJS: function() { return lzbDesktopDataLayer.get("narrowSearchAction") }, storeLength: "pageview" },
                "Narrow Search Group Item": { customJS: function() { return lzbDesktopDataLayer.get("narrowSearchGroupItem") }, storeLength: "pageview" },
                "Narrow Search Product Category": { customJS: function() { return lzbDesktopDataLayer.get("narrowSearchProductCategory") }, "default": "Unknown", storeLength: "pageview" },
                "New Vs Returning User": { customJS: function() { return lzbDesktopDataLayer.get("newVsReturnUser") }, storeLength: "session" },
                "Option Details": { customJS: function() { return lzbDesktopDataLayer.get("optionDetails") }, storeLength: "pageview" },
                "Option Price": { customJS: function() { return lzbDesktopDataLayer.get("optionPrice") }, "default": "Standard", storeLength: "pageview" },
                "Order Number": {
                    customJS: function() {
                        return lzbDesktopDataLayer.get("orderNumber")
                    },
                    storeLength: "pageview"
                },
                "Order Price Item One": { customJS: function() { try { $(".order-item").find(".item-price-unit")[0].innerText.match(/\d.*$/)[0].replace(/,/, "") } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Order Price Item Three": { customJS: function() { try { $(".order-item").find(".item-price-unit")[2].innerText.match(/\d.*$/)[0].replace(/,/, "") } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Order Price Item Two": { customJS: function() { try { $(".order-item").find(".item-price-unit")[1].innerText.match(/\d.*$/)[0].replace(/,/, "") } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Order Quantity Item One": { customJS: function() { try { $(".order-item").find(".quantity-hide-for-small")[0].innerText.match(/\d+/)[0] } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Order Quantity Item Three": { customJS: function() { try { $(".order-item").find(".quantity-hide-for-small")[2].innerText.match(/\d+/)[0] } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Order Quantity Item Two": { customJS: function() { try { $(".order-item").find(".quantity-hide-for-small")[1].innerText.match(/\d+/)[0] } catch (e) {} }, "default": "blank", storeLength: "pageview" },
                "Page Name": { customJS: function() { return lzbDesktopDataLayer.get("pageName") }, storeLength: "pageview" },
                "Page Not Found": { customJS: function() { return lzbDesktopDataLayer.get("pageNotFound") }, "default": "page found", storeLength: "pageview" },
                "Page Tab Usage": { customJS: function() { return lzbDesktopDataLayer.get("tabUsage") }, "default": "no tab usage detected", storeLength: "pageview" },
                "Personalization Category": { customJS: function() { return _satellite.getQueryParam("category") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Personalization Email Link": { customJS: function() { return _satellite.getQueryParam("link") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Preferred Store": { cookie: "preferredStoreSet", storeLength: "session", cleanText: !0 },
                "Product Detail Section Opened": { customJS: function() { return lzbDesktopDataLayer.get("productDetailSectionOpened") }, storeLength: "pageview" },
                "Product Page Product Category": { customJS: function() { return $($("a[itemprop='url']")[1]).attr("title") }, storeLength: "pageview", cleanText: !0 },
                "Product Page Product Name": { selector: "h1", property: "text", storeLength: "pageview", cleanText: !0 },
                "Product Quantity": { customJS: function() { return lzbDesktopDataLayer.get("productQuantity") }, storeLength: "pageview" },
                "Product SKU": { customJS: function() { return lzbDesktopDataLayer.get("productSKU") }, storeLength: "pageview" },
                "Product Style and Name": { customJS: function() { return lzbDesktopDataLayer.get("productStyleAndName") }, storeLength: "pageview" },
                "Promotion Viewed": { customJS: function() { return lzbDesktopDataLayer.get("promotionViewed") }, storeLength: "pageview" },
                "Quick Look Product": { customJS: function() { return lzbDesktopDataLayer.get("quickLookProduct") }, storeLength: "pageview" },
                Random: { customJS: function() { t.getElementById("Random"); for (var e = "", n = "0123456789", a = 0; a < 15; a++) e += n.charAt(Math.floor(Math.random() * n.length)); return e }, storeLength: "pageview", cleanText: !0 },
                Referrer: { jsVariable: "window.document.referrer", "default": "unknown", storeLength: "pageview" },
                "Room Inspiration Usage": { customJS: function() { return lzbDesktopDataLayer.get("roomInspirationUsage") }, "default": "no room inspiration used", storeLength: "pageview" },
                "Search Product Clicked": { customJS: function() { return lzbDesktopDataLayer.get("searchProductClicked") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Search Results Amount": { customJS: function() { return lzbDesktopDataLayer.get("searchResultsAmount") }, "default": "0", storeLength: "pageview" },
                "Sectional Option": { customJS: function() { return lzbDesktopDataLayer.get("sectionalOption") }, storeLength: "pageview" },
                "Sectional Piece Name": { customJS: function() { return lzbDesktopDataLayer.get("sectionalPieceName") }, storeLength: "pageview" },
                "Sectional Piece Price": { customJS: function() { return lzbDesktopDataLayer.get("sectionalPiecePrice") }, storeLength: "pageview" },
                "Sectional Piece Style Number": { customJS: function() { return lzbDesktopDataLayer.get("sectionalPieceStyleNumber") }, storeLength: "pageview" },
                Server: { customJS: function() { return lzbDesktopDataLayer.get("server") }, "default": "no server defined", storeLength: "pageview" },
                "Shop By Usage": { customJS: function() { return lzbDesktopDataLayer.get("shopByUsage") }, storeLength: "pageview" },
                "Site Search Term": { customJS: function() { return lzbDesktopDataLayer.get("siteSearchTerm") }, "default": "no search term", storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Site Section": { customJS: function() { return lzbDesktopDataLayer.get("siteSection") }, "default": "no site section", storeLength: "pageview" },
                "Site Sub-Section": { customJS: function() { return lzbDesktopDataLayer.get("siteSubSection") }, "default": "no subsection defined", storeLength: "pageview" },
                SKU: { selector: "data-skuid", property: "innerHTML", storeLength: "pageview" },
                State: { customJS: function() { return lzbDesktopDataLayer.get("userState") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 },
                "Style Number": { customJS: function() { return lzbDesktopDataLayer.get("styleNumber") }, storeLength: "pageview" },
                "Tool Tip Viewed": { customJS: function() { return lzbDesktopDataLayer.get("toolTipViewed") }, storeLength: "pageview" },
                "Top Seller Category": { customJS: function() { return lzbDesktopDataLayer.get("topSellerCategory") }, storeLength: "pageview" },
                "Top Seller Product": { customJS: function() { return lzbDesktopDataLayer.get("topSellerProduct") }, storeLength: "pageview" },
                "User Login Status": { customJS: function() { return lzbDesktopDataLayer.get("userLoginStatus") }, storeLength: "pageview" },
                "User Status": { customJS: function() { return lzbDesktopDataLayer.get("newVsReturnUser") }, storeLength: "pageview" },
                "Video Name": { customJS: function() { return lzbDesktopDataLayer.get("videoName") }, storeLength: "pageview" },
                "Wishlist Cover SKU": { customJS: function() { return lzbDesktopDataLayer.get("wishlistCoverSKU") }, storeLength: "pageview" },
                Zipcode: { customJS: function() { return lzbDesktopDataLayer.get("userZip") }, storeLength: "pageview", forceLowerCase: !0, cleanText: !0 }
            },
            appVersion: "7QN",
            buildDate: "2020-05-14 12:59:26 UTC",
            publishDate: "2020-05-14 12:59:24 UTC"
        })
    }(window, document);