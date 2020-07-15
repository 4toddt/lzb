<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>

	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="turnToEnabled" bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
	<dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
	<!-- for TurnTo product item -->
	<dsp:getvalueof var="prodId" value="${productRecord['sku.repositoryId']}" scope="request"/>

	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />

	<%-- Define SEO Alternate URL --%>
	<c:set var="alternateUriReplacePattern" value="${storeConfig.storeProductUrl}/" />
	<c:set var="alternateUriReplaceWith" value="${storeConfig.mobileProductUrl}/" />
	<c:set var="seoAlternateURL" value="${fn:replace(endecaUrl, alternateUriReplacePattern, alternateUriReplaceWith)}" />
	
	<c:if test="${fn:contains(fn:toLowerCase(endecaUrl),'/p/') }">
		<c:forEach var="element" items="${content.mainContent}">
			<c:if test="${element['@type'] eq 'ProductDetail'}">
				<dsp:getvalueof var="productRecord" value="${element.record.attributes}" />
			</c:if>
		</c:forEach>

		<c:set var="prodName" value="${productRecord['sku.displayName']}" scope="request" />

	</c:if>

	<c:choose>
		<c:when test="${productRecord['record.type'] eq 'sectional'}">
			<c:set var="TurnToProductSku" value="${productRecord['product.repositoryId']}" scope="request" />
		</c:when>
		<c:otherwise>
			<c:set var="TurnToProductSku" value="${productRecord['sku.repositoryId']}" scope="request" />
		</c:otherwise>
	</c:choose>

	<c:set var="currencyCodeForOGTag" value="USD" scope="request" />
	<c:if test="${not empty  currencyCode }" >
	<c:set var="currencyCodeForOGTag" value="${ currencyCode}" scope="request" />
	</c:if>

	<c:set var="rPDPNameSpaceForOGTag" value="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# product: http://ogp.me/ns/product#" scope="request"/>

	<dsp:include page="/browse/pdp/pdpImage.jsp">
		<dsp:param name="productRecord" value="${productRecord}"/>
	</dsp:include>

	<%-- below fragment should be included after /browse/pdp/pdpImage.jsp include  --%>
	<dsp:include page="/browse/pdp/pdpOgTagImage.jsp" />


	<c:set var="pageTypeForTracking" value="product" scope="request" />
	<c:set var="PDPProductDataForTracking" value="${productRecord['sku.repositoryId']}" scope="request" />
	
	<%-- Define SEO Structured Data --%>
	<dsp:droplet name="ProductLookup">
		<dsp:param name="id" value="${productRecord['product.repositoryId']}" />
		<dsp:param name="elementName" value="product" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="seoStructuredData" param="product.seoStructuredData"/>
		</dsp:oparam>
	</dsp:droplet>
	
	<lzb:pageContainer>

	<dsp:getvalueof var="largeImage" value="${largeImage}" />

	<c:set var="protocol" value ="http://"/>

		<jsp:attribute name="pageSpecificMETA">
			<meta property="og:title" content="${productRecord['sku.displayName']}"/>
			<meta property="og:type" content="product"/>
			<meta property="og:url" content="http://${header['host']}${requestScope['javax.servlet.forward.request_uri']}"/>
			<meta property="og:site_name" content="La-Z-Boy"/>
			<meta property="og:description" content="${productRecord['product.longDescription']}"/>

			<meta property="fb:app_id" content="${storeConfig.fbAppId}"/>

			<meta property="og:image" content="${largeImageURLForOGTag}" />
			<meta property="og:image:type" content="image/jpeg" />
			<meta property="og:image:width" content="225" />
			<meta property="og:image:height" content="225" />

			<meta property="product:category" content="${productRecord['parentCategory.displayName']}">
			<meta property="product:mfr_part_no" content="${productRecord['sku.repositoryId']}">
			
			<c:if test="${not empty seoStructuredData}">
				${seoStructuredData}
			</c:if>

		</jsp:attribute>

		<%-- <jsp:attribute name="pageSpecificJS">
			<script type="text/javascript">
		        (function(d) { if (document.addEventListener) document.addEventListener('ltkAsyncListener', d);
		        else {e = document.documentElement; e.ltkAsyncProperty = 0; e.attachEvent('onpropertychange', function (e) {
		        if (e.propertyName == 'ltkAsyncProperty'){d();}});}})(function() {
		            /********** Begin Custom Code **********/
		            _ltk.Activity.AddProductBrowse("${productRecord['configurableSku.styleNumber']}");
		            _ltk.Activity.Submit();
		            /********** End Custom Code **********/
		        });
			</script>
		</jsp:attribute> --%>
		<jsp:attribute name="bodyClass">two-column-equal pdp</jsp:attribute>
		<jsp:attribute name="title">
			<c:choose>
			<c:when test="${not empty prodName }">
				${prodName }
			</c:when>
			<c:when test="${not empty content.tHitle}">
				${content.title}
			</c:when>
			<c:otherwise>
			</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty content.metaDescription }">
					${content.metaDescription}
				</c:when>
				<c:when test="${not empty productRecord['product.longDescription'] }">
					${productRecord['product.longDescription']}
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaKeywords">
			<c:choose>
				<c:when test="${not empty content.metaKeywords }">
					${content.metaKeywords}
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${seoAlternateURL}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${endecaUrl}</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">
			<%-- Stylesheet Reference for TurnTo Reviews --%>
			<link rel="stylesheet" href="//static.www.turnto.com/tra4_3/tra.css" />
			<%-- Stylesheet Reference for TurnTo Image Gallery In Product Details Overview Section --%>
			<%-- <link rel="stylesheet" href="//static.www.turnto.com/tra4_3/turnto-gallery-en_US.css"/> --%>
			${content.cssIncludes}
		</jsp:attribute>
		<jsp:attribute name="pageSpecificBottomJS">
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
		</jsp:attribute>

		<jsp:body>

