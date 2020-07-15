<%--
  - Cartridge: ImageWithTextLink
  - File Name: ImageWithTextLink.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up an image with text link.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem.link}">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	<%-- Render Image With Text Link --%>
	<div class="image-with-text-link">
		<c:choose>
			<c:when test="${not empty actionURLLink && not empty contentItem.imageUrl}">
				<div class="content-image">
					<a href="${actionURLLink}">
						<img src="${contentItem.imageUrl}" alt="${contentItem.imageAlt}" />
					</a>
				</div>
			</c:when>
			<c:when test="${empty actionURLLink && not empty contentItem.imageUrl}">
				<div class="content-image">
					<img src="${contentItem.imageUrl}" alt="${contentItem.imageAlt}" />
				</div>
			</c:when>
		</c:choose>

		<c:if test="${not empty actionURLLink && not empty contentItem.text}">
			<a href="${actionURLLink}" class="content-title">${contentItem.text}</a>
		</c:if>
	</div>
</dsp:page>
