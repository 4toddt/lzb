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

            $(".make-required").change(function() {
                var inputs = $(this).siblings('div').children('input');
                if (this.checked) {
                    inputs.attr('required', 'true');
                    inputs.removeAttr('disabled');
                } else {
                    inputs.removeAttr('required');
                    inputs.attr('disabled', 'true');
                }
            });
            
            $("input[name='" + $(".show-hidden-sibling").attr('name') + "']").change(function() {
                console.log('change');
                var inputs = $(this).siblings('.hidden-sibling').find('input');
                if ($(this).val() == 'yes') {
                    inputs.removeAttr('disabled');
                } else {
                    inputs.attr('disabled', 'true');
                }
            });

            $('.default-text input').blur(function() {
                if ($(this).val() == "") {
                    $(this).removeClass('filled');
                    //console.log("removed .filled class from " + $(this).attr('name'));
                } else {
                    $(this).addClass('filled');
                    //console.log("added .filled class to " + $(this).attr('name'));
                    // For Design Services Request Zip/Postal code verification
                    if ($(this).filter('#dsr-field5:valid').length) {
                        //console.log("zip format is valid");
                        $.get('https://gallerysiteapi.la-z-boy.com/api/DesignForm/Validate?zipcode=' + $(this).val(), function(data, status) {
                            //console.log("zip code is " + data["Data"]);
                            if (data["Data"] == "Invalid") {
                                if (window.confirm('Unfortunately we do not yet have a La-Z-Boy Furniture Galleries designer in your area. Would you like to find a store near you instead?')) {
                                    window.location.href = 'https://www.la-z-boy.com/storeLocator/storeLocator.jsp';
                                } else {
                                    $('#dsr-field5').val(function(index, val) {
                                        return val + " - no designer";
                                    });
                                }
                            }
                        });
                    }
                }
            });

            $(".aggregate-checkboxes>input:checkbox").change(function() {
                var selectedValues = $(this).parent().children().filter(':checked').map(function() {
                    return this.value;
                }).get().join('; ');
                $(this).siblings('.aggregate').val(selectedValues);
            });

            function offerStoreLocator() {
                // delay to allow for submit button transition
                setTimeout(function() {
                    if (window.confirm('Unfortunately your submission was unsuccessful. Would you like to contact a store near you?')) {
                        window.location.href = 'https://www.la-z-boy.com/storeLocator/storeLocator.jsp';
                    } else {
                        $('.form-button').removeClass('submitted');
                    }
                }, 200);
            }
            $('.form-button').click(function() {
                var currentPage = $("[name='currentPage']:checked").attr('id');
                var invalidInputs = $("." + currentPage + " input:invalid");
                if (invalidInputs.length) {
                    // There are validation issues
                    invalidInputs.addClass('filled');
                    $('html, body').animate({
                        scrollTop: invalidInputs.offset().top - $(".ds-topnav").outerHeight(true) - $("#mobile-header-container").outerHeight(true) - 10
                    }, 500);
                    return false;
                } else {
                    // There are no validation issues
                    if (currentPage == "last-page") {
                        if (!$(this).hasClass('submitted')) {
                            // User hasn't already clicked Submit
                            $(this).addClass('submitted');
                            var currentForm = $(this).closest("form");
                            var formData = currentForm.serialize();
                            if (currentForm.attr('id') == "dsr-form") {
                                // Special submission for Design Services Request form
                                $.post('https://gallerysiteapi.la-z-boy.com/api/DesignForm/Submission', formData, function(response) {
                                        // Hart submission succeeded
                                        // console.log('Hart submission succeeded.');
                                        if (response.Data == "Success") {
                                            $('#confirmation-page')[0].checked = true;
                                            $('html, body').scrollTop(0);
                                            $.post('https://s20103530.t.eloqua.com/e/f2', formData, function() {
                                                    //console.log('Eloqua submission succeeded.');
                                                })
                                                .fail(function() {
                                                    //console.log('Eloqua submission failed.');
                                                });
                                        } else {
                                            console.log('Hart submission validation error: ' + response.Data);
                                            offerStoreLocator();
                                        }
                                    })
                                    .fail(function() {
                                        // console.log('Hart submission http error.');
                                        offerStoreLocator();
                                    });
                            } else {
                                // General Eloqua submission
                                $.post('https://s20103530.t.eloqua.com/e/f2', formData, function() {
                                        // console.log('Eloqua submission succeeded.');
                                        $('#confirmation-page')[0].checked = true;
                                        $('html, body').scrollTop(0);
                                    })
                                    .fail(function() {
                                        // console.log('Eloqua submission failed.');
                                        $('.form-button').removeClass('submitted');
                                    });
                            }
                        }
                    } else {
                        $('html, body').scrollTop($('.' + currentPage + ' .hero').offset().top + $('.' + currentPage + ' .hero').outerHeight(true) - $(".ds-topnav").outerHeight() - $("#mobile-header-container").outerHeight(true));
                        return true;
                    }
                }
            });

        });
    }
})();