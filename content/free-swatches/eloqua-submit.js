/**
 * @module eloqua-submit
 * @description initializes eloqua-submit
 * @author Amplifi Commerce Presentation Layer Technology Group hopenthis works
 */

define(
    [
        'core/main',
        'jQuery'
    ],

    function(

        ampBase,
        $

    ) {

        return (

            function(module) {

                module.defaults = {};

                module.setName('eloqua-submit');

                module.setup = function() {

                    var defaults = {};

                    var config = {};
                    var elequaFormID = ($(this.elem).prop('nodeName') == 'FORM') ? $(this.elem).attr('id') : $(this.elem).find('form').attr('id');
                    var postData = $('#' + elequaFormID).serializeArray();
                    //console.log('eloqua nodename = ' + $(this.elem).prop('nodeName'));
                    //console.log('eloqua formId = ' + elequaFormID);
                    function postIt() {
                        $.post('https://s20103530.t.eloqua.com/e/f2', $('#' + elequaFormID).serialize());
                    }

                    $('#createuser', this.elem).on('click', function(e) {
                        e.preventDefault();
                        if ($(this.elem).prop('nodeName') !== 'FORM') {
                            postIt();
                            window.setTimeout(function() { $('#' + elequaFormID).submit(); }, 1000);
                        } else {
                            postIt();
                        }
                    });

                    $('#catalogRequestSubmit').on('click', function(e) {
                        e.preventDefault();
                        if ($(this.elem).prop('nodeName') !== 'FORM') {
                            $.post('https://s20103530.t.eloqua.com/e/f2', $('#catalogRequest').serialize());
                            window.setTimeout(function() { $('#catalogRequest').submit(); }, 1000);
                        } else {
                            postIt();
                        }
                    });

                    $('#emailSignup', this.elem).on('click', function(e) {
                        e.preventDefault();
                        if ($(this.elem).prop('nodeName') !== 'FORM') {
                            $.post('https://s20103530.t.eloqua.com/e/f2', $('#emailSignUpForm').serialize());
                            //window.setTimeout(function(){$('#emailSignUpForm').submit();}, 1000);
                        } else {
                            postIt();
                        }
                    });

                    $('#sendSwatches', this.elem).on('click', function(e) {
                        e.preventDefault();
                        if ($(this.elem).prop('nodeName') !== 'FORM') {
                            // postIt(); I replaced postIt() with the line below - TT
                            $.post('https://s20103530.t.eloqua.com/e/f2', $('form#80').serialize());
                            window.setTimeout(function() {
                                $('[name="formSubmitter"]').click();
                            }, 1000);
                        } else {
                            postIt();
                        }
                    });
                }; /* module.setup */

                return module;

            }(Object.create(ampBase))

        );

    }

);