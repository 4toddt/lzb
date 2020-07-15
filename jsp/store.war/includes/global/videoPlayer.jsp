<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<%--
    - File Name: videoPlayer.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the video player.
    - Required Parameters:
        - url: video source url
    - Optional Parameters:
        - index: number value used for unique ID if more than one video is rendered
        - thumbImage: video poster image url
        - hasAudio: boolean value if video is muted by default
        - loop: boolean value to replay video after video ends
        - autoplay: boolean value to auto play video
--%>
<dsp:page>
    <%-- Imports --%>

    <%-- Page Variables --%>
    <dsp:getvalueof var="index" param="index"/>
    <dsp:getvalueof var="url" param="url"/>
    <dsp:getvalueof var="thumbImage" param="thumbImage"/>
    <dsp:getvalueof var="hasAudio" param="hasAudio"/>
    <dsp:getvalueof var="loop" param="loop"/>
    <dsp:getvalueof var="autoplay" param="autoplay"/>

    <c:choose>
        <c:when test="${hasAudio}">
            <c:set var="mutedAttribute" value=""/>
        </c:when>
        <c:otherwise>
            <c:set var="mutedAttribute" value="muted"/>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${loop}">
            <c:set var="loopAttribute" value="loop"/>
        </c:when>
        <c:otherwise>
            <c:set var="loopAttribute" value=""/>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${autoplay}">
            <c:set var="autoplayAttribute" value="autoplay"/>
        </c:when>
        <c:otherwise>
            <c:set var="autoplayAttribute" value=""/>
        </c:otherwise>
    </c:choose>

    <%-- Render Video Player --%>
    <div class="video-player-container" role="presentation" data-videoplayer data-module="videoplayer">
        <div class="video-container">
            <video src="${url}" poster="${thumbImage}" width="100%" height="100%" class="video-media" id="video-media${index}" ${mutedAttribute} playsinline ${loopAttribute} controlsList="nodownload" ${autoplayAttribute}>
                <source src="${url}" type="video/mp4">
            </video>
        </div>

        <div class="controls-container">
            <button class="play-control" aria-label="Toggle play and pause of video">
                <span class="icon icon-play-arrow" aria-hidden="true"></span>
            </button>

            <button class="volume-control" aria-label="Toggle volume mute and unmute of video audio">
                <span class="icon icon-volume-up" aria-hidden="true"></span>
            </button>

            <div class="indicator">0:00 / 0:00</div>

            <div class="progress">
                <div class="progress-background"></div>
                <div class="progress-over"></div>
                <div class="progress-hidden"></div>
            </div>

            <button class="fullscreen-control" aria-label="Display video as full screen">
                <span class="icon icon-fullscreen" aria-hidden="true"></span>
            </button>
        </div>
    </div>
</dsp:page>