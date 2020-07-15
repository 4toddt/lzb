/*!
 * The MAIN Controller
 */

(function (global, $, namespace) {
	//"use strict";

	var CONSTANTS = global[namespace].constants,
		loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
		utilities = global[namespace].utilities,
		$body = $('body');

	/*
	 * Initilization code
	 * Based on Garber-Irish method of DOM-ready execution
	 * @see viget.com/inspire/extending-paul-irishs-comprehensive-dom-ready-execution/
	 *
	 * MAIN is an object that contains dom ready actions for pages.
	 * The format is {namespace}.{controller}.{action}
	 * Three functions are executed on dom ready:
	 * 1) common.init()  - not called for modals.
	 * 2) {controller}.init() or modal.init()
	 * 3) {controller}.{action}()
	 */

	var initFunctions = {
		init : function (pController, pAction, pOptions) {
			// Call the page-specific controller methods

			var body = document.body,
					mController = (pController === undefined) ? body.getAttribute('data-controller') : pController,
					mAction = (pAction === undefined) ? body.getAttribute('data-action') : pAction,
					mOptions = (pOptions === undefined) ? {} : pOptions;

			if (mController !== 'modal'&& mController !== 'proxy') {
				this.fire('common', 'init', mOptions);
			}
			this.fire(mController, 'init', mOptions);
			this.fire(mController, mAction, mOptions);
		},
		fire : function (controller, action, options) {
			var action = (action === undefined) ? 'init' : action;
			if (controller !== '' && this[controller] && typeof this[controller][action] === 'function') {
				if (loggingDebug) {
					console.log('calling:' + controller + '.' + action);
				}
				this[controller][action](options);
			}
		},
		common : {
			init : function(){
				
				$('.phone').mask('(000) 000-0000');
				$('.ccExpDate').mask('00/00');
				
				// Listener for Country dropdown to update State dropdown
				$body.on('change', 'select#selCountry', function() {
					var selectedCountry = $(this).val();
					$.ajax({
                        url:  CONSTANTS.contextPath + '/contactus/stateList.jsp?selectedCountry=' + selectedCountry,
                        type: 'GET',
                        error : function(data){
                        	console.log('An error occurred during state list retrieval.');
                        },
                        success : function(data){
                        	$('#atg_store_stateSelect').html(data);
                        }
                    });
				});
				
				// Initialize Cross Sell Product Slider
				$('.product-tile-slider').slick({
					dots: false,
					infinite: true,
					slidesToShow: 1,
					slidesToScroll: 1,
					mobileFirst: true,
					responsive: [
						{
							breakpoint: global[namespace].config.mediumMin,
							settings: {
								slidesToShow: 3,
								slidesToScroll: 3
							}
						},
						{
							breakpoint: global[namespace].config.largeMin,
							settings: {
								slidesToShow: 4,
								slidesToScroll: 4
							}
						}
					]
				});

				// click event to set focus to search input field when offCanvas is shown.
				$body.on('click', '#mobile-search-icon', function(e){
					if ($('.off-canvas-wrap').hasClass('search-menu')){
						$('#searchForm #keyword').focus();
					}
				});

				/* Mouseover Event to Close Desktop Search Menu if another header menu is opened */
				$('.primary-nav-button, .sub-nav-button').mouseover(function(){
					$('.dropdown-search').dropdown('close');
				});

				// little delay when mousing on/off the minicart to prevent the annoying accidental hover state
				var setTimeoutDelay;
				$('.mini-cart').mouseover(function(){
					setTimeoutDelay = setTimeout(function(){
						$('.mini-cart-expanded').show();
						$('.mini-cart-header').addClass('mini-cart-hover');
					}, 300);
				}).mouseout(function(){
					clearTimeout(setTimeoutDelay);
					setTimeout(function(){
						var isHover = $('.mini-cart-expanded').is(':hover');
						if (isHover !== true) {
							$('.mini-cart-expanded').hide();
							$('.mini-cart-header').removeClass('mini-cart-hover');
						}
					}, 300);
				});

				var profileOptions = {
						dataType : 'json',
						beforeSerialize : function($form) {
						},
						beforeSubmit : function(arr, $form, options) {
							global[namespace].loader.showLoader();
						},
						success: function(responseText, statusText, xhr, $form) {

							if (statusText == 'success') {
								if (responseText.success == 'true') {
									global[namespace].profileController.getProfileStatus(true);
									window.location = window.location.href;
								}
								else {
									global[namespace].loader.hideLoader();
									global[namespace].utilities.form.showErrors($form, responseText);
									var containerHeight = $form.closest('ul.submenu').outerHeight();
									$form.closest('.drilldown-menu').animate({height: containerHeight}, 500);
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
				$('.sign-in-form').ajaxForm(profileOptions);


				/* START: Language Selection
				========================================================= */
				/* NOTE: Language Selection is currently only supported for the desktop expierence.
						This IF checks if desktop utility navigaiton exists with language ID element */
				if ($('.util-nav #currLang').length) {
					//get site language
					var __lang = $('html').attr('lang');

					//pull just the first two characters in case there's a country code associated with the value
					var lang = __lang.substring(0, 2);
					lang = lang.toLowerCase();

					//grab the UL element
					var lang_list = $('.lang-list', this.elem);

					//grab the text value from the li whose data-lang attr mathces the current site language
					var lang_text = $('.lang-list li[data-lang="' + lang + '"]', this.elem).text();

					//detach the li whose lang attr matches the sites language, effectively removing it from the list
					var curr_lang = $('.lang-list li[data-lang="' + lang + '"]', this.elem).detach();

					//set the visible language text to that of the detached li
					var trans_lang = lang_text;
					$('#currLang').text(trans_lang).append('<span class="icon icon-arrow-down"></span>');

					//grab the remaioning li elements (should be all but the one that was detached - matching the site lang)
					var li = lang_list.children('li');

					//sort the remaining LIs, after the current language LI has bee detached
					li.sort(
					    function(a, b){
					        var
					        keyA = $(a).data('lang'),
					        keyB = $(b).data('lang');

					        return (keyA > keyB) ? 1 : 0;
					    }
					);

					//append the sorted LI back to the UL
					$.each(li,
					    function(index, row){
					        $('a', row).removeClass('triangle-down');
					        lang_list.append(row);
					    }
					);

					$('a', curr_lang).text(trans_lang);
					document.getElementById('currLang').style.visibility = 'visible';
				}
				/* END: Language Selection
				========================================================= */


				/* START: Footer Email SignUp Form
				========================================================= */
				function emailSignupSubmitForm() {
				    event.preventDefault();
				    var $form = $(this).closest('form'),
				        formAction = $form.attr('action'),
				        formData = $form.serialize(),
				        $mainForm = $form.find('.main-form'),
				        $errorMessage = $form.find('.error-message'),
				        $successMessage = $form.find('.success-message');

					// Post form data to Eloqua
				    $.post('https://s20103530.t.eloqua.com/e/f2', $form.serialize());

				    $.ajax({
				        url: formAction,
				        data: formData,
				        success: function(data){
				            if(data && data.success === true){
				                $mainForm.addClass('hide');
				                $errorMessage.addClass('hide');
				                $successMessage.removeClass('hide').html(data.successMessage);
				            }

				            if(data && data.success === false){
				                var message ='';
				                if(data.errors){
				                    $.each(data.errors, function(i, obj) {
				                        message= message+ obj.successMessage;
				                        message=message+'<br>';
				                    });
				                }
				                $errorMessage.removeClass('hide').html(message);
				            }
				        }
				    });
				}

				// form submit
				$('#emailSignup').on('click', emailSignupSubmitForm);

				/* END: Footer Email SignUp Form
				========================================================= */
			}
		},
		home : {
			init: function() {

				// home page slider
				$('.hero-slider').slick({
                    infinite: true,
					speed: 300,
					slidesToShow: 1,
					slidesToScroll: 1,
					dots: true,
					arrows: true,
					responsive: [
						{
							breakpoint: global[namespace].config.mediumMin,
							settings: {
								arrows: true
							}
						}
					]
				});
			}
		},
		store : {
			init: function() {
			},
			storeLocator : function() {
				var storesCollection = $('.distance'),
					output = document.getElementById('geolocation_msg');

				function numberWithCommas(x) {
					return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				}

				function getLocation(){
					if (!navigator.geolocation){
						output.innerHTML = '<p>Geolocation is not supported by your browser</p>';
						return;
					}
					function success(position) {
						var latitude  = position.coords.latitude,
							longitude = position.coords.longitude,
							pos       = new google.maps.LatLng(latitude,longitude),
							geocoder  = new google.maps.Geocoder(),
							locInput  = $('input[name=locator]'),
							currentLocLatInput  = $('input[name=currentLocationLat]'),
							currentLocLngInput  = $('input[name=currentLocationLng]'),
							currentLocZipInput  = $('input[name=currentLocationZip]');

						$(currentLocLatInput).val(latitude);  
						$(currentLocLngInput).val(longitude);  
						//get your address based on lat/long
						geocoder.geocode({'latLng': pos},function(results, status){
							if(status === google.maps.GeocoderStatus.OK){
								//break down address to components
								for(var i=0; i < results[0].address_components.length; i++){
									var componentResults = String(results[0].address_components[i].types);
									if(componentResults === 'postal_code') {
										$(locInput).val(results[0].address_components[i].long_name);  //get postal code value
										$(currentLocZipInput).val(results[0].address_components[i].long_name); 
										if($(locInput).val() !== ''){
											$('[name=findStore]').click(); //submit store locator for after zip code found
										}
									}
								}
							}
						});
					}
					function error() {
						$(output).html('Unable to retrieve your location');
					}

					navigator.geolocation.getCurrentPosition(success, error);
				}

				function milesSuccess(position){
					var latitude  = position.coords.latitude,
						longitude = position.coords.longitude,
						currPos       = new google.maps.LatLng(latitude,longitude),
						geocoder  = new google.maps.Geocoder();

					if(storesCollection.length === 0){
						console.log('no stores');
					} else {
						var myCords = new google.maps.LatLng(latitude,longitude);
					//	for(var i = 0; i <= storesCollection.length; i++){
						$('.distance').each(function(i){
							console.log('milesSuccess for loop');
							console.log($(this).parent());
							var currStoreLongitude = $(this).parent().children('input[name="longitude"]').val(),
								currStoreLatitude = $(this).parent().children('input[name="latitude"]').val(),
								storePos = new google.maps.LatLng(currStoreLatitude,currStoreLongitude),
								dist = google.maps.geometry.spherical.computeDistanceBetween(storePos, currPos),
								miles = dist * 0.000621371192,
								prettyMiles = numberWithCommas(miles.toFixed(0));
							$(this).html(prettyMiles + ' miles away');
						});
					}
				}

				function milesError(){
					$(output).html('Unable to retrieve your location');
				}

				navigator.geolocation.getCurrentPosition(milesSuccess, milesError);

				$('a.locator', this.elem).on('click', function(e){
						e.preventDefault();
						getLocation();
					}
				);

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
								//window.location = responseText.url;
								global[namespace].loader.hideLoader();
								$('.store-location-results').html(Mustache.render(global[namespace].templates.storeResultsListTemplate, responseText));
								$('html, body').animate({
								    scrollTop: $('.store-location-results').position().top - 100
								}, 400);
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
		},
		content : {
			init : function() {

			},
			staticContent : function(){

				/**
				 * =============================================================
				 * ====================== COVER SEARCH =========================
				 * =============================================================
				 * 
				 * All cover search scripts are executed within the single
				 * entry point defined below as an IIFE.  This creates its own
				 * namespace and makes it easily collapsible by code editors.
				 * 
				 * Each IIFE inside represents a single module within the
				 * cover search namespace.  These are only ever nested one level
				 * deep, and nothing else (besides the first few lines) is
				 * written here, so you can collapse all the funtions to
				 * see all the modules at once, and then only expand the areas
				 * you need.
				 */
				(function() { // IIFE for namespacing -- cover search modules (all)

					// don't continue unless the cover search element exists on the page.
					var coverSearchEl = document.querySelector('.cust-support.coverSearch');
					if (!coverSearchEl) return;

					// set up local modules to keep each concern separate.
					var modules = {};

					(function(){ // IIFE for namespacing -- cover search modules | template utilities
						'use strict';
		
						// this is the most efficient way to parse HTML, much faster than innerHTML
						var parseHTML = function(htmlStr) {
							var range = document.createRange();
							range.selectNode(document.body); // required in Safari
							return range.createContextualFragment(htmlStr);
						};
						
						// this is the most efficient way to clear HTML, much faster than innerHTML
						var clearHTML = function(element) {
							var i = element.childNodes.length;
							while(i--) {
								element.removeChild(element.lastChild);
							}
						};
		
						// mini-state for tracking template constructors
						var elements = {};
						var initElement = function(key) {
							if (!elements[key]) elements[key] = {};
						};
						var getParentElement = function(key) {
							initElement(key);
							return elements[key].parentElement;
						};
						var setParentElement = function(key, parentElement) {
							initElement(key);
							elements[key].parentElement = parentElement;
						};
						var getCreateElement = function(key) {
							initElement(key);
							return elements[key].createElement;
						};
						var setCreateElement = function(key, createElement) {
							initElement(key);
							elements[key].createElement = createElement;
						};
		
						// deliberately assigning specific functions to an external object
						// essentially makes this a legacy-friendly `export` equivalent
						modules.coverSearchTemplates = {
							getParentElement: getParentElement,
							setParentElement: setParentElement,
							getCreateElement: getCreateElement,
							setCreateElement: setCreateElement,
							parseHTML: parseHTML,
							clearHTML: clearHTML
						};
					})();

					(function(){ // IIFE for namespacing -- cover search modules | state
						'use strict';
		
						// mini-state for tracking search filters
						var state = {
							sortBy: '',
							filters: [],
							details: [],
							allDetails: [],
							page: 1,
							itemsPerPage: 25,
							lastPage: 1
						};
						var stateProxy;
		
						// deliberately assigning specific functions to an external object
						// essentially makes this a legacy-friendly `export` equivalent
						modules.coverSearchState = {
		
							// return proxied state so it can't be assigned directly
							getState: function() {
								return stateProxy;
							},
		
							// this serves as the single point of entry to modify the state
							updateState: function(callback) {
								callback(state);
		
								// clone and freeze an object as the proxy returned by getState
								var stateClone = Object.create(state);
								stateProxy = Object.freeze(stateClone);
							}
						};
					})();

					(function() { // IIFE for namespacing -- cover search modules | utilities
						'use strict';
		
						// "import" the state utilities
						var getState = modules.coverSearchState.getState;
						var updateState = modules.coverSearchState.updateState;
		
						// "import" the template utilities
						var clearHTML = modules.coverSearchTemplates.clearHTML;
						var getParentElement = modules.coverSearchTemplates.getParentElement;
						var getCreateElement = modules.coverSearchTemplates.getCreateElement;
		
						// this retrieves the data from a JSON script tag,
						// then initializes the state based on the result.
						var retrieveAllDetails = function(updateState) {
							var allDetails = JSON.parse(document.querySelector('#CoverData').textContent);
							updateState(function(state) {
								state.allDetails = allDetails;
								state.details = allDetails;
							});
						};
		
						// this injects the cover template into the DOM
						var addCoversToDom = function(details) {
							var createCoverElement = getCreateElement('cover');
							var createNoResultsElement = getCreateElement('coverNoResults');
							var coversEl = getParentElement('cover');
							clearHTML(coversEl);
							if (details.length === 0) return coversEl.appendChild(createNoResultsElement());
							details.forEach(function(detail) {
								coversEl.appendChild(createCoverElement(detail));
							});
						};
		
						// this injects the page number templates into the DOM
						var addPagesToDom = function(getState, maxRange) {
							var state = getState();
							var currentPage = state.page;
							var lastPage = state.lastPage;
		
							// condensing removes 2 pages from the range, on ONE or EACH side.
							// That is, first page + ellipsis AND/OR ellipsis + last page
							var partiallyCondensedRange = maxRange - 2;
							var fullyCondensedRange = maxRange - 4;
		
							// after removing 2 pages, the minimum starting point is always 4
							var minPageAfterCondense = 3;
		
							// after removing 2 pages, the maximum ending point is
							// whatever page comes last in the given range.
							// Start counting from the current page, counting the current page itself, hence -1.
							var maxPageAfterCondense = (currentPage - 1) + partiallyCondensedRange;
		
							// pagination logic
							var pagesFitOnScreen = lastPage <= maxRange;
							var condenseFirst = currentPage > minPageAfterCondense && !pagesFitOnScreen;
							var condenseLast = !pagesFitOnScreen && lastPage > maxPageAfterCondense;
							var fullRange = pagesFitOnScreen
								? lastPage
								: condenseFirst && condenseLast
								? fullyCondensedRange
								: condenseFirst || condenseLast
								? partiallyCondensedRange
								: maxRange;
		
							// find the page to start from
							var firstPageInRange = (lastPage + 1) - fullRange; // counting the last page itself, hence +1.
							var startingPageAfterCondense = condenseLast ? currentPage : firstPageInRange;
							var page = condenseFirst ? startingPageAfterCondense : 1;
		
							// get elements and element constructors
							var createPageNumberElement = getCreateElement('pageNumber');
							var createEllipsisElement = getCreateElement('pageNumberEllipsis');
							var pagesEl = getParentElement('pageNumber');
		
							// update the DOM to reflect the changes
							clearHTML(pagesEl);
							if (condenseFirst) {
								pagesEl.appendChild(createPageNumberElement(1));
								pagesEl.appendChild(createEllipsisElement());
							}
							for (var i = 0; i < fullRange; i++) {
								var isCurrentPage = currentPage === page;
								pagesEl.appendChild(createPageNumberElement(page, isCurrentPage));
								page++;
							}
							if (condenseLast) {
								pagesEl.appendChild(createEllipsisElement());
								pagesEl.appendChild(createPageNumberElement(lastPage));
							}
						};
						
						// use cached data in state to return the range of items on the page.
						// note: this just returns data, it doesn't query nor modify the DOM.
						var getItemsInPage = function(getState) {
							var state = getState();
							var pageNumber = state.page;
							var details = state.details;
							var itemsPerPage = state.itemsPerPage;
							var previousPageNumber = pageNumber > 1 ? pageNumber - 1 : 0;
							var itemsBeforePage = itemsPerPage * previousPageNumber;
							var previousItemIndex = itemsBeforePage > 0 ? itemsBeforePage : 0;
							var lastItemIndex = itemsBeforePage + itemsPerPage;
							return details.slice(previousItemIndex, lastItemIndex);
						};
		
						// this updates the page info in the state
						var updatePageInfo = function(getState, updateState, itemsPerPage) {
							var state = getState();
							var lastPage = Math.ceil(state.details.length / itemsPerPage);
							var lastPageIsSame = lastPage === state.lastPage;
							var itemsPerPageIsSame = itemsPerPage === state.itemsPerPage;
							if (lastPageIsSame && itemsPerPageIsSame) return;
							updateState(function(state) {
								state.itemsPerPage = itemsPerPage;
								state.lastPage = lastPage;
							});
						};
		
						// this updates the DOM to reflect only the current page's items
						var updateItemsOnPage = function(getState) {
							var itemsInPage = getItemsInPage(getState);
							addCoversToDom(itemsInPage);
						};
		
						// this groups all page functions together to update everything at once:
						//  - the state
						//  - the items in the DOM
						//  - the page numbers in the DOM
						var updateFullPage = function(getState, updateState, itemsPerPage, maxPageRange) {
							updatePageInfo(getState, updateState, itemsPerPage);
							updateItemsOnPage(getState);
							addPagesToDom(getState, maxPageRange);
						};
		
						// this changes the page number in the state
						var changePage = function(updateState, page) {
							updateState(function(state) {
								var currentPage = state.page;
								var lastPage = state.lastPage;
								var pageNum =
									typeof page === 'number' ? page
									: page === 'next' && currentPage < lastPage ? currentPage + 1
									: page === 'prev' && currentPage > 1 ? currentPage - 1
									: state.page;
								state.page = pageNum;
							});
						};

						// this sorts the current data by the given option
						var sortCovers = function(updateState, sortBy) {
							updateState(function(state) {
								state.details.sort(function(a, b) {
									var sortValue = sortBy === 'A-Z' ? 1 : -1;
									if (a.title > b.title) return sortValue;
									else if (a.title < b.title) return sortValue * -1;
									else return 0;
								});
							});
						};
		
						// this takes the current filters and runs them against the current data,
						// updating the details in the state.
						var applyFilters = function(getState, updateState) {
							var state = getState();
							var allDetails = state.allDetails;
							var filters = state.filters;
							var filteredDetails = allDetails.filter(function(detail) {
		
								// if even one filter fails to match, skip this item
								var matchedFilters = filters.every(function(filter) {
									return detail[filter.type] === filter.value;
								});
		
								return matchedFilters;
							});
							updateState(function(state) {
								state.details = filteredDetails;
							});
						};
		
						// this adds data for a single filter to the state, then applies them
						var addFilter = function(getState, updateState, type, value) {
							var filterObj = {
								type: type,
								value: value
							};
							updateState(function(state) {
								var currentFilter = state.filters.find(function(filter) {
									return filter.type === type;
								});
		
								// if this filter type already exists, replace it, otherwise, add it
								if (!currentFilter) return state.filters.push(filterObj);
								currentFilter.value = value;
							});
							applyFilters(getState, updateState);
						};
		
						// this removes data for a single filter from the state, then reapplies the remaining filters
						var removeFilter = function(getState, updateState, type) {
							updateState(function(state) {
								state.filters = state.filters.filter(function(filter) {
		
									// only keep this filter if it's not the one we're removing
									return filter.type !== type;
								});
							});
							applyFilters(getState, updateState);
						};
		
						// searching for sku does not impact filters and is not impacted by filters.
						// this will replace details in the state with just a single result.
						var searchForSku = function(updateState, sku) {
							updateState(function(state) {
								var matchedItems = state.allDetails.filter(function(detail) {
									return detail.sku.slice(0, sku.length).toLowerCase() === sku.toLowerCase();
								});
								state.details = matchedItems;
							});
						};
		
						// this is a generic utility to keep event listeners organized
						var addKeyEventListener = function(element, key, callback) {
							element.addEventListener('keydown', function(event) {
								if (event.key === key) callback(event);
							});
						};
		
						// this returns the number of items returned in the filtered results
						var getItemsAmt = function(getState) {
							var state = getState();
							return state.details.length;
						};

						// this adds a cover to the customer's list of saved covers
						var saveCover = function(updateState, sku, wishlistId) {
							var params = '{"dealerid":"","productid":"","catalogrefid":"' + sku + '","exceptionId":"","qty":"1"}';
							var notInWishList = wishlistId === '';
							var action = notInWishList ? 'add_item_to' : 'remove_item_from';
							var ajaxData = notInWishList ? 'favouriteiteminfo=' + params : 'wishlistItemIdToRemove=' + wishlistId;

							// return a promise from the AJAX call
							return $.ajax({
								url: '/browse/action/' + action + '_save_cover_list_action.jsp',
								type: 'post',
								dataType: 'json',
								data: ajaxData,
								success:  function (data) {
									updateState(function(state) {
										var getDetailBySku = function(detail) {
											return detail.sku === sku;
										};
										var loadedDetail = state.details.find(getDetailBySku);
										var cachedDetail = state.allDetails.find(getDetailBySku);
										loadedDetail.wishlistId = notInWishList ? data.giftItemId : '';
										cachedDetail.wishlistId = notInWishList ? data.giftItemId : '';
									});
								}
							});
						};

						var getCurrentPage = function(getState) { return getState().page; };
						var getTotalPages = function(getState) { return getState().lastPage; };
		
						// deliberately assigning specific functions to an external object
						// essentially makes this a legacy-friendly `export` equivalent
						modules.coverSearchUtilities = {
							updateFullPage: updateFullPage.bind(this, getState, updateState),
							changePage: changePage.bind(this, updateState),
							retrieveAllDetails: retrieveAllDetails.bind(this, updateState),
							sortCovers: sortCovers.bind(this, updateState),
							addFilter: addFilter.bind(this, getState, updateState),
							removeFilter: removeFilter.bind(this, getState, updateState),
							applyFilters: applyFilters.bind(this, getState, updateState),
							searchForSku: searchForSku.bind(this, updateState),
							addKeyEventListener: addKeyEventListener,
							getItemsAmt: getItemsAmt.bind(this, getState),
							saveCover: saveCover.bind(this, updateState),
							getCurrentPage: getCurrentPage.bind(this, getState),
							getTotalPages: getTotalPages.bind(this, getState)
						};
					})();

					(function() { // IIFE for namespacing -- cover search modules | search results template
						'use strict';
		
						// "import" each required template utility
						var parseHTML = modules.coverSearchTemplates.parseHTML;
						var setParentElement = modules.coverSearchTemplates.setParentElement;
						var setCreateElement = modules.coverSearchTemplates.setCreateElement;
						
						// this is the HTML template for each cover
						setParentElement('cover', document.querySelector('.coverSearch__covers-js'));
						setCreateElement('cover', function(detail) {

							// Keeping this commented as a "soft removal" in case this needs to come back.
							// var cp = CONSTANTS.contextPath;
							// var fullContextPath = cp === '/mobile' ? cp + '/mb' : cp + '/b';
							// var href = fullContextPath + '/_/N-1k7w5b5?Nr=AND(sku.covers:' + detail.sku + ')';
							
							var wishlistClass = detail.wishlistId === '' ? '' : 'cover__saveIcon--inWishlist';
							return parseHTML('\
								<div class="cover">\
									<figure class="cover__container">\
										<span class="cover__link">\
											<img class="cover__thumbnail" src="//content.la-z-boy.com/Images/Fabrics/Thumbnails/' + detail.sku + '.jpg">\
											<figcaption class="cover__title">\
												' + detail.title + '\
											</figcaption>\
										</span>\
									</figure>\
									<div class="cover__allDetails">\
										<p class="cover__allDetailsTitle">\
											<span class="cover__detailTitle">\
												' + detail.title + '\
											</span>\
											<button class="cover__saveBtn cover__saveBtn-js" data-sku="' + detail.sku + '" data-wishlist-id="' + detail.wishlistId + '" title="Save this cover">\
												<span class="cover__saveIcon ' + wishlistClass + '"></span>\
												<span class="screenReader">Save this cover</span>\
											</button>\
										</p>\
										<p class="cover__detail">\
											<span class="cover__detailTitle">\
												Material:\
											</span>\
											' + detail.material +  '\
										</p>\
										<p class="cover__detail">\
											<span class="cover__detailTitle">\
												Color:\
											</span>\
											' + detail.color +  '\
										</p>\
										<p class="cover__detail">\
											<span class="cover__detailTitle">\
												Pattern:\
											</span>\
											' + detail.pattern +  '\
										</p>\
									</div>\
								</div>\
							');
						});

						// this is the HTML template for each cover
						setParentElement('coverNoResults', document.querySelector('.coverSearch__covers-js'));
						setCreateElement('coverNoResults', function() {
							return parseHTML('\
								<div class="coverSearch__noResults">We didn\'t find any covers to display.</div>\
							');
						});
					})();

					(function() { // IIFE for namespacing -- cover search modules | pagination template
						'use strict';
		
						// "import" each required template utility
						var parseHTML = modules.coverSearchTemplates.parseHTML;
						var setParentElement = modules.coverSearchTemplates.setParentElement;
						var setCreateElement = modules.coverSearchTemplates.setCreateElement;
		
						// this is the HTML template for each page number
						setParentElement('pageNumber', document.querySelector('.coverPagination__numbers-js'));
						setCreateElement('pageNumber', function(pageNum, isCurrentPage) {
							return parseHTML('\
								<a\
									href="#"\
									class="coverPagination__number coverPagination__number-js ' + (isCurrentPage ? 'coverPagination__number--current' : '') + '"\
									data-page="' + pageNum + '"\
								>\
									' + pageNum + '\
								</a>\
							');
						});
		
						// this is the HTML template for the ellipsis between page numbers
						setCreateElement('pageNumberEllipsis', function() {
							return parseHTML('<span class="coverPagination__ellipsis">...</span>');
						});
					})();

					(function() { // IIFE for namespacing -- cover search modules | presentation
						'use strict';

						// query the DOM
						var optionEls = document.querySelectorAll('.filterBar__option-js');
						optionEls = Array.prototype.slice.call(optionEls); // enable foreach on IE11
						var paginationEl = document.querySelector('.coverPagination-js');
						var prevEl = document.querySelector('.coverPagination__prev-js');
						var nextEl = document.querySelector('.coverPagination__next-js');
		
						// toggle the selection of options
						var toggleSelected = function(currentOptionEl, deselectable, override) {
							var modifierClass = currentOptionEl.className.match(/--[^ ]+/)[0];
							var optionType = modifierClass.replace(/--/g, '');
							var optionSelector = '.filterBar__option--' + optionType + '-js';
							var allCurrentOptionEls = document.querySelectorAll(optionSelector);
							allCurrentOptionEls = Array.prototype.slice.call(allCurrentOptionEls); // enable foreach on IE11
							allCurrentOptionEls.forEach(function(optionEl) {
								var isSelected = optionEl.getAttribute('aria-selected') === 'true';
								var isCurrentOptionEl = optionEl === currentOptionEl;

								// this value may select or deselect based on the current UI
								var uiSelect = isCurrentOptionEl && (!isSelected || !deselectable);
								var select = override !== undefined ? override : uiSelect;
								if (isSelected === select) return;
								optionEl.setAttribute('aria-selected', String(select));
							});
						};
		
						// add event listeners
						var toggleSelectedFromEvent = function(event) {
							var target = event.target;
							var deselectableAttr = target.dataset.deselectable;
							var deselectable = !deselectableAttr || deselectableAttr === 'true';
							toggleSelected(target, deselectable);
						};
						optionEls.forEach(function(optionEl) {
							optionEl.addEventListener('click', toggleSelectedFromEvent);
						});

						// hide/show pagination
						var refreshPagination = function(currentPage, pages) {
							var hiddenClass = 'coverPagination--hidden';

							// if there's only one page, hide pagination and escape early
							if (pages === 1) return paginationEl.classList.add(hiddenClass);

							// make sure pagination shows and 'prev' or 'next' is shown or hidden
							// based on whether the user is on the first or last page.
							paginationEl.classList.remove(hiddenClass);
							var addOrRemovePrev = currentPage === 1 ? 'add' : 'remove';
							var addOrRemoveNext = currentPage === pages ? 'add' : 'remove';
							prevEl.classList[addOrRemovePrev](hiddenClass);
							nextEl.classList[addOrRemoveNext](hiddenClass);
						};
		
						// deliberately assigning specific functions to an external object
						// essentially makes this a legacy-friendly `export` equivalent
						modules.coverSearchPresentation = {
							toggleSelected: toggleSelected,
							refreshPagination: refreshPagination
						};
					})();

					(function() { // IIFE for namespacing -- cover search modules | UI interactivity
						'use strict';
		
						// "import" each required utility
						var utils = modules.coverSearchUtilities;
						var retrieveAllDetails = utils.retrieveAllDetails;
						var updateFullPage = utils.updateFullPage;
						var changePage = utils.changePage;
						var sortCovers = utils.sortCovers;
						var addFilter = utils.addFilter;
						var removeFilter = utils.removeFilter;
						var applyFilters = utils.applyFilters;
						var searchForSku = utils.searchForSku;
						var addKeyEventListener = utils.addKeyEventListener;
						var getItemsAmt = utils.getItemsAmt;
						var saveCover = utils.saveCover;
						var getCurrentPage = utils.getCurrentPage;
						var getTotalPages = utils.getTotalPages;
		
						// "import" presentation functions
						var presentation = modules.coverSearchPresentation;
						var toggleSelected = presentation.toggleSelected;
						var refreshPagination = presentation.refreshPagination;
		
						// query the DOM
						var itemsSelectEl = document.querySelector('.searchBar__select--items-js');
						var itemsAmtEl = document.querySelector('.searchBar__itemsAmt-js');
						var materialSelectEl = document.querySelector('.filterBar__select--material-js');
						var colorSelectEl = document.querySelector('.filterBar__select--color-js');
						var patternSelectEl = document.querySelector('.filterBar__select--pattern-js');
						var searchInputEl = document.querySelector('.searchBar__search-js');
						var searchBtnEl = document.querySelector('.searchBar__searchBtn-js');
						var prevPageEl = document.querySelector('.coverPagination__prev-js');
						var nextPageEl = document.querySelector('.coverPagination__next-js');
						var optionEls = document.querySelectorAll('.filterBar__option-js');
						optionEls = Array.prototype.slice.call(optionEls); // enable foreach on IE11
						var sortSelectEl = document.querySelector('.filterBar__select--sort-js');
						var getSaveBtnEls = function() {
							var saveBtnEls = document.querySelectorAll('.cover__saveBtn-js');
							saveBtnEls = Array.prototype.slice.call(saveBtnEls); // enable foreach on IE11
							return saveBtnEls;
						};
						var getPageNumEls = function() {
							var pageNumEls = document.querySelectorAll('.coverPagination__number-js');
							pageNumEls = Array.prototype.slice.call(pageNumEls); // enable foreach on IE11
							return pageNumEls;
						};

						// ---------- misc
						var openLoginModal = function() {
							var loginModalEl = document.querySelector('#login-modal');
							var $modalTarget = loginModalEl ? $(loginModalEl) : utilities.createModal('login-modal', 'medium');
							$modalTarget.modal({'url': CONSTANTS.contextPath + '/account/ajax/loginModal.jsp'});
						};

						// ---------- save cover
						var activateSaveBtn = function(saveBtnEl) {
							var saveIconEl = saveBtnEl.querySelector('.cover__saveIcon');
							var updateWishlistId = function(data) {
								saveBtnEl.dataset.wishlistId = data.giftItemId || '';
								saveIconEl.classList.toggle('cover__saveIcon--inWishlist');
							};
							saveBtnEl.addEventListener('click', function() {
								var sku = saveBtnEl.dataset.sku;
								var wishlistId = saveBtnEl.dataset.wishlistId;
								saveCover(sku, wishlistId)
									.error(openLoginModal)
									.done(updateWishlistId);
							});
						};
		
						// ---------- pagination
						var updateItemsPerPage = function() {
							changePage(1);
							updateItemsOnCurrentPage();
						};
						var activatePageLink = function(pageNumEl) {
							var pageNum = Number(pageNumEl.dataset.page);
							pageNumEl.addEventListener('click', function(event) {
								goToPage(event, pageNum);
							});
						};
						var updateItemsOnCurrentPage = function() {
							var itemsPerPage = Number(itemsSelectEl.value);
							var maxPageRange = 5; // for now this is not responsive.
							updateFullPage(itemsPerPage, maxPageRange);
							getPageNumEls().forEach(activatePageLink);
							getSaveBtnEls().forEach(activateSaveBtn);
							refreshPagination(getCurrentPage(), getTotalPages());
							itemsAmtEl.textContent = getItemsAmt();
						};
						var goToPage = function(event, page) {
							event.preventDefault();
							changePage(page);
							updateItemsOnCurrentPage();
						};
						var goToNextPage = function(event) {
							goToPage(event, 'next');
						};
						var goToPrevPage = function(event) {
							goToPage(event, 'prev');
						};

						// ---------- sort
						var updateSort = function(value) {
							var sortBy = value === 'none' ? 'A-Z' : value;
							sortCovers(sortBy);
							changePage(1); // reset to page one any time the filters are changed
							updateItemsOnCurrentPage();
						};
						var updateMobileSort = function(event) {
							var value = event.target.value;
							updateSort(value);

							// make sure the desktop select box correlates
							sortSelectEl.value = value;
						};
						var updateDesktopSort = function(event) {
							var value = event.target.value;
							updateSort(value);

							// make sure the mobile selection correlates
							var optionsArr = Array.prototype.slice.call(optionEls);
							var targetOption = optionsArr.find(function(option) {
								return option.value === value;
							});
							toggleSelected(targetOption);
						};

						// ---------- filter
						var updateFilter = function(type, value) {
							if (value === 'none') removeFilter(type);
							else addFilter(type, value);
							changePage(1); // reset to page one any time the filters are changed
							updateItemsOnCurrentPage();
						};
						var updateMobileFilter = function(type, value) {
							updateFilter(type, value);
		
							// make sure the desktop select box correlates
							var selectBoxSelector = '.filterBar__select--' + type + '-js';
							var selectBox = document.querySelector(selectBoxSelector);
							selectBox.value = value;

							// clear the sku search
							searchInputEl.value = '';
						};
						var updateDesktopFilter = function(type, value) {
							updateFilter(type, value);
							
							// make sure the mobile selection correlates
							var optionSelector = '.filterBar__option--' + type + '-js';
							var optionEls = document.querySelectorAll(optionSelector);
							optionEls = Array.prototype.slice.call(optionEls); // enable find on IE11
							var targetOption = optionEls.find(function(option) {
								return option.value === value;
							});
							toggleSelected(targetOption);

							// clear the sku search
							searchInputEl.value = '';
						};
						var updateMaterialFilter = function(event) {
							updateDesktopFilter('material', event.target.value);
						};
						var updateColorFilter = function(event) {
							updateDesktopFilter('color', event.target.value);
						};
						var updatePatternFilter = function(event) {
							updateDesktopFilter('pattern', event.target.value);
						};
						var resetAllFilters = function() {
							removeFilter('material');
							removeFilter('color');
							removeFilter('pattern');
							materialSelectEl.value = 'none';
							colorSelectEl.value = 'none';
							patternSelectEl.value = 'none';
							optionEls.forEach(function(optionEl) {
								var deselectableAttr = optionEl.dataset.deselectable;
								var deselectable = !deselectableAttr || deselectableAttr === 'true';
								toggleSelected(optionEl, deselectable, false);
							})
						};
						var updateFilterFromOption = function(event) {
							var option = event.target;
							var modifierClass = option.className.match(/--[^ ]+/)[0];
							var optionType = modifierClass.replace(/--/g, '');
							var isSelected = option.getAttribute('aria-selected') === 'true';
							var value = value = isSelected ? option.value : 'none';
							updateMobileFilter(optionType, value);
						};
		
						// ---------- search
						var searchForSkuFromInput = function() {
							var sku = searchInputEl.value;
							if (sku === '') applyFilters();
							else {
								resetAllFilters();
								searchForSku(sku);
							}
							updateItemsOnCurrentPage();
						};
		
						// initialize the data and then the DOM
						retrieveAllDetails();
						updateItemsOnCurrentPage();
		
						// add event listeners
						itemsSelectEl.addEventListener('change', updateItemsPerPage);
						materialSelectEl.addEventListener('change', updateMaterialFilter);
						colorSelectEl.addEventListener('change', updateColorFilter);
						patternSelectEl.addEventListener('change', updatePatternFilter);
						searchBtnEl.addEventListener('click', searchForSkuFromInput);
						addKeyEventListener(searchInputEl, 'Enter', searchForSkuFromInput);
						nextPageEl.addEventListener('click', goToNextPage);
						prevPageEl.addEventListener('click', goToPrevPage);
						sortSelectEl.addEventListener('change', updateDesktopSort);
						optionEls.forEach(function(option) {
							var isSort = option.classList.contains('filterBar__option--sort');
							if (isSort) option.addEventListener('click', updateMobileSort);
							else option.addEventListener('click', updateFilterFromOption);
						});
					})();

				})();


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
								window.location.href = responseText.url;
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
				
				//order status section 
				$('#anonymous_orders').ajaxForm(basicAjaxOptions);
				
				// manages floating form labels functionality
				var inputs = $('.floating-label-form .move-label');
				for (var i = 0; i < inputs.length; i++) {
					input = inputs[i];
					input.onfocus = function() { $(this).parent().removeClass('filled').addClass('active'); };
					input.onblur = function() {
						if (this.value == '') {
							$(this).parent().removeClass('filled active');
						} else {
							$(this).parent().removeClass('active').addClass('filled');
						}
					};
					if (input.value == '') {
						 $(input).parent().removeClass('filled active');
					} else {
						$(input).parent('').removeClass('active').addClass('filled');
					}
				}
				
				/* START: DSR Page
				========================================================= */
				var $dsrForm = $('#dsrForm');
				
				var urlParams = window.location.search;
				
				// Add 'filled' class to input fields that have values if form handler returns error
				if (urlParams.indexOf('success=false') > 0) {
					$('#dsrForm .move-label').each(function(){
						if ($(this).val()) {
							$(this).parent('div.text').addClass('filled');
						};
					});
				}
				
				var selectedValue = $('input[name="typeOfRequest"]:checked').val();
				if (selectedValue == 'deletion') {
					$('.delete-confirmation-container').removeClass('hide');
				} else {
					$('.delete-confirmation-container').addClass('hide');
					
					// Empty Delete input field
					$('#delete').val('');
				}
				
				$('#dsrForm .type-of-data').on('change', '#account', function(){
					if (this.checked) {
						// display Account Data Authentication section
						$('.additional-auth-info').removeClass('hide');
						$('.account-data-auth').removeClass('hide');
						$('.additional-account-row').addClass('hide');
						$('.account-data-auth .add-more-row').removeClass('hide').show();
					} else {
						// hide Account Data Authentication section, and clear Account Name fields
						$('.account-data-auth').addClass('hide');
						$('.additional-account-row').addClass('hide');
						$('input[name="accountNames"]').val('').parent('.additional-data').removeClass('filled');
						
						if (!$('input:checkbox[name="typeOfData"]:checked').val() || ($('input:checkbox[name="typeOfData"]:checked').val() && $('input:checkbox[name="typeOfData"]:checked').val() == 'Marketing')) { 
							$('.additional-auth-info').addClass('hide');
						}
					}
				});
				
				$('#dsrForm .type-of-data').on('change', '#product', function(){
					if (this.checked) {
						// display Product Data Authentication section
						$('.additional-auth-info').removeClass('hide');
						$('.product-data-auth').removeClass('hide');
						$('.additional-product-row').addClass('hide');
						$('.product-data-auth .add-more-row').removeClass('hide').show();
					} else {
						// hide Account Data Authentication section, and clear Account Name fields
						$('.product-data-auth').addClass('hide');
						$('.additional-product-row').addClass('hide');
						$('input[name="productName"]').val('').parent('.text').removeClass('filled');
						$('input[name="serialNumber"]').val('').parent('.text').removeClass('filled');
						
						if (!$('input:checkbox[name="typeOfData"]:checked').val() || ($('input:checkbox[name="typeOfData"]:checked').val() && $('input:checkbox[name="typeOfData"]:checked').val() == 'Marketing')) { 
							$('.additional-auth-info').addClass('hide');
						}
					}
				});
				
				$('#dsrForm .type-of-request').on('click', 'input[name=typeOfRequest]', function(){
					var selectedValue = $(this).val();
					
					if (selectedValue == 'access' || selectedValue == 'deletion') {
						$('.type-of-data-container').removeClass('hide');
					} else {
						$('.type-of-data-container').addClass('hide');
					}
					
					$('.additional-auth-info').addClass('hide');
					$('.account-data-auth').addClass('hide');
					$('.additional-account-row').addClass('hide');
					$('.product-data-auth').addClass('hide');
					$('.additional-product-row').addClass('hide');
					
					// reset Type of Data
					$('input[name="typeOfData"]').prop("checked", false);
					
					// clear account data and product data fields
					$('input[name="accountNames"]').val('').parent('.text').removeClass('filled');
					$('input[name="productName"]').val('').parent('.text').removeClass('filled');
					$('input[name="serialNumber"]').val('').parent('.text').removeClass('filled');
					
					if (selectedValue == 'deletion') {
						$('.delete-confirmation-container').removeClass('hide');
					} else {
						$('.delete-confirmation-container').addClass('hide');
						
						// Empty Delete input field
						$('#delete').val('');
					}
				});
				
				$dsrForm.on('click', '.account-data-auth .add-more-row', function(){
					$('.additional-account-row').removeClass('hide');
					$(this).hide();
				});
				
				$dsrForm.on('click', '.add-more-prod', function(){
					$(this).parent().next('.additional-data').removeClass('hide');
					$(this).hide();
					if (!$(this).hasClass('second-add-more-product')) {
						$('.second-add-more-product').removeClass('hide').show();
					}
				});
				
				$dsrForm.on('keyup paste change', '#comments', function(text) {
					var $this = $(this),
						maxLength = 254,
						length = $this.val().length,
						limit = maxLength - length;
					
					if(limit < 0){
						var question = $this.val();
						question = question.substr(0, 254);
						$this.val(question);
						limit = 0;
					}

					$dsrForm.find('.characterLimit').html(limit);
				});
				
				/* END: DSR Page
				========================================================= */
				
				/* START: Catalog Request Page
				========================================================= */
				$('.catalog-options').on('change', 'input[type=radio]', function() {
					if (this.value == 'print') {
						$('.catalog-request-content .floating-label-form').show();
						$('#viewCatalogBtn').addClass('hide');
				    }
				    else {
				        $('.catalog-request-content .floating-label-form').hide();
				        $('#viewCatalogBtn').removeClass('hide');
				        $('.catalog-request-content .alert-box').remove();
				    }
				});
				
				// Clear type of furniture error once user select an option
				$('#furnitureStyle').on('change', 'input[type=radio]', function() {
					$('#error-msg-furnitureStyle').remove();
					$('#furnitureStyle').removeClass('error').removeAttr('aria-invalid aria-describedby');
				});
				
				var catalogRequestFormOptions = {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							if (responseText.success == 'true') {
								// Post form data to Eloqua
								$.ajax({
							    	type: 'POST',
							    	url: 'https://s20103530.t.eloqua.com/e/f2',
							      	data: $form.serialize(),
							     	success: function (data) {
							     	},
							     	error: function (data) {
								 		console.log('An error occurred when during Eloqua post.');
								 		console.log(data);
								  	},
									complete: function (data) {
										// redirect to success URL
										window.location.href = responseText.url;
								 	}
								});
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
					error: function(xhr, statusText, exception, $form) {
						console.log('AJAX Error:');
						global[namespace].loader.hideLoader();
						global[namespace].utilities.form.ajaxError(xhr, statusText, exception, $form);
					}	
				};
				$('#catalogRequestForm').ajaxForm(catalogRequestFormOptions);
				/* END: Catalog Request Page
				========================================================= */
				
				/* START: Contact Us Page
				========================================================= */
				// Contact Us Comments Character Count
				var $contactusForm = $('#contactusForm');
				
				$contactusForm.on('change', '#category', function(text) {
					var catValue = $(this).find('option:selected').text().trim();
					
					$.ajax({
						url:  CONSTANTS.contextPath + '/contactus/subcat.jsp?category='+catValue,
                     	type: 'GET',
                    	error : function(data){
                        	console.log('An error occurred when subcategory retrieval.');
                      	},
                     	success : function(data){
                     		$('.cust-supp-add').addClass('cust-supp-hidden');
                        	$('.cust-supp-add').parent('.field-group').addClass('hide');
                        	$('#subCategory').html(data);
                      	}
                 	});
					
					if(catValue.length > 0){
						$('#subCategory').removeAttr('disabled').parent('.custom-select').removeClass('disabled');
					} else {
						$('#subCategory').attr('disabled', true).parent('.custom-select').addClass('disabled').removeClass('filled');
					}
				});
				
				$contactusForm.on('change', '#subCategory', function(){
					var subcatValue = $(this).find('option:selected').text().trim();
					
					revealAdditionalFields(subcatValue);
				});
				
				$contactusForm.on('keyup paste change', '#comments', function(text) {
					var $this = $(this),
						maxLength = 254,
						length = $this.val().length,
						limit = maxLength - length;
					
					if(limit < 0){
						var question = $this.val();
						question = question.substr(0, 254);
						$this.val(question);
						limit = 0;
					}

					$contactusForm.find('.characterLimit').html(limit);
				});
				
				// Reset Contact Us form and scroll to top of page
				$contactusForm.on('click', '.form-reset', function (e) {
					e.preventDefault();
					$contactusForm.trigger('reset');
					$contactusForm.find('div').removeClass('filled active');
					$contactusForm.find('input.error').removeAttr('aria-invalid aria-describedby').removeClass('error');
					$contactusForm.find('select.error').removeAttr('aria-invalid aria-describedby').removeClass('error');
					$contactusForm.find('label').removeClass('error');
					$contactusForm.find('div.error.field-error-text').remove();
					$('html, body').animate({
						scrollTop:0
					});
				});
				
				var contactusFormOptions = {
					dataType : 'json',
					beforeSerialize : function($form) {
						// send email optIn to Eloqua as value 'on' instead of true
                        if ($form.find('#getEmail').prop('checked')) {
                        	$form.find('#emailOptIn').addClass('eloquaFormField').val('on');
                        }
                        else {
                        	$form.find('#emailOptIn').removeClass('eloquaFormField').val('');
                        }
					},
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							if (responseText.success == 'true') {
								// Post form data to Eloqua
								$.ajax({
						            type: 'POST',
						            url: 'https://s20103530.t.eloqua.com/e/f2',
						            data: $form.find('.eloquaFormField').serialize(),
						            success: function (data) {
						            },
						            error: function (data) {
						                console.log('An error occurred when during Eloqua post.');
						                console.log(data);
						            },
									complete: function (data) {
										// redirect to success URL
										window.location.href = responseText.url;
						            }
						        });
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
				$('#contactusForm').ajaxForm(contactusFormOptions);
				
				// Retrieve additional form fields based on selected Category and Subcategory
				function revealAdditionalFields(catValue) {
					$.ajax({
						url: CONSTANTS.contextPath + '/contactus/field.jsp?subCategory='+catValue,
						type: 'GET',
						error : function(){
							console.log('error');
						},
						success : function(data){
							$('.cust-supp-add').addClass('cust-supp-hidden').removeClass('filled');
							$('.cust-supp-add').parent('.field-group').addClass('hide');
							$('.cust-supp-add input').val('');
							$('.cust-supp-add select').val('');
							showHiddenContactFields(data);
						}
					});
				}
				
				// Display hidden additional form fields based on selected Category and Subcategory
				function showHiddenContactFields(data) {
					var jVal = $.parseJSON(data);
					
					if(jVal.fieldArray.length > 0){
						var fieldArrayLength = jVal.fieldArray.length;
						var dataReturnVal = [];
						var lengthDataReturn = $('.cust-supp-add').length;
						var dReturn = '';
						
						for(var k = 0; k < lengthDataReturn; k++){
							dReturn = $('.cust-supp-add').eq(k).attr('data-return');
							dataReturnVal.push(dReturn);
						}
						
						var lenDataReturnArray = dataReturnVal.length;
						
						for(var i = 0; i < fieldArrayLength; i++){
							for(var h = 0; h < lenDataReturnArray; h++){
								if(jVal.fieldArray[i] === dataReturnVal[h]){
									$('.cust-supp-add[data-return="'+dataReturnVal[h]+'"]').removeClass('cust-supp-hidden');
									$('.cust-supp-add[data-return="'+dataReturnVal[h]+'"]').parent('.field-group').removeClass('hide');
								}
							}
						}
					}
				}
				
				/* END: Contact Us Page
				========================================================= */
				
				/* START: Free Swatches Page
				========================================================= */
				// disable submit button if swatches are not checked
				if ($('[name="freeSwatchGroup"]:checked').length > 0){
					$('#sendSwatches').removeAttr('disabled');
				} else {
					$('#sendSwatches').addClass('disabled');
				}

				// check swatch selections to show max error and enable/disable form button
				var limitSelection = function() {
					var maxSelection = 3;
					if ($('[name="freeSwatchGroup"]:checked').length <= maxSelection) {
						$('#swatchLimitMessage').addClass('hide');
					}
					else {
						$('#swatchLimitMessage').removeClass('hide');
						$('html, body').animate({
							scrollTop: $('#swatchLimitMessage').position().top - 100
						}, 400);
						this.checked = false;
					}

					if ($('[name="freeSwatchGroup"]:checked').length > 0) {
						$('#sendSwatches').removeClass('disabled');
					}
					else {
						$('#sendSwatches').addClass('disabled');
					}
				};

				// form handler options
				var freeSwatchFormOptions = {
					dataType : 'json',
					beforeSerialize : function($form) {
						// format phone number so the value is sent in the same format as desktop.
						var $phone = $form.find('#homePhone1'),
							phoneValue = $phone.val();

						phoneValue = phoneValue.replace(/[()]/g, '');
						phoneValue = phoneValue.replace(' ', '-');
						$phone.val(phoneValue);
					},
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							if (responseText.success == 'true') {
								// Post form data to Eloqua
								$.ajax({
						            type: 'POST',
						            url: 'https://s20103530.t.eloqua.com/e/f2',
						            data: $form.serialize(),
						            success: function (data) {
						            },
						            error: function (data) {
						                console.log('An error occurred when during Eloqua post.');
						                console.log(data);
						            },
									complete: function (data) {
										// redirect to success URL
										window.location.href = responseText.url;
						            }
						        });
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

				// change event for swatches checkbox
				$('[name="freeSwatchGroup"]').on('change', limitSelection);
				// form submit
				$('#freeswatchForm').ajaxForm(freeSwatchFormOptions);

				/* Swatch Search */
				$('#swatch-search').on('change paste keyup', '#swatch-search-field', function() {
					var searchValue = $(this).val().toLowerCase(),
						$noResultsMessage = $('.swatch-search-no-results');

					// Filter through each swatch and show the results
					$('.single-swatches .swatch-item').filter(function() {
						var $swatch = $(this),
							rawSearchData = $swatch.data('name') + ' ' + $swatch.data('sku') + ' ' + $swatch.data('keywords'),
							searchDataNoCommas = rawSearchData.replace(/,/g, ' '),
							searchDataCleaned = searchDataNoCommas.replace(/\s\s+/g, ' '),
							result = searchDataCleaned.toLowerCase().indexOf(searchValue, 0);

						$swatch.toggle(result > -1);
					});

					// Show or hide no results message
					if ($('.single-swatches .swatch-item:visible').length > 0) {
						$noResultsMessage.hide();
					}
					else {
						$noResultsMessage.find('.search-term').text(searchValue);
						$noResultsMessage.show();
					}
				});

				/* Swatch Search Button */
				$('#swatch-search').on('click', '.btn-swatch-search', function(e) {
					e.preventDefault();
					$('#swatch-search-field').change();
				});


				/* END: Free Swatches Page
				========================================================= */

				$('.cboxElement').click(function(e) {
					var redirectURL = $(this).attr('data-href');
					if(redirectURL != '' && redirectURL != undefined) {
						if(redirectURL.startsWith("/content", 0)){
							redirectURL = CONSTANTS.contextPath + redirectURL;
						}
						var $modalTarget = document.getElementById('Modal') ? $('#pageRedirectModal') : global[namespace].utilities.createModal('pageRedirectModal', 'small');
						$modalTarget.modal({'url': CONSTANTS.contextPath + '/browse/npc/ajax/pageRedirectModal.jsp?redirectURL=' + redirectURL });
					}
				});
				
				//modal close on click no button on static pages
				$body.on('click','.orange-button',function(e){
					$('.modal-close').click();
				});

		        /* Update Context Path for All Static Pages */
		        $('.npc #site-wrapper').find('a').not('.desktop-only').each(function(){
					var $href = $(this).attr('href');
		        	if($href  != undefined) {
		        		if($href.startsWith("/content", 0)){
		        			$href = CONSTANTS.contextPath + $href;
		        			$(this).attr('href',$href);
		        		}
		        		if($href.startsWith("/b/", 0)){
		        			$href = $href.replace(/b/, "mb"); 
		        			$href = CONSTANTS.contextPath + $href;
		        			$(this).attr('href',$href);
		        		}
						if($href.startsWith("/p/", 0)){
		        			$href = $href.replace(/p/, "mp");
		        			$href = CONSTANTS.contextPath + $href;
		        			$(this).attr('href',$href);
		        		}
						if($href.startsWith("/s?", 0)){
		        			$href = $href.replace(/s/, "ms");
		        			$href = CONSTANTS.contextPath + $href;
		        			$(this).attr('href',$href);
		        		}
		        	}
						});
			}
		},
		modal : {
			init : function(){
				// initialize tabs in the modal
				$('.tabs').tabs();

				// initialize accordion in the modal
				$('.accordion').accordion();

				// initialize validate in the modal
				$('[data-validate]').validate();

				// initialize dropdown in the modal
				$('[data-dropdown]').dropdown();
				
				// initialize tooltip in the modal
				$('[data-tooltip]').tooltip();
			},
			loginModal : function() {
				
				var $loginModal = $('#login-modal');
			 	
				$loginModal.on('shown.bs.modal', function () {
					var headerHeight = $('#mobile-header-container').outerHeight(),
					topPosition = $loginModal.find('.modal-window').offset().top;
					if(headerHeight > topPosition) {
						$loginModal.find('.modal-window').css('top', +headerHeight);
					}
				});
				
				var profileOptions = {
						dataType : 'json',
						beforeSerialize : function($form) {
						},
						beforeSubmit : function(arr, $form, options) {
							global[namespace].loader.showLoader();
						},
						success: function(responseText, statusText, xhr, $form) {

							if (statusText == 'success') {
								if (responseText.success == 'true') {
									global[namespace].profileController.getProfileStatus(true);
									if( responseText.url != ''){
										window.location = responseText.url;
									}else{
										window.location = window.location.href;
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
				$('.sign-in-form').ajaxForm(profileOptions);
			},
			createRegisterModal : function() {
				var $registerModal = $('#create-account-modal');
			 	
				$registerModal.on('shown.bs.modal', function () {
					var headerHeight = $('#mobile-header-container').outerHeight(),
						topPosition = $registerModal.find('.modal-window').offset().top;
					if(headerHeight > topPosition) {
						$registerModal.find('.modal-window').css('top', +headerHeight);
					}
				});
				var profileOptions = {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							if (responseText.success == 'true') {
								// Post form data to Eloqua
								$.ajax({
						            type: 'POST',
						            url: 'https://s20103530.t.eloqua.com/e/f2',
						            data: $form.serialize(),
						            success: function (data) {
						            },
						            error: function (data) {
						                console.log('An error occurred when during Eloqua post.');
						                console.log(data);
						            },
									complete: function (data) {
										// redirect to success url
										window.location.href = responseText.url;
						            }
						        });
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
				$('#registerUser').ajaxForm(profileOptions);
			},
			forgotPasswordModal : function() {
				var passwordResetOptions = {
					dataType : 'json',
					beforeSubmit : function(arr, $form, options) {
						global[namespace].loader.showLoader();
					},
					success: function(responseText, statusText, xhr, $form) {
						if (statusText == 'success') {
							global[namespace].loader.hideLoader();
							if (responseText.success == 'true') {
								$('.modal').modal('hide');
								var $modalTarget = document.getElementById('passwordResetModal') ? $('#passwordResetModal') : global[namespace].utilities.createModal('passwordResetModal', 'small'),
										url = CONSTANTS.contextPath + '/account/ajax/forgotPasswordSuccessModal.jsp',
										option = {'url': url};
								$modalTarget.modal(option);
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
				$('#forgotPasswordForm').ajaxForm(passwordResetOptions);
			},
			viewCoverDetailsModal : function() {
				/* Pan and Zoom for Swatch Image in View Cover Details Modal (plugin used: jquery.panzoom.min.js)
				 * For additional options, refer to https://www.jqueryscript.net/zoom/jQuery-Plugin-For-Panning-Zooming-Any-Elements-panzoom.html
				========================================================= */
				var $section = $('#swatch-image-section');
				$section.find('.panzoom').panzoom({
					$zoomIn: $section.find(".panzoom-in"),
					$zoomOut: $section.find(".panzoom-out"),
					increment: 0.1,
					minScale: 1,
					contain: 'invert'
				}).panzoom('zoom');
			},
			estimateShippingCostModal : function() {
				var container = '#estimated-shipping',
				 	$results = $(container + ' .results'),
				 	$dislaimer = $(container + ' .shipping-cost-disclaimer'),
				 	$modalFooter = $(container + ' .modal-footer'),
				 	$cost = $(container + ' .shipping-cost'),
				 	$estimateShippingModal = $('#estimated-shipping');
				 	
				$estimateShippingModal.on('shown.bs.modal', function () {
					var qty = $('#quantity').val();
					if(qty != ''){
						$('#estShippingQty').val(Number(qty));
					}else{
						$('#estShippingQty').val(1);
					}
				});
				
				var deliveryChargeOptions = {
						dataType : 'json',
						beforeSubmit : function(arr, $form, options) {
							global[namespace].utilities.form.hideErrors($form);
							global[namespace].loader.showLoader();
							$cost.html('');
							$results.addClass('hide');
						},
						success: function(responseText, statusText, xhr, $form) {
							if (statusText == 'success') {
								global[namespace].loader.hideLoader();
								if (responseText.success == 'true') {
									$cost.html('$'+responseText.deliveryCost);
									$results.removeClass('hide');
									//$results.html(Mustache.render(global[namespace].templates.estimatedShippingMethodsTemplate, responseText));
									//$modalFooter.removeClass('hide');
									//$dislaimer.removeClass('hide');
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
				
				$('#deliveryChargeForm').ajaxForm(deliveryChargeOptions);
			},
			videoModal : function() {
				// stop playing video when modal is closed.
				$('.modal #overlay, .modal-close').click(function(e) {
					var $myVideo = $body.find('.video-modal-iframe');
					if($myVideo.length > 0) {
						$myVideo.attr("src", $myVideo.attr("src"));
					}
				});
			},
			addToCartModal : function() {
				var $addToCartModal = $('.add-to-cart-modal'),
					addToCartModalJSON = JSON.parse(decodeURIComponent($('#addToCartModalJSON').val())),
					$productImages = $('.product-images'),
					addToCartImageUrl = $productImages.find('.product-composer').attr('data-image-url'),
					pdpRecordType = $('.product-page').data('product-record');

				if (pdpRecordType === 'configurable' || pdpRecordType === 'sectional') {
					// override product image if image composer and imager is enabled and has an image configuration
					if ($productImages.attr('data-composer-enabled') === 'true' && $productImages.attr('data-imager-enabled') === 'true' && addToCartImageUrl != '') {
						addToCartModalJSON.productImgURL = addToCartImageUrl;
					}
				}

				// render modal content
				$addToCartModal.html(Mustache.render(global[namespace].templates.addToCartModalTemplate, addToCartModalJSON));
			},
			socialShareModal : function() {
				/* PRODUCT SOCIAL SHARING */
				$body.on('click', ".social-share-button", function(e){
					e.preventDefault();

					var url = window.location.href,
						proto = window.location.protocol,
						host = window.location.host,
						domain = proto + '//' + host,
						image = $('#divSpins').data() == undefined ? proto + $('.product-image img').first().attr('src') : $('#divSpins').data('image-url'),
						prodTitle = $('h1.product-name').text(),
						productID = $('#productid').val(),
						coverID = $('#coverId').val(),
						skuNum = $('#catalogrefid').val(),
						prodName = $('h1.product-name').text(),
						$thisModal = $("#social-share-modal"),
						$socialShareModalEmail = document.getElementById('social-share-modal-ext') ? $("#social-share-modal-ext") : global[namespace].utilities.createModal('social-share-modal-ext'),
						externalService = true;

					switch($(this).data('service')) {
						case 'facebook':
						FB.ui(
							{
								method:'share_open_graph',
								action_type:'og.likes',
								action_properties: JSON.stringify(
									{
										object:url,
										'fb:explicitly_shared':true
									}
								)
							},
							function(response){}
						);
						return;
						case 'pinterest':
                            var gListId;
                            /* added for mobile wishlist specific items to get the pdp url */
							if ($(this).attr('data-gListItems')) {
								var gListItem = $(this).attr('data-gListItems');
								gListId = splitGListId(gListItem);
								var dataUrl = $('#shareWishListAnchorId_'+gListId).attr('data-url');
								url = 'http://www.la-z-boy.com'+dataUrl;
							}

							/* this is for mobile wishlist, as img doesn't exist where image above can grab it */
							if (image === undefined) {
								image = $('.wItem-'+gListId).attr('src');
							}

							/* this is for mobile wishlist, as prodTitle doesn't exist where the above can grab it */
							if (prodTitle === undefined) {
								prodTitle = $('.wListProdTitle-'+gListId).html();
								prodTitle = $.trim(prodTitle);
							}

							base = $(this).data('url');
							text = 'Check out what I found at La-Z-Boy! ' + prodTitle;
							itemURL = base + '?url=' + encodeURI(url) + '&media=' + encodeURI(image) + '&description=' + text;
						break;
						case 'twitter':
							if ($(this).closest('div').next().hasClass('btn-primary')) {
								url = $(this).closest('div').next().attr('href');
							}
							else {
								url = window.location.href;
							}
							base = $(this).data('url');
							text = 'Check out what I found at La-Z-Boy! ' + prodTitle + ', ';
							currUrl = url;
							queryStr = '?text=' + text + '&url=' + currUrl + '&WT.mc_id=sharedfromsite&DCSext.w_event_name=Shares&DCSext.w_event_action=pinterest&DCSext.w_event_label=' + prodTitle;
							itemURL = base + queryStr;
						break;
						case 'email':
							base = $(this).data('url');
							queryStr = "?skuNo=" + skuNum + "&ProdName=" + prodName + "&prodId=" + productID + "&coverSkuId=" + coverID;
							itemURL = base + queryStr;
							window.location = itemURL;
							return;
					}
					window.open(itemURL, null, 'height=450,width=540,status=yes,toolbar=no,menubar=no,location=no');
				});
			},
		}

	};

	$.extend(global[namespace], initFunctions);

	$(document).ready(function () {
		global[namespace].init();
	});

})(this, window.jQuery, "LZB");
