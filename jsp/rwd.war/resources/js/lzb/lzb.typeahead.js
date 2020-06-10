/* =========================================================
 * lzb.typeahead.js
 * =========================================================

 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Typeahead = function Typeahead(element, options) {
				this.init ('typeahead', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug;

	//PUBLIC
	Typeahead.prototype = {
		constructor: Typeahead,
		init: function init(type, element, options) {
			if (loggingDebug) {
				console.debug('init typeahead with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}

			var self = this,
					counter = 0;


			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);
			var headerType = element.dataset.contentType;
			this.selectors = {
						$body : $('body'),
						resultsContainer: 'keyword-search-' + headerType,
						$topSearches : $('.top-searches-' + headerType),
						typeaheadSuggestions : '.search-results-' + headerType,
						$typeaheadSuggestions : $('.search-results-' + headerType),
						typeaheadProducts : '.typeahead-products-' + headerType,
						$typeaheadProducts : $('.typeahead-products-' + headerType),
						$noSuggestionsMsg : $('.typeahead-no-suggestions-' + headerType),
						$productsContainer : $('.typeahead-products-' + headerType),
						$searchMenu : $('.search-menu'),
						$searchBar : $('#searchBar-' + headerType),
						$searchForm : $('#searchForm-' + headerType),
						$offCanvas : $('.off-canvas-wrap'),
						$typeaheadPromos : $('.typeahead-promos')
					  };


			this.$element.keyup(function(e) {
				var searchTerm = String($(this).val());
				if (searchTerm.length >= self.options.trigger_num_chars) {
					//no!
					self.showResults(searchTerm, self.selectors.$typeaheadSuggestions);
				}
				else {
					self.hideResults();
				}

				// update offCanvas container height as results content changes - FOR MOBILE ONLY.
				if (self.$element.attr('id') == 'keyword-mobile') {
					var containerHeight,
						mobileHeaderOffset = $('#mobile-header-container').outerHeight(),
						offCanvasHeight = mobileHeaderOffset;
					// need a setTimeout to wait for content elements to update.
					setTimeout(function(){
						// get offCanvas container height
						$('.off-canvas-search').children('div').each(function () {
			                offCanvasHeight += $(this).outerHeight(true);
			            });
						// change height of offCanvas container
						self.selectors.$offCanvas.animate({height: offCanvasHeight}, 500);
					}, 500);
				}
			});

			self.selectors.$body.on('mouseenter', self.selectors.typeaheadSuggestions + ' li a', function(e){
				self.showProducts($(this).data('detail-url'), self.selectors.$productsContainer);
			});

			self.selectors.$body.on('mouseleave', self.selectors.typeaheadSuggestions + ' li a', function(e){
				self.showProducts($(this).data('detail-url'), self.selectors.$productsContainer);
			});

			self.selectors.$body.on('focus', self.selectors.typeaheadSuggestions + ' li a', function(e){
				self.showProducts($(this).data('detail-url'), self.selectors.$productsContainer);
			});

			// make typeahead details keyboard accessible
			self.selectors.$body.on('keydown', self.selectors.typeaheadSuggestions + ' a', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				if (keycode == 9 && !e.shiftKey) {
					if ($(self.selectors.typeaheadProducts + ' a').length > 0 && !$(this).hasClass('see-all-results')) {
						e.preventDefault();
						$(self.selectors.typeaheadProducts + ' li:first a').focus();
					} else {
						e.preventDefault();
						$('.close-off-canvas-link').focus();
					}
				}
			});
			self.selectors.$body.on('keydown', self.selectors.typeaheadProducts + ' a:last', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				if (keycode == 9 && !e.shiftKey) {
					var $next = $(self.selectors.typeaheadSuggestions + ' a[data-detail-url="' + $(self.selectors.typeaheadProducts).attr('data-detail-url') + '"]').parent().next();
					if ($next.length > 0) {
						e.preventDefault();
						$next.find('a').focus();
					}
					else {
						e.preventDefault();
						$('.see-all-results').focus();
						//self.hideResults();
					}
				}
			});
			self.selectors.$body.on('keydown', self.selectors.resultsContainer + ' a', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				if (keycode == 13 || keycode == 32) {
					window.location.href = this.href;
				}
			});
		},
		hideResults : function (){
			this.selectors.$typeaheadSuggestions.hide();
			this.selectors.$typeaheadProducts.hide();
			this.selectors.$noSuggestionsMsg.hide();
			this.selectors.$typeaheadSuggestions.empty();
			this.selectors.$typeaheadProducts.empty();
			this.selectors.$topSearches.show();
			this.selectors.$typeaheadPromos.show();
		},
		showResults : function (searchTerm, $results) {
			var self = this;
			$.ajax({
				//url: global[namespace].constants.contextPath + '/sitewide/json/typeahead.jsp',
				url: '/typeahead/suggest/' + searchTerm + '.js',
				dataType: 'json',
				success: function(data){
					var query = data.searchTerm,
							queryBold = '<strong>$1</strong>',
							suggestions = data.results,
							output = '',
							count = 0;

					// make query string bold in suggestions list
					$(suggestions).each(function(e){
						data.results[count].term = this.term.replace(new RegExp('(' + query + ')', 'gi'), queryBold);
						count++;
					});

					// hide default content divs and show results content divs
					self.selectors.$topSearches.hide();
					self.selectors.$typeaheadSuggestions.show();
					self.selectors.$typeaheadProducts.show();
					self.selectors.$noSuggestionsMsg.hide();
					self.selectors.$typeaheadPromos.hide();

					// define results path per header type
					if (self.selectors.$typeaheadSuggestions.hasClass('search-results-mobile')) {
						// set path for mobile
						data.resultsPath = '/ms';
					}
					else {
						// set path for desktop
						data.resultsPath = '/s';
					}

					// apply mustache template
					output = Mustache.render(global[namespace].templates.typeaheadSuggestionsTemplate, data);
					$results.html(output);

					// call the first detailUrl
					if (suggestions.length > 0) {
						self.showProducts(suggestions[0].detailUrl);
					}
					else {
						self.selectors.$productsContainer.html();
					}

					// hide results on click
					self.selectors.$body.on('click', function(){
						if(!self.selectors.$offCanvas.hasClass('offcanvas-overlap')){
							self.hideResults();
						}
					});
				},
				error: function(data){
					console.log('error: ', data);
				}
			});
			$results.removeClass('hide');
		},
		showProducts: function(detailUrl) {
			var self = this;
			$.ajax({
				url: detailUrl,
				dataType: 'json',
				success: function(data){
					var sections = data.sections,
					resultsProducts = {},
					outputProducts = '';

					for (var i=0; i<sections.length; i++){
						if($(sections)[i].title == "Products"){
							resultsProducts = sections[i];
						}
					}

					// hide no suggestions message.
					self.selectors.$noSuggestionsMsg.hide();

					// define product path per header type
					if (self.selectors.$typeaheadProducts.hasClass('typeahead-products-mobile')) {
						// set path for mobile
						resultsProducts.productPath = '/mp';
					}
					else {
						// set path for desktop
						resultsProducts.productPath = '/p';
					}

					// apply mustache template
					outputProducts = Mustache.render(global[namespace].templates.typeaheadProductsTemplate, resultsProducts);
					self.selectors.$productsContainer.attr('data-detail-url', detailUrl);
					self.selectors.$productsContainer.html(outputProducts);
				},
				error: function(data){
					console.log('error: ', data);
				}
			});

		}
	};

	$.fn.typeahead = function typeahead(option) {
		var el = this,
				options = $.extend({}, $.fn.typeahead.defaults, typeof option === 'object' && option);
		return el.each(function () {
			var data = $.data(this, 'typeahead');
			if (!data) {
				$.data(this, 'typeahead', (data = new Typeahead(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				}
			}
		});
	};

	$.fn.typeahead.defaults = {
		trigger_num_chars:3
	};

	$.fn.typeahead.Constructor = Typeahead;


	$(function () {
		$('[data-typeahead]').typeahead();
	});


}(this, window.jQuery, "LZB"));
