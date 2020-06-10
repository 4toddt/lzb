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
		</c:when>
		<c:otherwise>
			<c:set var="seoCanonicalURL" value="${originatingRequest.getRequestURI()}" />
		</c:otherwise>
	</c:choose>

	<%-- Define META index and follow --%>
	<c:set var="metaIndex" value="${contentItem.index}"/>
	<c:set var="metaFollow" value="${contentItem.follow}"/>
	<c:set var="metaIndexValue" value="${(metaIndex eq 'false') ? 'noindex' : 'index'}"/>
	<c:set var="metaFollowValue" value="${(metaFollow eq 'false') ? 'nofollow' : 'follow'}"/>

    <layout:default>
		<jsp:attribute name="pageTitle">${contentItem.title}</jsp:attribute>
		<jsp:attribute name="metaDescription">${contentItem.metaDescription}</jsp:attribute>
        <jsp:attribute name="metaKeywords">${contentItem.metaKeywords}</jsp:attribute>
        <jsp:attribute name="seoCanonicalURL">${seoCanonicalURL}</jsp:attribute>
        <jsp:attribute name="seoRobots">${metaIndexValue},${metaFollowValue}</jsp:attribute>
        <jsp:attribute name="lastModified"></jsp:attribute>
        <jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content npc mobile-site ${contentItem.bodyStyle}</jsp:attribute>
		<jsp:attribute name="analyticsPageType">staticContentPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">${contentItem.cssIncludes}</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">${contentItem.jsIncludes}</jsp:attribute>

        <jsp:body>
			<!-- START: LZB NPC One-Column Page -->

			<%-- Render the headerContent section --%>
			<c:if test="${not empty contentItem.headerContent}">
				<c:forEach var="element" items="${contentItem.headerContent}">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</c:if>

			<%-- content container--%>
			<section class="one-column-container">
				<%-- Render the mainContent section --%>
				<c:if test="${not empty contentItem.mainContent}">
					<c:forEach var="element" items="${contentItem.mainContent}">
					   	<dsp:renderContentItem contentItem="${element}" />
					 </c:forEach>
				</c:if>
			</section>

			<%-- Render the footerContent section --%>
			<c:if test="${not empty contentItem.footerContent}">
				<c:forEach var="element" items="${contentItem.footerContent}">
					<dsp:renderContentItem contentItem="${element}" />
				 </c:forEach>
			</c:if>

			<!-- END: LZB NPC One-Column Page -->
        </jsp:body>

    </layout:default>
</dsp:page>