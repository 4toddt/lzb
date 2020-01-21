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

requirejs(['jQuery'], function ($) {

    if ($(document.body).hasClass('mobileSite')) {
        // mobile

        // Put the html of the sticky nav in DMI's header
        $('.ds-topnav').clone().appendTo('header.masthead');

        // Add the id to make it sticky
        $('header.masthead .ds-topnav').attr('id', 'ds-sticky-topnav');

        // Adjust content below header.
        $('.mobileSite #site-wrapper').css('margin-top', $('header.masthead').css('height'));

        // Move the sticky nav as the user scrolls
        $(window).scroll(function () {
            if ($(window).scrollTop() > ($('.ds-topnav:not(#ds-sticky-topnav)').position().top) + ($('.ds-topnav:not(#ds-sticky-topnav) .lzb-button').position().top)) {
                $('#ds-sticky-topnav').css('display', 'block');
            } else {
                $('#ds-sticky-topnav').css('display', 'none');
            }
        });

        //Add Design Stories to breadcrumb
        $("<a href='/mobile/content/design-services/design-stories'>Design Stories</a>").insertAfter(".breadcrumb a:nth-child(2)");

        //Adjust mobile header on resize
        $(window).resize(function () {
            clearTimeout(window.resizedFinished);
            window.resizedFinished = setTimeout(function () {
                // Adjust content below header.
                $('.mobileSite #site-wrapper').css('margin-top', $('header.masthead').css('height'));
            }, 100);
        });
    } else {
        //desktop
        var navHeight = $('.ds-topnav').outerHeight();
        var navTop = $('main').position().top;
        $(window).scroll(function () {
            if ($(window).scrollTop() > navTop) {
                $('.ds-topnav').css('position', 'fixed');
                $('main').css('padding-top', navHeight);
            } else {
                $('.ds-topnav').css('position', 'relative');
                $('main').css('padding-top', 0);
            }
        });

        //Add Design Stories to breadcrumb
        $("<li><a href='/content/design-services/design-stories'>Design Stories</a></li>").insertAfter(".breadcrumb-wrapper li:nth-child(2)");
    }

    // Set Contact Design Services URLs
    $('a.dsr-redirect').each(function () {
        $(this).attr('href', 'http://www.la-z-boystore.com/designer-of-the-period/?id=' + storeID + '&redirect=true');
    });
});
