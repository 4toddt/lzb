<%--
  - Cartridge: Breadcrumbs
  - File Name: Breadcrumbs.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description:
  		Renders refinement that have been selected. Selected refinements can consist
  		of search refinements, dimension refinements or range filter refinements.

  		There are a number of different types of breadcrumb that can be returned
  		inside this content item:
			refinementCrumbs - As a result of selecting a dimension
			searchCrumbs - As a result of performing a search
			rangeFilterCrumbs - As a result of applying a range filter
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/multisite/Site"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />
	<dsp:getvalueof var="searchCrumb" value="${contentItem.searchCrumbs}" />

	<c:set var="searchResultsTitle" value="" />
	<c:if test="${not empty searchCrumb}">
		<c:set var="searchResultsTitle" value="search-results-title"/>
	</c:if>

	<section class="breadcrumbs ${searchResultsTitle}">
		<ul aria-label="breadcrumbs" role="navigation">
			<li>
				<span itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
					<a class="crumb" href="${contextPath}" itemprop="url">
						<span itemprop="title"><fmt:message key="breadcrumb.home"/></span>
					</a>
				</span>
			</li>

			<c:set var="catName" value="" />
			<c:forEach var="dimCrumb" items="${contentItem.refinementCrumbs}">
				<c:if test="${dimCrumb.dimensionName eq 'product.category'}">
					<c:choose>
						<c:when test="${catneme eq ' '}">
							<c:set var="catName" value="${dimCrumb.label }" />
						</c:when>
						<c:otherwise>
							<c:set var="catName" value="${catName}/${dimCrumb.label }" />
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>

			<c:set var="catName" value="${fn:replace(catName,'/Products/', '')}" scope="request" />
			<c:if test="${not empty contentItem.refinementCrumbs || not empty contentItem.rangeFilterCrumbs || not empty contentItem.searchCrumbs}">
				<%-- Display currently selected refinements if there are any --%>
				<c:forEach var="dimCrumb" items="${contentItem.refinementCrumbs}">

					<dsp:include page="/sitewide/includes/webtrendsContent.jsp">
						<dsp:param name="page" value="Product Group"  />
						<dsp:param name="label" value="${dimCrumb.label}"/>
					</dsp:include>
					<%-- Get dimension name for refinement --%>
					<c:set var="dimensionName" value="${dimCrumb.dimensionName}" />
					<c:if test="${not empty dimCrumb.ancestors}">

						<c:set var="showRemoveButton" value="true" />
						<c:forEach var="ancestor" items="${dimCrumb.ancestors}">
							<%-- Check whether it's product.category dimension and if so enable editing of corresponding category in preview. --%>
							<c:choose>
								<c:when test="${dimensionName eq 'product.category'}">
									<c:set var="categoryId" value="${ancestor.properties['category.repositoryId'] }" />
									<%-- Check whether it's not RootCategory dimension ancestor if so then display all ancestors of slected category. --%>
									<!--
									<c:if test="${ancestor.label ne 'Root Category'}">
										<dsp:include page="/global/getNavLink.jsp">
											<dsp:param name="navAction" value="${ancestor}"/>
											<dsp:param name="text" value="${ancestor.label}"/>
										</dsp:include>
										<a href="${link}" title="">${ancestor.label}</a>
									</c:if>
									-->
								</c:when>
							</c:choose>
						</c:forEach>

						<%--
							Render the last child of hierarchical breadcrumb. It is
							not a link
						--%>
						<c:if test="${not empty dimCrumb.ancestors}">
							<%-- Check whether it's product.category dimension and if so enable editing of corresponding category in preview. --%>
							<c:choose>
								<c:when test="${dimensionName eq 'product.category'}">
									<c:set var="categoryId" value="${dimCrumb.properties['category.repositoryId'] }" />
									<li><span class="crumb active">${dimCrumb.label}</span></li>
								</c:when>
								<c:otherwise>
									<li><span class="crumb active">${dimCrumb.label}</span></li>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>

					<%--
						Dimension refinement value e.g "Red". If it is hierarchical breadcrumb
						it was already rendered in atg_store_refinementAncestors div.
					--%>
					<c:if test="${empty dimCrumb.ancestors}">
						<c:set var="showRemoveButton" value="true" />
						<%-- Check whether it's product.category dimension and if so enable editing of corresponding category in preview. --%>
						<c:choose>
							<c:when test="${dimensionName eq 'product.category'}">
								<c:set var="categoryId" value="${dimCrumb.properties['category.repositoryId'] }" />								
								<c:choose>
									<c:when test="${dimensionName eq 'product.category'}">
										<c:set var="categoryId" value="${dimCrumb.properties['category.repositoryId'] }" />
										<li>
										<c:choose>
											<c:when test="${not empty selectedBreadcrumbs.clearAll || not empty selectedBreadcrumbs.rangeFilterCrumbs}">
												<dsp:a iclass="crumb" href="${contextPath}${selectedBreadcrumbs.clearAll}">${dimCrumb.label}</dsp:a>
											</c:when>
											<c:otherwise>
												<span class="crumb">${dimCrumb.label}</span>
											</c:otherwise>
										</c:choose>
										</li>
									</c:when>
									<c:otherwise>
										<c:if test="${dimensionName ne 'onSale'}">
											<li><span class="crumb">${dimCrumb.label}</span></li>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${dimensionName eq 'sku.covers'}">
										<li><span class="crumb"><fmt:message key="breadcrumb.cover-search"/></span></li>
									</c:when>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
				<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
					<!-- COVER CRUMB: <fmt:message key="breadcrumb.cover-search"/> -->
					<c:forEach items="${breadCrumb.value}" var="refinement">
						<c:set var="cPath" value="${fn:replace(refinement.removeAction.contentPath ,'//', '/')}" />
						<c:if test="${breadCrumb.key eq 'sku.colorFamily' || breadCrumb.key eq 'sku.coverType' ||breadCrumb.key eq 'featureCollections'}">
							<li>
<%--							<dsp:a iclass="crumb" href="${cPath}${refinement.removeAction.navigationState}"> --%>
								<span class="crumb active">${refinement.label}</span>
<%--							</dsp:a>   --%>
							</li>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:forEach var="searchCrumb" items="${contentItem.searchCrumbs}">
					<dsp:getvalueof var="searchTerm" value="${searchCrumb.correctedTerms}"/>
					<c:if test="${empty searchTerm}">
					 <dsp:getvalueof var="searchTerm" value="${searchCrumb.terms}"/>
					</c:if>
					<li><span class="crumb">Search: ${fn:escapeXml(searchTerm)}</span></li>
				</c:forEach>
			</c:if>
		</ul>
	</section>

</dsp:page>
