/* =========================================================
 * lzb.videoplayer.js
 * =========================================================
 * Video player with custom controls
 * <div class="video-player-container" role="presentation" data-videoplayer>
 *       <div class="video-container">
 *           <video src="" poster="" width="100%" height="100%" class="video-media" id="video-media">
 *               <source src="" type="video/mp4">
 *           </video>
 *       </div>
 *        <div class="controls-container">
 *           <button class="play-control" aria-label="Toggle play and pause of video">
 *               <span class="icon icon-play" aria-hidden="true"></span>
 *           </button>
 *           <button class="volume-control" aria-label="Toggle volume mute and unmute of video audio">
 *               <span class="icon icon-volume-up" aria-hidden="true"></span>
 *           </button>
 *           <div class="indicator">0:00 / 0:00</div>
 *           <div class="progress">
 *               <div class="progress-background"></div>
 *               <div class="progress-over"></div>
 *               <div class="progress-hidden"></div>
 *           </div>
 *           <button class="fullscreen-control" aria-label="Display video as full screen">
 *               <span class="icon icon-fullscreen" aria-hidden="true"></span>
 *           </button>
 *       </div>
 *   </div>
 * ========================================================= */

(function (global, $, namespace) {

	"use strict";

	var VideoPlayer = function VideoPlayer(element, options) {
				this.init ('videoPlayer', element, options);
			},
			CONSTANTS = global[namespace].constants,
			loggingDebug = global[namespace] && global[namespace].config && global[namespace].config.loggingDebug,
			utilities = global[namespace].utilities;

	// Private
	function setIndicator(videoPlayer) {
		var currentMinute,
			currentSecond,
			durationMinute = Math.floor(videoPlayer.$video.duration / 60),
			durationSecond = Math.floor(videoPlayer.$video.duration - durationMinute * 60),
			durationLabel = durationMinute + ':' + durationSecond;

		// fallback if duration has incorrect numbers present
		if (isNaN(durationMinute) || isNaN(durationSecond)) {
			durationLabel = '0:00';
		}

		currentSecond = Math.floor(videoPlayer.$video.currentTime);
		currentMinute = Math.floor(currentSecond / 60);
		currentSecond = currentSecond - ( currentMinute * 60 );
		currentSecond = ( String(currentSecond).length > 1 ) ? currentSecond : ( String('0') + currentSecond );

		var currentLabel = currentMinute + ':' + currentSecond,
			indicatorLabel = currentLabel + ' / ' + durationLabel;

		// fallback if current time has incorrect numbers present
		if (isNaN(currentMinute) || isNaN(currentSecond)) {
			indicatorLabel = '0:00 / ' + durationLabel;
		}

		// update video time indicator text
		videoPlayer.$element.find('.' + videoPlayer.options.indicator_class_name).text(indicatorLabel);
	}

	//PUBLIC
	VideoPlayer.prototype = {
		constructor: VideoPlayer,
		init: function init(type, element, options) {
			var self = this;

			if (loggingDebug) {
				console.debug('init videoPlayer with options:');
				console.debug(Array.prototype.slice.call(arguments));
			}
			this.options = $.extend({}, $.fn[type].defaults, options);
			this.$element = $(element);
			this.$video = this.$element.find('.' + this.options.video_class_name)[0];

			var fullScreenEnabled = !!(document.fullscreenEnabled || document.mozFullScreenEnabled || document.msFullscreenEnabled || document.webkitSupportsFullscreen || document.webkitFullscreenEnabled || document.createElement('video').webkitRequestFullScreen);

			// hides the full screen button on the video player if the browser does not support.
			if (!fullScreenEnabled) {
				this.$element.find('.' + this.options.fullscreen_button_class_name).hide();
			}

			this.$video.addEventListener('timeupdate', function() {
				self.handleProgress();
			}, false);

			// set correct icon state on initialization based on video props
			this.$video.paused ? this.toggleControlIcons('pause') : this.toggleControlIcons('play');
			this.$video.muted ? this.toggleControlIcons('mute') : this.toggleControlIcons('unmute');

			// set video time indicator label
			setIndicator(self);

			// events
			this.$video.addEventListener('timeupdate', function() {
				self.handleProgress();
			}, false);
			this.$video.addEventListener('volumechange', function() {
				self.$video.muted ? self.toggleControlIcons('mute') : self.toggleControlIcons('unmute');
			}, false);
			this.$video.onplay = function() {
				self.toggleControlIcons('play');
			};
			this.$video.onpause = function() {
				self.toggleControlIcons('pause');
			};
			this.$element.off('.videoPlayer')
				.on('click.' + namespace + '.videoPlayer', '.' + this.options.play_control_class_name + ',.' + this.options.video_container_class_name, function (e) {
					self.togglePlay();
				})
				.on('click.' + namespace + '.videoPlayer', '.' + this.options.volume_control_class_name, function (e) {
					self.toggleVolume();
				})
				.on('click.' + namespace + '.videoPlayer', '.' + this.options.fullscreen_button_class_name, function (e) {
					self.toggleFullScreen();
				})
				.on('click.' + namespace + '.videoPlayer', '.' + this.options.progress_class_name, function (e) {
					self.scrub(e);
				});
		},
		play : function () {
			this.$video.play();
		},
		pause : function () {
			this.$video.pause();
		},
		togglePlay : function () {
			this.$video.paused ? this.play() : this.pause();
		},
		toggleVolume : function () {
			this.$video.muted = !this.$video.muted;
		},
		toggleFullScreen : function () {
			if (this.$video.requestFullScreen) {
				this.$video.requestFullScreen();
			}
			else if (this.$video.webkitRequestFullScreen) {
				this.$video.webkitRequestFullScreen();
			}
			else if (this.$video.mozRequestFullScreen) {
				this.$video.mozRequestFullScreen();
			}
		},
		toggleControlIcons : function (action) {
			var icons = this.options.icon_class_names;

			if (action === 'play') {
				this.$element.find('.' + this.options.play_control_class_name + ' .icon').removeClass(icons.play).addClass(icons.pause);
			}
			else if (action === 'pause') {
				this.$element.find('.' + this.options.play_control_class_name + ' .icon').removeClass(icons.pause).addClass(icons.play);
			}
			else if (action === 'unmute') {
				this.$element.find('.' + this.options.volume_control_class_name + ' .icon').removeClass(icons.mute).addClass(icons.volume);
			}
			else if (action === 'mute') {
				this.$element.find('.' + this.options.volume_control_class_name + ' .icon').removeClass(icons.volume).addClass(icons.mute);
			}
		},
		handleProgress : function () {
			var percent = (this.$video.currentTime / this.$video.duration) * 100,
				$progressBar = this.$element.find('.' + this.options.progress_over_class_name);

			$progressBar.css('width', percent + '%');
			setIndicator(this);
		},
		scrub : function (e) {
			var scrubTime = (e.offsetX / $('.' + this.options.progress_class_name)[0].offsetWidth) * this.$video.duration;

			this.$video.currentTime = scrubTime;
		}
	};

	$.fn.videoPlayer = function videoPlayer(option) {
		var el = this,
				options = $.extend({}, $.fn.videoPlayer.defaults, typeof option === 'object' && option),
				args = Array.prototype.slice.call( arguments, 1 );
		return el.each(function () {
			var data = $.data(this, 'videoPlayer');
			if (!data) {
				$.data(this, 'videoPlayer', (data = new VideoPlayer(this, options)));
			} else {
				if (typeof option === 'object') {
					$.extend(data.options, option);
				} else if (typeof option == 'string') {
					data[option].apply(data, args);
				}
			}
		});
	};

	$.fn.videoPlayer.defaults = {
		video_container_class_name: 'video-container',
		video_class_name: 'video-media',
		play_control_class_name: 'play-control',
		volume_control_class_name: 'volume-control',
		indicator_class_name: 'indicator',
		progress_class_name: 'progress',
		progress_over_class_name: 'progress-over',
		fullscreen_button_class_name: 'fullscreen-control',
		icon_class_names: {'play': 'icon-play', 'pause': 'icon-pause', 'volume': 'icon-volume-up', 'mute': 'icon-volume-off'}
	};

	$.fn.videoPlayer.Constructor = VideoPlayer;


	$(function () {
		$('[data-videoplayer]').videoPlayer();
	});


}(this, window.jQuery, "LZB"));
