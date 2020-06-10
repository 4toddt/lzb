var images = document.querySelectorAll('[src*="widen-placeholder.jpg"]');

function widenPath(URL) {
    var match = URL.match(/(.*?)(\d+)px\/widen-placeholder\.(?:jpg|png)\??(?:q=\d+)?&?(?:size=(\d+))?/);
    if (match) {
        return (match[1] + (match[3] || (match[2] * 10)) + 'px');
    } else {
        return 'invalid-url';
    }
}

function slugify(phrase) {
    return phrase.toLowerCase().replace(/ /g, '-').replace(/[^\w-]+/g, '') || "no-name";
}

function HRSrc(path, name) {
    return path + "/" + name + ".jpg?q=85";
}

function HRSrcset(path, name) {
    return path + "@2x/" + name + ".jpg?q=50 2x, " + path + "/" + name + ".jpg?q=85 1x";
}

function HRSource(lowResSource, name) {
    var highResSource = lowResSource.cloneNode();
    var path = widenPath(lowResSource.srcset);
    highResSource.srcset = HRSrcset(path, name);
    return highResSource;
}

function loadHRImg(lowRes) {
    var highRes = document.createElement("IMG");
    highRes.id = lowRes.id;
    highRes.className = lowRes.className;
    highRes.alt = lowRes.alt;
    highRes.style.cssText = lowRes.style.cssText;
    highRes.onload = function() {
        lowRes.parentNode.replaceChild(highRes, lowRes);
    };
    var path = widenPath(lowRes.src);
    var name = slugify(lowRes.alt);
    highRes.srcset = HRSrcset(path, name);
    highRes.src = HRSrc(path, name);
}

function replaceOnLoad(oldEle, newEle) {
    newEle.onload = function() {
        oldEle.parentNode.replaceChild(newEle, oldEle);
        newEle.onload = null;
    }
}

function loadHRPicture(lowResPic) {
    var lowResSources = lowResPic.getElementsByTagName("SOURCE");
    var lowResImg = lowResPic.getElementsByTagName("IMG")[0];
    var imgName = slugify(lowResImg.alt);
    var highResPic = document.createElement("PICTURE");
    for (var j = 0; j < lowResSources.length; j++) {
        highResPic.appendChild(HRSource(lowResSources[j], imgName));
    }
    var highResImg = document.createElement("IMG");
    highResPic.appendChild(highResImg);
    highResImg.id = lowResImg.id;
    highResImg.className = lowResImg.className;
    highResImg.alt = lowResImg.alt;
    highResImg.onload = function() {
        lowResPic.parentNode.replaceChild(highResPic, lowResPic);
        highResImg.onload = null;
    };
    var imgPath = widenPath(lowResImg.src);
    highResImg.srcset = HRSrcset(imgPath, imgName);
    highResImg.src = HRSrc(imgPath, imgName);
}

for (var i = 0; i < images.length; ++i) {
    if (images[i].parentNode.tagName == "PICTURE" && window.HTMLPictureElement) {
        loadHRPicture(images[i].parentNode);
    } else {
        loadHRImg(images[i]);
    }
}