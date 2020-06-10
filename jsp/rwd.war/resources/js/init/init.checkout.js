/*!
 * Checkout Init
 */
(function (global, $, namespace) {
	//"use strict";

	var loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
		utilities = global[namespace].utilities,
		CONSTANTS = global[namespace].constants,
		$body = $('body');

	var checkout = {
		init : function () {
			// set session timeout
			utilities.startSessionTimeout();

			// Help dropdown
			$body.on('click', '.help-bubble', function(e){
				e.preventDefault();
				$('.help-info').toggleClass('hide');
				$('.help-icon').toggleClass('icon-arrow-down');
				$('.help-icon').toggleClass('icon-close');
				return false;
			});

			/* Keyboard Accessible Event for Help dropdown */
			$body.on('keydown', '.help-bubble', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				if (keycode === 13) {
					e.preventDefault();
					$(this).trigger('click');
				}
			});
			
			//hide the help overlay when click on out side
			$(document).on('click', function (event) {
			  if (!$(event.target).closest('.header-help-content-container, .help-info-content').length) {
			    // ... clicked on the 'body', but not inside of help overlay
				  $('.checkout-help-wrapper .header-help-content-container').hide();
				  $('.help-info').addClass('hide');
				  $('.help-icon').addClass('icon-arrow-down').removeClass('icon-close');
			  }else{
				  return true;
			  }
			});
			
			// Click Help button on Checkout page header 
			$('.checkout-header').on('click', 'a.header-help-link', function (e) {
				e.preventDefault();
				$('.checkout-help-wrapper .header-help-content-container').show();
				return false;
			});
			
			// CLose Help section on Checkout page header
			$('.checkout-help-wrapper').on('click', '.header-help-content-container .icon-close', function (e) {
				$('.checkout-help-wrapper .header-help-content-container').hide();
			});
		},
		cart : function() {
			// remove click for cart icon on cart page
			$('a.js-cart-link').removeAttr('href');
			
			var updateCartItemOptions = {
				dataType: 'json',
				beforeSubmit: function (arr, $form, options) {
					global[namespace].utilities.form.hideErrors($form);
					global[namespace].loader.showLoader();
				},
				success: function (responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							global[namespace].loader.hideLoader();
							
							if (responseText.orderTotals.cartCount > 0) {
								$.each(responseText.cartItems, function (index) {
									var $itemPrice = $('#item-price-' + this.commerceItemId);
									var $itemProtectionPlan = $('#item-protection-plan-' + this.commerceItemId);
									
									if ($itemPrice.length > 0) {
										if (this.salePriceRaw != '0.0') {
											// item is on sale
											$itemPrice.find('.price').html(Mustache.render(LZB.templates.cartItemOnSalePrice, this));
										} else {
											$itemPrice.find('.price').html(Mustache.render(LZB.templates.cartItemPrice, this));
										}
										
										if ($itemProtectionPlan.length > 0) {
											
											// Plan already added, update total plan price
											if ($itemProtectionPlan.find('.total-plan-price').length > 0) {
												$itemProtectionPlan.find('.total-plan-price').html(this.totalPlanPrice);
											}
											
											// add or remove plan
											var commerceIdForPlan = $('#addPlan #confId').val();
											
											if (this.commerceItemId == commerceIdForPlan) {
												
												if ($('#treat_' + commerceIdForPlan).hasClass('js-add-plan')) {
													// Adding protection plan
													$itemProtectionPlan.html(Mustache.render(LZB.templates.addProtectionPlan, this));
												} else {
													// Removing protection plan
													$itemProtectionPlan.html(Mustache.render(LZB.templates.removeProtectionPlan, this));
												}
												
												// reset hidden fields values
												$('#addPlan #confId').val('');
										      	$('#addPlan #planQuantity').val('');
											}
										}
									}
								});
								$('.payment-amount').text(responseText.financingCost.monthlyPrice);
								$('.financing-months').text(responseText.financingCost.financingMonths);
								updateOrderTotals(responseText);
								updateDeposit(responseText);
							}
						} else { // responseText.success is false
							global[namespace].loader.hideLoader();
							// the UI should display the prior qty. It is retaining the qty that failed the validation
							/*for (var i = 0; i < responseText.quantities.length; i++) {
								var qtyI = responseText.quantities[i];
								$('input[name="' + qtyI.itemId + '"], #dummy-' + qtyI.itemId).val(qtyI.qty);
							}*/

							global[namespace].utilities.form.showErrors($form, responseText);
						}
					}
				},
				error: function (xhr, statusText, exception, $form) {
					console.log('AJAX Error: ' + exception);
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			},
			cartCheckoutFormOptions = {
				dataType: 'json',
				beforeSubmit: function (arr, $form, options) {
					global[namespace].utilities.form.hideErrors($form);
					global[namespace].loader.showLoader();
				},
				success: function (responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							global[namespace].loader.hideLoader();
							// Redirect user to login or checkout page
							window.location = responseText.redirectURL;
						} else {
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
				error: function (xhr, statusText, exception, $form) {
					console.log('AJAX Error: ' + exception);
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			},
			digitalBuyShippingFormOptions = {
				dataType: 'json',
				beforeSubmit: function (arr, $form, options) {
					global[namespace].utilities.form.hideErrors($form);
					global[namespace].loader.showLoader();
				},
				success: function (responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							global[namespace].loader.hideLoader();
							// Redirect user to checkout page
							window.location = responseText.redirectURL;
						} else {
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
				error: function (xhr, statusText, exception, $form) {
					console.log('AJAX Error: ' + exception);
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			};
			
			function updateCartItems(e) {
				// Populate the updateCommerceId and itemQuantity input with the current id being changed
				$('#updateCommerceItemId').val($(e.target).data('ciid'));
				$('#itemQuantity').val($(e.target).val());

				$('#updateCartItemQty').ajaxSubmit(updateCartItemOptions);
			}
			
			function updatePlan(e, action) {
				var $itemProtectionPlan = $(e.target).closest('.item-protection-plan'),
					commerceItemId = $(e.target).data('ciid'),
					quantity = $('#item-qty-' + commerceItemId).val();

				$('#addPlan #confId').val(commerceItemId);
		      	$('#addPlan #planQuantity').val(quantity);
		      	
		      	if (action == 'add') {
		      		$('#addPlan #removePlan').val("false");
					$itemProtectionPlan.removeClass('unapplied');
		      	} else {
		      		$('#addPlan #removePlan').val("true");
					$itemProtectionPlan.addClass('unapplied');
		      	}
		      	
				$('#addPlan').ajaxSubmit(updateCartItemOptions);
			}
			
			// Update item quantity in cart
			$body.on('change', '.item-qty-value', function(e) {
				updateCartItems(e);
			});
			
			// Add or remove protection plan
			$body.on('click', '.item-protection-plan .add-remove-plan', function(e) {
				var action;
				e.preventDefault();
				if ($(this).hasClass('js-add-plan')) {
					action = 'add';
				} else {
					action = 'remove';
				}
				
				updatePlan(e, action);
			});
			
			// Proceed to checkout
			$body.on('click', '.to-checkout-btn', function(e) {
				e.preventDefault();
				$("#cartCheckoutForm").ajaxSubmit(cartCheckoutFormOptions);
			});
			
			// Proceed to Pay With DigitalBuy from Cart
			$body.on('click', '.to-digitalbuy-btn', function(e) {
				e.preventDefault();
				
				$.ajax({
					url: CONSTANTS.contextPath + '/checkout/json/digitalBuyToken.jsp',
					type: 'post',
					success: function (data) {
						$('#tokenId').val(data.token);
						
						var JSONObject = {};
						
						JSONObject.processInd = $('#processInd').val();
						JSONObject.tokenId = data.token;
						JSONObject.merchantID = $('#merchantID').val();
						JSONObject.clientTransId = $('#clientTransId').val();
						    
						syfDBuy.calldBuyProcess(null, JSONObject);
					},
					error: function (data) {
						console.log('AJAX Error:' + data);
					}
				});
			});
			
			// Detect Synchrony modal close and redirect to checkout page
			window.addEventListener("message",function(event) {
				if (typeof event.data == 'string' && event.data == 'Return To Merchant Shipping') {
					console.log('SYNCHRONY MODAL CLOSED', event.data);
					$('#digital-buy-shipping').ajaxSubmit(digitalBuyShippingFormOptions);
				}
			});
		},
		login : function() {
			var checkoutLoginOptions = {
				dataType : 'json',
				beforeSerialize : function($form) {
					$form.validate('validateForm');
					return $form.data('validate').isValid;
				},
				beforeSubmit : function(arr, $form, options) {
					global[namespace].utilities.form.hideErrors($form);
					global[namespace].loader.showLoader();
				},
				success: function(responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						if (responseText.success == 'true') {
							if (responseText.cartMerged == 'true') {
								window.location = '/rwd/checkout/cart.jsp?cartMerged=true';
							} else {
								// no errors, log in
								window.location = '/rwd/checkout/checkout.jsp?loginStatus=true';
							}
						} else {
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.showErrors($form, responseText);
						}
					} else {
						console.log('Malformed JSON : missing statusText parameter:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
					}
				},
				error: function (xhr, statusText, exception, $form) {
					console.log('AJAX Error: ' + exception);
					global[namespace].loader.hideLoader();
					global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
				}
			};
			
			$('#checkout-login-form').ajaxForm(checkoutLoginOptions);
		},
		checkout : function() {
			var $checkoutShippingSection = $('.checkout-shipping'),
				$checkoutPaymentSection = $('.checkout-payment'),
				$checkoutReviewSection = $('.checkout-review'),
				$shippingAddressFormPanel = $('.shipping-address-form-panel'),
				$shippingAddressReviewPanel = $('.shipping-address-review-panel'),
				$shippingAddressForm = $('#shipping-address-form'),
				$paymentFormPanel = $('.payment-form-panel'),
				$paymentReviewPanel = $('.payment-review-panel'),
				$reviewContent = $('.checkout-review .js-info-content'),
				$commitOrderForm = $('#commit-order-form'),
				$billingAddress = $('.billing-address'),
				$paymentForm = $('#paymentForm'),
				$reviewPanel = $('.review-panel'),
				$checkoutStep = $('.js-checkout-step'),
				
				// Delivery step shipping address form submit option
				shippingAddressFormOptions =  {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							global[namespace].loader.hideLoader();
							
							if (responseText.success == 'true') {
								// mark step as complete
								$checkoutShippingSection.removeClass('in-progress').addClass('complete');
								
								// update progress bar to highlight next step
								updateProgressBar('checkout-payment');
								
								// close shipping form and show review panel
								$shippingAddressFormPanel.slideUp(250, function(){
									$shippingAddressReviewPanel.html(responseText.content.shippingSummary);
									$shippingAddressReviewPanel.slideDown();
									
									$checkoutPaymentSection.removeClass('not-started').addClass('in-progress').slideDown();
									$paymentForm.show();
								});	
								
								updateOrderSummary();
								
							} else {
								global[namespace].utilities.form.showErrors($form, {'errorMessages': responseText.errorMessages});
							}
						} else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
						}
					},
					error: function (xhr, statusText, exception, $form) {
						console.log('AJAX Error:' + exception);
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				},
				changedDeliveryChargeFormOptions =  {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							global[namespace].loader.hideLoader();
							if (responseText.success == 'true') {
								$('#change-delivery-charge-modal .modal-close').click();
								
								// mark step as complete
								$checkoutShippingSection.removeClass('in-progress').addClass('complete');
								
								// update progress bar to highlight next step
								updateProgressBar('checkout-payment');
								
								// close shipping form and show review panel
								$shippingAddressFormPanel.slideUp(250, function(){
									$shippingAddressReviewPanel.html(responseText.content.shippingSummary);
									$shippingAddressReviewPanel.slideDown();
									
									$checkoutPaymentSection.removeClass('not-started').addClass('in-progress').slideDown();
									$paymentForm.show();
								});	
								
								//updateOrderSummary();
								$('.order-items').load(CONSTANTS.contextPath + '/checkout/includes/checkoutOrderItems.jsp', function() {
									  $('.checkout-order-summary-accordion .number-of-items').html($('.cart-item-count').html());
								});
								
							} else {
								global[namespace].utilities.form.showErrors($form, {'errorMessages': responseText.errorMessages});
							}
						} else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
						}
					},
					error: function (xhr, statusText, exception, $form) {
						console.log('AJAX Error:' + exception);
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				},
				// Delivery step shipping address form submit option
				paymentFormOptions =  {
					dataType : 'json',
					beforeSerialize : function($form) {
						// Only check credit card fields if user is not using DigitalBuy options
						var useDigitalBuy = $('#useDigitalBuy').text();
						
						if (useDigitalBuy == 'false') {
							var ccExpDateVal0 = $('#ccExpDate0').val();
							$('#cardExpMonth0').val(ccExpDateVal0.substring(0,2).replace(/^0+(?!\.|$)/, ''));
							$('#cardExpYear0').val('20' + ccExpDateVal0.substring(3));
						
							// There is split payment
							if ($('#ccExpDate1').val()) {
								var ccExpDateVal1 = $('#ccExpDate1').val();
								$('#cardExpMonth1').val(ccExpDateVal1.substring(0,2).replace(/^0+(?!\.|$)/, ''));
								$('#cardExpYear1').val('20' + ccExpDateVal1.substring(3));
							}
						}
			
						// Billing address same as shipping address
						if ($('#useDeliveryAddress').is(':checked')) {
							$form.find('#shipToBill').val('true');
							updateBillingAddressForm(true, 0);
						} else {
							$form.find('#shipToBill').val('false');
							updateBillingAddressForm(false, 0);
						}
						
						if (useDigitalBuy == 'false') {
							// Billing address same as shipping address for second billing address
							if ($('#useDeliveryAddress2').is(':checked')) {
								$form.find('#shipToBill').val('true');
								updateBillingAddressForm(true, 1);
							} else {
								$form.find('#shipToBill').val('false');
							}
							
							// Set splitPayment flag so 2 sets of credit card info can be submitted
							if ($('#splitPaymentCheckbox').is(':checked')) {
								$form.find('#splitPayment').val('true');
							} else {
								$form.find('#splitPayment').val('false');
							}
							
							$form.find('#usingDigitalBuy').val(false);
						} else {
							$form.find('#usingDigitalBuy').val(true);
						}
					},
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							global[namespace].loader.hideLoader();
							
							if (responseText.success == 'true') {
								// mark step as complete
								$checkoutPaymentSection.removeClass('in-progress').addClass('complete');
								
								// update progress bar to highlight next step
								updateProgressBar('checkout-review');
								
								// close payment form and show review panel
								$paymentFormPanel.slideUp(250, function(){
									$paymentReviewPanel.html(responseText.content.paymentSummary);
									$paymentReviewPanel.slideDown();
									
									// ajax call to retrieve Review content based on payment type
									$checkoutReviewSection.load(CONSTANTS.contextPath + '/checkout/includes/orderReview.jsp?useDigitalBuyPayment=' + $('#useDigitalBuy').text(), function() {
										$checkoutReviewSection.removeClass('not-started').addClass('in-progress').slideDown();
										$('.review-panel').show();
										$('.checkout-review .js-info-content').show();
									});
								});	
								
							} else {
								global[namespace].utilities.form.showErrors($form, {'errorMessages': responseText.errorMessages});
							}
						} else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
						}
					},
					error: function (xhr, statusText, exception, $form) {
						console.log('AJAX Error:' + exception);
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				},
				// Review step place order form submit option
				placeOrderOptions =  {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(data, statusText, xhr, $form) {
						global[namespace].loader.hideLoader();
						
						if (data.success == 'true') { // Commit order form came back success. Redirect user to order confirmation page
							window.location = "/rwd/checkout/orderConfirmation.jsp";
						} else {
							// Check if the first error message has empty string, which is from DigitalBuy from Customer Terminating DigitalBuy modal
							if (data.errorMessages[0].trim().length > 3) {
								global[namespace].utilities.form.showErrors($form, {'errorMessages': data.errorMessages});
							}
						}
					},
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:' + exception);
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}
				};
			
			// Open Special Delivery Instruction textarea
			$checkoutShippingSection.on('change', '#shippingAddrInstruction', function(e) {
				$this = $(this);
				if ($this.prop('checked')) {
					$('.specialDeliveryInstructions').show();
			    } else {
			    	$('#shippingAddrInstructionDetails').val('');
			    	$('.specialDeliveryInstructions #textCount').text('0'); 
			    	$('.specialDeliveryInstructions').hide();
			    }
			});
			
			// Character count for Special Delivery Instruction textarea
			$checkoutShippingSection.on('input propertychange', '#shippingAddrInstructionDetails', function(e) {
				 var len = $(this).val().length; 
				 $('.specialDeliveryInstructions #textCount').text(len); 
			});

			// Click Continue To Payment button on Checkout page shipping section
			$checkoutShippingSection.on('click', '.shipping-continue', function(e) {
				e.preventDefault();
				$shippingAddressForm.validate('validateForm');

				if ($shippingAddressForm.data('validate').isValid) {
					var zipCode = $('#shippingAddrZip').val();
					var orderId = $('#orderId').text();

					$.ajax({
						url: CONSTANTS.contextPath + '/checkout/ajax/changeDeliveryAjax.jsp?postalCode=' + zipCode + '&orderId=' + orderId,
						type: 'post',
						success: function (data) {
							if (data.success) {
								if (data.zipCode == '') {
									// Zip code validation passes, continue with submitting shipping address form
									$shippingAddressForm.ajaxSubmit(shippingAddressFormOptions);
								} else {
									// Open delivery charge changed modal
									var $modalTarget = document.getElementById('change-delivery-charge-modal') ? $('#change-delivery-charge-modal') : global[namespace].utilities.createModal('change-delivery-charge-modal', 'medium');
									$modalTarget.modal({'url': CONSTANTS.contextPath + '/checkout/ajax/changedDeliveryChargeModal.jsp?postalCode=' + zipCode});
								}
							} else {
								if (data.errorMessages.length > 0){
									global[namespace].utilities.form.showErrors($('#shipping-address-form'), {'errorMessages': data.errorMessages});
								}
							}
						},
						error: function (data) {
							console.log('AJAX Error:' + data);
						}
					});
				}
			});

			// Open Shipping section upon clicking Edit and close any in-progress section
			$body.on('click', 'a.edit-shipping', function (e) {
				e.preventDefault();
				updateProgressBar('checkout-shipping'); 
				$checkoutStep.removeClass('complete in-progress').addClass('not-started');
				$checkoutShippingSection.removeClass('not-started').addClass('in-progress');
				$shippingAddressReviewPanel.slideUp(250, function(){
					$shippingAddressFormPanel.slideDown();
					$paymentFormPanel.show();
					$paymentForm.hide();
					$paymentReviewPanel.hide();
					$('.checkout-review .js-info-content').hide();
				});
			});
			
			// Open Payment section upon clicking Edit and close any in-progress section
			$body.on('click', 'a.edit-payment', function (e) {
				e.preventDefault();
				if($(this).hasClass('isDisabled') != true) {
					updateProgressBar('checkout-payment'); 
					$checkoutPaymentSection.removeClass('complete').addClass('in-progress');
					$checkoutReviewSection.removeClass('in-progress').addClass('not-started');
					$paymentReviewPanel.slideUp(250, function(){
						$('.js-cc-content').removeClass('hide');
						$('.js-lzb-cc-link').removeClass('hide');
						$('.js-db-content').addClass('hide');
						$('.js-cc-field').removeAttr('disabled');
						$('#useDigitalBuy').text(false);
						$paymentFormPanel.slideDown();
						$paymentFormPanel.show();
						$paymentForm.show();
						$('.checkout-review .js-info-content').hide();
					});
				}
			});
			
			// Click event for Delivery Charge Change modal Accept button
			$(document).on('click', '#change-delivery-charge-modal .accept-btn', function(e){
				e.preventDefault();
				$('#shipping-address-form').ajaxSubmit(shippingAddressFormOptions);
				$("#changed-delivery-charge-modal").ajaxSubmit(changedDeliveryChargeFormOptions);
			});
			
			// Hide or show Billing Address
			$checkoutPaymentSection.on('click', '#useDeliveryAddress', function(){
				if (this.checked) {
					$('.billing-address').slideUp(250);
				} else {
					$('.billing-address').slideDown(250);
				}
			});

			/* START: Credit Card Type Detection
			   ========================================================= */
			var cardType = {
				card: [{
					name: 'Visa',
					value: 'Visa',
					pattern: /^4[0-9]/,
					className: 'cardtype-visa'
				},
				{
					name: 'Mastercard',
					value: 'MasterCard',
					pattern: /^5[1-5]|^(?:222[1-9]|22[3-9]\d|2[3-6]\d{2}|27[0-1]\d|2720)/,
					className: 'cardtype-mastercard'
				},
				{
					name: 'America Express',
					value: 'AmericanExpress',
					pattern: /^3[47]/,
					className: 'cardtype-amex'
				}],
				unknown: {
					name: 'Unknown',
					className: 'cardtype-unknown'
				}
			};

			$('input[id^="ccNum"]').on('change paste keyup', function() {
				var $this = $(this),
					cardTypeId = $this.data('card-type'),
					$cardTypeField = $('#' + cardTypeId),
					val = $this.val(),
					hasMatch = false;

                // remove all .cardtype- classes.
				$this.removeClass(function(index,classes){
				    var matches = classes.match(/\bcardtype-\S+/ig);
				    return (matches) ? matches.join(' ') : '';
				});

				// manage four digit spacing.
				$this.val(function () {
					var v = val.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
  					var matches = v.match(/\d{4,16}/g);
  				  	var match = matches && matches[0] || '';
  				 	var parts = [];
  					for (i=0, len=match.length; i<len; i+=4) {
  				    	parts.push(match.substring(i, i+4));
  				  	}
  					if (parts.length) {
  				    	return parts.join(' ');
  					} else {
  				    	return val;
  					}
  			  	});

                // check input for card type match.
				$.each(cardType.card, function(i, b) {
				    var valNoWhiteSpace = val.replace(/\s+/g, '');
					if (valNoWhiteSpace.match(b.pattern)) {
						$this.addClass(b.className);
						$cardTypeField.val(b.value).change();
						hasMatch = true;
				        return false;
				    } else {
				    	hasMatch = false;
				    }
				});

				// match unknown
				if(hasMatch == false) {
					$this.addClass(cardType.unknown.className);
					$cardTypeField.val('');
				}
			});

			$('input[id^="ccNum"]').change(function() {
				if($("#pcrcard-consent").is(":checked") ){
					$("#pcrcard-consent").attr('checked', false);
					$(".new-pcr-card-info-container .checkout-ge-content").empty();
				}
			});
			/* END: Credit Card Type Detection
			   ========================================================= */
			
			// Pay With DigitalBuy on Checkout page
			$checkoutPaymentSection.on('click', '.js-lzb-cc-link', function(e) {
				e.preventDefault();
				
				$(this).addClass('hide');
				$('.js-cc-content').addClass('hide');
				$('.js-db-content').removeClass('hide');
				$('.js-cc-field').attr('disabled', 'true');
				$('#useDigitalBuy').text(true);
			});
			
			// Split payment
			$checkoutPaymentSection.on('click', '#splitPaymentCheckbox', function(){
				if (this.checked) {
					$('.first-card-billing-addr').slideDown(250);
					$('.second-card-container').slideDown(250);
					$('.user-delivery-address-2').show();
					$('.split-payment-message').show();
					$('#splitPayment').val(true);
				} else {
					$('.first-card-billing-addr').slideUp(250);
					$('.second-card-container').slideUp(250);
					$('.user-delivery-address-2').hide();
					$('.split-payment-message').hide();
					$('#splitPayment').val(false);
					$('#useDeliveryAddress2:not(:checked)').trigger('click');
				}
			});
			
			// Hide or show Billing Address for second credit card
			$checkoutPaymentSection.on('click', '#useDeliveryAddress2', function(){
				if (this.checked) {
					$('.billing-address-2').slideUp(250);
				} else {
					$('.billing-address-2').slideDown(250);
				}
			});
			
			// Click Continue To Review button on Checkout page payment section
			$checkoutPaymentSection.on('click', '.payment-continue', function(e) {
				e.preventDefault();
				$('#paymentForm').validate('validateForm');
				if ($('#paymentForm').data('validate').isValid) {
					$('#paymentForm').ajaxSubmit(paymentFormOptions);
				}
			});

			// Place order for DigitalBuy from Cart
			$checkoutReviewSection.on('click', '.dbuyProcessInd2-order-btn', function(e) {
				e.preventDefault();
				
				var JSONObject = {};
						
				JSONObject.processInd = $('#processInd').val();
				JSONObject.tokenId = $('#tokenId').val();
				JSONObject.merchantID = $('#merchantID').val();
				JSONObject.clientTransId = $('#clientTransId').val();
					
				JSONObject.custFirstName = $('#custFirstName').val();
				JSONObject.custLastName = $('#custLastName').val();
				JSONObject.custZipCode = $('#custZipCode').val();
				JSONObject.custAddress1 = $('#custAddress1').val();
				JSONObject.custCity = $('#custCity').val();
				JSONObject.custState = $('#custState').val();

				JSONObject.transPromo1 = $('#transPromo1').val();
				JSONObject.transAmount1 = $('#transAmount1').val();
				
				syfDBuy.calldBuyProcess(null, JSONObject);
			});
			
			// Place order for DigitalBuy from Checkout (DigitalBuyCombined)
			$checkoutReviewSection.on('click', '.dbuyProcessInd3-order-btn', function(e) {
				e.preventDefault();
				
				$.ajax({
					url: CONSTANTS.contextPath + '/checkout/json/digitalBuyToken.jsp',
					type: 'post',
					success: function (data) {
						$('#tokenId').val(data.token);
						
						var JSONObject = {};
						
						JSONObject.processInd = $('#processInd').val();
						JSONObject.tokenId = data.token;
						JSONObject.merchantID = $('#merchantID').val();
						JSONObject.clientTransId = $('#clientTransId').val();
						
						JSONObject.custFirstName = $('#custFirstName').val();
						JSONObject.custLastName = $('#custLastName').val();
						JSONObject.custZipCode = $('#custZipCode').val();
						JSONObject.custAddress1 = $('#custAddress1').val();
						JSONObject.custCity = $('#custCity').val();
						JSONObject.custState = $('#custState').val();

						JSONObject.transPromo1 = $('#transPromo1').val();
						JSONObject.transAmount1 = $('#transAmount1').val();
						    
						syfDBuy.calldBuyProcess(null, JSONObject);
					},
					error: function (data) {
						console.log('AJAX Error:' + data);
					}
				});
			});
			
			// Detect Synchrony modal close and redirect to checkout page
			window.addEventListener("message",function(event) {
				if (typeof event.data == 'string' && (event.data == 'Close Model' || event.data == 'Return To Merchant Shipping')) {
					console.log('SYNCHRONY MODAL CLOSED', event.data);
					$('#digital-buy-form').ajaxSubmit(placeOrderOptions);
				}
			});
			
			$checkoutReviewSection.on('click', '.review-continue', function(e) {
				e.preventDefault();
				// Submit order via Ajax
				$('#commit-order-form').ajaxSubmit(placeOrderOptions);
			});
		}
	};

	global[namespace] = global[namespace] || {};

	global[namespace].checkout = checkout;

})(this, window.jQuery, "LZB");

