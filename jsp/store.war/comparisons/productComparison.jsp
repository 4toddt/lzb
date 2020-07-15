<dsp:page>

	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListContains"/>
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />

	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
  <dsp:getvalueof var="element" param="element" />
	<dsp:getvalueof var="productId" value="${element.attributes['product.repositoryId']}"/>
	<dsp:getvalueof var="skuId" value="${element.attributes['sku.repositoryId']}"/>
	<dsp:getvalueof var="productListItems" bean="ProductList.items" />
	<dsp:getvalueof var="productName" value="${element.attributes['sku.displayName']}" />
	<dsp:getvalueof var="formattedListPrice" value="${element.attributes['P_LowestPrice']}" />
	<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestPrice']}" >
		<dsp:getvalueof var="formattedListPrice" value="${element.attributes['P_LowestPriceCA']}" />
	</c:if>
	<dsp:getvalueof var="formattedSalePrice" value="${element.attributes['P_LowestSalePrice']}" />
	<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestPrice']}" >
		<dsp:getvalueof var="formattedSalePrice" value="${element.attributes['P_LowestSalePriceCA']}" />
	</c:if>
	<c:set var="endUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:set var="enableCompare" value="false" scope="request" />
	<c:if test="${ not empty productListItems[1]}">
		<c:set var="enableCompare" value="true" scope="request" />
	</c:if>

	<dsp:droplet name="ProductListContains">
		<dsp:param  name="productList" bean="ProductList"/>
		<dsp:param  name="productID" value="${productId}"/>
		<dsp:param  name="skuID" value="${skuId}"/>
		<dsp:param  name="categoryID" value="${categoryId}"/>
		<dsp:getvalueof var="itemid" param="itemid" vartype="java.lang.Integer"/>
		<dsp:getvalueof var="count" param="count"/>
		<dsp:oparam name="true">
			<div class="cdp-compare-button extend active">
				<div class="custom-checkbox">
					<input type="checkbox" id="add-compare-${skuId}" name="add-compare" class="cdp-compare-checkbox"
						data-skuid="${skuId}"
						data-productid="${productId}"
						data-listPrice="${formattedListPrice}"
						data-salePrice="${formattedSalePrice}"
						data-coverCount="${element.attributes['sku.noOfCovers']}"
						data-coverskuid="${element.attributes['defaultCoverSku']}"
						data-entriesId="${itemid}"
						data-productName="${productName}"
						checked="checked"/>
					<label for="add-compare-${skuId}" class="extendp">Compare Now</label>
				</div>
			</div>
		</dsp:oparam>
		<dsp:oparam name="false">
			<div class="cdp-compare-button">
				<div class="custom-checkbox">
					<input type="checkbox" id="add-compare-${skuId}" name="add-compare" class="cdp-compare-checkbox"
						data-skuid="${skuId}"
						data-productid="${productId}"
						data-listPrice="${formattedListPrice}"
						data-salePrice="${formattedSalePrice}"
						data-coverCount="${element.attributes['sku.noOfCovers']}"
						data-coverskuid="${element.attributes['defaultCoverSku']}"
						data-entriesId="${itemid}"
						data-productName="${productName}" />
					<label for="add-compare-${skuId}">Compare</label>
				</div>
			</div>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>
