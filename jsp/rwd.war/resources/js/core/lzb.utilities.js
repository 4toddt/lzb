/* global form2js */

/* Degrade console gracefully */
if (window.console === undefined) {
	window.console = {};
	var logHistory = [];
	window.console.log = function () {
		logHistory.push(arguments);
	};
}
if (window.console === undefined || console.debug === undefined) {
	console.debug = console.log;
}

/* Patch missing Date.now */
if (!Date.now) {
	Date.now = function() { return new Date().getTime(); };
}

(function (global, $, namespace ) {
	"use strict";

	var CONSTANTS = global[namespace].constants,
		utilities = {
		form : {
			validate : function ($form) {
				var isValid;
				$form.validate('validateForm');
				isValid = $form.data('validate').isValid;
				return isValid;
			},
			hideErrors : function ($form) {
				$form.find('.error-box').remove();
				$form.validate('clearFormErrors');
			},
			showErrors : function ($form, errorResponse, $modal, errorTemplate) {

				/* show field errors  */
				if (errorResponse.fieldErrorMessages !== undefined) {
					$form.validate('showFormErrors', errorResponse.fieldErrorMessages);
				}

				/* show form-level errors  */
				if (errorResponse.errorMessages.length > 0) {
					this.showFormErrors($form, errorResponse, errorTemplate);
				}

				if ($modal !== undefined) {
					$modal.modal('show');
				}
			},
			showFormErrors : function($form, errorMessages, errorTemplate){
				var template = errorTemplate || global[namespace].templates.errorMessageTemplate,
						content = Mustache.render(template, errorMessages);
				$form.find('.error-box').remove().end()
						.prepend(content);
				$form.validate('scrollToError', '.error-box');
			},
			showInlineErrors : function (errorObj) {
				var $form = $('#' + errorObj.formId);
				if ($form.length > 0) {
					$form.validate('showFormErrors', errorObj.fieldsWithErrors);
				}
			},
			showSuccessMessage : function($form, response, container){
				var successContainer = container || '.js-success-container',
						$successContent =  $(response.successContent),
						$wrappedResponse = $successContent.filter(successContainer).length > 0 ?  $successContent : $successContent.find(successContainer);
				if ($wrappedResponse.length > 0) {
					$form.closest(successContainer).html($wrappedResponse.html());
				} else {
					$form.closest(successContainer).html($successContent);
				}
			},
			submitFromToProxy : function (formId) {
				var pmData = {form: formId},
						form = document.getElementById(formId),
						formData =  form2js(form);
				pmData = $.extend(pmData, formData);
				pm({
					target: window.frames["proxy"],
					type: "postForm",
					data: pmData
				});
			},
			toggleFormDisable : function toggleFormDisable ($container, isDisabled) {
				$container.find('input, select, textarea').prop('disabled', isDisabled);
			},
			toggleValidation :  function toggleValidation ($container, isEnabled) {
				$container.find('[data-validation]')[isEnabled ? 'removeClass' : 'addClass']('disabled');
			},
			updateFormUrls : function (updateUrlArray, context) {
				var x = 0,
						arrayLen = updateUrlArray.length;
				for (x; x < arrayLen; x++) {
					if (context) {
						$(updateUrlArray[x][0], context).val(updateUrlArray[x][1]);
					} else {
						$(updateUrlArray[x][0]).val(updateUrlArray[x][1]);
					}

				}
			},
			loadProxyIframe : function (e, proxyFormId, showLoader, errorTemplate) {
				if (showLoader) {
					namespace.utilities.showLoader();
				}

				var $form = $(e.target),
						$loginErrors = $form.find('.form-errors');

				//clear any existing errors and validate
				$loginErrors.empty();
				$form.validate('validateForm');

				//listeners for form response
				pm.unbind("formError");
				pm.bind("formError", function (data) {
					namespace.utilities.form.showErrors($form, data.response, null, errorTemplate);
					namespace.utilities.hideLoader();
				});

				pm.unbind("ajaxError");
				pm.bind("ajaxError", function (data) {
					namespace.utilities.form.ajaxError(data.xhr);
				});

				pm.unbind("proxyIsReady");
				pm.bind("proxyIsReady", function (data) {
					namespace.modalProxy.loadingProxy.resolve();
				});

				//if this is valid, send message when loading proxy is ready
				if ($form.data('validate').isValid) {
					namespace.modalProxy.loadingProxy.done(function(){
						namespace.proxy._handleProxySubmit(e, proxyFormId);
					});
				}
				else {
					namespace.utilities.hideLoader();
				}
			},
			ajaxError : function (xhr, statusText, exception, $form) {
				if (xhr.status == '404') {
					window.location.href = CONSTANTS.contextLinkPath + "/global/pageNotFound.jsp";
				} else if (xhr.status == '500') {
					window.location.href = CONSTANTS.contextLinkPath + "/global/serverError.jsp";
				} else {
					var errors = [];
					errors.push(CONSTANTS.ajaxError);
					errors.push(exception);
					this.showFormErrors($form, {'errorMessages': errors});
				}
			}
		},
		sessionTimeoutHandle : null, /* returned from setTimeout, can be used to cancel execution */
		startSessionTimeout : function () {
			if (this.sessionTimeoutHandle) {
				clearTimeout(this.sessionTimeoutHandle);
			}
			this.sessionTimeoutHandle = setTimeout(this.redirectSessionTimeout, CONSTANTS.sessionTimeoutMillis);
		},
		redirectSessionTimeout : function () {
			global[namespace].profileController.clearProfileCookie();
			window.location = CONSTANTS.contextLinkPath + "/";
		},
		imgError : function(image) {
			console.log(['loading error for', image]);
			/* use this to replace the image with not found image when there is an error, if not using an image management
			 service that provides this. */
		},
		getSameProtocolSiteRoot : function () {
			var siteRoot = CONSTANTS.siteRoot;
			if (window.location.protocol == "https:") {
				siteRoot = CONSTANTS.secureSiteRoot;
			}
			return siteRoot;
		},
		removeClass: function (el, className) {
			if (el.classList) {
				el.classList.remove(className);
			} else {
				el.className = el.className.replace(new RegExp('(^|\\b)' + className.split(' ').join('|') + '(\\b|$)', 'gi'), ' ');
			}
		},
		addClass: function (el, className){
			if (el.classList) {
				el.classList.add(className);
			} else {
				el.className += ' ' + className;
			}
		},
		createModal: function(id, modalSize) {
			var modalTemplate = '<div class="modal" id="' + id + '" role="dialog"><div id="overlay" class="modal-backdrop fade" data-dismiss="modal" /><div class="modal-window fade resize" tabindex="-1"><div class="modal-content fade in"></div><div class="modal-close" data-dismiss="modal"><button tabindex="0" role="button"><span class="icon icon-close" aria-hidden="true"></span><span class="sr-only">close</span></button></div><div class="baseline-bar"></div></div></div>';
			if (typeof modalSize !== 'undefined') {
				modalTemplate = '<div class="modal" id="' + id + '" role="dialog"><div id="overlay" class="modal-backdrop fade" data-dismiss="modal" /><div class="modal-window fade resize ' + modalSize + '" tabindex="-1"><div class="modal-content fade in"></div><div class="modal-close" data-dismiss="modal"><button tabindex="0" role="button"><span class="icon icon-close" aria-hidden="true"></span><span class="sr-only">close</span></button></div><div class="baseline-bar"></div></div></div>';
			}
			return $(modalTemplate).appendTo('body');
		},
		addURLParameter : function(url, param, value) {
			var val = new RegExp('(\\?|\\&)' + param + '=.*?(?=(&|$))'),
					qstring = /\?.+$/,
					delimiter = (qstring.test(url)) ? '&' : '?';
			if (val.test(url)) {
				//if the parameter exists, replace the value
				return url.replace(val, '$1' + param + '=' + value);
			} else {
				//otherwise append the parameter to the url
				return url + delimiter + param + '=' + value;
			}
		},
		getURLParameter: function(url, param) {
			if (!url) {
				return null;
			}
			var value,
					query = url.toString(),
					querySplit = url.split('?'),
					hashSplit, queryParams;

			/* get just string past '?' */
			if (querySplit.length >= 2) {
				query = querySplit[1];
			}

			/* eliminate any hash values */
			hashSplit = query.split('#');
			if (hashSplit.length > 1) {
				query = hashSplit[0];
			}

			queryParams = query.split('&');
			for (var x = 0; x < queryParams.length; x++) {
				if (queryParams[x].indexOf( param + '=' ) === 0) {
					value = queryParams[x].split('=')[1];
				}
			}
			if (value === undefined) {
				value = '';
			}
			return value;
		},
		stripURLParameters : function (url, allowedParams) {
			var result = url.split('?')[0],
					x = 0, len = allowedParams.length;

			for (x; x < len; x++) {
				var param = global[namespace].utilities.getURLParameter(url, allowedParams[x]);
				if (param !== '') {
					result = global[namespace].utilities.addURLParameter(result, allowedParams[x], param);
				}
			}
			return result;
		},
		dedup: function(array) {
			var newArray = [],
					seen = {},
					i;

			for (i = 0; i < array.length; i++ ) {
				if ( seen[ array[i] ] ){
					continue;
				}
				newArray.push( array[i] );
				seen[ array[i] ] = 1;
			}
			return newArray;
		},
		decodeHTMLEntities: function(string) {
			// this prevents any overhead from creating the object each time
			var element = document.createElement('div');
			if (string && typeof string === 'string') {
			// strip script/html tags
			string = string.replace(/&amp;/gmi, '&');
			string = string.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
			string = string.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
			element.innerHTML = string;
			string = element.textContent;
			element.textContent = '';
			}
			return string;
		},
		truncateWithEllipses: function(string, max) {
    		return string.substr(0,max-1)+(string.length>max?'&hellip;':'');
		}
	};

	if (!global[namespace]) {
		global[namespace] = {};
	}
	global[namespace].utilities = utilities;

}(this, window.jQuery, "LZB"));


