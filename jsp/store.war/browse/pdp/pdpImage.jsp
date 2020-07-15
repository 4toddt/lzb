<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBAdditionalImagesDroplet" />
	<dsp:getvalueof param="productRecord" var="productRecord"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />

	<dsp:getvalueof value="${productRecord['product.vnt']}" var="productVNT"/>
	<dsp:getvalueof value="${productRecord['sku.repositoryId']}" var="skuid"/>
	<dsp:getvalueof param="jsonrequest" var="jsonrequest"/>
	<dsp:getvalueof var="defaultCoverSku" value="${productRecord['sku.defaultCover']}" />
	<dsp:getvalueof param="coverId" var="coverId"/>
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />
	
	<c:choose>
		<c:when test ="${empty coverId}">
			<dsp:getvalueof var="defaultCoverSkuId" value="${fn:split(defaultCoverSku,'~')[0]}" />
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="defaultCoverSkuId" value="${coverId}"/>
		</c:otherwise>
	</c:choose>

	<c:set var="cover" value="${coverId}" scope="request"/>
	<dsp:getvalueof var="jsonRequestValue" value="${jsonRequestValue}" />
	<dsp:getvalueof var="itemQtyValue" value="${itemQtyValue}" />

	<%-- Define pricing variables --%>
	<c:choose>
		<c:when test="${isConfigurable eq 'true' || isSectional eq 'true'}">
			<dsp:droplet name="/com/lzb/commerce/pricing/droplet/LZBProductWithOptionPriceDroplet">
				<dsp:param name="itemInfo" value="${jsonRequestValue}"/>
				<dsp:param name="item_qty" value="${itemQtyValue}"/>
				<dsp:param name="quantity" value="1"/>
				<dsp:param name="configSkuId" value="${productRecord['sku.repositoryId']}" />
				<dsp:param name="skuId" value="${defaultCoverSkuId}"  />
				<dsp:param name="productId" value="${productRecord['product.repositoryId']}" />
				<dsp:param name="profile" bean="Profile"/>
				<dsp:param name="dealerId" bean="ProfileTools.priceListId"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="listPrice" param="priceInfo.listPrice"/>
					<dsp:getvalueof var="salePrice" param="priceInfo.salePrice"/>
					<dsp:getvalueof var="onSale" param="priceInfo.onSale"/>
					<dsp:getvalueof var="endDate" param="endDate"/>
					<dsp:getvalueof var="saveAmount" param="saveAmount"/>
					<dsp:getvalueof var="inStock" param="inStock"/>
					<dsp:getvalueof var="stockMsg" param="stockMsg"/>
					<dsp:getvalueof var="isDealerRMS" bean="Profile.isDealerRMS" />
					<c:set var="listPrice" value="${listPrice}" scope="request"/>
					<c:set var="salePrice" value="${salePrice}" scope="request"/>
					<c:set var="onSale" value="${onSale}" scope="request"/>
					<c:set var="saveAmount" value="${saveAmount}" scope="request"/>
					<c:set var="endDate" value="${endDate}" scope="request"/>
					<c:set var="inStock" value="${inStock}" scope="request"/>
					<c:set var="stockMsg" value="${stockMsg}" scope="request"/>
					<c:set var="isDealerRMS" value="${isDealerRMS}" scope="request"/>
				</dsp:oparam>
				<dsp:oparam name="error">
				</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:when test="${isPurchasable eq 'true' && isSimple eq 'true'}">
			<dsp:droplet name="/com/lzb/commerce/pricing/droplet/LZBSkuBasedPriceDroplet">
				<dsp:param name="skuId" value="${skuid}"/>
				<dsp:param name="country" value="${country}"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="listPrice" param="listPrice"/>
					<dsp:getvalueof var="salePrice" param="salePrice"/>
					<dsp:getvalueof var="onSale" param="onSale"/>
					<dsp:getvalueof var="saveAmount" param="saveAmount"/>
					<dsp:getvalueof var="inStock" param="inStock"/>
					<dsp:getvalueof var="stockMsg" param="stockMsg"/>
					<dsp:getvalueof var="isDealerRMS" bean="Profile.isDealerRMS" />
					<c:set var="listPrice" value="${listPrice}" scope="request"/>
					<c:set var="salePrice" value="${salePrice}" scope="request"/>
					<c:set var="onSale" value="${onSale}" scope="request"/>
					<c:set var="saveAmount" value="${saveAmount}" scope="request"/>
					<c:set var="inStock" value="true" scope="request"/>
					<c:set var="stockMsg" value="${stockMsg}" scope="request"/>
					<c:set var="isDealerRMS" value="${isDealerRMS}" scope="request"/>
				</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:otherwise>
			<%-- no pricing --%>
		</c:otherwise>
	</c:choose>

	<dsp:droplet name="LZBAdditionalImagesDroplet">
		<dsp:param name="skuId" value="${skuid}"/>
		<dsp:oparam name="output">
			<dsp:getvalueof param="additionalImage" var="additionalImage" />
			<c:set var="additionalImage" scope="request" value="${additionalImage}"/>
		</dsp:oparam>
	</dsp:droplet>

	<%-- <input type="hidden" value="${productVNT}" id="datavnt" name="datavnt" />
	<input type="hidden" value="${skuid}" id="imageSkuId" name="imageSkuId" />
	 --%>
 </dsp:page>