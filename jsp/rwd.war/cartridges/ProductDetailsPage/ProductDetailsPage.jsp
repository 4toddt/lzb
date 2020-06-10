<%--
  - Cartridge: ProductDetailsPage
  - File Name: ProductDetailsPage.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up a product details page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean bean="/com/lzb/droplet/LZBAdditionalImagesDroplet" />
    <dsp:importbean bean="/com/lzb/droplet/LZBCanshipLicensedItem"/>
	<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="turnToEnabled" bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
	<dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
    <dsp:getvalueof var="dealerIdNumeric" bean="ProfileTools.dealerId" />

	<c:set var="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:forEach var="element" items="${contentItem.mainContent}">
		<c:if test="${element['@type'] eq 'ProductDetail'}">
			<c:set var="productRecord" value="${element.record.attributes}" />
		</c:if>
	</c:forEach>
	<c:set var="productRecordType" value="${productRecord['record.type']}" />
	<c:set var="productId" value="${productRecord['product.repositoryId']}" />
	<c:set var="productSkuId" value="${productRecord['sku.repositoryId']}" />
	<c:set var="isPurchaseable" value="${productRecord['sku.isPurchaseable']}" />
	<c:set var="productSkuStatus" value="${productRecord['sku.status']}" />
	<c:set var="productName" value="${productRecord['sku.displayName']}" scope="request" />
	<c:set var="productCoverList" value="${productRecord['sku.cover']}" />
	<c:set var="productVNT" value="${productRecord['product.vnt']}" />
	<c:set var="productMetaDescription" value="${productRecord['product.longDescription']}" />
	<c:set var="pageTypeForTracking" value="product" scope="request" />
	<c:set var="PDPProductDataForTracking" value="${productSkuId}" scope="request" />


	<%-- Set Product isPurchaseable Variable to false if Empty --%>
    <c:if test="${empty isPurchaseable}">
        <c:set var="isPurchaseable" value="false" />
    </c:if>

    <%-- Set Product SKU Status Variable to Discontinued if Empty --%>
    <c:if test="${empty productSkuStatus}">
        <c:set var="productSkuStatus" value="D" />
    </c:if>

    <%-- Set PDP Record Type Variable For Page Specific Logic --%>
    <c:choose>
        <c:when test="${productRecordType eq 'Configurable SKU' && isPurchaseable eq 'true' && productSkuStatus eq 'A'}">
            <%-- Purchasable Configurable Products --%>
            <c:set var="pdpRecordType" value="configurable" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'Configurable SKU' && isPurchaseable eq 'true' && productSkuStatus eq 'D' }">
            <%-- Purchasable Configurable Products - Discontinued --%>
            <c:set var="pdpRecordType" value="discontinuedConfigurable" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'Configurable SKU' && isPurchaseable eq 'false' && productSkuStatus eq 'A'}">
            <%-- Non-Purchasable Configurable Products --%>
            <c:set var="pdpRecordType" value="simple" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'Configurable SKU' && isPurchaseable eq 'false' && productSkuStatus eq 'D' }">
            <%-- Non-Purchasable Configurable Products - Discontinued --%>
            <c:set var="pdpRecordType" value="discontinuedSimple" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'sectional' &&  empty productCoverList}">
        	<%-- Sectionals Products - No Covers --%>
            <c:set var="pdpRecordType" value="simple" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'sectional' && productSkuStatus eq 'A' }">
            <%-- Sectionals Products - Active --%>
            <c:set var="pdpRecordType" value="sectional" scope="request" />
        </c:when>
        <c:when test="${productRecordType eq 'sectional' && productSkuStatus eq 'D' }">
            <%-- Sectionals Products - Discontinued --%>
            <c:set var="pdpRecordType" value="discontinuedSectional" scope="request" />
        </c:when>
		<c:when test="${productRecordType eq 'Licensed Sku' && productSkuStatus eq 'A' }">
            <%-- Licensed Products --%>
			<c:set var="pdpRecordType" value="licensed" scope="request" />
        </c:when>
		<c:when test="${productRecordType eq 'Standard Sku' && productSkuStatus eq 'A' }">
            <%-- Standard Sku Products --%>
			<c:set var="pdpRecordType" value="simple" scope="request" />
        </c:when>
        <c:when test="${isPurchaseable eq 'false' && productSkuStatus eq 'A' }">
            <%-- Non-Purchasable Products --%>
            <c:set var="pdpRecordType" value="simple" scope="request" />
        </c:when>
		<c:when test="${productRecordType eq 'Licensed Sku' && productSkuStatus eq 'D'}">
            <%-- Licensed Products - Discontinued --%>
			<c:set var="pdpRecordType" value="discontinuedLicensed" scope="request" />
        </c:when>
        <c:when test="${isPurchaseable eq 'false' && productSkuStatus eq 'D'}">
            <%-- Non-Purchasable Discontinued --%>
            <c:set var="pdpRecordType" value="discontinuedSimple" scope="request" />
        </c:when>
		<c:otherwise>
			<c:set var="pdpRecordType" value="" scope="request" />
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${productRecordType eq 'sectional'}">
			<c:set var="TurnToProductSku" value="${productId}" />
		</c:when>
		<c:otherwise>
			<c:set var="TurnToProductSku" value="${productSkuId}" />
		</c:otherwise>
	</c:choose>

	<%-- Droplet: Get Product Images --%>
	<dsp:droplet name="LZBAdditionalImagesDroplet">
		<dsp:param name="skuId" value="${productSkuId}" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="additionalImage" param="additionalImage" />
		</dsp:oparam>
	</dsp:droplet>

    <%-- Droplet: Define if a Licensed Product Can Ship to the Current Dealer --%>
    <dsp:droplet name="LZBCanshipLicensedItem">
        <dsp:param name="skuId" value="${productSkuId}" />
        <dsp:param name="dealerId" value="${dealerIdNumeric}" />
        <dsp:oparam name="output">
            <%-- canShip param returns true if record.type is not 'Licensed SKU' --%>
            <dsp:getvalueof var="canShip" param="canShip"/>
            <c:set var="canShip" value="${canShip}" scope="request" />
        </dsp:oparam>
    </dsp:droplet>

	<%-- Define Facebook Open Graph Product Image --%>
    <c:if test="${additionalImage ne null and not empty additionalImage and additionalImage.size() > 0}">
    	<c:set var="imageForOGTag" value="${additionalImage[0]}"/>
    	<c:if test="${additionalImage.size() > 1}">
    		<c:set var="imageForOGTag" value="${additionalImage[1]}"/>
    	</c:if>

		<c:choose>
			<c:when test ="${not fn:startsWith(imageForOGTag.largeImage, 'https')}" >
				<c:set var="largeImageURLForOGTag" value="https:${imageForOGTag.largeImage}"/>
			</c:when>
			<c:otherwise>
			 	<c:set var="largeImageURLForOGTag" value="${imageForOGTag.largeImage}"/>
			 </c:otherwise>
		</c:choose>
    </c:if>

	<%-- Define SEO Canonical URL --%>
	<c:set var="canonicalUriReplacePattern" value="${storeConfig.mobileProductUrl}/" />
	<c:set var="canonicalUriReplaceWith" value="${storeConfig.storeProductUrl}/" />
	<c:set var="seoCanonicalURL" value="${fn:replace(forwardRequestUri, canonicalUriReplacePattern, canonicalUriReplaceWith)}" />

	<%-- Define META index and follow --%>
	<c:set var="metaIndex" value="${contentItem.index}"/>
	<c:set var="metaFollow" value="${contentItem.follow}"/>
	<c:set var="metaIndexValue" value="${(metaIndex eq 'false') ? 'noindex' : 'index'}"/>
	<c:set var="metaFollowValue" value="${(metaFollow eq 'false') ? 'nofollow' : 'follow'}"/>

	<%-- Define SEO Structured Data --%>
	<dsp:droplet name="ProductLookup">
		<dsp:param name="id" value="${productId}" />
		<dsp:param name="elementName" value="product" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="seoStructuredData" param="product.seoStructuredData"/>
		</dsp:oparam>
	</dsp:droplet>

    <layout:default>
		<jsp:attribute name="pageTitle">
			<c:choose>
				<c:when test="${not empty productName}">
					${productName}
				</c:when>
				<c:otherwise>
					${contentItem.title}
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty productMetaDescription}">
					${productMetaDescription}
				</c:when>
				<c:otherwise>
					${contentItem.metaDescription}
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
        <jsp:attribute name="metaKeywords">${contentItem.metaKeywords}</jsp:attribute>
        <jsp:attribute name="pageSpecificMETA">
			<meta property="og:title" content="${productName}"/>
			<c:choose>
				<c:when test="${not empty productMetaDescription}">
					<meta property="og:description" content="${productMetaDescription}"/>
				</c:when>
				<c:otherwise>
					<meta property="og:description" content="${contentItem.metaDescription}"/>
				</c:otherwise>
			</c:choose>
			<meta property="og:image" content="${largeImageURLForOGTag}" />
			<meta property="og:image:type" content="image/jpeg" />
			<meta property="og:image:width" content="225" />
			<meta property="og:image:height" content="225" />
			<meta property="product:category" content="${productRecord['parentCategory.displayName']}">
			<meta property="product:mfr_part_no" content="${productSkuId}">
		    <meta itemprop="image" content="${additionalImage[0].largeImage}">

			<c:if test="${not empty seoStructuredData}">
				${seoStructuredData}
			</c:if>

		</jsp:attribute>
        <jsp:attribute name="seoCanonicalURL">${seoCanonicalURL}</jsp:attribute>
        <jsp:attribute name="seoRobots">${metaIndexValue},${metaFollowValue}</jsp:attribute>
        <jsp:attribute name="lastModified"></jsp:attribute>
        <jsp:attribute name="doSessionTimeout">false</jsp:attribute>
        <jsp:attribute name="section">browse</jsp:attribute>
        <jsp:attribute name="pageType">product</jsp:attribute>
        <jsp:attribute name="bodyClass">product product-${pdpRecordType} ${contentItem.bodyStyle}</jsp:attribute>
        <jsp:attribute name="analyticsPageType">productPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">
			<%-- Stylesheet Reference for TurnTo Reviews --%>
			<link rel="stylesheet" href="//static.www.turnto.com/tra4_3/tra.css" />
			<%-- Stylesheet Reference for TurnTo Image Gallery In Product Details Overview Section --%>
			<link rel="stylesheet" href="//static.www.turnto.com/tra4_3/turnto-gallery-en_US.css"/>
			${contentItem.cssIncludes}
		</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
			<%-- JS Reference for TurnTo Image Gallery In Product Details Overview Section --%>
			<c:if test="${turnToEnabled}">
				<script type="text/javascript">
					
					// Declare TurnTo Configuration
					var turnToConfig = {
						sku: '${TurnToProductSku}',
						locale: 'en_US',
						pageId: 'pdp-page',
						gallery: {
							skus: ['${TurnToProductSku}']
						}
					}
					window.TurnToCmd=window.TurnToCmd||function(){(TurnToCmd.q=TurnToCmd.q||[]).push(arguments)};
				</script>
				
				<%-- TurnTo Item JavaScript Include for TurnTo Reviews & Questions --%>
				<script src="https://widgets.turnto.com/v5/widgets/${turnToSiteKey}/js/turnto.js" async></script>
			</c:if>
			${contentItem.jsIncludes}
		</jsp:attribute>

        <jsp:body>
			<!-- START: LZB Product Details Page -->

			<%-- TurnTo hidden login button we use to help triggering an ajax logout --%>
		    <dsp:a id="logoutHidden" href="${contextPath}" value="logout" style="display: none;">
		       <dsp:property bean="/atg/userprofiling/ProfileFormHandler.logout" value="true"/>
		       <fmt:message key="logout.msg" />
		    </dsp:a>

			<%-- Render the headerContent section --%>
			<c:if test="${not empty contentItem.headerContent}">
				<c:forEach var="element" items="${contentItem.headerContent}">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</c:if>

			<%-- content container--%>
			<section class="product-page" id="product-${productSkuId}" data-product-record="${pdpRecordType}" data-product-id="${productId}" data-product-skuid="${productSkuId}" itemscope itemtype="http://schema.org/Product">
				<%-- Render the mainContent section --%>
				<c:if test="${not empty contentItem.mainContent}">
					<c:forEach var="element" items="${contentItem.mainContent}">
					   	<dsp:renderContentItem contentItem="${element}" />
					 </c:forEach>
				</c:if>

				<%-- Include Cross Sell Products --%>
				<fmt:message var="crossSellHeading" key="crossSell.heading"/>
				<dsp:include page="/browse/includes/crossSell.jsp">
					<dsp:param name="productId" value="${productId}" />
					<dsp:param name="displayHeading" value="${crossSellHeading}" />
				</dsp:include>

				<%-- Include Customer Reviews --%>
				<dsp:include src="/browse/includes/pdp/productReviews.jsp">
					<dsp:param name="TurnToProductSku" value="${TurnToProductSku}" />
				</dsp:include>
			</section>

			<%-- Render the footerContent section --%>
			<c:if test="${not empty contentItem.footerContent}">
				<c:forEach var="element" items="${contentItem.footerContent}">
					<dsp:renderContentItem contentItem="${element}" />
				 </c:forEach>
			</c:if>

			<!-- END: LZB Product Details Page -->
        </jsp:body>

    </layout:default>
</dsp:page>