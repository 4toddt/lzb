/*!
 * Browse Init
 */
(function (global, $, namespace) {
	//"use strict";

	var loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
		CONSTANTS = global[namespace].constants,
		$body = $('body'),
		$window = $(window);

	/* Function: Builds Cart Request Data */
	function getCartRequest() {
		var coverid = $('#coverId').val(),
			dealerid = $('#dealerid').val(),
			productid = $('#productid').val(),
			catalogrefid = $('#catalogrefid').val(),
			exceptionid = $('#exceptionid').val(),
			qty = $('#quantity').val(),
			cartRequest = {},
			coverRequest = {},
			coveroptionskus = [],
			dataRel = '',
			optionQty = '',
			selectedOptions = $('.option:checked');

		// Push Data Into cartRequest Object
		cartRequest.dealerid = dealerid;
		cartRequest.productid = productid;
		cartRequest.catalogrefid = catalogrefid;
		cartRequest.coverSkuId = coverid;
		cartRequest.exceptionId = exceptionid;
		cartRequest.qty = qty;
		cartRequest.coveroptionskus = coveroptionskus;
		coverRequest = {
			'subskuid': coverid,
			'type': 'cover',
			'howToStyle':'',
			'qty': qty
		};
		cartRequest.coveroptionskus.push(coverRequest);

		// Loop through all selected Options & Upgrades
		// console.log('selectedOptions', selectedOptions);
		$('.option:checked').each(function(){
			var $selectedOption = $(this);
			/* length greater than 2 because somehow backend sometimes supplies a value of [] which is unusable */
			if ($selectedOption.val().length > 2 && $selectedOption.val() !== '' && $selectedOption.val() !== undefined) {
				var options = [],
					optionitem = {},
					isPillowTypeAdd = false;

				dataRel = $selectedOption.attr('data-config');

				// IF selectedOption is a Pillow Option
				if ($selectedOption.attr('data-pillowtype')) {
					var pillowQtySelectVal = $('#pillowQuantitySelect_' + $selectedOption.val()).val();

					//console.log('this data-pillowtype');
					if (typeof(pillowQtySelectVal) != 'undefined' && pillowQtySelectVal != 'Quantity') {
						/* for pillow set 1 and 2, if there is a value for these two, then that has to be included in the json string
						 * the only means to add them that was available was to make them hidden checkboxes so they will gather their data
						 * differently
						 */

						//console.log('thisDataPillowtype', $selectedOption.attr('id'),	$selectedOption.val());
						var dataPillowType = $selectedOption.attr('data-pillowtype'),
							dataPillowSet = $selectedOption.attr('data-pillowset'),
							optionItemSubSkuId = coverid,
							optionCheckboxChecked = $('.option-checkbox-' + dataPillowType).prop('checked');

						/* this is checking if there is a selected check or one from the dropdown swatch */
						if (optionCheckboxChecked === true) {
							//console.log('optionCheckboxChecked checked');
						}
						else {
							var lenPillowSwatchRadio = $('[name="pillow-swatch-' + dataPillowSet+'"]').length,
								optionPillowSwatchVal = optionPillowSwatchValCheck(lenPillowSwatchRadio, dataPillowSet, optionPillowSwatchVal);

							if (optionPillowSwatchVal.length > 0) {
								optionItemSubSkuId = optionPillowSwatchVal;
							}
						}

						// Push Data Into optionitem Object
						optionitem = {
							'subskuid': optionItemSubSkuId,
							'type': 'optionCover',
							'howToStyle':'',
							'qty':'1'
						};
						// Push optionitem Data Into options Array
						options.push(optionitem);

						// Push Data Into coverRequest Object
						coverRequest = {
							'subskuid' : $selectedOption.val(),
							'type' : dataPillowType,
							'howToStyle' : '',
							'qty' : pillowQtySelectVal,
							'options' : options
						};
					}
					else {
						isPillowTypeAdd = true;
					}

				}
				// IF selectedOption is a Default Pillow Option
				else if ($selectedOption.attr('id') && $selectedOption.attr('id') === 'defaultPillowsOptions') {
					// Push Data Into optionSubItem Object
					var optionSubItem = [{
						'subskuid' : coverid,
						'type' : 'optionCover',
						'howToStyle' : '',
						'qty' : '1'
					}];
					// Push Data Into coverRequest Object
					coverRequest = {
						'subskuid': $selectedOption.val(),
						'type': 'option',
						'howToStyle':'',
						'qty':'1',
						'options': optionSubItem
					};
					// console.log('Before pdpcoverRequest: ',coverRequest);
					// Push coverRequest Data Into coveroptionskus Array
					cartRequest.coveroptionskus.push(coverRequest);
				}
				/* ELSE Standard Option */
				else {
					var optiontype = 'option',
						subOptionName = $selectedOption.attr('name');

					optionQty = $selectedOption.closest('.option-container').find('.option-radio-val').val();

					if (optionQty === undefined || optionQty === 'undefined') {
						optionQty = 1;
					}

					// console.log('name is', subOptionName);
					if (subOptionName !== 'Welt') {
						// Push Data Into coverRequest Object
						coverRequest = {
							'subskuid': $selectedOption.val(),
							'type': optiontype,
							'howToStyle':'',
							'qty': optionQty,
							'options': options
						};
					}

					dataRel = $selectedOption.attr('data-config');

					if ($selectedOption.val() !== undefined || dataRel !== 'None') {
						var optionRadioValDataRel = $selectedOption.closest('.option-container').find('.option-radio-val').attr('data-rel'),
							thisName = $selectedOption.attr('name'),
							accordionId = $selectedOption.closest('.accordion-container').attr('id'),
							dataSubOptions = $selectedOption.attr('data-subOptions');

						/* IF Finish Options */
						if (accordionId === 'accordion-Finish-Options') {
							// Push Data Into optionitem Object
							optionitem = returnOptionItem(this, optionitem, optionQty);
							// Push optionitem Data Into options Array
							options.push(optionitem);
						}
						// ELSE IF $selectedOption contains Sub Options such as contrasting welt covers, finishes.
						else if (dataSubOptions === 'true') {
							var subSkuIdVal = coverid,
								siblingColorSibling = $selectedOption.closest('.option-container').find('.option-swatches'),
								siblingOption = siblingColorSibling.find('.option'),
								lenSiblingOption = siblingOption.length;

							subSkuIdVal = returnSubSkuIdVal(lenSiblingOption, subSkuIdVal, siblingOption);

							// Push Data Into optionitem Object
							optionitem = {
								'subskuid': subSkuIdVal,
								'type': 'optionCover',
								'howToStyle':'',
								'qty': optionQty
							};
							// Push optionitem Data Into options Array
							options.push(optionitem);
						}
					}
				}
				//console.log('coverRequest: ',coverRequest);
				if (dataRel !== undefined && dataRel !== 'None' || $selectedOption.attr('data-pillowtype') && !isPillowTypeAdd) {
					// Push coverRequest Data Into coveroptionskus Array
					cartRequest.coveroptionskus.push(coverRequest);
				}

			}
		});
		console.log('cartRequest: ', cartRequest);
		return cartRequest;
	}

	/* Function: Returns Option Item */
	function returnOptionItem(thisI, optionitem, optionQty) {
		if ($(thisI).attr('data-config') !== 'Standard Finish') {
			optionitem = {
				'subskuid': $('.option-finish-img.selected').attr('data-finishcode'),
				'type': $('.option-finish-img.selected').attr('data-optiontype'),
				'howToStyle': '',
				'qty': optionQty
			};
		}
		else {
			var siblingImg = $(thisI).siblings('img');
			//console.log( siblingImg.attr('data-optiontype')	);
			optionitem = {
				'subskuid': siblingImg.attr('data-finishcode'),
				'type': siblingImg.attr('data-optiontype'),
				'howToStyle': '',
				'qty': optionQty
			};
		}
		return optionitem;
	}

	/* Function: Returns Sub Sku ID Value */
	function returnSubSkuIdVal(lenSiblingOption, subSkuIdVal, siblingOption) {
		for (var i=0; i < lenSiblingOption; i++) {
			if (siblingOption.eq(i).prop('checked') === true) {
				subSkuIdVal = siblingOption.eq(i).val();
			}
		}
		return subSkuIdVal;
	}

	/* Function: Returns Pillow Swatch Value */
	function optionPillowSwatchValCheck(lenPillowSwatchRadio, dataPillowSet, optionPillowSwatchVal){
		for (var k=0; k < lenPillowSwatchRadio; k++) {
			if ( $('[name="pillow-swatch-' + dataPillowSet+'"]').eq(k).prop('checked') === true ) {
				optionPillowSwatchVal = $('[name="pillow-swatch-' + dataPillowSet + '"]').eq(k).val();
			}
		}
		return optionPillowSwatchVal;
	}

	/* Function: Updates Cover Swatch Group Title with Selected Cover Name & SKU */
	function updateCoverGroupTitle() {
		var coverGroupTitleClass = '.cover-group-title',
			$coverGroupTitleName = $(coverGroupTitleClass).find('.cover-name'),
			$coverGroupTitleSku = $(coverGroupTitleClass).find('.cover-sku'),
			$coverDetailsLink = $('#view-cover-details-link'),
			$selectedCover = $('.cover.selected'),
			$selectedSwatchGroup = $selectedCover.closest('.cover-selection-swatches'),
			selectedCoverColorName = $selectedCover.data('color-name'),
			selectedCoverCoverid = $selectedCover.data('coverid');

		// clear existing content from all cover group titles
		$coverGroupTitleName.html('');
		$coverGroupTitleSku.html('');
		// set selected cover group title
		$selectedSwatchGroup.find($coverGroupTitleName).html(selectedCoverColorName);
		$selectedSwatchGroup.find($coverGroupTitleSku).html(selectedCoverCoverid);
		// set cover details modal link coverId param
		$coverDetailsLink.attr('href', CONSTANTS.contextPath + '/browse/ajax/viewCoverDetailsModal.jsp?coverId=' + selectedCoverCoverid + "&coverColor=" +selectedCoverColorName);
	}

	/* Function: Get Option Summary & Price Total for updating Accordion Title Bar */
	function getOptionSummaryAndPriceTotal($target) {
		var optionSummary = '',
			optionSummaryArray = [],
			optionPriceTotalsArray = [],
			priceTotal = 0;

		// loop through $target to get summary and price data
		$($target).each(function(index) {
			var $this = $(this),
				tmpPrice = $this.data('price-formatted');

			if (tmpPrice != undefined) {
				tmpPrice = tmpPrice.replace('$','');
			}
			else {
				tmpPrice = '0.00';
			}

			optionSummaryArray.push($this.data('config'));
			optionSummary = optionSummaryArray.join(', ');
			optionPriceTotalsArray.push(parseFloat(tmpPrice));
		});

		// Add up prices in array to get total cost.
		for (var i=0; i < optionPriceTotalsArray.length; i++) {
				priceTotal += optionPriceTotalsArray[i];
		}

		return {summary: optionSummary, price: '+$'.concat(priceTotal.toFixed(2))};
	}

	/* Function: Updates Accordion Title with selected summary detail & price */
	function updateAccordionTitle(dataObject, pdpRecordType) {
		var $titleContainer = dataObject.accordionTarget.find('.accordion-title').first(),
			$swatchImg = $titleContainer.find('.selected-swatch img'),
			$summary = $titleContainer.find('.selected-summary'),
			$totalPrice = $titleContainer.find('.selected-options-total');

		// apply updates
		if (dataObject.swatchImgUrl != undefined) {
			if ($swatchImg.length > 0) {
				// update existing img src
				$swatchImg.attr('src', dataObject.swatchImgUrl);
			} else {
				// no img exists, so we need to add new html
				$titleContainer.prepend(Mustache.render(global[namespace].templates.pdpAccordionTitleBarSwatchTemplate, dataObject));
			}
		}
		// update summary data for cover type
		if (dataObject.type === 'cover' && dataObject.summary != undefined) {
			$summary.find('.cover-sku').html(dataObject.summary);
			$summary.find('.cover-type').html(dataObject.summary2);
		}
		// update summary data
		else if (dataObject.summary != undefined) {
			$summary.html(dataObject.summary);
		}
		// update price data
		if (dataObject.price != undefined && pdpRecordType != 'sectional') {
			$totalPrice.html(dataObject.price);
		}
	}

	// Function: Splits the value of the aria-label and updates the string with a new value
	function updateAriaLabel($target, splitKey, newString) {
		var ariaLabelValue = $target.attr('aria-label'),
			ariaLabelText = '';

		if (ariaLabelValue != undefined) {
			ariaLabelText = ariaLabelValue.split(splitKey);
		}
		else {
			return;
		}

		if (newString != undefined && splitKey != undefined) {
			// append new price to value
			ariaLabelValue = ariaLabelText[0] + splitKey + newString;
		}
		else {
			// strip the price from the value
			ariaLabelValue = ariaLabelText[0] + splitKey;
		}

		$target.attr('aria-label', ariaLabelValue);
	}

	// Function: Splits the value of the content schema and updates the string with a new price value
	function updatePriceContentSchema($target, newPrice) {
		var contentSchema = '';

		if (newPrice != undefined) {
			contentSchema = newPrice.replace('$', '');
		}
		$target.attr('content', contentSchema);
	}

	/* Function: Get pricing with configured cover and options */
	function ajaxPriceRequest(pdpRecordType) {
		// stop execution if specific pdpRecordType
		if (pdpRecordType != 'configurable') {
			return;
		}

		var $errorBoxTarget = $('.product-page .product-main'),
			cartRequest = JSON.stringify(getCartRequest()),
			productVnt = $('#datavnt').val(),
			skuid = $('#catalogrefid').val(),
			params = 'productVnt=' + productVnt + '&jsonString=' + cartRequest + '&skuId=' + skuid;

		// remove any error messages
		$errorBoxTarget.find('.error-box').remove();

		$.ajax({
			url: CONSTANTS.contextPath + '/browse/json/productPrice.jsp',
			type: 'post',
			dataType: 'json',
			data: params,
			cache: false,
			success: function(responseText, statusText, xhr) {
				if (statusText == 'success') {
					if (responseText.success == 'true') {
						var $addToCartButton = $('#add-to-cart-submit'),
							$shippingLink = $('#estimated-shipping-link'),
							shippingLinkURL = $shippingLink.attr('href'),
							shippingLinkSplitValue = 'price=',
							shippingLinkURLParts = shippingLinkURL.split(shippingLinkSplitValue),
							$productPrice = $('.product-price'),
							$pdpMonthlyPricing = $('.pdp-monthly-pricing'),
							numberOfFinancingMonths = $('.pdp-monthly-pricing').attr('data-financingmonths'),
							$monthlyPrice = $('.pdp-monthly-pricing .monthly-amt'),
							$regularPriceContainer = $productPrice.find('.regular-price-container'),
							$salePriceContainer = $productPrice.find('.sale-price-container'),
							$saveAmountContainer = $productPrice.find('.save-amount-container'),
							currentPriceId = 'pdp-price',
							$currentPrice = $productPrice.find('#' + currentPriceId),
							$regularPrice = $productPrice.find('.regular-price'),
							$salePrice = $productPrice.find('.sale-price'),
							$originalPrice = $productPrice.find('.original-price'),
							$saveAmount = $saveAmountContainer.find('.save-amount'),
							$saveAmountText = $saveAmount.find('.savings-text'),
							$saleEndDate = $saveAmountContainer.find('.sale-end-date'),
							$saleEndDateText = $saleEndDate.find('.end-date-text'),
                            $ariaLabelSplitKey = ":",
                            buttonText,
                            priceCleaned,
                            monthlyRaw,
							monthlyRawRound,
							stockMsg = responseText.stockMsg,
							$stockMsgElem = $('.stock-message-text');
										
							$stockMsgElem.text(stockMsg);

						// Check if Add to Cart button is on the page.
						if ($addToCartButton.length) {
							var addToCartButtonValue = $addToCartButton.val();
                            buttonText = addToCartButtonValue.split('$');
						}

						// hide configure price message
						$productPrice.find('.configure-for-pricing').addClass('hide');

						if (responseText.onSale !== undefined && responseText.onSale === true) {
							priceCleaned = Number(responseText.salePrice.replace(/[^0-9\.]+/g,""));
							monthlyRaw = priceCleaned/numberOfFinancingMonths,
							monthlyRawRound = monthlyRaw+0.5-((monthlyRaw+0.5)%1);
							
							// hide regular price
							$regularPriceContainer.addClass('hide');
							// show sale price
							$salePriceContainer.removeClass('hide');
							// move current price id to sale price element
							$currentPrice.removeAttr('id');
							$salePrice.attr('id', currentPriceId);
							// update sale price
							$salePrice.html(responseText.salePrice);
							updateAriaLabel($salePrice, $ariaLabelSplitKey, responseText.salePrice);
							updatePriceContentSchema($salePrice, responseText.salePrice);
							// update orginal price
							$originalPrice.html(responseText.listPrice);
							updateAriaLabel($originalPrice, $ariaLabelSplitKey, responseText.listPrice);
							updatePriceContentSchema($originalPrice, responseText.listPrice);
							// update regular price
							$regularPrice.html('');
							updateAriaLabel($regularPrice, $ariaLabelSplitKey);
							updatePriceContentSchema($regularPrice);
							// update monthly price
							$monthlyPrice.html(monthlyRawRound);
							$pdpMonthlyPricing.removeClass('hide');
							// update Add to Cart button
							if ($addToCartButton.length) {
								$addToCartButton.val(buttonText[0] + responseText.salePrice);
							}
							// update estimated shipping cost url
							$shippingLink.attr('href',shippingLinkURLParts[0] + shippingLinkSplitValue + priceCleaned);
							// update save amount and end date
							if (responseText.saveAmount != '') {
								$saveAmountText.html('$' + responseText.saveAmount);
								updateAriaLabel($saveAmount, $ariaLabelSplitKey, responseText.saveAmount);
								$saveAmount.removeClass('hide');
							}
							else {
								$saveAmountText.html('');
								$saveAmount.addClass('hide');
							}
							if (responseText.endDate != '') {
								$saleEndDateText.html(responseText.endDate);
								updateAriaLabel($saleEndDate, $ariaLabelSplitKey, responseText.endDate);
								$saleEndDate.removeClass('hide');
							}
							else {
								$saleEndDateText.html('');
								$saleEndDate.addClass('hide');
							}
							if (responseText.saveAmount != '' || responseText.endDate != '') {
								$saveAmountContainer.removeClass('hide');
							}
							else {
								$saveAmountContainer.addClass('hide');
							}
						}
						else {
							priceCleaned = Number(responseText.listPrice.replace(/[^0-9\.]+/g,""));
							monthlyRaw = priceCleaned/numberOfFinancingMonths,
							monthlyRawRound = monthlyRaw+0.5-((monthlyRaw+0.5)%1);
							
							// hide sale price
							$salePriceContainer.addClass('hide');
							// show regular price
							$regularPriceContainer.removeClass('hide');
							// move current price id to sale price element
							$currentPrice.removeAttr('id');
							$regularPrice.attr('id', currentPriceId);
							// update regular price
							$regularPrice.html(responseText.listPrice);
							updateAriaLabel($regularPrice, $ariaLabelSplitKey, responseText.listPrice);
							updatePriceContentSchema($regularPrice, responseText.listPrice);
							// update sale price
							$salePrice.html('');
							updateAriaLabel($salePrice, $ariaLabelSplitKey);
							updatePriceContentSchema($salePrice);
							// update orginal price
							$originalPrice.html('');
							updateAriaLabel($originalPrice, $ariaLabelSplitKey);
							updatePriceContentSchema($originalPrice);
							// update save amount and end date
							$saveAmountContainer.addClass('hide');
							$saveAmountText.html('');
							$saleEndDateText.html('');
							// update monthly price
							$monthlyPrice.html(monthlyRawRound);
							$pdpMonthlyPricing.removeClass('hide');
							// update Add to Cart button
							if ($addToCartButton.length) {
								$addToCartButton.val(buttonText[0] + responseText.listPrice);
							}
							// update estimated shipping cost url
							$shippingLink.attr('href',shippingLinkURLParts[0] + shippingLinkSplitValue + priceCleaned);
						}

						$('#exceptionid').val(responseText.exceptionId);
						$('#isSelectPrice').val(responseText.isSelectPrice);
						$('#selectExceptionOptions').val(responseText.selectExceptionOptions);
					}
					else {
						// display error alert box
						$errorBoxTarget.prepend(Mustache.render(global[namespace].templates.errorMessageTemplate, responseText));
						// scroll to top of page.
						$('html, body').animate({scrollTop: 0}, 400);
					}
				}
				else {
					console.log('Malformed JSON : missing statusText parameter:');
				}
			},
			error: function(xhr, statusText, exception) {
				console.log('AJAX Error:');
			}
		});
	}

	/* Function: Resets Select Form Fields back to default (first option) */
	function resetFormSelects(id) {
		var $selector = $('#cover-filter-form select:not(#' + id +')'),
			$selectAll = $('#cover-filter-form select'),
			$inStock = $('#inStock');

		if(id!== undefined) {
		  // reset all form selects to default except the one last changed.
		  $selector.each(function() {
			$(this)[0].selectedIndex = 0;
		  });
		  if (id !== 'inStock') {
			$inStock.prop('checked', false);
		  }
		}
		else {
		  // reset all form selects to default.
		  $selectAll.each(function() {
				$(this)[0].selectedIndex = 0;
			});
			$inStock.prop('checked', false);
		}
	}
	
	var $coverSearch = $('#cover-search');

	/* Function: Initializes Sticky Elements by pageType */
	function stickyInit() {
		var pageType = $body.data('action'),
			mobileHeaderOffset = $('#mobile-header-container').outerHeight();

		// category or search pages
		if (pageType === 'category' || pageType === 'search') {
			var $categoryNavBar = $('.category-navigation-container');
			// sticky category navigation bar
			$categoryNavBar.stick_in_parent({
				parent: '.off-canvas-wrap',
				offset_top: mobileHeaderOffset
			});
		}
		// product pages
		else if (pageType === 'product') {
			var pdpRecordType = $('.product-page').data('product-record');

			// Only do Sticky elements on certain pdp record types
			var $productImages = $('#productImages'),
				$productAddToCart = $('.product-add-to-cart'),
				$productComposer = $productImages.find('.product-composer'),
				$addToCartButton = $productAddToCart.find('#add-to-cart-submit');

			var isMinScreen = $window.innerWidth() < global[namespace].config.mediumMin,
				isPortrait = window.matchMedia("(orientation: portrait)").matches,
				coverSearchIsActive = $coverSearch.hasClass('cover-search--active');

			// Sticky only on mobile breakpoint And Portrait orientation
			if (isMinScreen && isPortrait && !coverSearchIsActive) {
				var addToCartOffset = $window.height() - $productAddToCart.outerHeight();

				// only sticky if image composer exists
				if ($productComposer.length > 0) {
					// sticky product images
					$productImages.stick_in_parent({
						offset_top: 0
					});
				}
				// only sticky if add to cart button exists
				if ($addToCartButton.length > 0) {
					// sticky add to cart button. even though css forces bottom:0 we still need to apply offset_top so sticky-kit knows when to activate sticky attach event.
					$productAddToCart.stick_in_parent({
						parent: '.product-page',
						offset_top: addToCartOffset,
						spacer: false
					})
					.on('sticky_kit:bottom', function(e) {
							$(this).addClass('is_bottom');
					})
					.on('sticky_kit:unbottom', function(e) {
							$(this).removeClass('is_bottom');
					});
				}
			}
			else {
				// unsticky Elements
				stickyDetach($productImages);
				stickyDetach($productAddToCart);
			}
		}
	}

	/* Function: Detach Sticky Element */
	function stickyDetach($target) {
		// unsticky Elements
		$target.trigger("sticky_kit:detach");
	}

	/* Function: Play Video in Slick Slider current slide */
	function playVideoInCurrentSlide(slick){
		var $currentSlide = slick.find(".slick-current"),
			isVideoSlide = $currentSlide.find('.product-video').length;

		if (isVideoSlide){
			$currentSlide.find('.video-player-container').videoPlayer('play');
		}
	}

	/* Function: Pause Video in Slick Slider current slide */
	function pauseVideoInCurrentSlide(slick){
		var $currentSlide = slick.find(".slick-current"),
			isVideoSlide = $currentSlide.find('.product-video').length;

		if (isVideoSlide){
			slick.find('.video-player-container').videoPlayer('pause');
		}
	}

	var browse = {
		init : function () {

			/* START: Accessibility Controls
			========================================================= */
			// change tab order for Filters in offcanvas status. skips over offcanvas filters
			$body.on('keydown', '#features-menu', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				// tab keycode
				if (keycode == 9 && !e.shiftKey) {
					// change focus order if dropdown is closed
					if(!$(e.target).parent().hasClass('active')) {
						e.preventDefault();
						$('.category-navigation-container a.facets-toggle').focus();
					}
				}
			});
			// change shift+tab order for Filters in offcanvas status. skips over offcanvas filters
			$body.on('keydown', '.category-navigation-container a.facets-toggle', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				// tab keycode with shiftKey
				if (keycode == 9 && e.shiftKey) {
					var $prev = $('#features-menu');
					if ($prev.length > 0) {
						e.preventDefault();
						$prev.focus();
					}
				}
			});
			/* END: Accessibility Controls
			========================================================= */

			/* START: Wishlist Add/Remove Item
			========================================================= */
			var wishlistObj = {
				add : function(classElem){

				},
				remove : function(classElem){
					//$('#removeItemToWishList').ajaxSubmit(addToWishListOptions);
				},
				addCDP : function(classElem){
					//$('#addItemToWishList').ajaxSubmit(addToWishListOptions);
					var dataAttributes = {
						'catalogrefid' : classElem.data('skuid'),
						'productid' : classElem.data('productid'),
						'dealerid' : classElem.data('dealerid'),
						'qty' : 1,
						'coveroptionskus' : [{
							'subskuid' : classElem.data('coverid'),
							'type' : 'cover',
							'qty' : 1,
						}]
					};
					var jsonString = 'iteminfo='+encodeURIComponent(JSON.stringify(dataAttributes));
					this.ajaxCall(jsonString, 'add', classElem);
				},
				removeCDP :function(classElem){
					var wishListId = classElem.attr('data-wishlistid');
					var params = 'wishlistItemIdToRemove=' + wishListId;
					this.ajaxCall(params, 'remove', classElem);
				},
				ajaxCall : function(params, addRemove, classElem){
					var targetUrl;
					if(addRemove === 'add'){
						targetUrl = '/browse/action/add_item_to_wish_list_action.jsp';
					}
					if(addRemove === 'remove'){
						targetUrl = '/browse/action/remove_item_from_wish_list_action.jsp';
					}
					$.ajax({
						url : targetUrl,
						data : params,
						type : 'POST',
						error : function(){
							// console.log('cdpCompare - error');
						},
						success : function(data){
							// console.log('success', data);
							// console.log('login', data.loginUser);
						}
					}).done(function(data){
						// console.log('data', data);
						var loginStatus = data.loginUser;
						if(data.loginUser === false || loginStatus === undefined){
							var $modalTarget = document.getElementById('login-modal') ? $('#login-modal') : global[namespace].utilities.createModal('login-modal', 'medium');
							$modalTarget.modal({'url': CONSTANTS.contextPath + '/account/ajax/loginModal.jsp'});
						}else{
							if(data.success === true){
								classElem.attr('data-wishlistid', data.giftItemId);
								if(addRemove === 'add'){
									classElem.find('.icon').removeClass('icon-heart-empty').addClass('icon-heart-filled');
									classElem.addClass('active-wishlist');
									//wishlistObj.successMsg(data.successMessage);
								} 

								if('removeItemIdSucessfully' in data){
									classElem.find('.icon').removeClass('icon-heart').addClass('icon-heart-outline');
								}

								if(addRemove === 'remove'){
									classElem.find('.icon').removeClass('icon-heart-filled').addClass('icon-heart-empty');
									classElem.removeClass('active-wishlist');
								}
							} else {
								console.log('data success false');
								var errorMsg = data.errors[0].message;
								//wishlistObj.errorMsg(errorMsg);
							}
						}
					});
				},
				successMsg : function(successMsg){
				},
				errorMsg : function(errorMsg){
				}
			};
			/* Click event for add to wishlist */
			$body.on('click', '.add-to-wishlist', function(e){
				e.preventDefault();
				e.stopPropagation();
				if($(this).hasClass('active-wishlist')){
					$(this).removeClass('active-wishlist');
					wishlistObj.removeCDP($(this));
				} else {
					$(this).addClass('active-wishlist');
					wishlistObj.addCDP($(this));
				}
			});
			/* END: Wishlist Add/Remove Item
			========================================================= */
		},
		category : function () {
			// Set the facet sidebar product record count.
			$('.facet-sidebar .result-count').html($('.category-navigation-container .result-count').html());

			// Initalize Sticky Elements
			stickyInit();

			// Initalize filters
			var filterController = new global[namespace].FilterController();
		},
		search : function () {
			// Set the facet sidebar product record count.
			$('.facet-sidebar .result-count').html($('.category-navigation-container .result-count').html());

			// Initalize Sticky Elements
			stickyInit();

			// Initalize filters
			var filterController = new global[namespace].FilterController();
		},
		product : function() {

			/**
			 * =============================================================
			 * ====================== STAR RATINGS =========================
			 * =============================================================
			 * 
			 * These scripts are shared between all pages where star ratings
			 * are rendered.  This makes a call to TurnTo and uses the reponse
			 * to populate the review and rating counts on screen.
			 */
			(function() { // IIFE for namespacing -- star rating teaser

				// don't continue unless the star rating element exists on the page.
				var turnToRatingEl = document.querySelector('.turnto-star-rating');
				if (!turnToRatingEl) return;

				// get JSON data
				$.getJSON(window.turnToCountsEndpoint, function(countsObj) {

					// get rounded average rating and turn into a usable class name
					var r = +countsObj.avgRating + 0.25;
					var avgRating = r - (r % 0.5); // round rating to nearest whole or half (0.5)
					var avgRatingStr = avgRating.toFixed(1).replace('.', '-');
					var ratingClass = 'TTrating-' + avgRatingStr;

					// update the DOM
					var TTratingBoxEl = document.querySelector('.TTratingBox');
					var numOfReviewsEl = document.querySelector('.numOfReviews');
					TTratingBoxEl.classList.add(ratingClass);
					numOfReviewsEl.textContent = countsObj.reviews;
				});
			})();

			/* START: Initialize First Page Load
			========================================================= */
			var pdpRecordType = $('.product-page').data('product-record'),
				$cover = $('.cover'),
				$quantity = $('#quantity'),
				$imageComposer = $('#divSpins'),
				$coverSelectionAccordion = $('#accordion-cover-selection'),
				$optionsSelectionAccordion = $('#accordion-options-selection'),
				$mainProductImages = $('.product-images .product-images-slider'),
				$coverSelectionSwatchList = $('.cover-selection-swatches .swatch-list'),
				$optionCoverSwatchList = $('.option-cover-swatches .swatch-list'),
				mainProductImageSliderSettings = {
					dots: true,
					slidesPerRow: 1,
					autoPlay: true,
					draggable: false,
					infinite: true,
					slide: 'div',
					mobileFirst: true,
					swipe: false,
					lazyLoad: 'ondemand',
					responsive: []
				},
				coverSelectionSwatchSliderSettings = {
					dots: false,
					slidesPerRow: 5,
	    			rows: 2,
					autoPlay: false,
					draggable: false,
					infinite: false,
					slide: 'div',
					mobileFirst: true,
					lazyLoad: 'ondemand',
					responsive: [
							{
								breakpoint: 374,
								settings: {
									slidesPerRow: 6,
									rows: 2
								}
							},
							{
								breakpoint: global[namespace].config.largeMin,
								settings: {
									slidesPerRow: 8,
					    			rows: 2
								}
							}
						]
				},
				optionCoverSwatchSliderSettings = {
					dots: false,
					slidesPerRow: 4,
					rows: 8,
					autoPlay: false,
					draggable: false,
					infinite: false,
					slide: 'div',
					mobileFirst: true,
					lazyLoad: 'ondemand',
					responsive: [
							{
								breakpoint: 374,
								settings: {
									slidesPerRow: 5,
									rows: 8
								}
							},
							{
								breakpoint: global[namespace].config.largeMin,
								settings: {
									slidesPerRow: 7,
									rows: 8
								}
							}
						]
				},
				sliderInitCount = 0;

			// Initialize Sticky Elements
			stickyInit();
			// update sticky elements if window is resized or the cover search is focused/unfocused
			$window.resize($.debounce(250, stickyInit));
			$coverSearch.on('focus', function() {
				$coverSearch.addClass('cover-search--active');
				stickyInit();
			});
			$coverSearch.on('blur', function() {
				$coverSearch.removeClass('cover-search--active');
				stickyInit();
			});

			/* START: Video Player */
			// start playing video on slick initialization if video is first slide.
			$mainProductImages.on('init', function(slick){
				slick = $(slick.currentTarget);

				var $video = slick.find('.video-player-container');

				if ($video.length) {
					// make video visible after initialization. Video is hidden in by default in CSS to hide on page render.
					$video.css('visibility', 'visible');

					setTimeout(function(){
						playVideoInCurrentSlide(slick);
					}, 1000);
				}
			});
			// start playing video when slick slider finds a video in the new slide.
			$mainProductImages.on('afterChange', function(event, slick) {
				slick = $(slick.$slider);
				playVideoInCurrentSlide(slick);
			});
			// pause video when slick slider finds a video in the current slide before moving to the next slide.
			$mainProductImages.on('beforeChange', function(event, slick) {
				slick = $(slick.$slider);
				pauseVideoInCurrentSlide(slick);
			});
			/* END: Video Player */

			// Initialize Main Product Images Slider
			$mainProductImages.slick(mainProductImageSliderSettings);

			if (pdpRecordType === 'configurable' || pdpRecordType === 'sectional') {
				// Bind Slick Slider init Event to Cover Configuration Swatch Sliders
				$coverSelectionSwatchList.on('init', function(event, slick, image, imageSource) {
					sliderInitCount ++;
					if (sliderInitCount == $coverSelectionSwatchList.length) {
						// opens the covers accordion once we know slick sliders are ready
						$('#cover-selection-title').trigger('click');
					}
	  			});

				// Initialize Cover Configuration Swatch Sliders
				$coverSelectionSwatchList.slick(coverSelectionSwatchSliderSettings);
				// Initialize Options & Upgrades Configuration Swatch Sliders
				$optionCoverSwatchList.slick(optionCoverSwatchSliderSettings);

				/* Set Cover Group Title with selected cover on initial page load */
				updateCoverGroupTitle();

				/* Set all the selected options data in the Options & Upgrades Parent Accordion Title Bar on initial page load */
				var parentOptionDataObject = {},
					parentAccordionTitleBarData = getOptionSummaryAndPriceTotal($('.option-tile input.option:checked').not('.hidden-option'));
				// Push Data Into parentOptionDataObject Object
				parentOptionDataObject.accordionTarget = $optionsSelectionAccordion;
				parentOptionDataObject.summary = parentAccordionTitleBarData.summary;
				parentOptionDataObject.price = parentAccordionTitleBarData.price;
				// Update Options & Updgrades Parent Accordion Title Bar default selection data
				updateAccordionTitle(parentOptionDataObject, pdpRecordType);

				/* Set selected options data in each of its corresponding Accordion Title Bar on initial page load */
				$($('input.option:checked').not('.hidden-option')).each(function(index) {
					var $this = $(this),
						$accordionContainer = $this.closest('.accordion-container'),
						optionDataObject = {},
						optionAccordionTitleBarData = getOptionSummaryAndPriceTotal($accordionContainer.find('input.option:checked').not('.hidden-option'));

					// Push Data Into optionDataObject Object
					optionDataObject.accordionTarget = $this.closest('.accordion-container');
					optionDataObject.swatchImgUrl = $this.closest('.option-tile').find('img').attr('src');
					optionDataObject.summary = optionAccordionTitleBarData.summary;
					optionDataObject.price = optionAccordionTitleBarData.price;

					// Update Accordion Title Bar default selection data
					updateAccordionTitle(optionDataObject, pdpRecordType);
				});

				/* Sets the default selected base cover swatch in a hidden form field so we have the value if the user decides to filter the swatch list. */
				$('.filter-form-selected-base-swatch-cover').val($('.cover.selected').data('coverid'));

				/* Sets the default selected option cover swatch in a hidden form field so we have the value if the user decides to filter the swatch list. */
				$('.filter-form-selected-swatch-cover').each(function() {
					var $this = $(this),
						$optionSwatchContainer = $this.closest('.option-cover-swatches'),
						$pillowSwatchCheckedRadio = $optionSwatchContainer.find('.option-pillow-swatch-radio:checked'),
						$weltSwatchCheckedRadio = $optionSwatchContainer.find('.option:checked');

					if ($pillowSwatchCheckedRadio.length > 0) {
						// Swatch list is a pillow swatch option
						$this.val($pillowSwatchCheckedRadio.val());
					} else {
						// Swatch list is a welt swatch option
						$this.val($weltSwatchCheckedRadio.val());
					}
				});
			}
			/* END: Initialize First Page Load
			========================================================= */

			/* START: Product Configuration Events
			========================================================= */
			/* Click Event for Product Configuration Accordion Title Bar */
		   	$body.on('click', '.product-configuration .accordion-title', function(e){
				// set position of swatch list slider to fix layout position
				$body.find('.swatch-list.slick-initialized').slick('setPosition');
			});

			/* Change Event for Options Cover Filtering. Used for Welt & Pillow Covers */
			$('.cover-swatch-filter-form select').on('change', function() {
				var $this = $(this),
					$form = $this.closest('form'),
					swatchListId = $form.data('swatchlist-id'),
					$optionCoverSwatches = $this.closest('.option-cover-swatches'),
					$swatchList = $('#' + swatchListId),
					thisVal = $this.val();

				// AJAX Request
				var coverOptionSwatchOptions = {
					dataType : 'html',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							var responseSwatchListHTML = $(responseText).find('#' + swatchListId).html();

							// destroy slider
							$('#' + swatchListId).slick("unslick");
							// remove no-results class
							$('#' + swatchListId).removeClass('no-results');
							// remove previous pre filter selection html
							$optionCoverSwatches.find('.pre-filter-selected').remove();
							// update swatch list html
							$('#' + swatchListId).html(responseSwatchListHTML);

							// move the pre selected filter radio outside of the swatch list results if it is not in the selected filter configuration so the slider does not render the pre-selection.
							var $preFilterSelectedDiv = $('#' + swatchListId).find('.pre-filter-selected'),
								$preFilterSelectedRadio = $preFilterSelectedDiv.find('input[type="radio"]');

							// Pillow Set 1
							if ($this.attr('id') === "Pillow-Optionsset1-filter-color" && $preFilterSelectedRadio.data('family-color') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}
							else if ($this.attr('id') === "Pillow-Optionsset2-filter-color" && $preFilterSelectedRadio.data('family-color') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}
							// Pillow Set 2
							else if ($this.attr('id') === "Pillow-Optionsset1-filter-pattern" && $preFilterSelectedRadio.data('pattern') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}
							else if ($this.attr('id') === "Pillow-Optionsset2-filter-pattern" && $preFilterSelectedRadio.data('pattern') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}
							// Welt
							else if ($this.attr('id') === "Welt-Options-filter-color" && $preFilterSelectedRadio.data('family-color') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}
							else if ($this.attr('id') === "Welt-Options-filter-pattern" && $preFilterSelectedRadio.data('pattern') != thisVal.toLowerCase()) {
								$preFilterSelectedDiv.appendTo($optionCoverSwatches).hide();
							}

							// check if we have results or no results
							if ($.trim($('#' + swatchListId).html()).length > 0) {
								// ReInitialize Slider
								$('#' + swatchListId).slick(optionCoverSwatchSliderSettings);
							} else {
								// display no results message
								$('#' + swatchListId).addClass('no-results');
								var errorMessages = {errorMessages : 'Sorry, no results are found for these selections. Please try again.'};
								$('#' + swatchListId).html(Mustache.render(global[namespace].templates.errorMessageSimpleTemplate, errorMessages));
							}
							global[namespace].loader.hideLoader();
						}
						else {
							console.log('Malformed Response : missing statusText parameter:');
							global[namespace].loader.hideLoader();
						}
					},
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:');
						global[namespace].loader.hideLoader();
					}
				};

				// Submit Cover Swatch Filter Form Using AJAX
				$form.ajaxSubmit(coverOptionSwatchOptions);
			});

			/* AJAX Request For Base Cover Selection Form Filtering */
			var baseCoverSwatchFiltering = {
				dataType : 'html',
				beforeSubmit : function(arr, $form, options) {
					global[namespace].loader.showLoader();
				},
				success: function(responseText, statusText, xhr, $form) {
					if (statusText == 'success') {
						var swatchGroupId = $form.data('swatchgroup-id'),
							responseSwatchListHTML = $(responseText).find('#' + swatchGroupId).html(),
							$coverSelection = $form.closest('#cover-selection').find('.accordion-body-content').first(),
							$noResultsContent = $('#no-searched-covers'),
							$clearSearchButton = $form.find('#cover-search-clear'),
							$fieldId = $form.context.id,
							thisVal = '',
							resultsCounter = 0;

							// set value var and show/hide search button
							if ($fieldId === 'cover-search-submit') {
								thisVal = $form.find('#cover-search').val().toUpperCase();
								$clearSearchButton.removeClass('hide');
							}
							else {
								thisVal = $form.context.value.toLowerCase();
								$clearSearchButton.addClass('hide');
							}

						// destroy slider
						$coverSelectionSwatchList.slick("unslick");
						// hide no-results content
						$noResultsContent.addClass('hide');
						// remove previous pre filter selection html
						$coverSelection.find('.pre-filter-selected').remove();
						// update swatch list html
						$('#' + swatchGroupId).html(responseSwatchListHTML);

						// move the pre selected filter radio outside of the swatch list results if it is not in the selected filter configuration so the slider does not render the pre-selection.
						var $preFilterSelectedDiv = $('#' + swatchGroupId).find('.pre-filter-selected'),
							$preFilterSelectedAnchor = $preFilterSelectedDiv.find('a.cover');
						
						var coverTypeSelected;
						if ($fieldId === "cover-type" && $preFilterSelectedAnchor.data('cover-type') === undefined) {
							coverTypeSelected = '';
						} else {
							coverTypeSelected = $preFilterSelectedAnchor.data('cover-type');
						}
	
						// Base Cover
						if ($fieldId === "cover-type" && !coverTypeSelected.includes(thisVal) ||
							$fieldId === "color-family" && $preFilterSelectedAnchor.data('color-family') != thisVal ||
							$fieldId === "cover-pattern" && $preFilterSelectedAnchor.data('color-pattern') != thisVal ||
							$fieldId === "cover-search-submit" && $preFilterSelectedAnchor.data('coverid') != thisVal
						) {

							$preFilterSelectedDiv.appendTo($coverSelection).hide();
						}

						// update swatch group title results count
						$('#' + swatchGroupId).find('.cover-selection-swatches').each(function(index){
							var $this = $(this),
								swatchCount = $this.find('.cover').length
								selectedFilter = arguments[0];

							$this.find('.group-count').html(swatchCount);

							if (swatchCount > 0) {
								$this.show();
								if($this.data('hideRow')==true && selectedFilter !== 'unfilter') {
									$this.removeClass('hide');
								}
							} else {
								$this.hide();
								if($this.data('hideRow')==true) {
									$this.addClass('hide');
								}
							}
						},[thisVal]);

						// loop through each swatch list and determine if we have results to render.
						$('#' + swatchGroupId).find('.swatch-list').each(function(index){
							var $this = $(this);
							resultsCounter += $.trim($this.html()).length;
						});

						// check if we have results or no results
						if (resultsCounter > 0) {
							// ReInitialize Slider
							$body.find('.cover-selection-swatches .swatch-list').slick(coverSelectionSwatchSliderSettings);
						} else {
							// display no results message
							$noResultsContent.removeClass('hide');
						}

						// ReInitialize tooltip
						$body.find('.cover-group-title [data-tooltip]').tooltip();
						global[namespace].loader.hideLoader();
					}
					else {
						console.log('Malformed Response : missing statusText parameter:');
						global[namespace].loader.hideLoader();
					}
				},
				error: function(xhr, statusText, exception, $form) {
					console.log('AJAX Error:');
					global[namespace].loader.hideLoader();
				}
			};

			/* Click Event for Base Cover Search Filtering */
			$('#cover-filter-form #cover-search-submit').click(function(e) {
				var $form = $(this).closest('form'),
					$filterInput = $form.find('#cover-search'),
					filter = $filterInput.val();

				e.preventDefault();

				if (filter) {
					// reset select forms
					resetFormSelects();
					// Submit Cover Swatch Filter Form Using AJAX
					$form.ajaxSubmit(baseCoverSwatchFiltering);
				}
			});

			/* Click Event for Base Cover Search Filtering */
			$('#cover-filter-form #cover-search-clear').click(function(e) {
				var $form = $(this).closest('form'),
					$filterInput = $form.find('#cover-search');

				e.preventDefault();

				// clear search input
				$filterInput.val('');
				// reset select forms
				resetFormSelects();
				// Submit Cover Swatch Filter Form Using AJAX
				$form.ajaxSubmit(baseCoverSwatchFiltering);
				// hide clear search button
				$(this).addClass('hide');
			});

			/* Change Event for Base Cover Select Filtering */
			$('.cover-filter-form select, #inStock').on('change', function() {
				var $this = $(this),
					$form = $this.closest('form'),
					$filterInput = $form.find('#cover-search'),
					filterID = $this.attr('id');

				// clear search input
				$filterInput.val('');
				// reset select forms
				resetFormSelects(filterID);
				// Submit Cover Swatch Filter Form Using AJAX
				$form.ajaxSubmit(baseCoverSwatchFiltering);
			});
			

			/* Click Event for Cover Selection */
   			$body.on('click', '.cover', function(e){
				e.preventDefault();
				var $this = $(this),
					coversDataObject = {},
					coverId = $this.data('coverid'),
					coverType = $this.data('cover-type'),
					$addToCartForm = $('#add-to-cart-form'),
					$inStoreOnly = $('#in-store-only'),
					$productPrice = $('.product-price'),
					$addToCartLinks = $('.add-to-cart-links'),
					$customOrderNotice = $('.custom-order-notice'),
					$pillowSwatchGroup = $('.pillow-set-color-swatch-group'),
					$pillowSwatchRadio = $('.pillow-fabric-selection').find('.option-pillow-swatch-radio[value="' + coverId + '"]'),
					$accordionPillowOptions = $('#accordion-Pillow-Options'),
					$accordionWeltOptions = $('#accordion-Contrasting-Welt-Option');

   				// update form data value and set selected class
				$('#coverId').val(coverId);
				$('.cover.selected').removeClass('selected');
   				$this.addClass('selected');
				/* Sets the default selected base cover swatch in a hidden form field so we have the value if the user decides to filter the swatch list. */
				$('.filter-form-selected-base-swatch-cover').val(coverId);

				// update all pillow set swatch radios to match base cover if same as cover fabric is checked.
				if ($pillowSwatchGroup.find('.same-as-coverfabric').prop('checked') === true) {
					$pillowSwatchRadio.prop('checked', true);
					$pillowSwatchGroup.find('.filter-form-selected-swatch-cover').val(coverId);
				}

				// Update Cover Group Title with selected cover
				updateCoverGroupTitle();

				// Push Data Into coversDataObject Object
				coversDataObject.accordionTarget = $this.closest('.accordion-container');
				coversDataObject.type = 'cover';
				coversDataObject.swatchImgUrl = $this.data('swatch');
				coversDataObject.summary = coverId;
				coversDataObject.summary2 = $this.data('cover-type');
				coversDataObject.price = $this.data('price-formatted');

				// Update Accordion Title Bar with selected cover
				updateAccordionTitle(coversDataObject, pdpRecordType);

				// Get Configured Product Price & Update Price Display
				ajaxPriceRequest(pdpRecordType);

				// Show instore button if selected cover is a Custom cover
				if ($(this).hasClass('custom')) {
					$addToCartForm.addClass('hide');
					$productPrice.addClass('hide');
					$inStoreOnly.removeClass('hide');
					$addToCartLinks.addClass('hide');
					$customOrderNotice.removeClass('hide');
				}
				else {
					if ($addToCartForm.length) {
						$inStoreOnly.addClass('hide');
						$addToCartForm.removeClass('hide');
					}
					else {
						$inStoreOnly.removeClass('hide');
					}
					$productPrice.removeClass('hide');
					$addToCartLinks.removeClass('hide');
					$customOrderNotice.addClass('hide');
				}

				// Show/Hide product options when Leather covers are selected.
				// Check if selected Cover Type is leather.
				if (coverType === 'leather') {
					// Check if Pillow Accrodion exists and hide it.
					if ($accordionPillowOptions.length) {
						// Hide Pillow options.
						$accordionPillowOptions.addClass('hide');
						// Check if accordion was previously active and close it.
						if ($accordionPillowOptions.find('.accordion-title').hasClass('active')) {
							$accordionPillowOptions.find('.accordion-title').trigger('click');
						}
						// Reset Pillow Quantity to default value if Pillow Quantity is not already the default value.
						var $pillowQTY = $('.pillow-quantity-select');
						if ($pillowQTY.val() != 'Quantity') {
							$pillowQTY.val('Quantity').trigger('change');
						}
						// Deselect any Pillow options by triggering a click on None or Standard .option-tile
						var pillowStandardOption = $accordionPillowOptions.find('.option[data-config="Standard Pillow Comfort"]').closest('.option-tile'),
							pillowEdgeNoneOption = $accordionPillowOptions.find('.option[data-config="None"]').closest('.option-tile');
						// Check if Pillow option Standard exists before triggering a click event.
						if (pillowStandardOption.length) {
							// Trigger click event on Standard option to reset it.
							pillowStandardOption.trigger('click');
						}
						// Check if Pillow Edge option None exists before triggering a click event.
						if (pillowEdgeNoneOption.length) {
							// Trigger click event on None option to reset it.
							pillowEdgeNoneOption.trigger('click');
						}
					}
					// Check if Welt Accrodion exists and hide it.
					if ($accordionWeltOptions.length) {
						// Hide Welt options.
						$accordionWeltOptions.addClass('hide');
						// Check if accordion was previously active and close it.
						if ($accordionWeltOptions.find('.accordion-title').hasClass('active')) {
							$accordionWeltOptions.find('.accordion-title').trigger('click');
						}
						// Deselect any Welt options by triggering a click on None .option-tile
						var weltNoneOption = $accordionWeltOptions.find('.option[data-config="None"]').closest('.option-tile');
						// Check if Welt option None exists and is NOT active before triggering a click event.
						if (weltNoneOption.length && !weltNoneOption.hasClass('active')) {
							// Trigger click event on None option to reset it.
							weltNoneOption.trigger('click');
						}
					}
				}
				else {
					// Show options when leather is selected.
					if ($accordionPillowOptions.length && $accordionPillowOptions.hasClass('hide')) {
						// Show Pillow options.
						$accordionPillowOptions.removeClass('hide');
					}
					if($accordionWeltOptions.length && $accordionWeltOptions.hasClass('hide')) {
						// Show Welt options.
						$accordionWeltOptions.removeClass('hide');
					}
				}
   			});

			/* Click Event to show/hide additional Swatch Options */
			$body.on('click', '.option-tile', function(e){
				e.preventDefault();
				var $this = $(this),
					subOptionDataObject = {},
					parentOptionDataObject = {},
					$accordionContainer = $this.closest('.accordion-container'),
					$radio = $this.find('input.option'),
					$optionContainer = $this.closest('.option-container'),
					$groupedRadios = $optionContainer.find('.option:checked'),
					$optionSwatches = $optionContainer.find('.option-swatches');

				// Show/Hide Additional Swatch Options on .option-tile click
				if ($radio.hasClass('coverOptionRadio') || $radio.attr('data-rel') == 'Finish Options') {
					// Option is Welt or Finish
					var thisDataConfig = $radio.attr('data-config');
					if (thisDataConfig.indexOf('None') > -1 || thisDataConfig.indexOf('Standard') > -1) {
						$optionSwatches.slideUp();

						// reset swatch filters for Welt Option
						if ($accordionContainer.attr('id') === 'accordion-Contrasting-Welt-Option') {
							$optionSwatches.find('.filter-form-selected-swatch-cover').val('');

							$optionSwatches.find('.cover-swatch-filter-form select').each(function(index) {
								if ($(this).val() != '') {
									$(this).val('').trigger('change');
								}
							});
						}
					} else {
						$optionSwatches.slideDown();
						// set position of swatch list slider to fix layout position
						$optionSwatches.find('.swatch-list.slick-initialized').slick('setPosition');
					}
				}

				// set selected radio and active class
				$groupedRadios.prop('checked',false);
				$radio.prop('checked',true);
				$optionContainer.find('.option-tile').removeClass('active');
				$this.addClass('active');

				// Update Accordion Title Bar with selected options
				var subAccordionTitleBarData = getOptionSummaryAndPriceTotal($accordionContainer.find('input.option:checked').not('.hidden-option')),
					parentAccordionTitleBarData = getOptionSummaryAndPriceTotal($('.option-tile input.option:checked').not('.hidden-option'));

				// Push Data Into subOptionDataObject Object
				subOptionDataObject.accordionTarget = $this.closest('.accordion-container');
				subOptionDataObject.swatchImgUrl = $this.find('img').attr('src');
				subOptionDataObject.summary = subAccordionTitleBarData.summary;
				subOptionDataObject.price = subAccordionTitleBarData.price;

				// Update the Pillow Option Accordion Title Bar if inside the Pillow Set 2 Accordion
				if ($accordionContainer.attr('id') === 'accordion-pillow-set-2') {
					var $accordionPillowContainer = $accordionContainer.parent().closest('.accordion-container'),
						accordionPillowTitleBarData = getOptionSummaryAndPriceTotal($accordionPillowContainer.find('input.option:checked').not('.hidden-option')),
						pillowOptionDataObject = {};

					// Push Data Into pillowOptionDataObject Object
					pillowOptionDataObject.accordionTarget = $accordionPillowContainer;
					pillowOptionDataObject.summary = accordionPillowTitleBarData.summary;
					pillowOptionDataObject.price = accordionPillowTitleBarData.price;

					// Update Accordion Title Bar with selected Options
					updateAccordionTitle(pillowOptionDataObject, pdpRecordType);
				}

				// Push Data Into parentOptionDataObject Object
				parentOptionDataObject.accordionTarget = $optionsSelectionAccordion;
				parentOptionDataObject.summary = parentAccordionTitleBarData.summary;
				parentOptionDataObject.price = parentAccordionTitleBarData.price;

				// Update Accordion Title Bar with selected Options
				updateAccordionTitle(subOptionDataObject, pdpRecordType);
				updateAccordionTitle(parentOptionDataObject, pdpRecordType);

				// Get Configured Product Price & Update Price Display
				ajaxPriceRequest(pdpRecordType);
			});

			/* Click Event for option cover swatches. */
		   	$body.on('click', '.option-cover-swatches .option-pillow-swatch-radio, .option-cover-swatches .option', function(e){
				var $this = $(this);
				// updates the hidden filter form selected swatch data so we don't loose the selection when the user filters.
				$(this).closest('.option-cover-swatches').find('.filter-form-selected-swatch-cover').val($this.val());
			});

			/* Keyboard Accessible Event for Option Cover Swatches */
			$body.on('keydown', '.options-label-button', function(e){
				var $this = $(this),
					kCode = e.which;
				if (kCode === 13) {
					e.stopPropagation();
					if ($this.siblings().hasClass('option')) {
						// siblings is a welt swatch
						$this.siblings('.option').trigger('click');
					} else {
						// siblings is a pillow swatch
						$this.siblings('.option-pillow-swatch-radio').trigger('click');
					}
				}
			});

			/* Click Event for Optional Finish Sub Swatches */
			$body.on('click', '.option-finish-img', function(){
				var $this = $(this),
					thisColor = $this.attr('data-displayname');

				// set selected class
				$('.option-finish-img').removeClass('selected');
				$this.addClass('selected');

				// update display UI
				$('.option-selected-color').html(thisColor);
			});

			/* Keyboard Accessible Event for Finish Sub Swatch Options & Option Tile */
			$body.on('keydown', '.option-finish-img, .option-tile', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				if (keycode === 13) {
					e.preventDefault();
					$(this).trigger('click');
				}
			});

			/* Change Event for Pillow Option Quantity Select */
			$('.pillow-quantity-select').on('change', function() {
				var $this = $(this),
					thisVal = $this.val(),
					$swatchGroupContainer = $this.closest('.pillow-set-color-swatch-group'),
					$siblingSection = $swatchGroupContainer.find('.pillow-fabric-selection'),
					$optionSwatches = $siblingSection.find('.option-swatches'),
					$numSibling = $swatchGroupContainer.siblings('div'),
					numSiblingDiv = $numSibling.length,
					optionRadioBtn = '',
					$sameAsCoverFabricCheckbox = $swatchGroupContainer.find('.same-as-coverfabric'),
					$pillowFabricSelection= $swatchGroupContainer.find('.pillow-fabric-selection');

				// Check Pillow Quantity and show pillow cover options if qty value is a number
				if (thisVal === 'Quantity') {
					// show 'same as fabric' checkbox.
					$sameAsCoverFabricCheckbox.parent().slideUp();
					// hide pillow cover swatches when qty is not a number.
					$pillowFabricSelection.slideUp();

					// reset checkbox and pillow swatch radio to match base cover.
					var coverID = $('.cover.selected').data('coverid'),
						$pillowSwatchRadio = $pillowFabricSelection.find('.option-pillow-swatch-radio[value="' + coverID + '"]');

					$sameAsCoverFabricCheckbox.prop('checked', true);

					// reset swatch filters
					$siblingSection.find('.filter-form-selected-swatch-cover').val(coverID);
					$siblingSection.find('.cover-swatch-filter-form select').each(function(index) {
						if ($(this).val() != '') {
							$(this).val('').trigger('change');
						}
					});

					if ($pillowSwatchRadio.length > 0) {
						// set pillow swatch radio to match default base cover.
						$pillowSwatchRadio.prop('checked', true);
					} else {
						// set pillow swatch radio to first swatch in swatch list. NOTE: JSP has the same logic when base cover swatch is not available in the pillow swatches.
						$optionSwatches.find('.option-pillow-swatch-radio').first().prop('checked', true);
					}

					// sets the other pillow options qty back to default value of 1 rather than setting the the actual select value "Quantity" string.
					thisVal = 1;
				}
				else {
					// hide 'same as fabric' checkbox.
					$sameAsCoverFabricCheckbox.parent().slideDown();
					// show pillow cover swatches when qty is a number as long as 'same as fabric' checkbox is unchecked.
					if ($sameAsCoverFabricCheckbox.prop('checked') === false) {
						$pillowFabricSelection.slideDown();
					}
				}

				// loops through other pillow options and set the matching pillow qty
				for (var i=0; i < numSiblingDiv; i++) {
					optionRadioBtn = $numSibling.eq(i).find('.option-radio-val');
					if (optionRadioBtn.length > 0) {
						optionRadioBtn.val(thisVal);
					}
				}

				// Get Configured Product Price & Update Price Display
				ajaxPriceRequest(pdpRecordType);
			});

			/* Click Event for Pillow Option Covers Same as Fabric Checkbox */
			$body.on('click', '.same-as-coverfabric', function(){
				var $this = $(this),
					thisChecked = $this.prop('checked'),
					$swatchGroupContainer = $this.closest('.pillow-set-color-swatch-group'),
					$siblingSection = $swatchGroupContainer.find('.pillow-fabric-selection'),
					$optionSwatches = $siblingSection.find('.option-swatches');

				if (thisChecked === false) {
					$optionSwatches.show();
					$siblingSection.slideDown();
					// set position of swatch list slider to fix layout position
					$optionSwatches.find('.swatch-list.slick-initialized').slick('setPosition');
				}
				else {
					$siblingSection.slideUp();
					$optionSwatches.hide();
					// get selected base cover.
					var coverID = $('.cover.selected').data('coverid');

					// reset swatch filters
					$siblingSection.find('.filter-form-selected-swatch-cover').val(coverID);
					$siblingSection.find('.cover-swatch-filter-form select').each(function(index) {
						if ($(this).val() != '') {
							$(this).val('').trigger('change');
						}
					});

					// selector for pillow swatch radio that matches the base coverID value.
					var $pillowSwatchRadio = $optionSwatches.find('.option-pillow-swatch-radio[value="' + coverID + '"]');

					if ($pillowSwatchRadio.length > 0) {
						// set pillow swatch radio to match default base cover.
						$pillowSwatchRadio.prop('checked', true);
					} else {
						// set pillow swatch radio to first swatch in swatch list. NOTE: JSP has the same logic when base cover swatch is not available in the pillow swatches.
						$optionSwatches.find('.option-pillow-swatch-radio').first().prop('checked', true);
					}
				}
			});

			/* Click Event for Add To Cart */
			$body.on('click', '#add-to-cart-submit', function(){
				// Build itemInfo JSON for configurable product record types ONLY
				if (pdpRecordType != 'simple' && pdpRecordType != 'licensed') {
					var cartRequest = JSON.stringify(getCartRequest());

					// TODO: Should encode this content for dom, but doing so breaks the form handler back-end.
					$('#iteminfo').val(cartRequest);
					// console.log(cartRequest);
				}

				// Add To Cart AJAX Request
				var addToCartOptions = {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							var $productAddToCart = $('.product-add-to-cart');
							global[namespace].loader.hideLoader();

							if (responseText.success == 'true') {
								var $addToCartModal = document.getElementById('add-to-cart-modal') ? $('#add-to-cart-modal') : global[namespace].utilities.createModal('add-to-cart-modal');

								// store addedItem json data for modal rendering
								$('#addToCartModalJSON').val(encodeURIComponent(JSON.stringify(responseText.addedItem)));
								// Display Add to Cart Confirmation Modal
								$addToCartModal.modal({'url': CONSTANTS.contextPath + '/browse/ajax/addToCartModal.jsp'});

								// update header cart item counter
								global[namespace].profileController.getProfileStatus(true);

								// Detach and ReInitialize add to cart Sticky element incase there were previous form errors that got hidden. This will recalculate the offset height.
								stickyDetach($productAddToCart);
								stickyInit();
							}
							else {
								global[namespace].loader.hideLoader();
								global[namespace].utilities.form.showErrors($form, responseText);

								// Detach and ReInitialize add to cart Sticky element when there are form errors to show. This will recalculate the offset height.
								stickyDetach($productAddToCart);
								stickyInit();
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

				// Submit Add To Cart Form Using AJAX
				$('#add-to-cart-form').ajaxForm(addToCartOptions);
			});

			/* Click Event for Add To Cart */
			$body.on('click', '.add-plan', function(){
				var configcommid = $(this).attr('data-commerceid');
				$('#addPlan').find('#confId').val(configcommid);
				$('#addPlan').submit();
			});

			/* END: Product Configuration Events
			========================================================= */

			/* START: Establish Existing Product Configuration
			   Load Edit Product Configuration. Occurs when ?commid= is passed to a product page url from the cart product link.
			   NOTE: Sectional JSON structure is different from standard configurable products. This code does not support the sectional JSON which is currently
					 fine because full sectionals are now split into sectional pieces in the cart.
			========================================================= */
			var jsonReqInput = $('#jsonReqInput').val();
			if (typeof(jsonReqInput) != 'undefined' && jsonReqInput.length > 0) {
				console.log('START: Establish Existing Product Configuration');
				console.log($.parseJSON(jsonReqInput));
				console.log('END: Establish Existing Product Configuration');

				var editJson = $.parseJSON(jsonReqInput),
					editQty = $('#itemQtyValue').val(),
					coverOptionSkus = editJson.coveroptionskus,
					editCoverid = '',
					itemSubSkuid = '',
					itemType = '';

				// update quantity if quantity exists
				if ($quantity.length > 0) {
					// update quantity value
					$quantity.val(editQty);
				}

				// Loop through coverOptionSkus
				if (typeof(coverOptionSkus) != 'undefined') {
					for (var i=0; i < coverOptionSkus.length; i++) {
						itemSubSkuid = coverOptionSkus[i].subskuid;
						itemType = coverOptionSkus[i].type;

						// Cover SKU Data
						if (itemType === 'cover') {
							editCoverid = itemSubSkuid;
							// update cover accordion if cover accordion exists
							if ($coverSelectionAccordion.length > 0) {
								// set cover configuration
								$coverSelectionAccordion.find('.cover[data-coverid="' + editCoverid + '"]').trigger('click');
							}
						}
						// Option SKU Data
						else if (itemType === 'option') {
							// update options accordion if options accordion exists
							if ($optionsSelectionAccordion.length > 0) {
								var $optionRadio = $optionsSelectionAccordion.find('.option[value="' + itemSubSkuid + '"]'),
									$radioOptionSwatches = $optionRadio.closest('.option-container').find('.option-swatches');

								// set option tile configurations
								$optionRadio.closest('.option-tile').trigger('click');

								// optional welt sub options
								if ($optionRadio.data('config') === 'Contrasting Welt') {
									// set welt swatch configuration
									$radioOptionSwatches.find('.option[value="' + coverOptionSkus[i].options[0].subskuid + '"]').trigger('click');
								}
								// optional finishes sub options
								else if ($optionRadio.data('config') === 'Optional Finishes') {
									// set finish swatch configuration
									$radioOptionSwatches.find('[data-finishcode="' + coverOptionSkus[i].options[0].subskuid + '"]').trigger('click');
								}
							}
						}
						// Pillow Option SKU Data
						else if (itemType === 'P1' || itemType === 'P2') {
							// update pillow accordion if pillow accordion exists
							if ($optionsSelectionAccordion.find('#accordion-Pillow-Options').length > 0) {
								var pillowQty = coverOptionSkus[i].qty;
								// change pillow qty
								$('#pillowQuantitySelect_' + itemSubSkuid).val(pillowQty).trigger('change');

								// set pillow swatch
								if (coverOptionSkus[i].options[0].subskuid != editCoverid) {
									// uncheck same as fabric checkbox
									$('.option-checkbox-' + itemType).trigger('click');
									// select pillow swatch configuration
									$('.pillow-fabric-selection-' + itemType + ' .swatch-list [value="' + coverOptionSkus[i].options[0].subskuid + '"]').trigger('click');
									// set data attribute to let the imageComposer know we need to override the default active pillow options on load.
									$imageComposer.data('pillow-' + itemType, true);
								}
							}
						}
					}
				}
			}
			/* END: Establish Existing Product Configuration
			========================================================= */

			/* Initialize Product Image Composer after all events and product configurations have been set. */
			if ($imageComposer.length > 0) {
				$imageComposer.imagecomposer();
			}

			/* Click Event for Product Details Anchor Link */
			$body.on('click', '.product-details-link a', function(e){
				e.preventDefault();
				$('html, body').animate({
				    scrollTop: $('#productDetails').position().top - 125
				}, 400);
			});

			/* Click Event for Augmented Reality(AR) Action */
		   	$body.on('click', '.ar-link', function(e){
				e.preventDefault();
				var $this = $(this),
					$addToCartForm = $('#add-to-cart-form'),
					linkAction = $this.attr('href'),
					imageComposerRequest = decodeURIComponent($imageComposer.attr('data-json')),
					cartRequest = '';

				// Only passes cartRequest data if add to cart button is visible at time of event. This prevents wrong products from getting added to the cart from AR app.
				if ($addToCartForm.length && !$addToCartForm.hasClass('hide')) {
					cartRequest = JSON.stringify(getCartRequest());
				}

				// create new url link with encoded data.
				var encodedCartRequest = Base64.encode('imagecomposer=' + imageComposerRequest + '&iteminfo=' + cartRequest),
					newLinkAction = global[namespace].utilities.addURLParameter(linkAction, 'data', encodedCartRequest);

				// update href attribute
				$this.attr('href', newLinkAction);
				// redirect to action url
				window.location.href = newLinkAction;
			});
		},
		addItemToCart : function () {
			var encodedIteminfo = $('#encodedIteminfo').val(),
				$addToCartForm = $('#add-item-to-cart-form'),
				$actionContent = $('#action-content');

			if (encodedIteminfo.length > 0) {
				var decodedIteminfo = $.parseJSON(Base64.decode(encodedIteminfo));

				// update form field values
				$('#dealerid').val(decodedIteminfo.dealerid);
				$('#productid').val(decodedIteminfo.productid);
				$('#catalogrefid').val(decodedIteminfo.catalogrefid);
				$('#iteminfo').val(JSON.stringify(decodedIteminfo));
				$('#quantity').val(decodedIteminfo.qty);

				// Add Item To Cart AJAX Request
				var addItemToCartOptions = {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].utilities.form.hideErrors($form);
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							global[namespace].loader.hideLoader();

							if (responseText.success == 'true') {
								// Redirect user to login or checkout page
								window.location.href = '/rwd/checkout/cart.jsp';
							}
							else {
								global[namespace].loader.hideLoader();
								global[namespace].utilities.form.showErrors($form, responseText);

								if (decodedIteminfo.catalogrefid.length > 0) {
									var $pdpAction = $('.pdp-action');
									// update link url
									$pdpAction.find('.pdp-link').attr('href', CONSTANTS.contextPath + '/mp/_/R-' + decodedIteminfo.catalogrefid);
									// show pdp action content
									$pdpAction.removeClass('hide');
								}
								// show action content
								$actionContent.removeClass('hide');
							}
						}
						else {
							console.log('Malformed JSON : missing statusText parameter:');
							global[namespace].loader.hideLoader();
							global[namespace].utilities.form.ajaxError(xhr, statusText, responseText, $form);
							// show action content
							$actionContent.removeClass('hide');
						}
					},
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
						// show action content
						$actionContent.removeClass('hide');
					}
				};

				// Submit Add Item To Cart Form Using AJAX
				$addToCartForm.ajaxSubmit(addItemToCartOptions);
			}
			else {
				// display error alert box
				var errorMessages = {errorMessages : 'Sorry, we unfortunately are not able to add this product to your cart. Please revisit the product page and try again.'};
				$addToCartForm.prepend(Mustache.render(global[namespace].templates.errorMessageTemplate, errorMessages));
				// show action content
				$actionContent.removeClass('hide');
			}
		}
	};

	global[namespace] = global[namespace] || {};

	global[namespace].browse = browse;

})(this, window.jQuery, "LZB");
