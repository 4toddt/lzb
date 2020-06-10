<%--
  - File Name: monetateCDPAndPDPPageData.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This file is used for Monetate product data.
  - Required Parameters:
  		- cdpProductListForTracking: request scoped from ResultsList.jsp Cartridge,
		- cdpCategoryNameForTracking: request scoped from ResultsList.jsp Cartridge,
		- PDPProductDataForTracking: request scoped from ProductDetailsPage.jsp Cartridge
  - Optional Parameters:
--%>
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