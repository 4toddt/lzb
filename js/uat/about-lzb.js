// About LZB navigation structure

var navigation = {
    "Commitment": {
        "Our Commitment": "/content/AboutLaZBoy/corporate-commitment",
        "News Room": "/content/AboutLaZBoy/NewsRoom",
        "Our Brands": "/content/AboutLaZBoy/OurBrands",
        "Supplier Requirements": "/content/AboutLaZBoy/supplier-requirements"
    },
    "Financial": {
        "Financial Responsibility": "/content/AboutLaZBoy/financial-responsibility",
        //"Investor Relations": "/content/AboutLaZBoy/InvestorRelations"
        "Investor Relations": "https://lazboy.gcs-web.com/"
    },
    "Environmental": {
        "Sustainability at a Glance": "/content/AboutLaZBoy/sustainability-at-a-glance",
        "SASB Standards": "/content/AboutLaZBoy/sasb-standards",
        "Environment": "/content/AboutLaZBoy/sustainability",
        "Carbon & Climate": "/content/AboutLaZBoy/carbon-and-climate",
        "Natural Resources": "/content/AboutLaZBoy/natural-resources",
        "Waste & Toxicity": "/content/AboutLaZBoy/waste-and-toxicity"
    },
    "People": {
        "Our Employees": "/content/AboutLaZBoy/investing-in-employees",
        "Leadership": "/content/AboutLaZBoy/leadership",
        "Corporate Giving": "/content/AboutLaZBoy/corporate-giving",
        "Made In America": "/content/AboutLaZBoy/made-in-america",
        "Careers": "/content/AboutLaZBoy/Careers"
    }
}
var pagePath = window.location.pathname.match(/(.*\/mobile)?(.*)/)[2];

// Return HTML for navJSON
function buildNavigation(navJSON) {
    var menu = document.createElement('ul');
    for (navName in navJSON) {
        var navLink = navJSON[navName];
        if (typeof(navLink) === "string") {
            if (navLink === pagePath) {
                menu.innerHTML += '<li><a class="current-page">' + navName + '</a></li>';
            } else { menu.innerHTML += '<li><a href="' + navLink + '">' + navName + '</a></li>'; }
        } else if (typeof(navLink) === "object") {
            var hasCurrentpage = false;
            for (i in navLink) {
                hasCurrentpage = (hasCurrentpage || (navLink[i] === pagePath))
            }
            if (hasCurrentpage) {
                menu.innerHTML += '<li class="parent show-submenu"><a class="current-page">' + navName + '</a>' + buildNavigation(navLink) + '</li>';
            } else {
                menu.innerHTML += '<li class="parent"><a>' + navName + '</a>' + buildNavigation(navLink) + '</li>';
            }
        }
    }
    var temp = document.createElement('div');
    temp.appendChild(menu);
    return temp.innerHTML;
}

function hasClass(ele, cls) {
    if (!!(ele && cls)) {
        var classArr = ele.className.trim().split(/ +/);
        return (classArr.indexOf(cls) > -1);
    } else {
        return null;
    }
}

function addClass(ele, cls) {
    if (ele && cls) {
        var classArr = ele.className.trim().split(/ +/);
        if (classArr.indexOf(cls) == -1) {
            classArr.push(cls);
            ele.className = classArr.join(' ').trim();
        }
    }
}

function removeClass(ele, cls) {
    if (ele && cls) {
        var classArr = ele.className.trim().split(/ +/);
        var index = classArr.indexOf(cls);
        if (index > -1) {
            classArr.splice(index, 1);
            ele.className = classArr.join(' ').trim();
        }
    }
}

function removeClassAll(nodeList, cls) {
    if (nodeList && cls) {
        for (i = 0; i < nodeList.length; i++) {
            removeClass(nodeList[i], cls);
        }
    }
}

function toggleClass(ele, cls) {
    if (hasClass(ele, cls)) {
        removeClass(ele, cls);
    } else {
        addClass(ele, cls);
    }
}

function stopPropagation(evt) {
    if (typeof evt.stopPropagation == "function") {
        evt.stopPropagation();
    } else {
        evt.cancelBubble = true;
    }
}

