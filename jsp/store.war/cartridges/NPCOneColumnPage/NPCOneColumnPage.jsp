<%--
  - Cartridge: NPCOneColumnPage
  - File Name: NPCOneColumnPage.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up a one column non-product content(NPC) page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="pageTypeForTracking" value="main" scope="request" />
	<c:set var="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>

	<%-- Define SEO Canonical URL --%>
	<c:choose>
		<c:when test="${not empty forwardRequestUri}">
			<c:set var="seoCanonicalURL" value="${forwardRequestUri}" />
			<c:set var="seoAlternateURL" value="${forwardRequestUri}" />
		</c:when>
		<c:otherwise>
			<c:set var="seoCanonicalURL" value="${originatingRequest.getRequestURI()}" />
			<c:set var="seoAlternateURL" value="${originatingRequest.getRequestURI()}" />
		</c:otherwise>
	</c:choose>

    <lzb:pageContainer>
		<jsp:attribute name="title">${contentItem.title}</jsp:attribute>
		<jsp:attribute name="metaDescription">${contentItem.metaDescription}</jsp:attribute>
        <jsp:attribute name="metaKeywords">${contentItem.metaKeywords}</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${seoAlternateURL}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${seoCanonicalURL}</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content npc ${contentItem.bodyStyle}</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">${contentItem.cssIncludes}</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">${contentItem.jsIncludes}</jsp:attribute>

        <jsp:body>
			<!-- START: LZB NPC One-Column Page -->

			<%-- content container--%>
			<main role="main">
				<%-- Render the mainContent section --%>
				<c:if test="${not empty contentItem.mainContent}">
					<c:forEach var="element" items="${contentItem.mainContent}">
					   	<dsp:renderContentItem contentItem="${element}" />
					 </c:forEach>
				</c:if>
			</main>

			<!-- END: LZB NPC One-Column Page -->
        </jsp:body>

    </lzb:pageContainer>
</dsp:page>