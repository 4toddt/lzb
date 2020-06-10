<%--
  - Cartridge: GuidedNavigationHorizontal
  - File Name: GuidedNavigationHorizontal.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the Guided Navigation.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<fmt:message var="filtersAriaLabel" key="plp.filters.ariaLabel" />

	<%-- START: Facet Sidebar --%>
	<div id="facet-sidebar" class="facet-sidebar">
		<%-- offCanvas heading --%>
		<div class="off-canvas-heading">
			<div class="heading">
				<fmt:message key="plp.filters.heading"/>
				<%-- result count is set from the init.browse.js file for this instance --%>
				<span class="product-results-count">(<span class="result-count">0</span> <fmt:message key="plp.results.items"/>)</span>
			</div>
			<a href="javascript:void(0);" class="close-off-canvas-link">
				<span class="icon icon-close" aria-hidden="true"></span>
				<span class="sr-only"><fmt:message key="common.closeMenu"/></span>
			</a>
		</div>
		<%-- Filters --%>
		<div class="filters" data-filters>
			<%-- START: facet menu --%>
			<div class="facet-menu">
				<c:if test="${not empty contentItem.navigation}">
					<div class="filters-list-container accordion facet-group" data-accordion aria-multiselectable="false" role="tablist" aria-label="${filtersAriaLabel}">
						<c:forEach var="element" items="${contentItem.navigation}">
				            <c:if test="${element['@type'] eq 'RefinementMenu'}">
								<dsp:renderContentItem contentItem="${element}" />
							</c:if>
						</c:forEach>
					</div>
				</c:if>

				<%-- side menu actions --%>
				<div class="side-menu-actions">
					<a href="javascript:void(0);" class="apply-facets button primary"><fmt:message key="plp.results.button"/></a>
				</div>
			</div>
			<%-- END: facet menu --%>
		</div>
	</div>
	<%-- END: Facet Sidebar --%>
</dsp:page>
