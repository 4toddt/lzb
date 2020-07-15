<section id="video-player-docs" class="docs-section">
	<h2>Video Player</h2>
	<p>A generic HTML5 video player with custom UI controls for basic video playback.</p>
	<p>Video player styles are stored in <code>_videoPlayer.scss</code>. For video player styling it's usually better to leave the default styling to be very basic and then enhance the style by using a modified class or with contextual selectors. For example you may use <code>.product-video .video-player-container</code> to style the video player on a product page without affecting the video player style elsewhere in the site.</p>
	<p>Supported playback controls:</p>
	<ul>
		<li><strong>Play/Pause button:</strong> toggles the video play and pause control</li>
		<li><strong>Mute/Unmute button:</strong> toggles the video audio volume level on/off</li>
		<li><strong>Time Indicator:</strong> displays the current video time and the duration of the video</li>
		<li><strong>Progress Bar:</strong> displays a visual bar of the current time duration and allows interaction to seek or rewind the video</li>
		<li><strong>Fullscreen button:</strong> invokes the browser full screen mode. Button is programed to only display if supported by the browser.</li>
	</ul>


	<div class="docs-example">
		<h4>Example</h4>

		<c:import url="/documentation/includes/videoPlayer.jsp">
			<c:param name="url" value="http://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_5mb.mp4"/>
			<c:param name="thumbImage" value=""/>
			<c:param name="audio" value="true"/>
			<c:param name="loop" value="true"/>
			<c:param name="autoplay" value="false"/>
		</c:import>

	</div>

	<h4>JSP Include</h4>
<pre class="prettyprint">
&lt;c:import url="/documentation/includes/videoPlayer.jsp">
	&lt;c:param name="url" value="http://sample-videos.com/video123/mp4/480/big_buck_bunny_480p_5mb.mp4"/>
	&lt;c:param name="thumbImage" value=""/>
	&lt;c:param name="audio" value="true"/>
	&lt;c:param name="loop" value="true"/>
	&lt;c:param name="autoplay" value="false"/>
&lt;/c:import>
</pre>

	<p>
		It is recommended that you create a JSP include for the video player and add it to a directory such as <code>/sitewide/includes/</code>.
		You can use <code>/documentation/includes/videoPlayer.jsp</code> as starting point. It has been setup to allow passing in specific optional parameters
		to the video player.
	</p>
	<p>Supported JSP Include Parameters:</p>
	<ul>
		<li><strong>url:</strong> video source url <span style="color:red">(Required)</span></li>
		<li><strong>index:</strong> number value used for unique ID if more than one video is rendered <span style="color:blue">(Optional)</span></li>
		<li><strong>imagePoster:</strong> video poster image url <span style="color:blue">(Optional)</span></li>
		<li><strong>audio:</strong> boolean value if video is muted by default <span style="color:blue">(Optional)</span></li>
		<li><strong>loop:</strong> boolean value to replay video after video ends <span style="color:blue">(Optional)</span></li>
		<li><strong>autoplay:</strong> boolean value to auto play video <span style="color:blue">(Optional)</span></li>
	</ul>

	<h4>HTML</h4>
	<format:prettyPrint>
		<jsp:attribute name="htmlString"><c:import url="/documentation/includes/videoPlayer.jsp" /></jsp:attribute>
	</format:prettyPrint>

	<p>The video player behavior is automatically applied to elements with the <code>data-videoplayer</code> attribute. Otherwise you can
		initialize calling the jQuery plugin.</p>

	<h4 >JavaScript</h4>
<pre class="prettyprint">
$('.video-player-container').videoPlayer(/*{options}*/);

*/
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
*/
</pre>

	<p>The play, pause, and volume toggle actions can be called programmatically on the video player if you need to trigger them via
		javascript. In order to make this call you need to pass in the action/function name to a DOM or jQuery element. These calls are
		programed to toggle the control icons to it's alternate state.
	</p>

	<div class="docs-example">
		<h4>Example</h4>

		<p>
			<span class="button secondary" onclick="$('.video-player-container').videoPlayer('play');">Play</span>
			<span class="button secondary" onclick="$('.video-player-container').videoPlayer('pause');">Pause</span>
			<span class="button secondary" onclick="$('.video-player-container').videoPlayer('toggleVolume');">Mute/Unmute</span>
		</p>


	</div>

	<h4>JavaScript</h4>
<pre class="prettyprint">
$('.video-player-container').videoPlayer('play');
$('.video-player-container').videoPlayer('pause');
$('.video-player-container').videoPlayer('toggleVolume');
</pre>


</section>