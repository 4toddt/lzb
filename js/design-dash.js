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
        '<div id="npc-modal" class="video" onclick="removeModal();"><div id="npc-modal-container">\
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

//open links in new tab
var links = document.querySelectorAll("section.cust-support a");
for (var i = 0; i < links.length; i++) {
    links[i].target = "_blank";
}

//display vote modal
function displayVoteModal(blogger) {
    if (displayVoteModal.arguments.length == 1) {
        document.getElementById('field11').value = blogger;
        document.getElementById('form-title-blogger').innerHTML = blogger;
    }
    document.getElementById('vote-modal').style.display = 'block';
    return false;
}

//move vote modal to top of body so it displays correctly on mobile devices
var voteModal = document.getElementById('vote-modal');
if (voteModal != null) {
    document.body.insertBefore(voteModal, document.body.firstChild);
}

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
        $(document).ready(function() {
            //Rendomize Design Dash blogger rooms
            $(function() {
                var roomContainer = $("#dd-blogger-rooms.randomize");
                var rooms = roomContainer.children('div');
                while (rooms.length) {
                    roomContainer.append(rooms.splice(Math.floor(Math.random() * rooms.length), 1)[0]);
                }
                roomContainer.css("display", "block");
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

            // Add click and keyboard events to [toggle-class] elements
            $("[toggle-class]").on('click keypress', function(event) {
                if (accessibleClick(event)) {
                    $(this).toggleClass($(this).attr("toggle-class"));
                }
            });

            // Design Dash slides
            $('.dd-slideshow .thumbnails img').on('click', function(event) {
                $(this).addClass('active').siblings().removeClass('active');
                var position = $(this).index();
                $(this).parent().prev().children().eq($(this).index()).addClass('active').siblings().removeClass('active');
            });

            // Design Dash form validation
            function emptyFieldAlert(theField) {
                theField.val(theField.attr("dd-validation"));
                theField.css("background-color", "#F8DEDE");
                theField.css("font-style", "italic");
            }

            function clearAlert(theField) {
                theField.val("");
                theField.css("background-color", "#f1f1f1");
                theField.css("font-style", "normal");
            }

            function thankYou(theForm) {
                theForm.style.display = 'none';
                document.getElementById('thank-you').style.display = 'block';
                return true;
            }

            $(".validate").focus(function() {
                if ($(this).val() == $(this).attr("dd-validation")) {
                    clearAlert($(this));
                }
            });

            $(".validate").blur(function() {
                if ($(this).val() == "") {
                    emptyFieldAlert($(this));
                }
            });

            $("#vote-modal form").submit(function() {
                var returnVal = true;
                $(".validate").each(function() {
                    if (($(this).val() == "") || ($(this).val() == $(this).attr("dd-validation"))) {
                        emptyFieldAlert($(this));
                        returnVal = false;
                    } else {
                        returnVal = returnVal && true;
                    }
                });
                if (returnVal) {
                    $(this).css("display", "none");
                    $("#thank-you").css("display", "block");
                    // lzbDesktopDataLayer.push({
                    //     'formSubmitted': "DesignDashVotingForm2018"
                    // });
                    // lzbDesktopDataLayer.push({
                    //     'eventPageName': "beneath-my-heart"
                    // });
                    _satellite.track("form_submitted");
                    return true;
                } else {
                    return false;
                }
            });
        });
    }
})();