<dsp:page>

	<c:if test="${(not empty cdpProductListForTracking)}">
		<script>
			<%-- Set category for monetate --%>
			window.monetateQ.push(["addCategories",["${cdpCategoryNameForTracking}"]]);
			<%-- Set product list for monetate --%>
			window.monetateQ.push(["addProducts",[${cdpProductListForTracking}]]);		
		</script>
	</c:if>
	
	<c:if test="${(not empty PDPProductDataForTracking)}">
		<script>
			<%-- Set product id --%>
			window.monetateQ.push(["addProductDetails",["${PDPProductDataForTracking}"]]);
		</script>
	</c:if>	
</dsp:page>