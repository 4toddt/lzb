/* =========================================================
 /* =========================================================
 * lzb.tabs.js
 * Created by DMI UX Team
 * ==========================================================
 * Utility to control tabs behavior. Tabs are a set of stacked
 * divs revealed by clicking title boxes at top.
 * <div class="tabs" data-tabs>
 *	 <ul class="tabs-container" role="tablist">
 *		 <li role="presentation">
 *			 <a id="tab1" class="tab-title active" href="#panel1" aria-selected="true" aria-controls="panel1" role="tab">Tab 1</a>
 *		 </li>
 *		 <li role="presentation">
 *			 <a id="tab2" class="tab-title" href="#panel2" aria-selected="false" aria-controls="panel2" role="tab">Tab 2</a>
 *		 </li>
 *	 </ul>
 *	 <div class="tabs-content">
 *		 <section id="panel1" class="tab-body active" aria-labeledby="tab1" aria-hidden="false" role="tabpanel">
 *			 <div class="tab-body-content">
 *				 <p>This is the first panel of the basic tab example.</p>
 *			 </div>
 *		 </section>
 *		 <section id="panel2" class="tab-body" aria-labeledby="tab2" aria-hidden="true" role="tabpanel">
 *			 <div class="tab-body-content">
 *				 <p>This is the second panel of the basic tab example.</p>
 *			 </div>
 *		 </section>
 *	 </div>
 * </div>
 * ========================================================= */

$(function(){
	(function (global, $, namespace) {

		"use strict";

		var Tabs = function Tabs(element, options) {
					this.init ('tabs', element, options);
				};

		Tabs.prototype = {
			constructor: Tabs,
			init : function init(type, element, options){
				var self = this,
						elements = {},
						$element, $trigger, $target;

				if (element instanceof jQuery) {
					$element  = element;
				} else {
					$element = $(element);
				}

				this.options = $.extend({}, $.fn[type].defaults, options);
				this.$element = $(element);
				this.$trigger = this.$element.find('.tab-title');
				this.$target = this.$element.find('.tab-body');

				this.$element.on('click', '.tab-title', function(e){
					e.preventDefault();
					self.changeTab(this);
				});
			},

			changeTab: function (el){
				this.$trigger.removeClass('active');
				this.$target.removeClass('active');

				var t = $(el).attr('aria-controls');
				$(el).addClass('active');
				$('#' + t).addClass('active');
			}
		};

		$.fn.tabs = function tabs(option) {
			var el = this,
					options = $.extend({}, $.fn.tabs.defaults, typeof option === 'object' && option),
					args = Array.prototype.slice.call( arguments, 1 );
			return el.each(function () {
				var data = $.data(this, 'tabs');
				if (!data) {
					$.data(this, 'tabs', (data = new Tabs(this, options)));
				} else {
					if (typeof option === 'object') {
						$.extend(data.options, option);
					} else if (typeof option == 'string') {
						data[option].apply(data, args);
					}
				}
			});
		};

		$.fn.tabs.Constructor = Tabs;


		$(function () {
			$('[data-tabs]').tabs();
		});

	}(this, window.jQuery, "LZB"));
});

