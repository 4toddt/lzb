<%--
  - Cartridge: MainContentHero
  - File Name: MainContentHero.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This cartridge lays out the elements that make up a a main content image and heading text.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof value="${storeConfig.endecaMediaURL}" var="mediaURL"/>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem}">
		<%-- START: Main Hero Banner --%>
		<div class="main-hero-banner">
			<%-- render image --%>
			<c:if test="${not empty contentItem.mediaUrl}">
				<div class="main-hero-banner-image">
					<img src="${contentItem.mediaUrl}" alt="${contentItem.imageAlt}" />
				</div>
			</c:if>
			<%-- render text --%>
			<c:if test="${not empty contentItem.title || not empty contentItem.body}">
				<div class="main-hero-banner-text">
					<c:if test="${not empty contentItem.title}">
						<h1>${contentItem.title}</h1>
					</c:if>
					<c:if test="${not empty contentItem.body}">
						<p>${contentItem.body}</p>
					</c:if>
				</div>
			</c:if>
		</div>
		<%-- END: Main Hero Banner --%>
	</c:if>
</dsp:page>