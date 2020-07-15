<dsp:page>

	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList" />
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListContains"/>
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Get the items in the product list --%>
	<dsp:getvalueof var="categoryId" param="categoryId" />
	<dsp:getvalueof var="productId" param="productId" />
	<dsp:getvalueof var="skuId" param="skuId" />
	<dsp:getvalueof var="productListItems" bean="ProductList.items" />
	<dsp:getvalueof var="numberOfProduct" bean="ProductList.count" />

	<div class="cdp-compare" data-module="nav-hover-intent">

		<ul class="cdp-compare-items">
			<c:forEach begin="0" end="4" var="count">

				<c:set var="cProductId" value="" />
				<c:set var="cSkuId" value="" />
				<c:set var="cImgVal" value="" />
				<c:set var="cPriceInfoListPrice" value="" />
				<c:set var="cPriceInfoSalePrice" value="" />
				<c:set var="cProductName" value="" />

				<c:set var="addClassName" value="cdp-compare-item-empty" />
				<c:set var="classCompareUsed" value="" />
				<c:set var="imagePath" value="${storeConfig.imagePath}" />
				<c:set var="contentHostName" value="//${storeConfig.contentHostName}" />
			  <c:set var="storeConfigHostName" value="${storeConfig.hostName}" />

				<c:if test="${count lt numberOfProduct}">
					<c:set var="currentProductListItem" value="${productListItems[count]}" />
					<c:set var="productListItemsLength" value="${numberOfProduct}" />
					<c:set var="cProductId" value="${currentProductListItem.product.repositoryId }" />
					<c:set var="cProductName" value="${currentProductListItem.product.displayName}" />
					<c:set var="cSkuId" value="${currentProductListItem.sku.repositoryId }" />
					<c:set var="cImgVal" value="${contentHostName}${storeConfig.baseImagePath}${currentProductListItem.CDPDefaultImage}" />
					<c:set var="cPriceInfoListPrice" value="${currentProductListItem.priceInfo.listPrice}" />
					<c:set var="cPriceInfoSalePrice" value="${currentProductListItem.priceInfo.salePrice}" />
					<c:set var="addClassName" value="add-compare-${cSkuId}-item" />
					<c:set var="classCompareUsed" value=" compare-used" />
					<c:set var="imagePath" value="${storeConfig.imagePath}" />
			  	<c:set var="storeConfigHostName" value="${storeConfig.hostName}" />
			  	<c:set var="cCoverCount" value="${currentProductListItem.coverCount}" />
			  	<c:set var="cDefaultcoverSkuId" value="${currentProductListItem.defaultCoverId}" />
				</c:if>

				<li id="comparebar-item-${count}" class="${addClassName} ${classCompareUsed}"
					data-skuid="${cSkuId}" data-productid="${cProductId}"
					data-listPrice="${cPriceInfoListPrice}" data-salePrice="${cPriceInfoSalePrice}" data-coverCount="${cCoverCount}"
					data-coverskuid="${cDefaultcoverSkuId}" data-entriesId="${currentProductListItem.id}" data-productName="${cProductName}"
					data-imgurl="${cImgVal}" tabindex="0">
					<c:choose>
						<c:when test="${count lt productListItemsLength}">
							<span class="cdp-compare-remove-btn icon-close-x" role="button" alt="remove from compare" tabindex="0"></span>
							<img alt="comparelistProduct" class="cdp-compare-item-image" src="${cImgVal}" tabindex="0"/>
						</c:when>
						<c:otherwise>
							<span class="cdp-compare-remove-btn icon-close-x" style="display: none" role="button" alt="remove from compare" tabindex="0"></span>
							<img alt="" class="cdp-compare-item-image" src="${cImgVal}" tabindex="0"/>
						</c:otherwise>
					</c:choose>
					<p class="compare-summary-itemname">${cProductName}</p>
				</li>

			</c:forEach>

		</ul>

		<c:choose>
			<c:when test="${numberOfProduct gt 1}">
				<button class="compare-button" tabindex="0"><fmt:message key="compare.now"/></button>
			</c:when>
			<c:otherwise>
				<button class="compare-button" disabled="true"><fmt:message key="compare.now"/></button>
			</c:otherwise>
		</c:choose>

	</div>

</dsp:page>