function myEventListener(el, eventName, handler) {
    if (el.addEventListener) {
        el.addEventListener(eventName, handler);
    } else {
        el.attachEvent('on' + eventName, function() {
            handler.call(el);
        });
    }
}

//Function to remove the modal.
function removeModal() {
    document.body.removeChild(document.getElementById('npc-modal'));
}

// Function to play a video in a modal. Test video is 'P1li3aQv3eQ'.
function videoModal(srcID) {
    var div = document.createElement('div');
    div.innerHTML =
        '<section id="npc-modal" class="video" onclick="removeModal();"><div id="npc-modal-container">\
        <div id="npc-modal-content">\
            <iframe src="https://www.youtube.com/embed/' + srcID + '?rel=0&amp;amp;ecver=2&amp;amp;enablejsapi=1&amp;amp;showinfo=0&amp;amp;autoplay=1" frameborder="0" allowfullscreen></iframe>\
        </div>\
        <img id="npc-modal-close" src="https://www.la-z-boy.com/Images/npc/modal-close.svg">\
    </section>';
    var modal = div.firstChild;

    document.body.insertBefore(modal, document.body.firstChild);

    return false;
}

// Create array of query string values
var params = [],
    hash;
var q = document.URL.split('?')[1];
if (q != undefined) {
    q = q.split('&');
    for (var i = 0; i < q.length; i++) {
        hash = q[i].split('=');
        params.push(hash[1]);
        params[hash[0]] = hash[1];
    }
}


// Writes navigation HTML to page, adds classes and event listeners. Call this within body HTML like this: <nav id="topnav"><script>insertNav();</script></nav>
function insertNavHere() {
    document.write(buildNavigation(navigation));

    var topNav = document.getElementById('topnav');
    var parentLIs = topNav.querySelectorAll('li.parent');
    var parentLinks = topNav.querySelectorAll('li.parent>a');

    for (i = 0; i < parentLinks.length; i++) {
        parentLinks[i].addEventListener('click', function() {
            var evt = evt || window.event; // For IE
            stopPropagation(evt);
            if (hasClass(this.parentNode, 'show-submenu')) {
                removeClass(this.parentNode, 'show-submenu');
            } else {
                removeClassAll(parentLIs, 'show-submenu');
                addClass(this.parentNode, 'show-submenu');
            }
            // menu.style.maxHeight = menu.scrollHeight;
        });
    }
    //open external links in new tab
    for (var links = document.links, i = 0, a; a = links[i]; i++) {
        if (a.host !== location.host) {
            a.target = '_blank';
        }
    }
}

// Removes all stylesheets. Be sure this loads before this page's CSS!
(function() {
    var stylesheeets = document.querySelectorAll('link[rel=stylesheet]');
    for (var i = stylesheeets.length; i--;) {
        stylesheeets[i].parentNode.removeChild(stylesheeets[i]);
    }
}());

var dynamicSheet = document.getElementById('dynamic-sheet');

function runAfterDOM() {
    // Look for .hamburger
    var topNav = document.getElementById('topnav');
    var hamburger = topNav.querySelector('.hamburger');
    var menu = topNav.querySelector('ul');
    // On click
    hamburger.addEventListener("mousedown", function() {
        // Toggle class "show-menu"
        var evt = evt || window.event; // For IE
        evt.preventDefault ? evt.preventDefault() : (evt.returnValue = false);
        if (hasClass(topNav, 'show-menu')) {
            removeClass(topNav, 'show-menu');
        } else {
            addClass(topNav, 'show-menu');
        }
    });

    // Play the video in the query string
    if (params['video'] != null) {
        videoModal(params['video']);
    }

    // Add click and keyboard events to videoModal elements
    var videoLinks = document.querySelectorAll('[videoModal]');
    for (i = 0; i < videoLinks.length; i++) {
        (function() {
            var currentVideoLink = videoLinks[i];
            var srcID = currentVideoLink.getAttribute('videoModal');

            currentVideoLink.setAttribute("tabIndex", "0");

            myEventListener(currentVideoLink, "click", function() {
                videoModal(srcID);
            })

            myEventListener(currentVideoLink, 'keypress', function(event) {
                var code = event.charCode || event.keyCode;
                if ((code === 32) || (code === 13)) {
                    videoModal(srcID);
                }
            });
        })();
    }
}