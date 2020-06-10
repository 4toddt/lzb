<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" bean="/OriginatingRequest.contextPath"/>

	<%-- Page Param  --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<dsp:getvalueof var="cells" value="${1 + (contentItem.indexOffset > 0 ? contentItem.indexOffset : 0)}"/>
	<dsp:getvalueof var="bgColor" value="${contentItem.backgroundColor}"/>
	<c:if test="${not empty contentItem.link}">
		<dsp:droplet name="/com/lzb/endeca/ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURL" param="actionURL"/>
			</dsp:oparam>
		</dsp:droplet>

		<c:if test="${!empty contentItem.queryString && !empty actionURL}">
			<dsp:getvalueof var="actionURL" value="${actionURL}${fn:contains(actionURL, '?') ? '&': '?' }"/>
		</c:if>
	</c:if>

	<c:choose>
		<c:when test="${cells eq '2'}">
			<div class="cdp-promo-lg">
				<c:choose>
					<c:when test="${not empty contentItem.videoURL}">
						<c:url value="/modals/video.jsp" var="modalUrl">
							<c:param name="vid" value="${contentItem.videoURL}" />
						</c:url>
						<c:choose>
							<c:when test="${contentItem.isModal}">
								<div class="video-link" data-module="cbox" data-transition="elastic" data-speed="500" data-class="video-modal" data-width="680" data-title="false">
									<a href="${modalUrl}" class="video cboxElement" aria-label="${contentItem.title}" tabindex="0"><span class="icon-play"></span>
										<img src="${contentItem.videoThumbnailURL}" alt="${contentItem.title}" />
									</a>
								</div>
							</c:when>
						</c:choose>
					</c:when>
					<c:otherwise>
						<div class="visual-link">
							<a href="${actionUrl}" tabindex="0">
								<img src="${contentItem.imageURL}" alt="${contentItem.imageAltText}" class="cdp-promo-lg-visual-link" width="230" height="378" />
							</a>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="content">
					<a href="${actionURL}" aria-label="${contentItem.title}">
						<img src="${contentItem.imageURL2}" alt="${contentItem.imageAlt2}" width="250" height="50" />
					</a>
					<h3>${contentItem.title}</h3>
					<p class="small">${contentItem.description}</p>
				</div>
			</div>
		</c:when>
		<c:when test="${cells eq '1'}">
			<div class="cdp-promo-sm vertical-promo">
				<a href="${actionURL}" aria-label="${contentItem.title}">
					<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}" width="230" height="180" />
				</a>
				<div class="content">
					<h3>${contentItem.title}</h3>
						<c:if test="${not empty contentItem.description}">
						<p>${contentItem.description}</p>
					</c:if>
				</div>
			</div>
		</c:when>
	</c:choose>

</dsp:page>

