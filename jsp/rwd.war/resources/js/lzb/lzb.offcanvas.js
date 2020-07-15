/* =========================================================
 * lzb.offcanvas.js
 * =========================================================
 * This is based off of the Foundation offcanvas plugin, but
 * stripped down to the essentials for this implementation.
 * ========================================================= */

(function (global, $, namespace) {

    "use strict";

    var Offcanvas = function Offcanvas(element, options) {
                this.init ('offcanvas', element, options);
            },
            CONSTANTS = global[namespace].constants,
            loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
            utilities = global[namespace].utilities,
            $menu = $('.off-canvas-menu'),
            $wrap = $('.off-canvas-wrap'),
            $window = $(window);

    function setOffCanvasHeight(){
        // prevent the page from scrolling past the bottom of the off-canvas nav when it's open
        // NOTE: addtional offCanvas height adjustments can be found in lzb.drilldown.js
        var mobileHeaderOffset = $('#mobile-header-container').outerHeight(),
            offCanvasHeight = mobileHeaderOffset;

        // Set offCanvas height for filter facets
        if ($wrap.hasClass('side-facets-overlap')) {
            $('.facet-sidebar').children('div').each(function () {
                offCanvasHeight += $(this).outerHeight(true);
            });
        }
        // Set offCanvas height for sort facets
        else if ($wrap.hasClass('side-sort-overlap')) {
            $('.sort-sidebar').children('div').each(function () {
                offCanvasHeight += $(this).outerHeight(true);
            });
        }
        // Set offCanvas height for search menu
        else if ($wrap.hasClass('search-menu')) {
            $('.off-canvas-search').children('div').each(function () {
                offCanvasHeight += $(this).outerHeight(true);
            });
        }
        // Set offCanvas height for store locator menu
        else if ($wrap.hasClass('locator-menu')) {
            $('.off-canvas-locator').children('div').each(function () {
                offCanvasHeight += $(this).outerHeight(true);
            });
        }
        // Set offCanvas height for header navigation
        else {
            $menu.children('ul, div').each(function () {
                offCanvasHeight += $(this).outerHeight(true);
            });
        }

        $wrap.css('minHeight', $window.height()).css('height', offCanvasHeight);
    }

    function removeOffCanvasHeight(){
        $wrap.css('height', 'auto');
    }

	//PUBLIC
	Offcanvas.prototype = {
		constructor: Offcanvas,
		init: function init(type, element, options) {
			var self = this,
				move_class = '',
				side_facet_class = 'side-facets-overlap',
				side_sort_class = 'side-sort-overlap',
				$body = $('body');

            if (loggingDebug) {
                console.debug('init offcanvas with options:');
                console.debug(Array.prototype.slice.call(arguments));
            }
            this.options = $.extend({}, $.fn[type].defaults, options);
            this.$element = $(element);
            this.menuButtons = {
                'main-menu': $('#mobile-menu-icon'),
                'search-menu': $('#mobile-search-icon'),
                'locator-menu': $('#mobile-locator-icon'),
                'side-facets-overlap': $('.category-navigation-container .facets-toggle'),
                'side-sort-overlap': $('.sort-toggle')
            };

            if (this.options.open_method === 'move') {
                move_class = 'move-right';
            } else if (this.options.open_method === 'overlap_single') {
                move_class = 'offcanvas-overlap-right';
            } else if (this.options.open_method === 'overlap') {
                move_class = 'offcanvas-overlap';
            }

            // make offcanvas menu keyboard accessible
            $body.on('keydown', '.' + move_class + ',.' + side_facet_class + ',.' + side_sort_class, function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                // esc keycode
                if (keycode == 27) {
                    self.closeContent([move_class, side_facet_class, side_sort_class]);
                }
            });

            // Trap focus inside menu until closed
            $body.off('.offcanvas-overlap')
            .on('keydown', '.off-canvas-menu' + ' a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('.off-canvas-menu').find('.close-off-canvas-link').focus();
                }
            })
            .on('keydown', '.off-canvas-search' + ' a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('.off-canvas-search').find('.close-off-canvas-link').focus();
                }
            })
            .on('keydown', '.off-canvas-locator' + ' a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('.off-canvas-locator').find('.close-off-canvas-link').focus();
                }
            })
            .on('keydown', '.facet-sidebar' + ' a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('.facet-sidebar').find('.close-off-canvas-link').focus();
                }
            })
            .on('keydown', '.sort-sidebar' + ' a:last', function(e){
                var keycode = (e.keyCode ? e.keyCode : e.which);
                if (keycode == 9 && !e.shiftKey) {
                    e.preventDefault();
                    $(this).closest('.sort-sidebar').find('.close-off-canvas-link').focus();
                }
            });

			$body.off('.offcanvas')
					.on('click.' + namespace + '.offcanvas', '.off-canvas-toggle', function (e) {
						// hide facet menu
						self.hide(side_facet_class);
						// hide sort menu
						self.hide(side_sort_class);
						// toggle the offcanvas menu
						if(typeof this.dataset.menuType !== undefined) {
							self.switchContent(move_class, this);
						} else {
							self.toggle(move_class, this);
						}
					})
                    .on('click.' + namespace + '.offcanvas', '.facet-title', function (e) {
                        // need a setTimeout to wait for accordion animation to finish.
    					setTimeout(function(){
                            // update offCanvas height if accordion event is triggered
                            setOffCanvasHeight();
                        }, 450);
					})
                    .on('click.' + namespace + '.offcanvas', '.facets-toggle', function (e) {
						// toggle the offcanvas facets menu
						self.toggle(side_facet_class, this);
					})
					.on('click.' + namespace + '.offcanvas', '.sort-toggle', function (e) {
						// toggle the offcanvas sort menu
						self.toggle(side_sort_class, this);
					})
					.on('click.' + namespace + '.offcanvas', '.off-canvas-menu a', function (e) {
						var $parent = $(this).parent();
						if(self.options.close_on_click && !$parent.hasClass('has-submenu') && !$parent.hasClass('back')){
							// close the menu
							self.hide.call(self, move_class);
						} else if ($parent.hasClass('has-submenu')) {
							e.preventDefault();
						}
					})
					.on('click.' + namespace + '.offcanvas', '.exit-off-canvas, .close-off-canvas-link', function (e) {
						e.preventDefault();
                        self.closeContent([move_class, side_facet_class, side_sort_class]);
					});
		},
		toggle: function(class_name, trigger) {
			if (this.$element.is('.' + class_name)) {
				this.hide(class_name);
			} else {
				this.show(class_name);
                this.setFocus(trigger.dataset.target);
			}
		},
		show: function(class_name, trigger) {
			this.$element.trigger('open').trigger('open.' + namespace + '.offcanvas');
			this.$element.addClass(class_name);
			if (trigger) {
				trigger.setAttribute('aria-expanded', 'true');
			} else {
				this.$element.find('.off-canvas-toggle').attr('aria-expanded', 'true');
			}
			setOffCanvasHeight();
		},
		hide: function(class_name, trigger) {
			this.$element.trigger('close').trigger('close.' + namespace + '.offcanvas');
			this.$element.removeClass(class_name);
			if (trigger) {
				trigger.setAttribute('aria-expanded', 'false');
				this.$element.removeClass('main-menu search-menu locator-menu');
			} else {
				this.$element.find('.off-canvas-toggle').attr('aria-expanded', 'false');
			}
			removeOffCanvasHeight();
		},
        closeContent: function(closeElements) {
            //closeElements must be an array
            var classList = this.$element.attr('class').split(' ');
            var filteredClassList = classList.filter(function(currentValue){
                return currentValue.endsWith('-menu');
            });
            if(filteredClassList.length <= 0) {
                filteredClassList = classList.filter(function(currentValue){
                    return currentValue.startsWith('side-');
                });
            }
            var $menuButton = this.menuButtons[filteredClassList[filteredClassList.length - 1]];
            this.$element.removeClass(filteredClassList.join('.'));
            closeElements.map(function(element){
                this.hide(element);
            }, this);
            if(filteredClassList.indexOf('main-menu') != -1){
                this.$element.find('.mobile-primary-nav').removeClass('hide');
            }
            $("#keyword").val('');
            $menuButton.focus();
        },
		switchContent: function(class_name, trigger) {
			//Function to swap content in single off canvas menu

            //Get menu type from data attribute of trigger
            var menuTypeClass = trigger.dataset.menuType + '-menu';
            //Check to see if same trigger was clicked and hide menu
            if(this.$element.hasClass(menuTypeClass)){
                //Remove the class that triggers content
                this.$element.removeClass(menuTypeClass);
                //Hide off canvas
                this.hide(class_name, trigger);
            } else {
                //Check to see if a different trigger was clicked - switch content if previously opened
                var classList = this.$element.attr('class').split(' ');
                var removeClasses = classList.filter(function(className){
                    return className.indexOf('-menu') != -1;
                }).join(' ');
                this.$element.removeClass(removeClasses);
                //Add class to show selected content
                this.$element.addClass(menuTypeClass);
                //Show off canvas - if already opened it will stay opened
                this.show(class_name, trigger);
                this.setFocus(trigger.dataset.target);
            }
        },
        setFocus: function(target, position) {
            var focusable = $('#' + target).find('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
            var firstFocusable = focusable[0];
            var lastFocusable = focusable[focusable.length - 1];

            if(position === "last") {
                $(lastFocusable).focus();
            }
            else {
                // default postion is first focusable element
                $(firstFocusable).focus();
            }
        },
    };

    $.fn.offcanvas = function offcanvas(option) {
        var el = this,
                options = $.extend({}, $.fn.offcanvas.defaults, typeof option === 'object' && option);
        return el.each(function () {
            var data = $.data(this, 'offcanvas');
            if (!data) {
                $.data(this, 'offcanvas', (data = new Offcanvas(this, options)));
            } else {
                if (typeof option === 'object') {
                    $.extend(data.options, option);
                }
            }
        });
    };

    $.fn.offcanvas.defaults = {
        open_method : 'overlap',
        close_on_click : true
    };

    $.fn.offcanvas.Constructor = Offcanvas;


    $(function () {
        $('[data-offcanvas]').offcanvas();
    });


}(this, window.jQuery, "LZB"));
