<dsp:page>

	<dsp:importbean bean="/biglots/commerce/catalog/CategoryLookup"/>
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList" />

	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />
	<dsp:getvalueof var="numberOfProduct" bean="ProductList.count" />

	<c:set var="cdpAppliedFacetsClass" value="" />
	<c:if test="${not empty selectedBreadcrumbs &&  not empty selectedBreadcrumbs.breadcrumbsMap}">
		<c:set var="cdpAppliedFacetsClass" value="open" />
	</c:if>

	<div class="applied-facet-container">
		<div class="cdp-applied-facets ${cdpAppliedFacetsClass}">
			<c:if test="${not empty selectedBreadcrumbs && (not empty selectedBreadcrumbs.breadcrumbsMap || not empty selectedBreadcrumbs.rangeFilterCrumbs)}">
				<ul>
					<c:set var="hideCDPSEOContent" value="true" scope="request" />
					<c:if test="${not empty selectedBreadcrumbs.breadcrumbsMap}">
						<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
							<c:forEach items="${breadCrumb.value}" var="refinement">
								<c:set var="cPath" value="${fn:replace(refinement.removeAction.contentPath ,'//', '/')}" />
								<c:set var="inputID" value="${refinement.displayName}-${fn:replace(refinement.label, ' ', '-')}" />
								<c:choose>
									<c:when test="${breadCrumb.key eq 'sku.covers'}">
										<c:set var="colorArr" value="${fn:split(refinement.label,'~')}" />
										<li class="applied-facet-tile" data-cat="${cPath}${refinement.removeAction.navigationState}" data-id="${inputID}" data-count="${refinement.count}" aria-label="Filter ${colorArr[1]}" tabindex="0">
											${colorArr[1]}
										</li>
									</c:when>
									<c:otherwise>
										<li class="applied-facet-tile" data-cat="${cPath}${refinement.removeAction.navigationState}" data-id="${inputID}" data-count="${refinement.count}"  aria-label="Filter by ${refinement.label}" tabindex="0">
											<span class="icon-close-x" tabindex="0"></span>${refinement.label}
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:forEach>
					</c:if>
					<c:if test="${not empty selectedBreadcrumbs.rangeFilterCrumbs}">
						<c:set var="rangeFilterCrumb" value="${selectedBreadcrumbs.rangeFilterCrumbs}"/>
						<c:set var="cPath" value="${fn:replace(rangeFilterCrumb.removeAction.contentPath ,'//', '/')}" />
						<c:set var="rangeInputID" value="Price-${rangeFilterCrumb.lowerBound}-${rangeFilterCrumb.upperBound}" />
						<fmt:formatNumber var="rangeFilterLower" value="${rangeFilterCrumb.lowerBound}" maxFractionDigits="0" />
						<fmt:formatNumber var="rangeFilterUpper" value="${rangeFilterCrumb.upperBound}" maxFractionDigits="0" />
						<li class="applied-facet-tile price-range-facet" data-cat="${cPath}${rangeFilterCrumb.removeAction.navigationState}" data-id="${rangeInputID}" aria-label="Filter by $${rangeFilterLower} to $${rangeFilterUpper}" tabindex="0">
							<span class="icon-close-x" tabindex="0"></span>$${rangeFilterLower}&nbsp;-&nbsp;$${rangeFilterUpper}
						</li>
					</c:if>
				</ul>
			
				<c:if test="${not empty selectedBreadcrumbs.clearAll || not empty selectedBreadcrumbs.rangeFilterCrumbs}">
					<span class="facets-clear-all" data-id="clearallfilters">
						<a href="${selectedBreadcrumbs.clearAll}" aria-label="Clear all filters" tabindex="0">Clear All</a>
					</span>
				</c:if>

			</c:if>

		</div>

		<%-- compare drawer --%>
		<c:set var="compareClass" value="hide" scope="request" />
		<c:if test="${numberOfProduct gt 0}">
			<c:set var="compareClass" value="" scope="request" />
		</c:if>

		<div class="cdp-compare-label toggle-menu ${compareClass}">
			<span class="number-compared">${numberOfProduct}</span>/5 | <span class="cdp-compare-label-text"><fmt:message key="compare.compare"/></span> <span class="icon-arrow-down"></span>
		</div>
	</div>

</dsp:page>
