<%--
  - Cartridge: FourColumnsContainer
  - File Name: FourColumnsContainer.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out a maximum of 4 columns section at the bottom of a page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem}">

		<c:choose>
			<c:when test="${isMobile}">
				<c:set var="headingUrl" value="${contentItem.headingUrlMobile}" />
				<c:set var="linkUrl1" value="${contentItem.linkUrl1Mobile}" />
				<c:set var="linkUrl2" value="${contentItem.linkUrl2Mobile}" />
				<c:set var="linkUrl3" value="${contentItem.linkUrl3Mobile}" />
				<c:set var="linkUrl4" value="${contentItem.linkUrl4Mobile}" />
			</c:when>
			<c:otherwise>
				<c:set var="headingUrl" value="${contentItem.headingUrlDesktop}" />
				<c:set var="linkUrl1" value="${contentItem.linkUrl1Desktop}" />
				<c:set var="linkUrl2" value="${contentItem.linkUrl2Desktop}" />
				<c:set var="linkUrl3" value="${contentItem.linkUrl3Desktop}" />
				<c:set var="linkUrl4" value="${contentItem.linkUrl4Desktop}" />
			</c:otherwise>
		</c:choose>
	
		<div class="bottom-content">
			<c:if test="${not empty contentItem.heading}">
				<a class="heading" href="${headingUrl}">${contentItem.heading}</a>
			</c:if>
			
			<c:if test="${not empty contentItem.maxNumColumns}">
				<ul class="bottom-content-grid-row col${contentItem.maxNumColumns}">
					<c:if test="${not empty contentItem.mediaUrl1}">
						<li class="bottom-content-grid-container">
							<a href="${linkUrl1}"><img src="${contentItem.mediaUrl1}" alt="${contentItem.imageAlt1}"></a>
							<a class="title" href="${linkUrl1}">${contentItem.textDesc1}</a>
						</li>
					</c:if>
					<c:if test="${not empty contentItem.mediaUrl2}">
						<li class="bottom-content-grid-container">
							<a href="${linkUrl2}"><img src="${contentItem.mediaUrl2}" alt="${contentItem.imageAlt2}"></a>
							<a class="title" href="${linkUrl2}">${contentItem.textDesc2}</a>
						</li>
					</c:if>
					<c:if test="${not empty contentItem.mediaUrl3}">
						<li class="bottom-content-grid-container">
							<a href="${linkUrl3}"><img src="${contentItem.mediaUrl3}" alt="${contentItem.imageAlt3}"></a>
							<a class="title" href="${linkUrl3}">${contentItem.textDesc3}</a>
						</li>
					</c:if>
					<c:if test="${not empty contentItem.mediaUrl4}">
						<li class="bottom-content-grid-container">
							<a href="${linkUrl4}"><img src="${contentItem.mediaUrl4}" alt="${contentItem.imageAlt4}"></a>
							<a class="title" href="${linkUrl4}">${contentItem.textDesc4}</a>
						</li>
					</c:if>
				</ul>
			</c:if>
		</div>
	</c:if>
</dsp:page>