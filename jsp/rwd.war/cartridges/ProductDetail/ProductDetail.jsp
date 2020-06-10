<%--
  - Cartridge: ProductDetail
  - File Name: ProductDetail.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the product detail section.
  - Required Parameters:
        - contentItem
        - pdpRecordType: pdp record type is a request scope variable
  - Optional Parameters:
        - coverId: passed into URL to override default seclected cover sku
--%>
<dsp:page>
	<%-- Imports --%>
    <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
    <dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
    <dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBProductWithOptionPriceDroplet" />
    <dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBSkuBasedPriceDroplet" />
    <dsp:importbean bean="/com/lzb/droplet/LZBAdditionalImagesDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
    <%-- NOTE: param ?coverId= is passed in the url to override the default cover selection from endeca contentItem --%>
    <dsp:getvalueof var="coverId" param="coverId" />
    <dsp:getvalueof var="loginStatus" bean="Profile.transient"/>
    <dsp:getvalueof var="dealerId" bean="ProfileTools.priceListId" />
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />
	<%-- NOTE: param ?commid= is passed in url to restablish the product configuration from cart, like a cart edit link --%>
	<dsp:getvalueof var="editCommerceItemId" param="commid" />

    <c:set var="productRecord" value="${contentItem.record.attributes}" />
    <c:set var="productId" value="${productRecord['product.repositoryId']}" />
    <c:set var="productSkuId" value="${productRecord['sku.repositoryId']}" />
    <c:set var="productName" value="${productRecord['sku.displayName']}" />
    <c:set var="productReviewCount" value="${productRecord['product.reviewCount']}" />
    <c:set var="productRating" value="${productRecord['product.rating']}" />
    <c:set var="isPurchaseable" value="${productRecord['sku.isPurchaseable']}" />
	<c:set var="defaultCover" value="${productRecord['sku.defaultCover']}" />
	<c:set var="productCoverList" value="${productRecord['sku.cover']}" />
    <c:set var="productConfigurableOptionNames" value="${productRecord['sku.configurableOptionNames']}" />
    <c:set var="productVNT" value="${productRecord['product.vnt']}" />
    <c:set var="productVideoUrl" value="${productRecord['product.videoURL']}" />
    
    <dsp:droplet name="SKULookup">
	<dsp:param name="id" value="${productSkuId}" />
	<dsp:param name="elementName" value="sku" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="isPillowOptions" param="sku.isPillowOptions" />
	</dsp:oparam>
	</dsp:droplet>
	
	<%-- If there is no value in isPillowOptions, it will default to true, meaning to show Pillow Options --%>
	<c:if test="${empty isPillowOptions}">
		<dsp:getvalueof var="isPillowOptions" value="${true}"/>
	</c:if>

    <%-- Set Product isPurchaseable Variable to false if Empty --%>
    <c:if test="${empty isPurchaseable}">
        <c:set var="isPurchaseable" value="false" />
    </c:if>

    <%-- Droplet: Get Product JSON Data when passed ?commid= is passed in url to restablish the product configuration from cart, like a cart edit link --%>
    <dsp:droplet name="LZBItemJsonRequestDroplet">
        <dsp:param name="commid" value="${editCommerceItemId}" />
        <dsp:oparam name="output">
            <dsp:getvalueof var="jsonRequestValue" param="jsonrequest" />
            <dsp:getvalueof var="itemQtyValue" param="item_qty" />
        </dsp:oparam>
    </dsp:droplet>

	<%-- Set Default Cover SKU Variable --%>
	<c:choose>
		<c:when test ="${empty coverId}">
			<c:set var="defaultCoverSkuId" value="${fn:split(defaultCover,'~')[0]}" />
		</c:when>
		<c:otherwise>
			<%-- set defaultCoverSkuId if coverId param is passed in URL --%>
			<c:set var="defaultCoverSkuId" value="${coverId}" />
		</c:otherwise>
	</c:choose>

    <%-- Set Pricing --%>
    <c:choose>
		<c:when test="${isPurchaseable eq 'true' && pdpRecordType eq 'configurable'}">
            <%-- Show Price --%>
            <c:set var="showPrice" value="true" />
            <%-- Droplet: Get Pricing for Product With Options --%>
        	<dsp:droplet name="LZBProductWithOptionPriceDroplet">
        		<dsp:param name="itemInfo" value="${jsonRequestValue}" />
        		<dsp:param name="item_qty" value="${itemQtyValue}" />
        		<dsp:param name="quantity" value="1" />
        		<dsp:param name="configSkuId" value="${productSkuId}" />
        		<dsp:param name="skuId" value="${defaultCoverSkuId}" />
        		<dsp:param name="productId" value="${productId}" />
        		<dsp:param name="profile" bean="Profile" />
        		<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
        		<dsp:oparam name="output">
        			<dsp:getvalueof var="listPrice" param="priceInfo.listPrice" />
        			<dsp:getvalueof var="salePrice" param="priceInfo.salePrice" />
        			<dsp:getvalueof var="onSale" param="priceInfo.onSale" />
        			<dsp:getvalueof var="endDate" param="endDate" />
        			<dsp:getvalueof var="saveAmount" param="saveAmount" />
                    <dsp:getvalueof var="inStock" param="inStock" />
                    <dsp:getvalueof var="stockMsg" param="stockMsg" />
        		</dsp:oparam>
        		<dsp:oparam name="error"></dsp:oparam>
        	</dsp:droplet>
        </c:when>
        <c:when test ="${isPurchaseable eq 'true' && (pdpRecordType eq 'simple' || pdpRecordType eq 'licensed')}">
            <%-- Show Price --%>
            <c:set var="showPrice" value="true" />
            <%-- Droplet: Get Pricing for Product Without Options --%>
            <dsp:droplet name="LZBSkuBasedPriceDroplet">
				<dsp:param name="skuId" value="${productSkuId}"/>
				<dsp:param name="country" value="${country}"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="listPrice" param="listPrice"/>
					<dsp:getvalueof var="salePrice" param="salePrice"/>
					<dsp:getvalueof var="onSale" param="onSale"/>
					<dsp:getvalueof var="saveAmount" param="saveAmount"/>
				</dsp:oparam>
			</dsp:droplet>
        </c:when>
        <c:otherwise>
            <%-- Show No Price --%>
            <c:set var="showPrice" value="false" />
        </c:otherwise>
    </c:choose>

    <!-- Set Price Display Variables -->
    <c:if test="${not empty salePrice}">
        <fmt:parseNumber var="lowestSalePrice" value="${salePrice}" />
        <fmt:formatNumber var="lowestSalePriceDecimal" value="${lowestSalePrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
        <fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
    </c:if>
    <c:if test="${not empty listPrice}">
        <fmt:parseNumber var="lowestPrice" value="${listPrice}" />
        <fmt:formatNumber var="lowestPriceDecimal" value="${lowestPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
        <fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />
    </c:if>

    <%-- Droplet: Get Product Images --%>
	<dsp:droplet name="LZBAdditionalImagesDroplet">
		<dsp:param name="skuId" value="${productSkuId}" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="additionalImage" param="additionalImage" />
		</dsp:oparam>
	</dsp:droplet>

    <%-- START: Render Product Detail --%>

    <%-- Sets the Product Item Quantity from cart using the Data droplet: LZBItemJsonRequestDroplet to restablish the product configuration from cart, like a cart edit link --%>
    <input type="hidden" id="itemQtyValue" value="${itemQtyValue}" />
    <%-- Sets the Product JSON Data from droplet: LZBItemJsonRequestDroplet to restablish the product configuration from cart, like a cart edit link --%>
    <input type="hidden" id="jsonReqInput" name="jsonReqInput" value="${fn:escapeXml(jsonRequestValue)}" />

    <%-- Render Product Title Row --%>
    <dsp:include page="/browse/includes/pdp/productTitleBar.jsp">
        <dsp:param name="productSkuId" value="${productSkuId}" />
        <dsp:param name="productName" value="${productName}" />
        <dsp:param name="productReviewCount" value="${productReviewCount}" />
        <dsp:param name="productRating" value="${productRating}" />
        <dsp:param name="isPurchaseable" value="${isPurchaseable}" />
        <dsp:param name="showPrice" value="${showPrice}" />
        <dsp:param name="onSale" value="${onSale}" />
        <dsp:param name="lowestSalePrice" value="${lowestSalePrice}" />
        <dsp:param name="lowestSalePriceDecimal" value="${lowestSalePriceDecimal}" />
        <dsp:param name="formatLowestSalePrice" value="${formatLowestSalePrice}" />
        <dsp:param name="lowestPrice" value="${lowestPrice}" />
        <dsp:param name="lowestPriceDecimal" value="${lowestPriceDecimal}" />
        <dsp:param name="formatLowestPrice" value="${formatLowestPrice}" />
        <dsp:param name="saveAmount" value="${saveAmount}" />
        <dsp:param name="endDate" value="${endDate}" />
    </dsp:include>

    <div class="product-main section-row">
        <%-- Render Product Images --%>
        <dsp:include page="/browse/includes/pdp/productImages.jsp">
            <dsp:param name="productRecord" value="${productRecord}" />
            <dsp:param name="productId" value="${productId}" />
            <dsp:param name="productSkuId" value="${productSkuId}" />
            <dsp:param name="additionalImage" value="${additionalImage}" />
            <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
            <dsp:param name="productVideoUrl" value="${productVideoUrl}" />
            <dsp:param name="productName" value="${productName}" />
        </dsp:include>

        <%-- Render Product Configuration --%>
        <dsp:include page="/browse/includes/pdp/productConfiguration.jsp">
            <dsp:param name="productId" value="${productId}" />
            <dsp:param name="productSkuId" value="${productSkuId}" />
            <dsp:param name="defaultCover" value="${defaultCover}" />
            <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
            <dsp:param name="productCoverList" value="${productCoverList}" />
            <dsp:param name="productConfigurableOptionNames" value="${productConfigurableOptionNames}" />
            <dsp:param name="dealerId" value="${dealerId}" />
            <dsp:param name="productVNT" value="${productVNT}" />
            <dsp:param name="isPurchaseable" value="${isPurchaseable}" />
            <dsp:param name="onSale" value="${onSale}" />
            <dsp:param name="lowestSalePrice" value="${lowestSalePrice}" />
            <dsp:param name="formatLowestSalePrice" value="${formatLowestSalePrice}" />
            <dsp:param name="lowestPrice" value="${lowestPrice}" />
            <dsp:param name="formatLowestPrice" value="${formatLowestPrice}" />
            <dsp:param name="editCommerceItemId" value="${editCommerceItemId}" />
            <dsp:param name="isPillowOptions" value="${isPillowOptions}" />
            <dsp:param name="stockMsg" value="${stockMsg}" />
            <dsp:param name="isDealerRMS" value="${isDealerRMS}" />
       </dsp:include>
    </div>

    <%-- Render Product Details --%>
    <dsp:include page="/browse/includes/pdp/productDetails.jsp">
        <dsp:param name="productRecord" value="${productRecord}" />
        <dsp:param name="productName" value="${productName}" />
    </dsp:include>

    <%-- END: Render Product Detail --%>
</dsp:page>