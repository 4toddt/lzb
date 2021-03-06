// Control text field label position and size
var inputs = document.getElementsByClassName('move-label');
for (var i = 0; i < inputs.length; i++) {
    input = inputs[i];
    input.onfocus = function() { this.parentElement.className = 'text active'; };
    input.onblur = function() {
        if (this.value == '') {
            this.parentElement.className = 'text';
        } else {
            this.parentElement.className = 'text filled';
        }
    }
    if (input.value == '') {
        input.parentElement.className = 'text';
    } else {
        input.parentElement.className = 'text filled';
    }
}

// jQuery functions
requirejs(['jQuery'], function($) {
    // Limit user to 3 swatches
    $('.swatch>input').on('change', function() {
        if ($('.swatch>input:checked').length > 3) {
            this.checked = false;
        }
    });

    //Tweak mobile header
    //Check if mobileSite
    if (document.getElementsByTagName("body")[0].classList.contains('mobileSite')) {
        //Adjust mobile header on load
        $(document).ready(function() {
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
        $(window).resize(function() {
            clearTimeout(window.resizedFinished);
            window.resizedFinished = setTimeout(function() {
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
    }

    // Use AJAX to submit form
    $(function() {

        // Get the form.
        var form = $('#form80');

        // Get the submit button.
        var submitButton = $('#submit');

        // Set up an event listener for the contact form.
        $(form).submit(function(e) {
            // Stop the browser from submitting the form.
            e.preventDefault();

            // Serialize the form data.
            var formData = $(form).serialize();

            // Submit the form using AJAX.
            $.ajax({
                    type: 'POST',
                    url: $(form).attr('action'),
                    data: formData
                })
                .done(function(response) {

                    // Disable the submit button.
                    document.querySelector('form#form80 input[type=submit]').disabled = true;

                    // Make sure that the submit button has the 'success' class.
                    $(submitButton).removeClass('error');
                    $(submitButton).addClass('success');

                    // Set the message text.
                    $(submitButton).val('Thank you!');

                    // Clear the form.
                    document.getElementById('form80').reset();

                    // Redirect to the success page.
                    window.location.href = 'free-swatches/thank-you';
                })
                .fail(function(data) {
                    // Make sure that the formMessages div has the 'error' class.
                    $(submitButton).removeClass('success');
                    $(submitButton).addClass('error');

                    // Set the message text.
                    $(submitButton).val('Oops! An error occured');
                    // if (data.responseText !== '') {
                    //     $(formMessages).text(data.responseText);
                    // } else {
                    //     $(formMessages).text('Oops! An error occured and your message could not be sent.');
                    // }
                });

        });

    });
});





function jqIsReady() {
    if (typeof $ === "undefined") {
        return false;
    }
    return true;
}

(function jqCheck() {
    if (!jqIsReady()) {
        setTimeout(jqCheck, 10);
        return;
    } else {

        // Limit user to 3 swatches
        $('.swatch>input').on('change', function() {
            if ($('.swatch>input:checked').length > 3) {
                this.checked = false;
            }
        });


        // Use AJAX to submit form
        $(function() {

            // Get the form.
            var form = $('#form80');

            // Get the submit button.
            var submitButton = $('#submit');

            // Set up an event listener for the contact form.
            $(form).submit(function(e) {
                // Stop the browser from submitting the form.
                e.preventDefault();

                // Serialize the form data.
                var formData = $(form).serialize();

                // Submit the form using AJAX.
                $.ajax({
                        type: 'POST',
                        url: $(form).attr('action'),
                        data: formData
                    })
                    .done(function(response) {

                        // Disable the submit button.
                        document.querySelector('form#form80 input[type=submit]').disabled = true;

                        // Make sure that the submit button has the 'success' class.
                        $(submitButton).removeClass('error');
                        $(submitButton).addClass('success');

                        // Set the message text.
                        $(submitButton).val('Thank you!');

                        // Clear the form.
                        document.getElementById('form80').reset();

                        // Redirect to the success page.
                        window.location.href = 'free-swatches/thank-you';
                    })
                    .fail(function(data) {
                        // Make sure that the formMessages div has the 'error' class.
                        $(submitButton).removeClass('success');
                        $(submitButton).addClass('error');

                        // Set the message text.
                        $(submitButton).val('Oops! An error occured');
                        // if (data.responseText !== '') {
                        //     $(formMessages).text(data.responseText);
                        // } else {
                        //     $(formMessages).text('Oops! An error occured and your message could not be sent.');
                        // }
                    });

            });

        });


    }
})();