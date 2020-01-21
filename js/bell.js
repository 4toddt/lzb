//function to check if jQuery is ready
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
        // Make images followed by links clickable
        $(document).ready(function() {
            $('#bcc-content .image~a').siblings(".image").addClass('clickable').click(function() {
                $(this).siblings('a')[0].click();
            });
        });
        // Make images containing links clickable
        $(document).ready(function() {
            $('#bcc-content .image>a').parent().addClass('clickable').click(function() {
                $(this).children('a')[0].click();
            });
        });



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
            var arrOfSlideshows = document.querySelectorAll("#bcc-content .auto-slideshow");
            if (arrOfSlideshows[0]) {
                for (var i = 0; i < arrOfSlideshows.length; i++) {
                    autoSlideshow(arrOfSlideshows[i]);
                }
            }
        })();
    }
})();