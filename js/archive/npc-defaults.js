//Set page title
var pageTitle = document.querySelector('section.cust-support>title');
if (pageTitle != null) {
    document.title = pageTitle.innerHTML;
} else {
    pageTitle = document.querySelector('section.cust-support>h1');
    if (pageTitle != null) {
        document.title = pageTitle.innerHTML + ' | La-Z-Boy';
    }
}
//get a cookie
function getCookie(cname) {
    var name = cname + '=';
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return '';
}

//Get preferredStoreSet cookie
var storeID = getCookie('preferredStoreSet');

//Function to remove the modal.
function removeModal() {
    document.body.removeChild(document.getElementById('npc-modal'));
}

// Function to play a video in a modal. Test video is 'P1li3aQv3eQ'.
function videoModal(srcID) {
    var div = document.createElement('div');
    div.innerHTML =
        '<div id="npc-modal" class="video"><div id="npc-modal-container">\
        <div id="npc-modal-content">\
            <iframe src="https://www.youtube.com/embed/' + srcID + '?rel=0&amp;amp;ecver=2&amp;amp;enablejsapi=1&amp;amp;showinfo=0&amp;amp;autoplay=1" frameborder="0" allowfullscreen></iframe>\
        </div>\
        <img id="npc-modal-close" src="https://www.la-z-boy.com/Images/npc/modal-close.svg">\
    </div>';
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

// Play the video in the query string
if (params['video'] != null) {
    videoModal(params['video']);
}

// Function to see if event is a click, enter, or spacebar
function accessibleClick(event) {
    if (event.type === 'click') {
        return true;
    } else if (event.type === 'keypress') {
        var code = event.charCode || event.keyCode;
        if ((code === 32) || (code === 13)) {
            return true;
        }
    } else {
        return false;
    }
}

//Function to create a slideshow from elements within container
function autoSlideshow(container) {
    //CSS opacity transition requires at least 3 child elements
    var seconds = container.lastElementChild.getAttribute("seconds");
    var wait = (seconds === null) ? 2000 : seconds * 1000;
    setTimeout(function() {
        container.insertBefore(container.lastElementChild, container.firstElementChild);
        autoSlideshow(container);
    }, wait);
}

//Auto run on all elements with class="auto-slideshow"
var arrOfSlideshows = document.querySelectorAll("section.cust-support .auto-slideshow");
for (var i = 0; i < arrOfSlideshows.length; i++) {
    autoSlideshow(arrOfSlideshows[i]);
}

//jQuery test using requireJS
// requirejs(['jQuery'], function($) {
// });

//var JQREADY = false;
function jqIsReady() {
    if (typeof $ === "undefined") {
        //if (!JQREADY)
        return false;
    }
    return true;
}

(function jqCheck() {
    if (!jqIsReady()) {
        setTimeout(jqCheck, 10);
        return;
    } else {

        // Set Contact Design Services URLs
        $('a.dsr-redirect').each(function() {
            $(this).attr('href', 'http://www.la-z-boystore.com/designer-of-the-period/?id=' + storeID + '&redirect=true');
        });

        // Add click and keyboard events to videoModal elements
        $("[videoModal]").attr("tabIndex", "0");
        $("[videoModal]").on('click keypress', function(event) {
            if (accessibleClick(event)) {
                videoModal($(this).attr("videoModal"));
            }
        });

        //Scripts for mobileSite
        if (document.getElementsByTagName("body")[0].classList.contains('mobileSite')) {

            function adjustToMobileHeader() {
                if (window.innerHeight > window.innerWidth) {
                    // Device is Landscape. Hide search box.
                    $('body.mobileSite #searchForm').css('display', 'inline-block');
                } else {
                    // Device is Portrait. Show search box.
                    $('body.mobileSite #searchForm').css('display', 'none');
                }
                // Get header height
                headerHeight = $('header.masthead').css('height');
                // Adjust content below header.
                $('.mobileSite #site-wrapper').css('margin-top', headerHeight);
                // Adjust anchors to accommodate header
                $('.mobileSite section.cust-support .anchor').css('top', '-' + headerHeight);
            }

            //Adjust mobile header on load
            $(document).ready(adjustToMobileHeader());

            //Adjust mobile header on resize
            $(window).resize(function() {
                clearTimeout(window.resizedFinished);
                window.resizedFinished = setTimeout(adjustToMobileHeader(), 100);
            });
        }
    }
})();