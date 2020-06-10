<%--
  - File Name: appliedFacets.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This page lays out the applied facets for the product listing pages.
  - Required Parameters:
  - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>

	<%-- Page Variables --%>
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />
	<dsp:getvalueof var="valueNs" param="Ns"/>

	<%-- Deine clear all link action that keeps sort selection --%>
	<c:choose>
        <c:when test="${not empty valueNs}">
            <c:set var="actionPathClearAllFilters" value="${contextPath}${selectedBreadcrumbs.clearAll}?Ns=${valueNs}" />
        </c:when>
        <c:otherwise>
            <c:set var="actionPathClearAllFilters" value="${contextPath}${selectedBreadcrumbs.clearAll}" />
        </c:otherwise>
    </c:choose>

    <%-- START: Applied Facets --%>
    <div class="applied-facets accordion" data-accordion aria-multiselectable="false" role="tablist">
        <div class="accordion-container">
            <div class="accordion-title" role="tab" aria-controls="applied-facet-body" id="applied-facet-title" tabindex="0">
                <fmt:message key="plp.appliedFacets.title"/> <span class="ref-count"></span>
                <span class="icon icon-arrow-down"></span>
            </div>
            <div class="accordion-body" aria-labeledby="applied-facet-title" role="tabpanel" id="applied-facet-body">
                <div class="accordion-body-content">
                    <%-- applied-facet --%>
                    <c:if test="${not empty selectedBreadcrumbs && (not empty selectedBreadcrumbs.breadcrumbsMap || not empty selectedBreadcrumbs.rangeFilterCrumbs)}">
                        <c:if test="${not empty selectedBreadcrumbs.breadcrumbsMap}">
    						<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
    							<c:forEach items="${breadCrumb.value}" var="refinement">
    								<c:set var="contentPath" value="${fn:replace(refinement.removeAction.contentPath ,'//', '/')}" />
    								<c:set var="dataId" value="${refinement.displayName}-${fn:replace(refinement.label, ' ', '-')}" />
    								<c:choose>
										<%-- NOTE: JIRA DMI-1775 sku.covers is no longer a dimension value that is used in any of the cartridges for Refinement or Guided Navigation. --%>
    									<c:when test="${breadCrumb.key eq 'sku.covers'}">
    										<c:set var="colorArr" value="${fn:split(refinement.label,'~')}" />
                                            <div class="applied-facet" data-count="${refinement.count}" data-nstate="${contextPath}${contentPath}${refinement.removeAction.navigationState}" data-id="${dataId}" aria-label="Filter ${colorArr[1]}">
                                                <a class="applied-facet-item" href="javascript:void(0);" rel="nofollow">
                                                    ${colorArr[1]}
                                                </a>
                                            </div>
    									</c:when>
    									<c:otherwise>
                                            <div class="applied-facet" data-count="${refinement.count}" data-nstate="${contextPath}${contentPath}${refinement.removeAction.navigationState}" data-id="${dataId}" aria-label="Filter by ${refinement.label}">
                                                <a class="applied-facet-item" href="javascript:void(0);" rel="nofollow">
                                                    <span class="icon icon-remove" aria-hidden="true"></span>
                                                    <span class="sr-only"><fmt:message key="common.remove"/></span> ${refinement.label}
                                                </a>
                                            </div>
    									</c:otherwise>
    								</c:choose>
    							</c:forEach>
    						</c:forEach>
    					</c:if>
                    </c:if>

                    <%-- clear facets actions --%>
                    <div class="clear-facet-actions">
                        <c:if test="${not empty selectedBreadcrumbs.clearAll}">
                            <a class="clear-all-link" href="${actionPathClearAllFilters}" rel="nofollow" data-id="clearallfilters" aria-label="Clear all filters"><fmt:message key="plp.appliedFacets.clearAll"/></a>
                            <span class="divider">|</span>
                        </c:if>
                        <a class="facets-toggle" href="javascript:void(0);" rel="nofollow"><fmt:message key="plp.appliedFacets.moreFilters"/></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- END: Applied Facets --%>
</dsp:page>