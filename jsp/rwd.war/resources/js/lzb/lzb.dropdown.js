/* =========================================================
 * lzb.dropdown.js
 * =========================================================

 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Dropdown = function Dropdown(element, options) {
				this.init ('dropdown', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
			maxPageWidth = global[namespace].config.maxWidth;

	//PUBLIC
	Dropdown.prototype = {
		constructor: Dropdown,
		init: function init(type, element, options) {
			if (loggingDebug) {
				console.debug('init dropdown with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}

			var self = this;

			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);
			this.$toggle = this.$element.find('.dropdown-toggle');
			this.$menu = this.$element.find('.dropdown-menu');

			this.url = this.$element.attr('data-url');
			this.isLoaded = false;

			if (Modernizr.touch) {
				self.options.is_hover = false;
			}

			/* make dropdown keyboard accessible */
			// close dropdown on tab out
			this.$menu.on('keydown', 'a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                // tab keycode
				if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    self.close.call(self);

					/* set specific focus if category features menu to avoid next focus being offCanvas */
					if($(this).hasClass('features-item')) {
						$('.category-navigation-container a.facets-toggle').focus();
					}
                }
            });
			this.$toggle.on('keydown', this, function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
				// tab keycode with shiftKey
				if (keycode == 9 && e.shiftKey) {
                    self.close.call(self);
                }
            });

			/* Event binding */
			if (self.options.is_hover) {
				this.$toggle
						.off('dropdown')
						.on('mouseenter.' + namespace + '.dropdown', function () {
							clearTimeout(self.timeout);
							self.timeout = setTimeout(function () {
								/* small delay before opening the menu means that if you briefly mouse-over another trigger on your
								 way to the menu contents, you won't close this menu and open a neighboring menu */
								self.open.call(self);
							},250);

						})
						.on('mouseleave.' + namespace + '.dropdown', function () {
							clearTimeout(self.timeout);
							self.timeout = setTimeout(function () {
								self.close.call(self);
							}.bind(this), 150);
						});
				this.$menu.on('mouseenter.' + namespace + '.dropdown', function () {
					clearTimeout(self.timeout);
				});
			} else {

				this.$toggle
						.off('dropdown')
						.on('click.' + namespace + '.dropdown', function(e){
							self.toggle();
							e.preventDefault();
						});
				$('body').off('dropdown').on('click.' + namespace + '.dropdown, touchstart.' + namespace + '.dropdown', function (e) {
					//Will close any open item if the click does not originate from this menu
					if ($(e.target).closest(element).length > 0) {
						return;
					}
					self.close.call(self);
				});
			}
		},
		toggle: function () {
			// hasClass('active') is false
			if (this.$element.hasClass('active')) {
				this.close.call(this);
			} else {
				// in touch screen, touch primary nav gets you here
				this.open.call(this);
			}
		},
		close : function (){
			this.$menu.hide();
			this.$element.removeClass('active').attr('aria-expanded', false);

			/* Change desktop search dropdown display state to default UI */
			if (this.$element.hasClass('dropdown-search')) {
				this.$toggle.find('.title').text('Search');
				this.$toggle.find('.icon').removeClass('icon-close').addClass('icon-search');
			}
		},
		open : function (){
			var self = this,
					windowWidth = window.innerWidth,
					toggleLeft = this.$toggle.offset().left,
					menuWidth = this.$menu.outerWidth(),
					forceLeft = false,
					leftPos, rightPos;

			function insertContent(response){
				self.$menu.html(response);
				self.isLoaded = true;
			}

			//clear out css values
			this.$menu.css("left","").css("right","");

			/* edge detection */
			if (toggleLeft + menuWidth > windowWidth || toggleLeft + menuWidth > windowWidth) {
				forceLeft = true;
			}

			if (!forceLeft) {
				leftPos = '0px';
				rightPos = 'auto';
			} else {
				leftPos = 'auto';
				rightPos = '0px';
			}

			if (this.url !== undefined && this.isLoaded === false) {
				if (loggingDebug) {
					console.log('making ajax request');
				}

				$.ajax({
					url: self.url,
					dataType: 'html',
					success: insertContent
				});
			}
			this.$menu.css({"left" : leftPos, "right" : rightPos}).show();
			this.$element.addClass('active').attr('aria-expanded', true);

			/* Change desktop search dropdown display state to open UI */
			if (this.$element.hasClass('dropdown-search')) {
				this.$toggle.find('.title').text('Close');
				this.$toggle.find('.icon').removeClass('icon-search').addClass('icon-close');
			}
		}
	};

	$.fn.dropdown = function dropdown(option) {
		var el = this,
				options = $.extend({}, $.fn.dropdown.defaults, typeof option === 'object' && option),
				args = Array.prototype.slice.call( arguments, 1 );
		return el.each(function () {
			var data = $.data(this, 'dropdown');
			if (!data) {
				$.data(this, 'dropdown', (data = new Dropdown(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				} else if (typeof option == 'string') {
					data[option].apply(data, args);
				}
			}
		});
	};

	$.fn.dropdown.defaults = {
		is_hover : false
	};

	$.fn.dropdown.Constructor = Dropdown;


	$(function () {
		$('[data-dropdown]').dropdown();
	});


}(this, window.jQuery, "LZB"));
