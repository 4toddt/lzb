// Function to get a cookie
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

//Function to remove the modal.
function removeModal() {
    document.body.removeChild(document.getElementById('npc-modal'));
}

// Function to play a video in a modal. Test video is 'P1li3aQv3eQ'.
function videoModal(srcID) {
    var div = document.createElement('div');
    div.innerHTML =
        '<div id="npc-modal" class="video" onclick="removeModal();">\
            <div id="npc-modal-container">\
                <div id="npc-modal-content">\
                    <iframe src="https://www.youtube.com/embed/' + srcID + '?rel=0&amp;amp;ecver=2&amp;amp;enablejsapi=1&amp;amp;showinfo=0&amp;amp;autoplay=1" frameborder="0" allowfullscreen></iframe>\
                </div>\
                <img id="npc-modal-close" src="https://www.la-z-boy.com/Images/npc/modal-close.svg">\
            </div>\
        </div>';
    var modal = div.firstChild;

    document.body.insertBefore(modal, document.body.firstChild);

    return false;
}

// Function to create a custom modal.
function nonVideoModal(innerHTML) {
    var div = document.createElement('div');
    div.innerHTML =
        '<div id="npc-modal" onclick="removeModal();">\
            <div id="npc-modal-container">\
                <div id="npc-modal-content">' + innerHTML + '</div>\
                <img id="npc-modal-close" src="https://www.la-z-boy.com/Images/npc/modal-close.svg">\
            </div>\
        </div>';
    var modal = div.firstChild;

    document.body.insertBefore(modal, document.body.firstChild);

    return false;
}

// Autoplay video in query string
(function() {
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
})();


// Function returns true if event is a click, enter, or spacebar
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
(function() {
    var arrOfSlideshows = document.querySelectorAll("section.cust-support .auto-slideshow");
    if (arrOfSlideshows[0]) {
        for (var i = 0; i < arrOfSlideshows.length; i++) {
            autoSlideshow(arrOfSlideshows[i]);
        }
    }
})();

// function returns true if jQuery is ready
function jqIsReady() {
    if (typeof $ === "undefined") {
        return false;
    }
    return true;
}

// Auto run once jQuery is ready
(function jqCheck() {
    if (!jqIsReady()) {
        setTimeout(jqCheck, 10);
        return;
    } else {

        // Add click and keyboard events to videoModal elements
        $("[videoModal]").attr("tabIndex", "0");
        $("[videoModal]").on('click keypress', function(event) {
            if (accessibleClick(event)) {
                videoModal($(this).attr("videoModal"));
            }
        });

        // Add click and keyboard events to [toggle-class] elements
        $("[toggle-class]").on('click keypress', function(event) {
            if (accessibleClick(event)) {
                $(this).toggleClass($(this).attr("toggle-class"));
            }
        });

        // Design Services sticky nav
        if ($("section.cust-support .ds-topnav").length) {
            if ($(document.body).hasClass('mobile-site')) {
                // Copy the sticky nav in DMI's header
                $('.ds-topnav').clone().appendTo('#mobile-header-container .masthead-mobile-content');
                $('#mobile-header-container .ds-topnav').attr('id', 'ds-sticky-topnav');
                if ($(window).scrollTop() > (40 + $('.ds-topnav:not(#ds-sticky-topnav) .lzb-button').position().top)) {
                    $('#ds-sticky-topnav').css('display', 'block');
                }
                // Show/hide the sticky nav as the user scrolls
                $(window).scroll(function() {
                    if ($(window).scrollTop() > (40 + $('.ds-topnav:not(#ds-sticky-topnav) .lzb-button').position().top)) {
                        $('#ds-sticky-topnav').css('display', 'block');
                    } else {
                        $('#ds-sticky-topnav').css('display', 'none');
                    }
                });
            } else {
                var navHeight = $('.ds-topnav').outerHeight();
                var navTop = $('main').position().top;
                $(window).scroll(function() {
                    if ($(window).scrollTop() > navTop) {
                        $('.ds-topnav').css('position', 'fixed');
                        $('main').css('padding-top', navHeight);
                    } else {
                        $('.ds-topnav').css('position', 'relative');
                        $('main').css('padding-top', 0);
                    }
                });
            }
        }

        // Set Contact Design Services URLs
        if ($('body.mobile-site').length) {
            $('a.dsr-redirect').each(function() {
                $(this).attr('href', '/mobile/content/design-services/design-request-form');
            });
        } else {
            $('a.dsr-redirect').each(function() {
                $(this).attr('href', '/content/design-services/design-request-form');
            });
        }
    }

})();