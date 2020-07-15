/* =========================================================
 * lzb.imagecomposer.js
 * =========================================================
 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var Imagecomposer = function Imagecomposer(element, options) {
				this.init ('imagecomposer', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug;

	//PUBLIC
	Imagecomposer.prototype = {
		constructor: Imagecomposer,
		init : function init(type, element, options) {
			var self = this,
				mxtSpinBuilder = new MXTSpinBuilder(),
				productId = $(element).attr('data-product-id'), // value must be a string
				$body = $('body');

			if (loggingDebug) {
				console.debug('init imagecomposer with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}
			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);

			// stop execution if no productId value.
			if (productId === undefined || productId === '' ) {
				// remove composer from image slider
				self.removeComposer();
				return;
			}

			// remove any html content from element
			this.$element.innerHTML = "";

            // This initializes the composer engine with the group and page to embed.
            mxtSpinBuilder.init(this.options.oauthToken, productId, this.$element.context, this.options.secure, this.options.clientId);

			// Setup variables for default page load request.
            var defaultBase = $(this.$element).data('default-cover'),
                defaultFinish = $(this.$element).data('default-finish'),
                defaultNailhead = $(this.$element).data('default-nailhead'),
                isPillow1Active = false,
                isPillow2Active = false,
                initialPageLoadData = {},
				jsonReqInput = $('#jsonReqInput').val();

			// jsonReqInput is used to Establish Existing Product Configurations. Occurs when ?commid= is passed to a product page url from the cart product link.
			if (typeof(jsonReqInput) != 'undefined' && jsonReqInput.length > 0) {
				// check if existing product configuration has pillow set 1
				if (this.$element.data('pillow-P1')) {
					isPillow1Active = this.$element.data('pillow-P1');
				}
				// check if existing product configuration has pillow set 2
				if (this.$element.data('pillow-P2')) {
					isPillow2Active = this.$element.data('pillow-P2');
				}

				initialPageLoadData = self.buildComposerRequest(isPillow1Active, isPillow2Active);
 			}
			else {
				// Push results into request variable
				if (defaultBase) {
					initialPageLoadData[this.options.imageParamKeys[0]] = defaultBase;
				}
				if (defaultFinish) {
					initialPageLoadData[this.options.imageParamKeys[1]] = defaultFinish;
				}
				/*
				// Commenting code for default Nailhead on initial page load as it is not working accurately for products where 'none' is pre-selected.
				if (defaultNailhead) {
					initialPageLoadData[this.options.imageParamKeys[2]] = defaultNailhead;
				}
				*/
			}

			// Set our initial configuration. See the info page for the Composer View
			// to see information about the available configurations.
			self.makeComposerRequest(mxtSpinBuilder, initialPageLoadData, true);

			// Click/Change Events
			$body.off('.imagecomposer')
					.on('click.' + namespace + '.imagecomposer', '.cover, .option-tile, .option-pillow-swatch-radio, .option-cover-swatches .option, .option-finish-img, .same-as-coverfabric', function (e) {
						// console.log('Fire Composer Event Click');
						var $target = $(e.currentTarget),
							$targetInput = $target.find('input'),
							targetRel = $targetInput.data('rel'),
							targetName = $targetInput.attr("name");

						// Check $target class .option-tile to see if it is an composer configured option.
						if ($target.hasClass('option-tile')) {
							if (!(targetRel == 'Finish Options' || targetRel == 'Contrasting Welt Option' || targetName.indexOf("Nail Head") > -1)) {
								// Stop execution if not an composer configured option to prevent the request from being made.
								// console.log('not a valid composer option');
								return;
							}

							// Check .option-tile is welt
							if (targetRel == 'Contrasting Welt Option') {
		                        var base = self.getBase(),
		                        	welt = self.getWelt(base);

								// Check to compare selected base cover against selected welt cover so we can cancel the composer request if no change occured.
		                        if (welt === undefined || base === welt) {
									// Stop execution if no welt sku was changed to prevent the request from being made.
		                            return;
		                        }
			                }
						}

						// Check if event target is a pillow option.
						if ($target.hasClass('option-pillow-swatch-radio')) {
							// Check if pillow option is from set 1.
							if ($target.attr('name') == 'pillow-swatch-set1') {
								// Pillow1 is only active after first click.
								isPillow1Active = true;
							}
							// Check if pillow option is from set 2.
							if ($target.attr('name') == 'pillow-swatch-set2') {
								// Pillow2 is only active after first click.
								isPillow2Active = true;
							}
						}

						// Check if event target is .same-as-coverfabric checkbox
						// Additional checkbox functionality is located in pdp-options-upgrades.js around line: 953.
						if ($target.hasClass('same-as-coverfabric')) {
							var thisChecked = $(this).prop('checked');
							if (thisChecked === true) {
								// turn off the ability to send pillow as an option.
								if ($target.data('h3') === 'h3-pillowset-1') {
									isPillow1Active = false;
									// console.log('isPillow1Active', isPillow1Active);
								}
								else if ($target.data('h3') === 'h3-pillowset-2') {
									isPillow2Active = false;
									// console.log('isPillow2Active', isPillow2Active);
								}
							}
						}

						// delay needed to allow options to set before request is made.
						setTimeout(function() {
							var data = self.buildComposerRequest(isPillow1Active, isPillow2Active);
							// Make request and set changes.
							self.makeComposerRequest(mxtSpinBuilder, data);
						}, 500);
					})
					.on('change.' + namespace + '.imagecomposer', '.pillow-quantity-select', function (e) {
						var $target = $(e.target),
							thisVal = $target.val();

						// Checks if Quantity has been reset by user
						if (thisVal === 'Quantity') {
							// turn off the ability to send pillow as an option.
							if ($target.closest('.pillow-set-color-swatch-group').hasClass('h3-pillowset-1-colorswatch')) {
								isPillow1Active = false;
								// console.log('isPillow1Active', isPillow1Active);
							}
							else if ($target.closest('.pillow-set-color-swatch-group').hasClass('h3-pillowset-2-colorswatch')) {
								isPillow2Active = false;
								// console.log('isPillow2Active', isPillow2Active);
							}
						}

						// delay needed to allow options to set before request is made.
						setTimeout(function() {
							var data = self.buildComposerRequest(isPillow1Active, isPillow2Active);
							// Make request and set changes.
							self.makeComposerRequest(mxtSpinBuilder, data);
						}, 500);
					});
		},
		removeComposer: function () {
			// remove composer from image slider
			if (this.$element.closest('.product-images-slider').hasClass('slick-initialized')) {
				this.$element.closest('.product-images-slider').slick('slickRemove', 0);
			} else {
				this.$element.remove();
			}
		},
		buildComposerRequest: function (isPillow1Active, isPillow2Active) {
			// Assemble data request for Composer
			var composerRequest = {},
				base = this.getBase(),
				finish = this.getFinish(),
				nailhead = this.getNailhead(),
				pillows = this.getPillows(),
				pillow = pillows.pillowSet1,
				pillow2 = pillows.pillowSet2,
				welt = this.getWelt(base);

			/* Test DATA
			composerRequest.Base = "B100024";
			composerRequest.Finish = "007";
			composerRequest.Nailhead = "NS";
			composerRequest.Pillow = "B100009";
			composerRequest.Pillow2 = "B100078";
			composerRequest.Welt = "B100009";
			*/

			// Push results into request object variable
			if (base) {
				composerRequest[this.options.imageParamKeys[0]] = base;
			}
			if (finish) {
				composerRequest[this.options.imageParamKeys[1]] = finish;
			}
			if (nailhead) {
				composerRequest[this.options.imageParamKeys[2]] = nailhead;
			}
			if (pillow && isPillow1Active === true) {
				composerRequest[this.options.imageParamKeys[3]] = pillow;
			}
			if (pillow2 && isPillow2Active === true) {
				composerRequest[this.options.imageParamKeys[4]] = pillow2;
			}
			if (welt) {
				composerRequest[this.options.imageParamKeys[5]] = welt;
			}

			// console.log('composerRequest: ', JSON.stringify(composerRequest));
			return composerRequest;
		},
		makeComposerRequest: function (mxtSpinBuilder, data, firstRequest) {
			var self = this;
			// Make composer Request
			console.log('composerRequest', data);

			// send request and set it.
			mxtSpinBuilder.send('SetConfiguration', data, function(result) {
				// IF result is Success
				if (result === 200) {
					// IF First Event Call
					if (firstRequest) {
						// show composer
						mxtSpinBuilder.show();
					}
					// update static images using composer Imager API if enabled.
					if ($('.product-images').attr('data-imager-enabled') === 'true') {
						self.updateStaticImageUrl(data);
					}
				}
				// ELSE result Failed
				else {
					// Any code other than 200 is an error!
					console.log('SetConfiguration failed with status code: ' + result);

					// IF First Event Call
					if (firstRequest) {
						// remove composer from image slider
						self.removeComposer();
						return;
					}
				}
			});

			// set composer request json as a data attribute.
			this.$element.attr('data-json', encodeURIComponent(JSON.stringify(data)));
		},
		getBase: function () {
			// Get Selected Base Cover Option.
			var base = $('.cover-selection-details a.selected').attr('data-coverid');
			return base;
		},
		getFinish: function () {
			// Get Selected Finish Option.
			var finish,
				$finishRadio = $('input[data-rel="Finish Options"]:checked');

			// if standard finish use the default standard value.
			if ($finishRadio.attr('data-config') == 'Standard Finish') {
				finish = $finishRadio.prev().attr('data-finish');
			}
			// if optional finish is selected get it's value.
			else if ( $finishRadio.attr('data-config') == 'Optional Finishes' ) {
				finish = $('.option-finish-img.selected').attr('data-finish');
			}
			return finish;
		},
		getNailhead: function () {
			// Get Selected Nailhead Option.
			var nailhead,
				$nailheadRadio = $('.option-tile input[name^="Nail Head"]:checked');

			// only look for the nailhead value if nailhead option is selected.
			if ($nailheadRadio.length) {
				// check to see if option is not equal to 'None'
				if ($nailheadRadio.attr('data-config') != 'None') {
					nailhead = $nailheadRadio.attr('data-optioncode');
				}
			}
			return nailhead;
		},
		getPillows: function () {
			// Get Selected Pillow Options.
			var pillowSet1 = $('input[name="pillow-swatch-set1"]:checked').attr('data-value'),
				pillowSet2 = $('input[name="pillow-swatch-set2"]:checked').attr('data-value');

			return {
				pillowSet1: pillowSet1,
				pillowSet2: pillowSet2
			};
		},
		getWelt: function (base) {
			// Get Selected Welt Option.
			var welt,
				$weltRadio = $('.option-tile input[data-config="Contrasting Welt"]:checked');

			// only look for the welt value if welt option is selected.
			if ($weltRadio.length) {
				// get the welt cover swatch.
				var weltCover = $('#Contrasting-Welt-Option .option-cover-swatches').find('input[name="Welt"]:checked').attr('data-value');
				if (weltCover === undefined || weltCover === '') {
					// if not defined use the base cover.
					welt = base;
				}
				else {
					// if defined use the selected cover swatch.
					welt = weltCover;
				}
			}
			return welt;
		},
		updateStaticImageUrl: function (data) {
			// Update Static Image URL using Composer Imager API
			var imageURL = this.$element.attr('data-image-url'),
				paramsToRemove_arr = this.options.imageParamKeys,
				newSRC = (function() {
					// function to update the image url paramaters and replace with the values from the data object.
					var imgURL = imageURL.split('?')[0],
						param,
						params_arr = [],
						queryString = (imageURL.indexOf('?') !== -1) ? imageURL.split('?')[1] : '';

					if (queryString !== '') {
						params_arr = queryString.split('&');
						// loop through params found in the source url
						for (var i = params_arr.length - 1; i >= 0; i -= 1) {
							param = params_arr[i].split('=')[0];
							// loop through paramsToRemove_arr.
							for (var j = 0; j < paramsToRemove_arr.length; j++) {
								if (param === paramsToRemove_arr[j]) {
									// remove the matching params.
									params_arr.splice(i, 1);
								}
							}
						}
						imgURL = imgURL + '?' + params_arr.join('&');
						imgURL = imgURL + '&' + $.param(data);
					}
					return imgURL;
				})();

			// console.log('imageURL', imageURL);
			// console.log('paramsToRemove_arr', paramsToRemove_arr);
			// console.log('newSRC', newSRC);

			// Set new image source for imgSelector.
			this.$element.attr('data-image-url', newSRC);
		}
	};

	$.fn.imagecomposer = function imagecomposer(option) {
		var el = this,
				options = $.extend({}, $.fn.imagecomposer.defaults, typeof option === 'object' && option),
				args = Array.prototype.slice.call( arguments, 1 );
		return el.each(function () {
			var data = $.data(this, 'imagecomposer');
			if (!data) {
				$.data(this, 'imagecomposer', (data = new Imagecomposer(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				} else if (typeof option == 'string') {
					data[option].apply(data, args);
				}
			}
		});
	};

	$.fn.imagecomposer.defaults = {
		oauthToken : 'LZB',
		clientId : '000025',
		secure : true,
		imageParamKeys : ['Base', 'Finish', 'Nailhead', 'Pillow', 'Pillow2', 'Welt']
	};

	$.fn.imagecomposer.Constructor = Imagecomposer;


	$(function () {
		$('[data-imagecomposer]').imagecomposer();
	});

}(this, window.jQuery, "LZB"));
