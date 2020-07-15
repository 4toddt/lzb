/* =========================================================
 * lzb.quantify.js
 * =========================================================

 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Quantify = function Quantify(element, options) {
				this.init ('quantify', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug;

	function updateStates(quantify, val) {
		quantify.$minus.removeClass('inactive');
		quantify.$plus.removeClass('inactive');
		if (val <= quantify.options.min_quantity){
			quantify.$minus.addClass('inactive');
		}
		if (val >= quantify.options.max_quantity){
			quantify.$plus.addClass('inactive');
		}
	}

	//PUBLIC
	Quantify.prototype = {
		constructor: Quantify,
		init: function init(type, element, options) {
			if (loggingDebug) {
				console.debug('init quantify with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}

			var self = this,
					minQuantity,
					maxQuantity;

			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);
			this.$plus = this.$element.find('.plus-icon');
			this.$minus = this.$element.find('.minus-icon');
			this.$counter = this.$element.find('.counter');

			maxQuantity = this.$element.attr('data-max');
			if (typeof maxQuantity != 'undefined') {
				this.options.max_quantity = parseInt(maxQuantity);
			}

			minQuantity = this.$element.attr('data-min');
			if (typeof minQuantity != 'undefined') {
				this.options.min_quantity = parseInt(minQuantity);
			}


			if (isNaN(parseInt(self.$counter.val()))) {
				self.$counter.val(self.options.min_quantity);
			}

			this.$element.on('click', '.plus-icon', function(){
				self.increment();
			});

			this.$element.on('click', '.minus-icon', function(){
				self.decrement();
			});

			//prevent non numbers
			this.$counter.keypress(function(e) {
				var key_codes = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 0, 8];

				if ($.inArray(e.which, key_codes) == -1) {
					e.preventDefault();
				}
			});

			this.$counter.keyup(function(e) {
				var currentValue = parseInt(self.$counter.val());

				if (currentValue > self.options.max_quantity) {
					//no!
					self.$counter.val(self.options.max_quantity).change();
				}

				if (currentValue < self.options.min_quantity) {
					//no!
					self.$counter.val(self.options.min_quantity).change();
				}

				updateStates(self, currentValue);
			}).keyup();

		},

		increment : function (){
			var newQuantity =  parseInt(this.$counter.val()) + 1;
			if (newQuantity > this.options.max_quantity){
				return;
			}
			this.$counter.val(newQuantity).change();
			updateStates(this, newQuantity);
			this.$element.trigger('increment');
		},
		decrement : function (){
			var newQuantity =  parseInt(this.$counter.val()) - 1;
			if (newQuantity < this.options.min_quantity){
				return;
			}
			this.$counter.val(newQuantity).change();
			updateStates(this, newQuantity);
			this.$element.trigger('decrement');
		}
	};

	$.fn.quantify = function quantify(option) {
		var el = this,
				options = $.extend({}, $.fn.quantify.defaults, typeof option === 'object' && option);
		return el.each(function () {
			var data = $.data(this, 'quantify');
			if (!data) {
				$.data(this, 'quantify', (data = new Quantify(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				}
			}
		});
	};

	$.fn.quantify.defaults = {
		max_quantity:10,
		min_quantity:0
	};

	$.fn.quantify.Constructor = Quantify;

	$(function () {
		$('[data-quantify]').quantify();
	});

}(this, window.jQuery, "LZB"));
