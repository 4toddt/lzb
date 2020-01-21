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