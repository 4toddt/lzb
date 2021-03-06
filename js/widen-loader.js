var images = document.querySelectorAll('[src*="widen-placeholder.jpg"]');

function widenPath(e) { var a = e.match(/(.*?)(\d+)px\/widen-placeholder\.(?:jpg|png)\??(?:q=\d+)?&?(?:size=(\d+))?/); return a ? a[1] + (a[3] || 10 * a[2]) + "px" : "invalid-url" }

function slugify(e) { return e.toLowerCase().replace(/ /g, "-").replace(/[^\w-]+/g, "") || "no-name" }

function HRSrc(e, a) { return e + "/" + a + ".jpg?q=85" }

function HRSrcset(e, a) { return e + "@2x/" + a + ".jpg?q=50 2x, " + e + "/" + a + ".jpg?q=85 1x" }

function HRSource(e, a) { var t = e.cloneNode(),
        n = widenPath(e.srcset); return t.srcset = HRSrcset(n, a), t }

function loadHRImg(e) { var a = document.createElement("IMG");
    a.id = e.id, a.className = e.className, a.alt = e.alt, a.style.cssText = e.style.cssText, a.onload = function() { e.parentNode.replaceChild(a, e) }; var t = widenPath(e.src),
        n = slugify(e.alt);
    a.srcset = HRSrcset(t, n), a.src = HRSrc(t, n) }

function replaceOnLoad(e, a) { a.onload = function() { e.parentNode.replaceChild(a, e), a.onload = null } }

function loadHRPicture(e) { for (var a = e.getElementsByTagName("SOURCE"), t = e.getElementsByTagName("IMG")[0], n = slugify(t.alt), r = document.createElement("PICTURE"), l = 0; l < a.length; l++) r.appendChild(HRSource(a[l], n)); var c = document.createElement("IMG");
    r.appendChild(c), c.id = t.id, c.className = t.className, c.alt = t.alt, c.onload = function() { e.parentNode.replaceChild(r, e), c.onload = null }; var o = widenPath(t.src);
    c.srcset = HRSrcset(o, n), c.src = HRSrc(o, n) }
for (var i = 0; i < images.length; ++i) "PICTURE" == images[i].parentNode.tagName && window.HTMLPictureElement ? loadHRPicture(images[i].parentNode) : loadHRImg(images[i]);