(function (global, namespace ) {
	"use strict";

	var templates = {
		errorMessageSimpleTemplate:
			'<div class="simple-box alert-box error" role="alert">' +
				'<div class="error-message">' +
					'<span class="icon icon-error"></span>' +
					'<p>{{#errorMessages}}{{.}}<br/>{{/errorMessages}}</p>' +
				'</div>' +
			'</div>',
		errorMessageTemplate:
			'<div class="error-box alert-box error" role="alert">' +
				'<div class="error-message">' +
					'<span class="icon icon-error"></span>' +
					'<p>{{#errorMessages}}{{.}}<br/>{{/errorMessages}}</p>' +
				'</div>' +
			'</div>',
		alertMessageTemplate:
			'<div class="info-box alert-box info" role="alert">' +
				'<div class="info-message">' +
					'<span class="icon icon-info"></span>' +
					'<p>{{#alertMessages}}{{.}}<br/>{{/alertMessages}}</p>' +
				'</div>' +
			'</div>',
		successMessageTemplate:
			'<div class="success-box alert-box success" role="alert">' +
				'<div class="success-message">' +
					'<span class="icon icon-valid"></span>' +
					'<p>{{#successMessages}}{{.}}<br/>{{/successMessages}}</p>' +
				'</div>' +
			'</div>',
		typeaheadSuggestionsTemplate : '<h4 class="search-title">Results</h4><ul class="link-list">{{#results}}<li><a href="'+ global[namespace].constants.contextLinkPath + '{{resultsPath}}{{{url}}}" data-detail-url="{{{detailUrl}}}">{{{term}}}</a></li>{{/results}}</ul><a href="' + global[namespace].constants.contextLinkPath + '{{resultsPath}}?Ntt={{searchTerm}}" class="see-all-results" aria-label="See All Search Results">See All Results <span class="icon icon-arrow-right" aria-hidden="true"></span></a>',
		typeaheadProductsTemplate : '<h4 class="search-title">Top Matching Products</h4><ul class="link-list">{{#links}}<li><a href="'+ global[namespace].constants.contextLinkPath + '{{productPath}}{{url}}" aria-label="{{title}}"><img src="{{{image}}}" alt="{{title}}"><p class="product-name">{{title}}</p><p class="product-price">{{price}}</p></a></li>{{/links}}</ul>',
		drilldownBackLinkTemplate : '<li class="back"><a href="#" tabindex="0"><span class="icon icon-arrow-left" aria-hidden="true"></span>{{linkText}}</a></li>',
		orderTotals : '<div class="total-row subtotal"><div class="total-label">Subtotal</div><div class="total-amount">{{orderSubtotal}}</div></div>' +
		'<div class="total-row shipping"><div class="total-label">Delivery</div><div class="total-amount">{{orderShipping}}</div></div>' +
		'<div class="total-row tax"><div class="total-label">Tax</div><div class="total-amount">{{orderTax}}</div></div>' +
		'{{#recycleFee}}' +
		'<div class="total-row recycling-fee">' +
			'<div class="total-label">' +
				'Recycling Fee' +
				'<span data-tooltip class="has-tip tip-left radius icon icon-info" title="<p>RECYCLING FEE</p>Your state legislation requires an additional fee to cover the proper recycling of old mattresses. This fee is set and paid to the Mattress Recycling Council."><span class="sr-only">RECYCLING FEE. Your state legislation requires an additional fee to cover the proper recycling of old mattresses. This fee is set and paid to the Mattress Recycling Council.</span></span>' +
				'<a href="' + global[namespace].constants.contextPath + '/checkout/ajax/financialStackModal.jsp?type=recyclingFee" class="modal-trigger" data-dismiss="modal" data-target="financial-stack-modal" tabindex="0" aria-label="Click to open details about Recycling Fee"><span class="icon icon-info"></span></a>' +
			'</div>' +
			'<div class="total-amount">{{recycleFee}}</div>' +
		'</div>' +
        '{{/recycleFee}}' +
		'<div class="total-row">&nbsp;</div>' +
		'<div class="total-row total"><div class="total-label">Total</div><div class="total-amount">{{orderTotal}}</div></div>',
		orderTotalsNoTax : '<div class="total-row subtotal"><div class="total-label">Subtotal</div><div class="total-amount">{{orderSubtotal}}</div></div>' +
		'<div class="total-row shipping"><div class="total-label">Delivery</div><div class="total-amount">{{orderShipping}}</div></div>' +
		'<div class="total-row">&nbsp;</div>' +
		'<div class="total-row total"><div class="total-label">Total</div><div class="total-amount">{{orderTotal}}</div></div>',
		orderTotalsWithTaxDown : '<div class="total-row subtotal"><div class="total-label">Subtotal</div><div class="total-amount">{{orderSubtotal}}</div></div>' +
		'<div class="total-row shipping"><div class="total-label">Estimated Delivery</div><div class="total-amount">{{orderShipping}}</div></div>' +
		'<div class="total-row tax"><span class="tax-down-msg"><p>Taxwaress is down<span data-tooltip class="has-tip tip-right radius icon icon-info" title="Your order has been submitted to La-Z-Boy, Inc. however we cannot fully process your order until tax can be assigned.  You will receive an email with the full amount of your order including tax when your order is processed.  If you have any questions please contact our Comfort Care Team, 1-800-375-6890."><span class="sr-only">Your order has been submitted to La-Z-Boy, Inc. however we cannot fully process your order until tax can be assigned.  You will receive an email with the full amount of your order including tax when your order is processed.  If you have any questions please contact our Comfort Care Team, 1-800-375-6890.</span></span></p>For now, your order will be submitted without tax.  The taxable amount will be applied later.</span></div>' +
		'<div class="total-row">&nbsp;</div>' +
		'<div class="total-row total"><div class="total-label">Total</div><div class="total-amount">{{orderTotal}}</div></div>',
		cartItemOnSalePrice : '<span class="regular-price">{{listPriceTotal}}</span><span class="sale-price">{{salePriceTotal}}</span>',
		cartItemPrice : '<span class="item-total-price">{{listPriceTotal}}</span>',
		removeProtectionPlan : '{{planName}}: <a id="treat_{{commerceItemId}}" href="#" class="add-remove-plan js-add-plan" data-ciid="{{commerceItemId}}">Add Plan for {{planPrice}}</a>',
		addProtectionPlan: '{{planName}}: <span class="total-plan-price hide-for-medium">{{totalPlanPrice}}</span><a id="treat_{{commerceItemId}}" href="#" class="add-remove-plan js-remove-plan" data-ciid="{{commerceItemId}}">Remove Plan</a><div class="total-plan-price hide-for-small">{{totalPlanPrice}}</div>',
		appliedPromotions : '{{#appliedPromotions}}<div class="promo-applied"><a class="view-details" href="#">{{couponMessage}}</a><span class="icon icon-remove removeCouponFromCart" couponId="{{couponCode}}">remove</span></div>{{/appliedPromotions}}',
		cartItemUnitPrice : '<div class="price"><div class="regular-price">{{itemUnitPrice}}</div>{{#itemUnitOriginalPrice}}<div class="original-price">Was {{itemUnitOriginalPrice}}</div>{{/itemUnitOriginalPrice}}{{#itemUnitSavings}}<div class="savings">Saved {{itemUnitSavings}}</div>{{/itemUnitSavings}}</div>',
		cartItemSubtotal : '<div class="price"><span class="original-price">{{itemSubtotalPrice}}</span>{{#itemSubtotalSavings}}<div class="savings">Saved {{itemSubtotalSavings}}</div>{{/itemSubtotalSavings}}</div>',
		estimatedShippingMethodsTemplate : '{{#variantShippingMethods}}<div class="shipping-container"><div class="shipping-methods"><div class="shipping-date"><strong>{{date}}</strong></div><div class="shipping-cost"><span class="price">{{price}}</span><span class="shipping-day">{{type}}</span></div></div></div>{{/variantShippingMethods}}',
		storeResultsListTemplate :
			'{{#stores}}' +
				'<div class="store-content store-add">' +
					'<h2>More Stores Near Me</h2>' +
					'<ul class="store-results-list">' +
						'{{#locations}}' +
							'<li>' +
								'<div class="address">' +
									'<h3 class="name">{{name}}</h3>' +
									'<p class="street-address">{{address}}&nbsp;{{address2}}&nbsp;{{address3}}</p>' +
									'<p class="state">{{city}},&nbsp;{{state}},&nbsp;{{zip}}</p>' +
									'<p class="distance"></p>' +
								'</div>'+
								'<input type="hidden" name="latitude" value="{{lat}}">' +
								'<input type="hidden" name="longitude" value="{{lng}}">' +
								'<div class="actions">'+
									'<a href="tel:{{phoneNum1}}-{{phoneNum2}}-{{phoneNum3}}" class="button secondary"><span class="icon icon-phone"></span>{{phoneNum1}}-{{phoneNum2}}-{{phoneNum3}}</a>'+
									'<a href="//www.google.com/maps/place/{{address}}+{{city}}+{{state}}+{{zip}}" class="button primary get-direct right">Get Directions</a>'+
									'{{#available}}' +
										'{{{preferredStoreButton}}}' +
									'{{/available}}' +
								'</div>' +
							'</li>' +
						'{{/locations}}' +
						'{{^locations}}' +

						'{{/locations}}' +
					'</ul>' +
				'</div>' +
			'{{/stores}}',
		addToCartModalTemplate :
			'<div class="add-to-cart-modal">' +
				'<div class="modal-header">' +
					'<div class="title-bar">' +
						'<h2 class="title">{{numOfItemAdded}} Item added to your cart</h2>' +
					'</div>' +
				'</div>' +
				'<div class="modal-body">' +
					'<div class="purchased-details">' +
						'<div class="cart-success-buttons">' +
							'<a href="/rwd/checkout/cart.jsp" class="button tertiary">Checkout</a>' +
							'<button data-dismiss="modal" class="button secondary">Continue shopping</button>' +
						'</div>' +
					'</div>' +
					'<div class="purchased-item">' +
						'<h3>{{configSkuDisplayName}}</h3>' +
						'<div class="purchased-image"><img src="{{productImgURL}}" alt="{{configSkuDisplayName}}" /></div>' +
						'{{#protectionPlan}}' +
							'<div class="protection-plan">' +
								'<img src="{{protectionPlanSmallImgURL}}" alt="Protection Plan Badge" />' +
								'<p>Protect your new furniture from common accidental stains and spills with a <strong>{{protectionPlanDisplayName}}</strong></p>' +
								'<div><strong>Only ${{protectionPlanPrice}}</strong> <button class="button primary medium add-plan" data-commerceId="{{commerceItemId}}">Add Plan</button></div>' +
							'</div>' +
						'{{/protectionPlan}}' +
					'</div>' +
				'</div>' +
				'{{#relatedProducts.length}}' +
					'<div class="modal-footer">' +
						'<div class="also-available">' +
							'<h4>Customers also purchased</h4>' +
							'<ul>' +
								'{{#relatedProducts}}' +
									'<li><a class="also-available-prod" href="{{url}}">' +
										'<img src="{{imageUrl}}" alt="{{name}}"/>' +
										'<div class="also-available-prod-name">{{name}}</div>' +
									'</a></li>' +
								'{{/relatedProducts}}' +
							'</ul>' +
						'</div>' +
					'</div>' +
				'{{/relatedProducts.length}}' +
			'</div>',
		pdpAccordionTitleBarSwatchTemplate : '<div class="selected-swatch"><img src="{{swatchImgUrl}}"></div>',
		facetItemTemplate :
			'<div class="facet custom-checkbox" data-id="{{facetID}}" data-nstate="{{facetURL}}" data-cat="{{facetCat}}">' +
				'<input id="{{facetID}}" type="checkbox" name="style" value="{{facetURL}}">' +
				'<label for="{{facetID}}">{{labelText}} <span class="ref-count">({{facetCount}})</span></label>' +
			'</div>'
	};

	if (!global[namespace]) {
		global[namespace] = {};
	}
	global[namespace].templates = templates;

}(this, "LZB"));
