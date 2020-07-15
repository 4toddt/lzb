<%--
  Breadcrumbs

  Renders refinement that have been selected. Selected refinements can consist
  of search refinements, dimension refinements or range filter refinements.

  There are a number of different types of breadcrumb that can be returned
  inside this content item:
    refinementCrumbs - As a result of selecting a dimension
    searchCrumbs - As a result of performing a search
    rangeFilterCrumbs - As a result of applying a range filter
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/multisite/Site"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="contextPath" bean="Site.contextRoot"/>
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />

	<dsp:getvalueof var="searchCrumb" value="${content.searchCrumbs}" />

	<c:set var="searchResultsTitle" value="" />
	<c:if test="${not empty searchCrumb}">
		<c:set var="searchResultsTitle" value="search-results-title"/>
	</c:if>

	<nav aria-label="breadcrumb" role="navigation" class="breadcrumb-wrapper ${searchResultsTitle}">
		<ul>
			<li><span itemscope itemtype="http://data-vocabulary.org/Breadcrumb"><a title="" href="${contextPath}" itemprop="url"><span itemprop="title"><fmt:message key="breadcrumb.home"/></span></a></span></li>

			<c:set var="catName" value="" />
			<c:forEach var="dimCrumb" items="${content.refinementCrumbs}">
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
			<c:if test="${not empty content.refinementCrumbs || not empty content.rangeFilterCrumbs || not empty content.searchCrumbs}">
				<%-- Display currently selected refinements if there are any --%>
				<c:forEach var="dimCrumb" items="${content.refinementCrumbs}">

					<dsp:include page="/includes/webtrendsContent.jsp">
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
									<li>${dimCrumb.label}</li>
								</c:when>
								<c:otherwise>
									<li>${dimCrumb.label}</li>
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
												<dsp:a href="${selectedBreadcrumbs.clearAll}">${dimCrumb.label}</dsp:a>
											</c:when>
											<c:otherwise>
												${dimCrumb.label}
											</c:otherwise>
										</c:choose>
										</li>
									</c:when>
									<c:otherwise>
										<c:if test="${dimensionName ne 'onSale'}">
											<li>${dimCrumb.label}</li>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${dimensionName eq 'sku.covers'}">
										<li><fmt:message key="breadcrumb.cover-search"/></li>
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
<%--							<dsp:a href="${cPath}${refinement.removeAction.navigationState}"> --%>
								${refinement.label}
<%--							</dsp:a>   --%>
							</li>
						</c:if>
					</c:forEach>
				</c:forEach>
				<c:forEach var="searchCrumb" items="${content.searchCrumbs}">
					<dsp:getvalueof var="searchTerm" value="${searchCrumb.correctedTerms}"/>
					<c:if test="${empty searchTerm}">
					 <dsp:getvalueof var="searchTerm" value="${searchCrumb.terms}"/>
					</c:if>
					<li>Search: ${fn:escapeXml(searchTerm)}</li>
				</c:forEach>
			</c:if>
		</ul>
		<c:if test="${not empty searchTerm}"><h2>Search Results for ${fn:escapeXml(searchTerm)}</h2></c:if>
	</nav>

</dsp:page>