<%-- 	<dsp:include page="/browse/pdp/pdpImage.jsp">
		<dsp:param name="productRecord" value="${productRecord}"/>
	</dsp:include>
 --%>
		<dsp:getvalueof value="${productRecord['product.vnt']}" var="productVNT_local"/>
		<dsp:getvalueof value="${productRecord['sku.repositoryId']}" var="skuid_local"/>

		<input type="hidden" value="${productVNT_local}" id="datavnt" name="datavnt" />
		<input type="hidden" value="${skuid_local}" id="imageSkuId" name="imageSkuId" />
		
		<dsp:droplet name="SKULookup">
		<dsp:param name="id" value="${skuid_local}" />
		<dsp:param name="elementName" value="sku" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="isPillowOptions" param="sku.isPillowOptions" />
		</dsp:oparam>
		</dsp:droplet>
		
		<%-- If there is no value in isPillowOptions, it will default to true, meaning to show Pillow Options --%>
		<c:if test="${empty isPillowOptions}">
			<dsp:getvalueof var="isPillowOptions" value="${true}"/>
		</c:if>
		
		<%-- Flag to enable/disable pillow options --%>
		<input type="hidden" value="${isPillowOptions}" id="isPillowOptions" name="isPillowOptions" />

			<main role="main" itemscope itemtype="http://schema.org/Product">
				<c:if test="${not empty content.mainContent}">
					<c:forEach var="element" items="${content.mainContent}">
					<c:choose>
					<c:when test="${element['@type'] eq 'ContentSlotMain'}">
					<c:forEach var="contentSlotMain" items="${element.contents}">
					<c:choose>
					<c:when test="${contentSlotMain['@type'] eq 'MainTargeterContainer'}">
						<c:set var="pdpPageTargeter" value="${contentSlotMain}" scope="request"/>
					</c:when>
					<c:otherwise>
					<dsp:renderContentItem contentItem="${contentSlotMain}" />
					</c:otherwise>
					</c:choose>
					</c:forEach>

					</c:when>
					<c:otherwise>
					<dsp:renderContentItem contentItem="${element}" />
					</c:otherwise>
					</c:choose>
					</c:forEach>
				</c:if>

				<%-- Include You Might Also Like Products (Complete The Set) --%>
				<fmt:message key="pdp.ymalHeading" var="ymalHeading"/>
				<dsp:include page="/browse/ymal.jsp">
					<dsp:param name="productId" value="${productRecord['product.repositoryId']}"/>
					<dsp:param name="displayMessage" value="${ymalHeading}"/>
					<dsp:param name="numToShow" value="4" />
				</dsp:include>

				<%-- Include Customer Reviews --%>
				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpTurnTo.jsp"/>

			</main>
		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