// Update Order Total section on cart and checkout page
function updateOrderTotals(responseText) {
	if (responseText.orderTotals.taxDown == 'true') {
		$('.totals-container .totals').html(Mustache.render(LZB.templates.orderTotalsWithTaxDown, responseText.orderTotals));
		
		// Initialize tax down tooltip
		$('.tax-down-msg .has-tip').tooltip();
	} 
	else if (responseText.orderTotals.taxHidden == 'true') {
		$('.totals-container .totals').html(Mustache.render(LZB.templates.orderTotalsNoTax, responseText.orderTotals));		
	}
	else {
		$('.totals-container .totals').html(Mustache.render(LZB.templates.orderTotals, responseText.orderTotals));

		// Initialize recycling fee tooltip
		var $recyclingFeeTooltip = $('.recycling-fee .has-tip');
		if ($recyclingFeeTooltip.length) {
			$recyclingFeeTooltip.tooltip();
		}
	}

	// update order summary accordion order total
	$('#checkoutOrderSummaryTotal').find('.order-total-amount').html(responseText.orderTotals.orderTotal);
}

// Update Deposit section on cart and checkout page
function updateDeposit(responseText) {
	var $depositSection = $('.deposit-section');

	if ($depositSection.length > 0) {
		$depositSection.find('.deposit-amount span.amount').html(responseText.orderDepositBalance.orderDeposit);
		$depositSection.find('.balance-amount span.amount').html(responseText.orderDepositBalance.orderBalance);
	}
}

