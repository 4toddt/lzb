/*!
 * Account Init
 */
(function (global, $, namespace) {

    var loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
    	CONSTANTS = global[namespace].constants,
		$body = $('body');
    
 // form handler options
	var basicAjaxOptions = {
		dataType : 'json',
		beforeSerialize : function($form) {
		},
		beforeSubmit : function(arr, $form, options) {
			global[namespace].loader.showLoader();
		},
		success: function(responseText, statusText, xhr, $form) {
			if (statusText == 'success') {
				if (responseText.success == 'true') {
					window.location = responseText.url;
				}
				else {
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.showErrors($form, responseText);
				}
			}
			else {
				console.log('Malformed JSON : missing statusText parameter:');
				global[namespace].loader.hideLoader();
				global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
			}
		},
		error: function(xhr, statusText, exception, $form) {
			console.log('AJAX Error:');
			global[namespace].loader.hideLoader();
			global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
		}
	};

    var account = {
        init : function () {
        	
        },
        login: function() {
        	$('.sign-in-form').ajaxForm(basicAjaxOptions);
        },
        profile: function() {
			$('.hide-message, .close-message').on('click', this.elem, function(e){
				$('.alert-box').remove();
			});
        	
        	$('#profileupdate').ajaxForm(basicAjaxOptions);
        },
        register : function() {
        	$('#registerUser').ajaxForm(basicAjaxOptions);
        },
        deactivateAccount : function() {
        	$('[name="reason"]').on('click', this.elem, function(){
				var thisVal = $(this).val();
				if(thisVal === 'Others'){
					$('.text-area').show();
				} else {
					$('.text-area').hide();
				}
			});
        	
        	$('#deactivateAccount').ajaxForm(basicAjaxOptions);
        },
        preferredStore : function() {
        	var storeLocatorOptions = {
					dataType : 'json',
					beforeSerialize : function($form) {
					},
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {

						if (statusText == 'success') {
							if (responseText.success == 'true') {
								global[namespace].loader.hideLoader();
								//$('.modal').modal('hide');
								//var $modalTarget = document.getElementById('storeLocatorModal') ? $('#storeLocatorModal') : global[namespace].utilities.createModal('storeLocatorModal', 'medium'),
								//		url = CONSTANTS.contextPath + '/account/ajax/storeLocatorListModal.jsp?stores=' + responseText.stores,
								//		option = {'url': url};
								//$modalTarget.modal(option);
								$('.store-location-results').html(Mustache.render(global[namespace].templates.storeResultsListTemplate, responseText));
								$('#storeInfoContainer').addClass('hide');
							}
							else {
								global[namespace].loader.hideLoader();
								global[namespace].utilities.form.showErrors($form, responseText);
							}
						}
						else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
						}
					},
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				};
        	
        	var changeStoreOptions = {
					dataType : 'json',
					beforeSerialize : function($form) {
					},
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {

						if (statusText == 'success') {
							if (responseText.success == 'true') {
								window.location = responseText.url;
							}
							else {
								global[namespace].loader.hideLoader();
								global[namespace].utilities.form.showErrors($form, responseText);
							}
						}
						else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
						}
					},
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				};
        	
        	$('#storeLocator').ajaxForm(storeLocatorOptions);
        	
        	$('body').on('click', '.make-this-store', function(e){
				e.preventDefault();
				var $this = $(this);
				var storeId = $this.data('change-store-id'),
					changeType = $this.data('change-type');
				if(changeType == 'change'){
					$('#change-store-id').val(storeId);
					$('#changeStore').ajaxSubmit(changeStoreOptions);
				}else{
					$('#prefer-store-id').val(storeId);
					$('#preferredStore').ajaxSubmit(changeStoreOptions);
				}
			});
        },
        wishList : function() {
			//$('#updateZipCodeBtn').on('click', this.elem, function(e){
			//	e.preventDefault();
			//	var zipCode= $('.zip-input').val();
			//	$('#zipCodeId').val(zipCode);
			//});
			$('#changeDealer').ajaxForm(basicAjaxOptions);
			
			// ajax form handler
			var addItemOptions = {
				dataType : 'json',
				beforeSubmit : function(arr, $form, options) {
					global[namespace].loader.showLoader();
				},
				success: function(responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							
						}
						else {
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.showErrors($form, responseText);
						}
					}
					else {
						console.log('Malformed JSON : missing statusText parameter:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
					}
				},
				error: function(xhr, statusText, exception, $form) {
					console.log('AJAX Error:');
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			};
			
			
			// ajax form handler
			var removeItemOptions = {
				dataType : 'json',
				beforeSubmit : function(arr, $form, options) {
					global[namespace].loader.showLoader();
				},
				success: function(responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							if (responseText.wishListCount > 0) {
								$('.wishlist-item-count').html(responseText.wishListCount > 1 ? responseText.wishListCount + ' items' : responseText.wishListCount + ' item');
								var removeItem = $form.find('#wishlistItemIdToRemove').val();
								if(removeItem != ''){
									$('#wishlist-item_'+removeItem).slideUp(200);
								}
								global[namespace].loader.hideLoader();
							}
							else {
								// cart is empty, show appropriate message
								$('.wish-list-content').load(CONSTANTS.contextPath + '/account/fragments/wishListEmpty.jspf');
								global[namespace].loader.hideLoader();
							}
						}
						else {
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.showErrors($form, responseText);
						}
					}
					else {
						console.log('Malformed JSON : missing statusText parameter:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
					}
				},
				error: function(xhr, statusText, exception, $form) {
					console.log('AJAX Error:');
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			};
			
			$('.add-to-cart').on('click', this.elem, function(e){
				e.preventDefault();
				var giftListId= $(this).data('giftlistid');
				$('#wishlistItemIdToAddOrder').val(giftListId);
				$('#addItemToCartFromWishlist').ajaxSubmit(addItemOptions);
			});
			
			$('.remove-item-from-wishlist').on('click', this.elem, function(e){
				e.preventDefault();
				var giftListId= $(this).data('giftlistid');
				$('#wishlistItemIdToRemove').val(giftListId);
				$('#removeSelectedItemFromWishList').ajaxSubmit(removeItemOptions);
			});
			
        }

    };

    global[namespace] = global[namespace] || {};

	global[namespace].account = account;

})(this, window.jQuery, "LZB");