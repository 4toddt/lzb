/* =========================================================
 * lzb.drilldown.js
 * =========================================================
 * Drilldown behavior for a series of links with option to allow only one submenu
 * visable at a time. In order to handle nested drilldown, markup is strict.
 * <div class="drilldown-menu" data-drilldown>
 *   <ul class="drilldown-list">
 *      <li><a href="#">Link 0.1</a></li>
 * 		<li>
 * 			<a href="#">Link with Drilldown 0.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
 * 			<ul class="submenu">
 * 				<li><a href="#">Link 1.1</a></li>
 * 				<li>
 * 					<a href="#">Link with Drilldown 1.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
 * 					<ul class="submenu">
 * 						<li><a href="#">Link 1.2.1</a></li>
 * 						<li>
 * 							<a href="#">Link with Drilldown 1.2.2 <span class="icon icon-arrow-right" aria-hidden="true"></span></a>
 *							<ul class="submenu">
 *								<li><a href="#">Link 1.2.2.1</a></li>
 *								<li><a href="#">Link 1.2.2.2</a></li>
 *								<li><a href="#">Link 1.2.2.3</a></li>
 *								<li><a href="#">Link 1.2.2.4</a></li>
 *								<li><a href="#">Link 1.2.2.5</a></li>
 *								<li><a href="#">Link 1.2.2.6</a></li>
 *							</ul>
 *						</li>
 *						<li><a href="#">Link 1.2.3</a></li>
 *						<li><a href="#">Link 1.2.4</a></li>
 *					</ul>
 *				</li>
 *			</ul>
 *		</li>
 *      <li><a href="#">Link 0.3</a></li>
 *   </ul>
 * </div>
 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Drilldown = function Drilldown(element, options) {
				this.init ('drilldown', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
			utilities = global[namespace].utilities;

	// Private
	// Custom utility menu toggle function
	function toggleUtilityMenu (action, type) {

		var menuElements = {
			secondary : {
				menuActiveClass: 'secondary-menu-active',
				targets: '.mobile-primary-nav, .mobile-utility-nav'
			},
			utility : {
				menuActiveClass: 'utility-menu-active',
				targets: '.mobile-primary-nav, .mobile-secondary-nav'
			}
		},
		$targets = $(menuElements[type].targets),
		$offcanvas = $('.off-canvas-menu');
		if (action === 'show') {
			$offcanvas.addClass(menuElements[type].menuActiveClass);
			$targets.addClass('hide');
		} else {
			$offcanvas.removeClass(menuElements[type].menuActiveClass);
			$targets.removeClass('hide');
		}
	}

	//PUBLIC
	Drilldown.prototype = {
		constructor: Drilldown,
		init: function init(type, element, options) {
			var self = this,
				$body = $('body');

			if (loggingDebug) {
				console.debug('init drilldown with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}
			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);

            // create back menu for each sub menu
            self.createBackButton();

			// set the orginal menu container height for auto height adjustment.
			self.setDefaultMenuHeight();

			// make drilldown menu keyboard accessible
			$body.on('keydown', '.drilldown-list a', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which),
					$next;
				// tab keycode
				if (keycode == 9 && !e.shiftKey) {
					var	$nextDrilldownList = $(this).closest('.drilldown-list').next();
					$next = $(this).parent().next();

					if ($next.length > 0) {
						e.preventDefault();
						if ($next.hasClass(self.options.has_submenu_class_name)) {
							$next.find('> a').focus();
						}
						else {
							$next.find('a, input[type="email"]').first().focus();
						}
					}
					else if ($nextDrilldownList.length > 0){
						e.preventDefault();
						var $subMenu = $(this).parent().parent(),
							isSubMenu = $subMenu.hasClass('submenu');
						if (isSubMenu) {
							$subMenu.find('li.back').first().find('a').trigger('click');
							$subMenu.closest('.has-submenu').find('a').first().focus();
						}
						else {
							$nextDrilldownList.find('a').first().focus();
						}
					}
				}
				// tab keycode with shift key
				else if (keycode == 9 && e.shiftKey) {
					var $prev = $(this).parent().prev(),
						$prevDrilldownList = $(this).closest('.drilldown-list').prev();
					if ($prev.length > 0) {
						e.preventDefault();
						if ($prev.hasClass(self.options.has_submenu_class_name)) {
							$prev.find('> a').focus();
						}
						else {
							$prev.find('a').focus();
						}
					}
					else if ($prevDrilldownList.length > 0){
						e.preventDefault();
						$prevDrilldownList.find('a').first().focus();
					}
				}
				// enter or spacebar keycode
				else if (keycode == 13 || keycode == 32) {
					e.preventDefault();
					$(this).trigger('click');
					$next = $(this).next();
					if ($next.hasClass(self.options.submenu_class_name)) {
						// wait for css animation to complete before setting focus.
						setTimeout(function() {
							$next.find('li').first().find('a').focus();
						}, 500);
					}
					else {
						window.location.href = this.href;
					}
				}
			});
			$body.on('keydown', '.drilldown-list li.back a', function(e){
				var keycode = (e.keyCode ? e.keyCode : e.which);
				// enter or spacebar keycode
				if (keycode == 13 || keycode == 32) {
					e.preventDefault();
					var $prev = $(this).closest('.' + self.options.has_submenu_class_name);
					$(this).trigger('click');
					if ($prev.length > 0) {
						e.preventDefault();
						// wait for css animation to complete before setting focus.
						setTimeout(function() {
							$prev.find('> a').focus();
						}, 500);
					}
				}
			});
			$body.on('focus', 'a.menu-pointer', function(e){
				self.reset();
			});

			// events
			$body.off('.drilldown')
					.on('click.' + namespace + '.drilldown', '.' + this.options.toggle_menu_class, function (e) {
						self.reset();
					})
					.on('click.' + namespace + '.drilldown', '.' + this.options.wrapper_class_name + ' li.' + this.options.has_submenu_class_name + ' > a', function (e) {
						e.preventDefault();
						self.showSubMenu(this);
					})
					.on('click.' + namespace + '.drilldown', '.'  + this.options.wrapper_class_name + ' li.back a', function (e) {
						e.preventDefault();
						self.back(this);
					})
					// Custom account menu events
					.on('click.' + namespace + '.drilldown', '.utility-link', function (e) {
						// e.preventDefault();
						toggleUtilityMenu('show', 'utility');
					})
					.on('click.' + namespace + '.drilldown', '.mobile-utility-submenu', function (e) {
						// e.preventDefault();
						//
						if(e.target.parentElement.classList.contains('back') || !$(this).find('li').hasClass('mobile-sign-in-form') || e.target.classList.contains('create-account-click') || e.target.classList.contains("forgot-password-click") || e.target.classList.contains("fb-login-button")){
							toggleUtilityMenu('hide', 'utility');
						}
					})
					// Custom account menu events
					.on('click.' + namespace + '.drilldown', '.secondary-link', function (e) {
						// e.preventDefault();
						toggleUtilityMenu('show', 'secondary');
					})
					.on('click.' + namespace + '.drilldown', '.secondary-submenu', function (e) {
						// e.preventDefault();
						toggleUtilityMenu('hide', 'secondary');
					});
		},
		setDefaultMenuHeight : function () {
			this.$element.attr('data-default-height', this.$element.outerHeight());
		},
		createBackButton : function () {
			var hassubmenu_class_name = this.options.has_submenu_class_name;
			this.$element.find('ul.' + this.options.submenu_class_name).each(function() {
              var dis     = $(this),
                  disPar  = dis.closest('li'),
				  disLinkText = {'linkText': 'Back'},
				  outputBackLink  = $(Mustache.render(global[namespace].templates.drilldownBackLinkTemplate, disLinkText));

              disPar.addClass(hassubmenu_class_name);
			  outputBackLink.prependTo(dis);
            });
		},
		reset : function () {
            $('.' + this.options.wrapper_class_name).find('li.active').removeClass('active');
			$('.' + this.options.wrapper_class_name).css('height', '');
			toggleUtilityMenu('hide', 'secondary');
			toggleUtilityMenu('hide', 'utility');
		},
		showSubMenu : function (element) {
			$('html, body').scrollTop(0);
			$(element).parent().addClass('active').siblings().removeClass('active');
			if (this.options.auto_height) {
				this.adjustHeight(element);
			}
			$(element).parent().find('.back').focus();
		},
		back : function (element) {
            $(element).closest('ul.' + this.options.submenu_class_name).parent().removeClass('active');
			if (this.options.auto_height) {
				this.adjustHeight(element, 'drillup');
			}
		},
		adjustHeight : function (element, action) {
			var containerHeight,
				mobileHeaderOffset = $('#mobile-header-container').outerHeight(),
				offCanvasHeight = mobileHeaderOffset;

			if (action === 'drillup') {
				var parentSubMenu = $(element).closest('ul.' + this.options.submenu_class_name).parent().closest('ul.' + this.options.submenu_class_name);
				containerHeight = parentSubMenu.outerHeight();
				if (parentSubMenu.length === 0) {
					parentSubMenu = $(element).closest('.' + this.options.wrapper_class_name);
					containerHeight = parentSubMenu.attr('data-default-height');

					// need a setTimeout to wait for height animation to finish.
					setTimeout(function(){
						// get offCanvas container height for drillup
						$('.off-canvas-menu').children('ul, div').each(function () {
				            offCanvasHeight += $(this).outerHeight(true);
				        });
					}, 550);
				}
			} else {
				// get height of menu container
				containerHeight = $(element).siblings('ul.' + this.options.submenu_class_name).outerHeight();

				// Conditional logic for Primary Navigation menu because this menu always shows other drilldown menus from the parent level below it's submenu.
				if ($(element.closest('.' + this.options.wrapper_class_name)).hasClass('mobile-primary-nav')) {
					// need a setTimeout to wait for height animation to finish.
					setTimeout(function(){
						// get offCanvas container height for drilldown
						$('.off-canvas-menu').children('ul, div').each(function () {
							offCanvasHeight += $(this).outerHeight(true);
						});
					}, 550);
				}
				else {
					// get offCanvas container height for drilldown
					offCanvasHeight += (containerHeight + $('.off-canvas-heading').outerHeight(true));
				}
			}
			// change height of menu container
			$(element.closest('.' + this.options.wrapper_class_name)).animate({height: containerHeight}, 0); /* DMI-2076: Remove Menu Animations (original setting: 500) */

			// need a setTimeout to wait for updated height values due to animations.
			setTimeout(function(){
				// change height of offCanvas container
				$('.off-canvas-wrap').animate({height: offCanvasHeight}, 0); /* DMI-2076: Remove Menu Animations (original setting: 500) */
			}, 600);
		}
	};

	$.fn.drilldown = function drilldown(option) {
		var el = this,
				options = $.extend({}, $.fn.drilldown.defaults, typeof option === 'object' && option),
				args = Array.prototype.slice.call( arguments, 1 );
		return el.each(function () {
			var data = $.data(this, 'drilldown');
			if (!data) {
				$.data(this, 'drilldown', (data = new Drilldown(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				} else if (typeof option == 'string') {
					data[option].apply(data, args);
				}
			}
		});
	};

	$.fn.drilldown.defaults = {
		auto_height: true,
		toggle_menu_class: 'masthead-mobile-link-menu',
		wrapper_class_name: 'drilldown-menu',
		has_submenu_class_name: 'has-submenu',
		submenu_class_name: 'submenu'
	};

	$.fn.drilldown.Constructor = Drilldown;


	$(function () {
		$('[data-drilldown]').drilldown();
	});


}(this, window.jQuery, "LZB"));
