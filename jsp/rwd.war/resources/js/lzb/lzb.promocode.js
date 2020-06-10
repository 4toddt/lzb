/* =========================================================
 /* =========================================================
 * lzb.promocode.js
 * Created by DMI UX Team
 * ==========================================================
 * Utility to control promo code behavior. The promo code widget
 * allows users to enter promo codes for item discounts applied
 * at checkout. When the user adds their code it will appear in
 * applied promo area under the form and give an option to view
 * details about the code in a modal.
 * You will have the ability to set how many promo codes users
 * are allowed to add in defaults.
 * ========================================================= */

$(function(){
	(function (global, $, namespace) {
		// "use strict";

		var Promocode = function Promocode(element, options) {
				this.init ('promo-code', element, options);
			};

		Promocode.prototype = {
			constructor: Promocode,
			init : function init(type, element, options){
				var self = this, $element;

				if (element instanceof jQuery) {
					$element  = element;
				} else {
					$element = $(element);
				}

				this.options = $.extend({}, $.fn.promocode.defaults, options);
				this.$element = $(element);
				this.$element.on('click', '.apply-promo-btn', function(e){
					self.applyPromo();
					e.preventDefault();
				});
				this.$element.on('click', '.icon-remove', function(){
					self.removeApplied($(this));
				});
			},

			applyPromo : function(){
				var couponCode, template, $template, appliedCode, $span;

				template = $('#template').html(); // get the html out of template
				$template = $(template);					// convert that to a jQuery object
				couponCode = $('#apply-promo-form').val();	// get value of input into couponCode
				$span = $('<span class="coupon-code">');		// create a span to hold the coupon code
				$template.prepend($span);										// Prepend the span to the templated object
				appliedCode = $('.coupon-code').html(); 		// get value of code already applied
				$span.text(couponCode);											// Add the couponCode text to the span
				$span.attr('data-pc', couponCode); 				// add a data-attribute with the same coupon code

				// for passing the actual coupon code name into the view-details modal as a parameter
				// grab the url of the modal and replace the param placeholder with couponCode
				// must be set up with a placeholder in the template
				var viewDetailsModalUrl = $template.find('.view-details').attr('href').replace('promocode', couponCode);
				// add the new href param to the href
				$template.find('.view-details').attr('href', viewDetailsModalUrl);


				// check to see if that same code has already been applied
				if (couponCode === appliedCode){
					// if so, add error message from template - then fade out
					$template.prependTo('.promo-applied-area').html(this.options.promo_already_applied_message);
						setTimeout(function(){
							// because message is being added to the template, remove the template parent too
							$('.already-applied-msg').fadeOut().parent().remove();
						}, 3000);
					$('#apply-promo-form').val('');
					return;
				} else {
					//  prepend the templated object to the area and show it
					$template.prependTo('.promo-applied-area').slideDown();
				}

				// clear the form
				$('#apply-promo-form').val('');
				// when maximum promos is reached, hide the field and show a message
				if($('.promo-applied').length >= this.options.max_applied_promos){
				 $('.apply-promo-field-group').hide();
				 $('#apply-promo').append($('.too-many-promos-msg'));
				 $('.too-many-promos-msg').fadeIn('fast');
				}
			},

			removeApplied : function($remove){
				// remove entered codes (from DOM)
				var $appliedPromo = $remove.parent();
				$appliedPromo.fadeOut(function(){
					$(this).remove();
				});
				// when one less than maximum promos, hide the msg and bring back the input field
				if ($('.promo-applied').length <= this.options.max_applied_promos) {
					$('.too-many-promos-msg').hide();
					$('.apply-promo-field-group').show();
				}
			},
		};

		$.fn.promocode = function promocode(option) {
			var el = this,
					options = $.extend({}, $.fn.promocode.defaults, typeof option === 'object' && option),
					args = Array.prototype.slice.call( arguments, 1 );
			return el.each(function () {
				var data = $.data(this, 'promocode');
				if (!data) {
					$.data(this, 'promocode', (data = new Promocode(this, options)));
				} else {
					if (typeof option === 'object') {
						$.extend(data.options, option);
					} else if (typeof option == 'string') {
						data[option].apply(data, args);
					}
				}
			});
		};

		$.fn.promocode.defaults = {
			max_applied_promos: 3,
			promo_already_applied_message : function (){
				return '<div class="already-applied-msg">That code has already been applied.</div>';
			}
		};

		$.fn.promocode.Constructor = Promocode;


		$(function () {
			$('[data-promocode]').promocode();
		});

	}(this, window.jQuery, "LZB"));
});

