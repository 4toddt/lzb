/* ========================
 Google Tag Manager Analytics
 =========================*/

var dataLayer = dataLayer || [];

(function (global, $, digitalData, namespace) {

	"use strict";

var analytics = {},
		viewedPromotions = [];

	function findById(idValue, arr) {
		return findProperty(idValue, arr, "id");
	}
	function findByPid(idValue, arr) {
		return findProperty(idValue, arr, "pid");
	}
	function findProperty(propertyValue, arr, propertyName) {
		if (arr) {
			for (var i=0; i < arr.length; i++) {
				if (arr[i][propertyName] === propertyValue) {
					return i;
				}
			}
		}
		return -1;
	}

	function getCookieConfig(storageType) {
		var cookieConfig = {};
		if (digitalData.checkoutStep === 1 ||
				(storageType && storageType=="cart")) {
			// checkout pages - cart products saved in semi-permanent cookies
			cookieConfig.name = "products";
			cookieConfig.options = {path : '/', expires: 1*365};
		} else {
			// otherwise, products stored only until end of session
			cookieConfig.name = "productsTemp";
			cookieConfig.options = {path : '/', expires: 1};
		}
		return cookieConfig;
	}

	/* ========================
	 getProductCategory()
	 The product category is how the user found the product
	 and is saved in / retrieved from cookie
	 =========================*/
	function getProductCategory(pid, cookieIt) {
		var category, product;
		product = getProductFromStorage(pid, cookieIt);
		if (product) {
			category = product.category;
		}
		return category;
	}
	/* ========================
	 getProductList()
	 The product list is where the user found the product
	 and is saved in / retrieved from cookie
	 =========================*/
	function getProductList(pid, cookieIt) {
		var list, product;
		product = getProductFromStorage(pid, cookieIt);
		if (product) {
			list = product.list;
		}
		return list;
	}
	/* ========================
	 getProductFromStorage()
	 Retrieve the product from cookie.
	 =========================*/
	function getProductFromStorage(pid, cookieConfig) {
		var cookieProducts, product, productIndex;
		pid = pid.toString();
		if (!cookieConfig) {
			cookieConfig = getCookieConfig();
		}
		cookieProducts = decodeURIComponent($.parseJSON($.cookie(cookieConfig.name)));
		productIndex  = findById(pid, cookieProducts);
		if (productIndex > -1) {
			product = cookieProducts[productIndex];
		}
		return product;
	}

	function removeProductFromStorage(pid, cookieConfig) {
		var productIndex, cookieProducts;
		if (!cookieConfig) {
			cookieConfig = getCookieConfig();
		}
		cookieProducts = decodeURIComponent($.parseJSON($.cookie(cookieConfig.name)));
		if (!cookieProducts) {
			return [];
		}
		productIndex  = findById(pid, cookieProducts);
		// replace stored product with latest selection
		if (productIndex > -1) {
			cookieProducts.splice(productIndex,1);
		}
		$.cookies(cookieConfig.name, cookieProducts, cookieConfig.options);
		return cookieProducts;
	}

	/* ========================
	 addProductToStorage(pid, category, list)
	 Store some product data into a cookie. This is for storing browsing data such as category and list that is not
	 available to us in checkout.
	 =========================*/
	function addProductToStorage(productId, category, list, cookieConfig) {
		if (!cookieConfig) {
			cookieConfig = getCookieConfig();
		}
		var cookieProducts = removeProductFromStorage(productId, cookieConfig);
		cookieProducts.push({
			"id": productId,
			"category": encodeURIComponent(category),
			"list": encodeURIComponent(list)
		});
		//housekeeping. Keep a max of 10 products so that cookie doesn't get to big.
		//Really should need 2 but want to cover a little history navigation (browser back/forward)
		if (cookieConfig.name === "productsTemp" && cookieProducts.length > 10) {
			while (cookieConfig.length > 10) {
				cookieConfig.shift();
			}
		}
		$.cookie.set(cookieConfig.name, cookieProducts, cookieConfig.options);
	}

	/* ========================
	 copyProductToCartStorage(productId)
	 used to move cookie data into a longer term cookie.
	 =========================*/
	function copyProductToCartStorage(productId) {
		var category,list, cookieConfig;
		category = getProductCategory(productId);
		list = getProductList(productId);
		cookieConfig = getCookieConfig("cart");
		addProductToStorage(productId, category, list, cookieConfig);
	}

	function sendProductEvent(event, product) {
		if (!product.category) {
			product.category = getProductCategory(product.id);
		}
		if (!product.list) {
			product.list = getProductList(product.id);
		}

		if (event === "addToCart") {
			copyProductToCartStorage(product.id);
		}

		digitalData.events.push({
			event: event,
			eventProducts : [product]
		});
		analytics.sendEventsTagManager();
	}

	function initializePromotionData(){

		var promotionLinks = $('[data-promotionname]'),
				$promotionLink,
				isVisible = false;
		if (promotionLinks.length > 0 && !digitalData.promotions) {
			digitalData.promotions = [];
		}

		for (var i = 0; i < promotionLinks.length; i++) {
			$promotionLink = $(promotionLinks[i]);
			$promotionLink.attr('data-promoid', 'promo' + i);
			//items in the mega nav or the flexslider are not considered visible on load, will be tracked using sendPromotionsInContainer
			isVisible = ($promotionLink.parents('#big-menu').length === 0 && $promotionLink.parents('.flexslider').length === 0);
			digitalData.promotions.push({
				pid:  'promo' + i,
				name: $promotionLink.data("promotionname"),
				creative: $promotionLink.data("promotionlink"),
				position: $promotionLink.data("promotionposition"),
				viewOnLoad: isVisible
			});
		}
	}

	analytics.init = function(){
		if ("order" in digitalData) {
			if (digitalData.checkoutStep === 7) {
				// order completed - remove products  from local storage
				$.cookies.remove('products', { path: '/' });
			}
		}

		//listen for promotion clicks.
		$('body').on('click', '[data-promotionname]', function(e) {
			var promoId = this.getAttribute("data-promoid");
			if (promoId) {
				analytics.sendPromotionClick(promoId);
			}
		});

		//get the promotion data ready
		initializePromotionData();

		//get the promotions we should send immediately
		var visiblePromotions = [];
		if ("promotions" in digitalData) {
			for (var i = 0; i < digitalData.promotions.length; i++) {
				if (digitalData.promotions[i].viewOnLoad === true) {
					visiblePromotions.push(digitalData.promotions[i]);
				}
			}
		}

		/* send empty keyword search event */
		if ("searchResults" in digitalData.page && digitalData.page.searchResults === 0) {
			digitalData.events.push({
				event: 'noSearchResults'
			});
		}

		/* Store locator and in store availability events */
		if ("locatorResults" in digitalData.page) {
			//In store lookup is Ajax in desktop site so tracking is event based.
			if ("pageType" in digitalData.page && digitalData.page.pageType === "InStoreLookup") {
				analytics.sendInStoreLookup('', digitalData.page.locatorZip, digitalData.page.locatorResults);
			} else {
				//Store locator search is not ajax, so only the empty search results is event based.
				if (digitalData.page.locatorResults === 0) {
					digitalData.events.push({
						event: 'noLocationResults'
					});
				}
			}
		}
		/* send store directions event */
		if ("locatorStoreId" in digitalData.page) {
			digitalData.events.push({
				event: 'storeDirections'
			});
		}
		/* End Store locator and in store availability events */

		/* Listen for promo code removes */
		$("#removeCoupon").on("submit", function(e) {
			var $this = $(this),
					couponId = $this.find('.coupon-id').val();
			analytics.removePromoCode(couponId);
		});

		analytics.sendProductViews();
		analytics.sendPromotionViews(visiblePromotions);
		analytics.sendEventsTagManager();
	};

	analytics.sendEventsTagManager = function() {
		var event;
		if (!digitalData){
			return;
		}
		if (!digitalData.events || digitalData.events.length === 0) {
			return;
		}
		while (digitalData.events.length > 0) {
			event = digitalData.events.splice(0,1);
			dataLayer.push(event[0]);
			console.log(event[0]);
		}
	};

	/* ========================
	 sendPromotionViews()
	 Sends the promotion impression data to google tag manager. Add custom logic in here to remove promotions that are
	 hidden from view when the page loads, these can be sent by sendPromotionsInContainer. This is a cap to how much data
	 can be sent, so this is done in batches.
	 =========================*/
	analytics.sendPromotionViews = function(promotionArray) {
		if (!digitalData.promotions || digitalData.promotions.length === 0 || typeof promotionArray === 'undefined') {
			return;
		}
		var maxToSend = 24,
				promotionsToSend = [];

		for (var i = 0; i < promotionArray.length; i++) {
			if ($.inArray(promotionArray[i].pid, viewedPromotions) === -1) {
				viewedPromotions.push(promotionArray[i].pid);
				promotionsToSend.push(promotionArray[i]);
			}
		}
		if (promotionsToSend.length === 0) {
			return;
		}

		while(promotionsToSend.length) {
			digitalData.events.push({
				event: "promotionView",
				eventPromotions: promotionsToSend.splice(0, maxToSend)
			});
		}
		analytics.sendEventsTagManager();
	};

	/* ========================
	 sendPromotionsInContainer(container)
	 Send in promotion data for promotions inside a container. Used for promotions that are hidden initially and not sent
	 in sendPromotionViews. (like promotions in a megamenu)
	 =========================*/
	analytics.sendPromotionsInContainer = function(container){
		if (!digitalData.promotions || digitalData.promotions.length === 0) {
			return;
		}
		var promotionLinks = $('[data-promotionname]', container),
				promotionsToSend = [];
		for (var i = 0; i < promotionLinks.length; i++) {
			var promoId = promotionLinks[i].getAttribute("data-promoid"),
					promoIdx  = findByPid(promoId, digitalData.promotions),
					promotion;
			if (promoIdx > -1){
				promotion = digitalData.promotions[promoIdx];
				promotionsToSend.push(promotion);
			}
		}
		if (promotionsToSend.length === 0) {
			return;
		}
		analytics.sendPromotionViews(promotionsToSend);
	};

	/* ========================
	 sendPromotionClick()
	 Sends the data for a promotion click to Google Tag Manager by looking up the promotion object by the promotionID
	 parameter. This is a cap to how much data can be sent, so this is done in batches.
	 =========================*/
	analytics.sendPromotionClick = function(promoId) {
		var promotionIndex = findByPid(promoId, digitalData.promotions),
				promotion,
				promotionsToSend = [];
		if (promotionIndex === -1) {
			return;
		}
		promotion = digitalData.promotions[promotionIndex];
		promotionsToSend.push(promotion);
		digitalData.events.push({
			event: "promotionClick",
			eventPromotions: promotionsToSend
		});
		analytics.sendEventsTagManager();
	};

	/* ========================
	 sendProductViews()
	 Sends the product impression data to google tag manager.
	 First, loops through the digitalData.products array and adds the product objects into a productView event.
	 Optionally caps the number of products in the event in order to keep below the 8k data load cap. Pushes the
	 productView event object into the digitalData.events array to queue up processing. Finally, calls
	 analytics.sendEventsToTagManager to process all the events in the queue. This function should fire only one time on
	 the page, sending all the visible products to Google Tag Manager.
	 =========================*/
	analytics.sendProductViews = function() {
		if (!digitalData.products || digitalData.products.length === 0) {
			return;
		}
		var maxToSend = 24,
				tmpProds = digitalData.products.slice(0);
		while(tmpProds.length) {
			digitalData.events.push({
				event: "productView",
				eventProducts: tmpProds.splice(0, maxToSend)
			});
		}
		analytics.sendEventsTagManager();
	};

	/* ========================
	 sendProductClick(productId)
	 Retrieve the product from digitalData products object and add an entry in temp storage for the product category and
	 list. Send a product click event.
	 =========================*/
	analytics.sendProductClick = function(productId) {
		var productIndex, product;
		productIndex  = findById(productId, digitalData.products);
		if (productIndex > -1) {
			product = digitalData.products[productIndex];
			addProductToStorage(productId, product.category, product.list);
			sendProductEvent("productClick", product);
		}
	};

	/* ========================
	 sendRemoveProduct(product)
	 Send a remove from cart event
	 =========================*/
	analytics.sendRemoveProduct = function(productId) {
		var productIndex, product;
		productIndex  = findById(productId, digitalData.order.products);
		if (productIndex > -1) {
			product = digitalData.order.products[productIndex];
			removeProductFromStorage(productId, "cart");
			sendProductEvent("removeFromCart", product);
		}
	};

	/* ========================
	 sendProductDetailView(product)
	 Send a remove from cart event
	 =========================*/
	analytics.sendProductDetailView = function(productId) {
		var productIndex, product;
		productIndex  = findById(productId, digitalData.products);
		if (productIndex > -1) {
			product = digitalData.products[productIndex];
			sendProductEvent("productDetailView", product);
		}
	};

	/* ========================
	 sendModalPageView(name, url, pageType)
	 Used to send data for a pageview into GTM. The url should be the ajax url, not the window location. Use this when
	 you open a modal that loads a new page.
	 =========================*/
	analytics.sendModalPageView = function(name, url, pageType) {
		digitalData.events.push({
			"event": 'modalPageView',
			"eventPage" : {
				"pageName" : name,
				"pageURL" : url,
				"pageType" : pageType
			}
		});
		analytics.sendEventsTagManager();
	};

	/* ========================
	 sendQuickViewClick(productId, url)
	 Registers a product click, a modal page view, and a productDetailView.
	 =========================*/
	analytics.sendQuickViewClick = function(productId, url) {
		var product, productIndex;
		productIndex  = findById(productId, digitalData.products);
		if (productIndex > -1) {
			analytics.sendProductClick(productId);
			product = digitalData.products[productIndex];
			analytics.sendModalPageView("QuickView : " + product.name, url, "quickView");
			analytics.sendProductDetailView(productId);
		}
	};

	/* ========================
	 sendCheckoutOption(checkoutOption)
	 During checkout, registers options the user has selected; there is a limitation of one option per checkout step.
	 Possible options are the card type the user has selected during payment and the user's interactions with the AVS
	 modal.
	 =========================*/
	analytics.sendCheckoutOption = function(checkoutOption) {
		var checkoutStep = digitalData.checkoutStep;
		digitalData.events.push({
			event: 'checkoutOption',
			checkoutStep: checkoutStep,
			checkoutOption : checkoutOption
		});
		analytics.sendEventsTagManager();
	};

	/* ========================
	 removePromoCode(promoCodeId)
	 Send a promo Code remove event with the promo code id and name retrieved from order.discounts.
	 =========================*/
	analytics.removePromoCode = function(promoCodeId) {
		if (typeof promoCodeId != "undefined" && "order" in digitalData && "discounts" in digitalData.order) {
			var index = findById(promoCodeId, digitalData.order.discounts);
			if (index != -1) {
				digitalData.events.push({
					event: 'promoCodeRemove',
					eventDiscount: {
						id: digitalData.order.discounts[index].id,
						name: digitalData.order.discounts[index].name
					}
				});
			}
		}
		analytics.sendEventsTagManager();
	};


	/* ========================
	 sendInStoreLookupModal(productId, url)
	 Sends the modal event for when user launches in-store availability modal
	 =========================*/
	analytics.sendInStoreLookupModal = function(productId, url) {
		var product,
				productIndex  = findById(productId, digitalData.products);
		if (productIndex > -1) {
			product = digitalData.products[productIndex];
			analytics.sendModalPageView( "In-Store Availability: " + product.name, url, "inStoreAvailability");
		}
	};

	/* ========================
	 sendInStoreLookup(productId, zipCode, resultCount)
	 Sends the results when user searches for in-store availability of a product
	 =========================*/
	analytics.sendInStoreLookup = function(productId, zipCode, resultCount) {
		var productIndex, eventProducts = [], product,
				eventName = (resultCount && resultCount > 0) ? "inStoreLookup" : "noAvailabilityResults";
			productIndex  = findById(productId, digitalData.products);
			if (productIndex > -1) {
				product = digitalData.products[productIndex];
				eventProducts.push(product);
			}
		digitalData.events.push({
			"event" : eventName,
			"eventPage" : {
				"locatorZip" : zipCode,
				"locatorResults" : resultCount
			},
			"eventProducts" : eventProducts
		});
		analytics.sendEventsTagManager();
	};

	/* ========================
	 trackEvent(category, action, label, value)
	 generic tracking function that can used in content-managed areas
	 =========================*/
	analytics.trackEvent = function (category, action, label, value) {
		digitalData.events.push({
			event: 'gaEvent',
			eventLabel : label,
			eventCategory: category,
			eventAction: action,
			eventValue : value
		});
		analytics.sendEventsTagManager();
	};

	if (!global[namespace]) {
		global[namespace] = {};
	}
	global[namespace].analytics = analytics;

}(this, window.jQuery, window.digitalData, "LZB"));