// Update Checkout page progress bar status
function updateProgressBar(currentStep) {
	if (currentStep == 'checkout-shipping') {
		$('.checkout-progress').addClass('isDisabled');
		$('.checkout-progress-shipping').removeClass('isDisabled');
	} else if (currentStep == 'checkout-payment') {
		$('.checkout-progress').removeClass('isDisabled');
		$('.checkout-progress-review').addClass('isDisabled');
	} else if (currentStep == 'checkout-review') {
		$('.checkout-progress').removeClass('isDisabled');
	}
}

// Update Order Summary on Checkout page
function updateOrderSummary() {
	$.ajax({
		url: '/rwd/checkout/json/repriceCheckoutOrderSummary.jsp',
		dataType: 'json',
		success: function (responseData) {
			updateOrderTotals(responseData);
			updateDeposit(responseData);
		},
		error: function (data) {
			console.log('error', data);
		}
	});
}

// Update billing address form
function updateBillingAddressForm(sameAsShipping, index) {
	if (sameAsShipping) {
		$('#billFName' + index).val($('.ship-addr-firstname').text());
		$('#billSName' + index).val($('.ship-addr-lastname').text());
		$('#billAddr1' + index).val($('.ship-addr-1').text());
		$('#billAddr2' + index).val($('.ship-addr-2').text());
		$('#billCity' + index).val($('.ship-addr-city').text());
		$('#selState' + index).val($('.ship-addr-state').text());
		$('#billZipCode' + index).val($('.ship-addr-zip').text());
		$('#billingPhone' + index).val($('.ship-addr-phone').text());
		$('#billEmailAddress' + index).val($('.ship-addr-email').text());
	} else {
		// Clear all billing address form fields, but always copy email
		$('#billEmailAddress' + index).val($('.ship-addr-email').text());
//		$('.js-billAdd-field-' + index).val('');
	}
}
