
//Tweak mobile header
//Check if mobileSite
if (document.getElementsByTagName("body")[0].classList.contains('mobileSite')) {
    //Wait for jQuery to load
    requirejs(['jQuery'], function ($) {
        //Adjust mobile header on load
        $(document).ready(function () {
            if (window.innerHeight > window.innerWidth) {
                // Device is Landscape. Hide search box.
                $('body.mobileSite #searchForm').css('display', 'inline-block');
            } else {
                // Device is Portrait. Show search box.
                $('body.mobileSite #searchForm').css('display', 'none');
            }
            // Adjust content below header.
            $('.mobileSite #site-wrapper').css('margin-top', $('header.masthead').css('height'));
        });
        //Adjust mobile header on resize
        $(window).resize(function () {
            clearTimeout(window.resizedFinished);
            window.resizedFinished = setTimeout(function () {
                if (window.innerHeight > window.innerWidth) {
                    // Device is Landscape. Hide search box.
                    $('body.mobileSite #searchForm').css('display', 'inline-block');
                } else {
                    // Device is Portrait. Show search box.
                    $('body.mobileSite #searchForm').css('display', 'none');
                }
                // Adjust content below header.
                $('.mobileSite #site-wrapper').css('margin-top', $('header.masthead').css('height'));
            }, 100);
        });
    });
}
