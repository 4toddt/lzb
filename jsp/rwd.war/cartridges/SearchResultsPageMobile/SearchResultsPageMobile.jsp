<%--
  - Cartridge: SearchResultsPage
  - File Name: SearchResultsPage.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the search results page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<fmt:message var="searchAgainText" key="search.searchAgain"/>
	<fmt:message var="searchAgainInstruction" key="search.searchAgainInstruction"/>

	<%-- Sets selectedFacet variables for breadCrumbs --%>
	<c:if test="${not empty contentItem.headerContent}">
	   <c:forEach var="element" items="${contentItem.headerContent}">
		    <c:if test="${element['@type'] eq 'Breadcrumbs'}">
				<c:set var="selectedBreadcrumbs" value="${element}" scope="request"/>
				<c:forEach var="dimCrumb" items="${element.refinementCrumbs}">
				    <c:if test="${dimCrumb.dimensionName eq 'product.category'}">
						<c:set var="selectedFacet" value="${dimCrumb.label}"/>
				    </c:if>
		     	</c:forEach>
				<c:if test="${empty selectedFacet}">
				    <c:forEach var="dimCrumb" items="${element.refinementCrumbs}" end="1">
					    <c:if test="${dimCrumb.dimensionName ne 'product.category'}">
					      	<c:choose>
					      		<c:when test="${dimCrumb.dimensionName eq 'sku.covers'}">
					      			<c:set var="colorArr" value="${fn:split(dimCrumb.label,'~')}" />
					      			<c:if test="${fn:length(colorArr) > 1}">
										<c:set var="selectedFacet" value="${colorArr[1]}" scope="request" />
									</c:if>
					      		</c:when>
					      		<c:otherwise>
					      			<c:set var="selectedFacet" value="${dimCrumb.label}" scope="request" />
					      		</c:otherwise>
					      	</c:choose>
					    </c:if>
				    </c:forEach>
				</c:if>
		    </c:if>
	    </c:forEach>
	 </c:if>

	<c:if test="${not empty selectedBreadcrumbs &&  not empty selectedBreadcrumbs.breadcrumbsMap}">
		<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
			<c:forEach items="${breadCrumb.value}" var="refinement" >
				<c:set var="refinementLabelForSEO" value="${refinement.label}" scope="request" />
			</c:forEach>
		</c:forEach>
 	</c:if>

	<%-- Defines SEO Tag Data --%>
	<c:choose>
		<c:when test="${not empty selectedFacet and not empty refinementLabelForSEO}">
			<dsp:include page="/sitewide/includes/SEOTagData.jsp">
				<dsp:param name="paramKeyForSEOTagData" value="${refinementLabelForSEO}_${selectedFacet}"/>
			</dsp:include>
		</c:when>
		<c:when test="${not empty selectedFacet}">
			<dsp:include page="/sitewide/includes/SEOTagData.jsp">
				<dsp:param name="paramKeyForSEOTagData" value="${selectedFacet}"/>
			</dsp:include>
		</c:when>
	</c:choose>

	<%-- Define SEO Canonical URL --%>
	<c:choose>
		<%-- No Search Results Page --%>
		<c:when test="${fn:contains(fn:toLowerCase(forwardRequestUri), storeConfig.mobileNoSearchUrl)}">
			<c:set var="canonicalUriReplacePattern" value="${storeConfig.mobileNoSearchUrl}" />
			<c:set var="canonicalUriReplaceWith" value="${storeConfig.storeNoSearchUrl}" />
		</c:when>
		<%-- Search Results Page --%>
		<c:otherwise>
			<c:set var="canonicalUriReplacePattern" value="${storeConfig.mobileSearchUrl}" />
			<c:set var="canonicalUriReplaceWith" value="${storeConfig.storeSearchUrl}" />
		</c:otherwise>
	</c:choose>
	<c:set var="seoCanonicalURL" value="${fn:replace(forwardRequestUri, canonicalUriReplacePattern, canonicalUriReplaceWith)}" />

	<%-- Define META index and follow --%>
	<c:set var="metaIndex" value="${contentItem.index}"/>
	<c:set var="metaFollow" value="${contentItem.follow}"/>
	<c:set var="metaIndexValue" value="${(metaIndex eq 'false') ? 'noindex' : 'index'}"/>
	<c:set var="metaFollowValue" value="${(metaFollow eq 'false') ? 'nofollow' : 'follow'}"/>

    <layout:default>
		<jsp:attribute name="pageTitle">${contentItem.title}</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty sEOMetaTagDescription}">
					${sEOMetaTagDescription}
				</c:when>
				<c:otherwise>
					${contentItem.metaDescription}
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
        <jsp:attribute name="metaKeywords">${contentItem.metaKeywords}</jsp:attribute>
        <jsp:attribute name="seoCanonicalURL">${seoCanonicalURL}</jsp:attribute>
        <jsp:attribute name="seoRobots">${metaIndexValue},${metaFollowValue}</jsp:attribute>
        <jsp:attribute name="lastModified"></jsp:attribute>
        <jsp:attribute name="doSessionTimeout">false</jsp:attribute>
        <jsp:attribute name="section">browse</jsp:attribute>
        <jsp:attribute name="pageType">search</jsp:attribute>
        <jsp:attribute name="bodyClass">search ${contentItem.bodyStyle}</jsp:attribute>
        <jsp:attribute name="analyticsPageType">searchResultsPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">${contentItem.cssIncludes}</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">${contentItem.jsIncludes}</jsp:attribute>

        <jsp:body>
			<!-- START: Search Results Page -->

			<%-- Render the headerContent section --%>
			<c:if test="${not empty contentItem.headerContent}">
				<c:forEach var="element" items="${contentItem.headerContent}">
					<dsp:renderContentItem contentItem="${element}" />

					<%-- set searchTerm variable --%>
					<c:if test="${element['@type'] eq 'Breadcrumbs'}">
						<c:forEach var="searchCrumb" items="${element.searchCrumbs}">
							<c:set var="searchTerm" value="${searchCrumb.correctedTerms}"/>
							<c:if test="${empty searchTerm}">
								<c:set var="searchTerm" value="${searchCrumb.terms}"/>
							</c:if>
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>

			<%-- content container--%>
			<section class="one-column-container">
				<c:choose>
					<c:when test="${fn:contains(fn:toLowerCase(forwardRequestUri), storeConfig.mobileNoSearchUrl)}">
						<%-- Render No Search Results --%>
					</c:when>
					<c:otherwise>
						<%-- Render Search Results --%>
						<c:if test="${not empty searchTerm}">
							<div class="page-heading">
								<%-- Render Page Heading --%>
								<h2><fmt:message key="plp.searchResults.termTitle"/> <span class="search-term">${fn:escapeXml(searchTerm)}</span></h2>
							</div>
						</c:if>
					</c:otherwise>
				</c:choose>

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

			<!-- END: Search Results Page -->
        </jsp:body>

    </layout:default>
</dsp:page>