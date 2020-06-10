<%--
	- File Name: categoryNavBar.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page lays out the category navigation for the product listing pages
	- Required Parameters:
		- contentItem.totalNumRecs
	- Optional Parameters:
--%>
<dsp:page>
	<%-- Page Variables --%>
	<dsp:getvalueof var="totalNumRecs" param="totalNumRecs" />

	<div class="category-navigation-container">
		<%-- product filter action --%>
		<div class="category-filter">
			<a class="facets-toggle" href="javascript:void(0);" data-target="facet-sidebar" aria-haspopup="true">
				<fmt:message key="plp.categoryNav.filter"/>
				<span class="icon icon-filter" aria-hidden="true"></span>
			</a>
		</div>

		<%-- product sort action --%>
		<div class="category-sort">
			<a class="sort-toggle" href="javascript:void(0);" data-target="sort-sidebar" aria-haspopup="true">
				<fmt:message key="plp.categoryNav.sort"/>
				<span class="icon icon-sort" aria-hidden="true"></span>
			</a>
		</div>

		<%-- product results count --%>
		<div class="product-results-count">
			<span class="result-count">${totalNumRecs}</span>
			<span class="result-title"><fmt:message key="plp.results.items"/></span>
		</div>
	</div>
</dsp:page>