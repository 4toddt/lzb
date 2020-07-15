<%--
  - Cartridge: ProductDetail-Why-LaZB
  - File Name: ProductDetail-Why-LaZB.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the Why LZB section on the product details page.
  - Required Parameters:
        - contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<%-- Render Why LZB Section --%>
    <div class="why-lzb section-row">
		<div class="section-title">
            <c:choose>
            	<c:when test="${not empty contentItem.title}">
            		<h2>${contentItem.title}</h2>
            	</c:when>
				<c:otherwise>
					<h2><fmt:message key="pdp.whyLZB.heading"/></h2>
				</c:otherwise>
            </c:choose>
        </div>

		<div class="section-content">
			<c:if test="${not empty contentItem.tiles}">
				<div class="why-lzb-tiles">
	      			<ul>
	        			<c:forEach var="tile" items="${contentItem.tiles}" varStatus="status">
							<%-- Render Tile Content --%>
							<li><dsp:renderContentItem contentItem="${tile}" /></li>
						</c:forEach>
	      			</ul>
	        	</div>
			</c:if>

			<%-- Render Image/Video Content --%>
			<c:if test="${not empty contentItem.videoURL || not empty contentItem.imageURL}">
		   	  	<c:choose>
					<c:when test="${not empty contentItem.videoURL}">
						<c:url value="/sitewide/ajax/videoModal.jsp" var="modalUrl">
							<c:param name="videoURL" value="${contentItem.videoURL}" />
						</c:url>
						<c:choose>
							<c:when test="${contentItem.isModal}">
								<div class="media-content video-link">
									<a href="${modalUrl}" class="modal-trigger video" data-target="modal-video" data-size="medium" aria-label="${contentItem.title}">
										<span class="icon icon-play-filled" aria-hidden="true"></span>
										<img src="${contentItem.videoThumbnailURL}" alt="${contentItem.imageAlt}" />
									</a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="media-content video-link">
									<a href="${contentItem.videoURL}" aria-label="${contentItem.title}">
										<span class="icon icon-play-filled" aria-hidden="true"></span>
										<img src="${contentItem.videoThumbnailURL}" alt="${contentItem.imageAlt}" />
									</a>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<div class="media-content">
							<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}" />
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>

			<%-- Render Paragraph Content --%>
			<c:if test="${not empty contentItem.paragraphHeading || not empty contentItem.paragraph}">
				<div class="copy">
					<c:if test="${not empty contentItem.paragraphHeading}">
						<h3>${contentItem.paragraphHeading}</h3>
					</c:if>
					<c:if test="${not empty contentItem.paragraph}">
						<p>${contentItem.paragraph}</p>
					</c:if>
				</div>
			</c:if>
		</div>
    </div>
</dsp:page>