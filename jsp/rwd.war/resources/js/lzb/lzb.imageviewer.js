/* =========================================================
 * lzb.imageimageviewer.js
 * =========================================================
 * Creates a 360 image viewer from the Marxent Composer API.
 * @requires: vendor .js and .css server files to be included in DOM.
 * <div id="divSpins" class="product-composer" data-imagecomposer data-product-id="" data-default-cover="" data-default-finish="" data-default-nailhead="" data-image-url=""></div>
 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Imageviewer = function Imageviewer(element, options) {
				this.init ('imageviewer', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug;

	//PUBLIC
	Imageviewer.prototype = {
		constructor: Imageviewer,
		init: function init(type, element, options) {
			if (loggingDebug) {
				console.debug('init imageviewer with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}

			var self = this;

			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);
			this.$navigation =  this.$element.find(this.options.thumbnail_container_class);
			this.$mainView =  this.$element.find(this.options.large_container_class);
			this.totalSlides = this.$navigation.find(this.options.thumbnail_class).length;
			this.slidesToShow = self.options.slider_min;

			this.$navigation.find(this.options.thumbnail_class).first().addClass('active');

			this.$mainView.slick({
				slidesToShow: 1,
				slidesToScroll: 1,
				arrows: false,
				fade: true,
				infinite: false,
				onAfterChange : function(){
					var index = self.$mainView.slickCurrentSlide();
					// catch when user has dragged the main image and update the nav to match
					if (self.getActiveSlide() != index) {
						self.setActiveSlide(index);
						if (!self.isSlideVisible(index, self.$navigation.slickCurrentSlide())) {
							self.$navigation.slickGoTo(Math.floor(index / self.slidesToShow) * self.slidesToShow);
						}
					}
				}
			});

			this.$navigation.slick({
				slidesToShow: self.options.slider_min,
				slidesToScroll: self.options.slider_min,
				dots: false,
				infinite: false,
				onAfterChange : function(){
					var index = self.$mainView.slickCurrentSlide();
					if (!self.isSlideVisible(index, self.$navigation.slickCurrentSlide())) {
						self.$mainView.slickGoTo(self.getFirstVisibleSlide(self.$navigation.slickCurrentSlide()));
						self.setActiveSlide(self.getFirstVisibleSlide(self.$navigation.slickCurrentSlide()));
					}
				}
			});

			this.$navigation.find(this.options.thumbnail_class).click(function(){
				var index = parseInt(this.getAttribute('index'));
				self.setActiveSlide(index);
				self.$mainView.slickGoTo(index);
			});
		},
		getFirstVisibleSlide: function(currentSlide) {
			var firstSlide = currentSlide;
			if (currentSlide + this.slidesToShow >= this.totalSlides) {
				firstSlide = this.totalSlides - this.slidesToShow;
			}
			return firstSlide;
		},
		isSlideVisible: function(slideIndex, currentSlide){
			var isVisible = false;
			if (currentSlide + this.slidesToShow > this.totalSlides) {
				isVisible = (slideIndex >= this.totalSlides - this.slidesToShow) && (slideIndex <= this.totalSlides - 1);
			} else {
				isVisible = (slideIndex >= currentSlide) && (slideIndex <= currentSlide + this.slidesToShow - 1);
			}
			return isVisible;
		},
		getActiveSlide: function(){
			return this.$navigation.find('.active').index() || 0;
		},
		setActiveSlide: function(index){
			this.$navigation.find(this.options.thumbnail_class).removeClass('active').end()
					.find("[index='" + index + "']").addClass('active');
		}

	};

	$.fn.imageviewer = function imageviewer(option) {
		var el = this,
				options = $.extend({}, $.fn.imageviewer.defaults, typeof option === 'object' && option);
		return el.each(function () {
			var data = $.data(this, 'imageviewer');
			if (!data) {
				data = new Imageviewer(this, options);
				$.data(this, 'imageviewer', data);
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				}
			}
		});
	};

	$.fn.imageviewer.defaults = {
		large_container_class: ".viewer-main",
		thumbnail_container_class: ".viewer-thumbnails",
		thumbnail_class: ".viewer-thumb",
		slider_min: 5
	};

	$.fn.imageviewer.Constructor = Imageviewer;


	$(function () {
		$('[data-imageviewer]').imageviewer();
	});


}(this, window.jQuery, "LZB"));
