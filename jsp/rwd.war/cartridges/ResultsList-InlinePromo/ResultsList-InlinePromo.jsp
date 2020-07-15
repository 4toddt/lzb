<%--
  - Cartridge: ResultsList-InlinePromo
  - File Name: ResultsList-InlinePromo.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the inline promos that make up product results.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>

	<%-- Page Variables --%>
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
			<div class="cdp-promo cdp-promo-lg">
				<c:choose>
					<c:when test="${not empty contentItem.videoURL}">
						<c:url value="/sitewide/ajax/videoModal.jsp" var="modalUrl">
							<c:param name="videoURL" value="${contentItem.videoURL}" />
						</c:url>
						<c:choose>
							<c:when test="${contentItem.isModal}">
								<div class="video-link">
									<a href="${modalUrl}" class="modal-trigger video" data-target="modal-video" aria-label="${contentItem.title}" tabindex="0">
										<span class="icon icon-play-filled" aria-hidden="true"></span>
										<img src="${contentItem.videoThumbnailURL}" alt="${contentItem.title}" />
									</a>
								</div>
							</c:when>
						</c:choose>
					</c:when>
					<c:otherwise>
						<div class="visual-link">
							<a href="${actionUrl}" tabindex="0">
								<img src="${contentItem.imageURL}" alt="${contentItem.imageAltText}" class="cdp-promo-lg-visual-link" />
							</a>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="content">
					<a href="${actionURL}" aria-label="${contentItem.title}">
						<img src="${contentItem.imageURL2}" alt="${contentItem.imageAlt2}" />
					</a>
					<h3>${contentItem.title}</h3>
					<p class="small">${contentItem.description}</p>
				</div>
			</div>
		</c:when>
		<c:when test="${cells eq '1'}">
			<div class="cdp-promo cdp-promo-sm">
				<a href="${actionURL}" aria-label="${contentItem.title}">
					<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}" />
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

