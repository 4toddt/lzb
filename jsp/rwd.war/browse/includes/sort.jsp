<%--
    - File Name: sort.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the sort feature for the product listing pages.
    - Required Parameters:
		- contentItem.totalNumRecs
		- contentItem.sortOptions
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Page Variables --%>
	<dsp:getvalueof var="totalNumRecs" param="totalNumRecs" />
	<dsp:getvalueof var="sortOptionsContent" param="sortOptions" />

	<%-- START: Sort Sidebar --%>
	<div id="sort-sidebar" class="sort-sidebar">
		<%-- offCanvas heading --%>
		<div class="off-canvas-heading">
			<div class="heading">
				<fmt:message key="plp.sort.heading"/>
				<span class="product-results-count">(<span class="result-count">${totalNumRecs}</span> <fmt:message key="plp.results.items"/>)</span>
			</div>
			<a href="javascript:void(0);" class="close-off-canvas-link">
				<span class="icon icon-close" aria-hidden="true"></span>
				<span class="sr-only"><fmt:message key="common.closeMenu"/></span>
			</a>
		</div>

		<%-- START: sort menu --%>
		<div class="sort-menu">
			<div class="sort-list">
				<%-- Loop through Each Sort Option --%>
				<c:set var="count" value="0" />
				<c:forEach var="sortOption" items="${sortOptionsContent}">
					<c:set var="count" value="${count + 1}"/>
					<c:set var="contentPath" value="${fn:replace(sortOption.contentPath ,'//', '/')}" />
					<c:choose>
						<c:when test="${sortOption.selected}">
							<%-- Render Selected Sort Radio Button --%>
							<div class="sort-item custom-radio active" data-sortparam="sortby-radio${count}" data-sortvalue="${contextPath}${contentPath}${sortOption.navigationState}">
								<input id="sortby-radio${count}" type="radio" name="sort-radio" value="${contextPath}${contentPath}${sortOption.navigationState}" checked="checked"/>
								<label for="sortby-radio${count}"><fmt:message key="${sortOption.label}"/></label>
							</div>
						</c:when>
						<c:otherwise>
							<%-- Render Sort Radio Button --%>
							<div class="sort-item custom-radio" data-sortparam="sortby-radio${count}" data-sortvalue="${contextPath}${contentPath}${sortOption.navigationState}">
								<input id="sortby-radio${count}" type="radio" name="sort-radio" value="${contextPath}${contentPath}${sortOption.navigationState}"/>
								<label for="sortby-radio${count}"><fmt:message key="${sortOption.label}"/></label>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>

			<%-- side menu actions --%>
			<div class="side-menu-actions">
				<a href="javascript:void(0);" class="apply-facets button primary"><fmt:message key="plp.results.button"/></a>
			</div>
		</div>
		<%-- END: sort menu --%>
	</div>
	<%-- END: Sort Sidebar --%>
</dsp:page>