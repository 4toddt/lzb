<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
	<dsp:getvalueof var="productSkuId" value="${productRecord['sku.repositoryId']}" />
<%--	<c:set var="protocol" value ="http://"/>
	<meta property="og:title" content="${productRecord['product.displayName']}"/>
	<meta property="og:type" content="product"/>
	<meta property="og:url" content="${protocol}${header['host']}${requestScope['javax.servlet.forward.request_uri']}"/>
	<meta property="og:site_name" content="La-Z-Boy"/>
	<meta property="og:price:currency" content="${currencyCode}"/>
	<meta itemprop="url" content="${protocol}${header['host']}${requestScope['javax.servlet.forward.request_uri']}"/>
	<meta property="og:description" content="${productRecord['sku.longDescription']}"/>
 --%>

	<section itemscope itemtype="http://schema.org/Product">

		<!-- START Product Title/Price row -->
		<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
		<div class="pdp-title-row">

			<c:if test="${content['@type'] eq 'ProductDetail'}">
				<div class="pdp-title">
					<c:if test="${not empty productRecord['product.displayName']}">
						<h1 itemprop="name">${productRecord['sku.displayName']}</h1>
					</c:if>
				</div>
			</c:if>
			
			<!-- TurnTo star rating -->
			<dsp:include page="${pageContext.request.contextPath}/browse/pdp/starRatingSummary.jsp">
				<dsp:param name="productSkuId" value="${productSkuId}" />
			</dsp:include>

		</div>
		<!-- END Product Title/Price row -->


			<%-- <c:if test="${content['@type'] eq 'ProductDetail'}">
				<c:if test="${not empty productRecord['product.displayName']}">
					<h1 class="pdp-title" itemprop="name">${productRecord['sku.displayName']}</h1>
				</c:if>
				<p>
					<c:if test="${not empty productRecord['styleNumber']}">
						<b><fmt:message key="pdp.styleNumber" /> ${productRecord['styleNumber']}</b>
					</c:if>
					<fmt:message key="pdp.productReviews" />
					<dsp:include src="${pageContext.request.contextPath}/global/pdp/_bv_showReviews.jsp">
						<dsp:param name="productId" value="${productRecord['product.repositoryId'] }" />
					</dsp:include>
					<!-- <span class="review-stars">Star ratings here</span>
					<span class="review-links"><a href="#">Reviews(25)</a> |
					<a href="#">Write a review</a></span> -->
				</p>
			</c:if>
 --%>

		<%-- Display Product Images --%>
		<dsp:include page="${pageContext.request.contextPath}/browse/pdp/productImages.jsp"/>

		<section role="region">
	<%-- 		<fmt:parseNumber var="lowestSalePrice" value="${productRecord['P_LowestSalePrice']}"/>
			<fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
			<fmt:parseNumber var="lowestPrice" value="${productRecord['P_LowestPrice']}"/>
			<fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />
			<c:choose>
				<c:when test="${not empty productRecord['P_LowestSalePrice']}">
					<span class="pdp-item-price on-sale">$${formatLowestPrice}</span>
					<span class="pdp-sale-price-label">Now</span>
					<span class="pdp-sale-price">$${formatLowestSalePrice}</span>
					-<span class="pdp-currency">USD</span>
					<a href="#"><span class="pdp-charges-tooltip"><fmt:message key="pdp.delCharges" /></span></a>
					<a title="This means that we will save your password until you " class="tooltip" href="#">
						<div class="triangle-with-shadow"></div>
						<div title="" class="tooltip-img"></div>
					</a>
				</c:when>
				<c:otherwise>
					<span class="pdp-sale-price">${formatLowestPrice}</span>
					<span class="pdp-currency">USD</span>
					<a href="#"><span class="pdp-charges-tooltip"><fmt:message key="pdp.delCharges" /></span></a>
					<a title="This means that we will save your password until you " class="tooltip" href="#">
						<div class="triangle-with-shadow"></div>
						<div title="" class="tooltip-img"></div>
					</a>
				</c:otherwise>
			</c:choose> --%>
			

			<dsp:getvalueof var="productId" value="${productRecord['product.repositoryId'] }" />
			<dsp:getvalueof var="skuId" param="sku.id" />
			<dsp:getvalueof var="editCommerceItemId" param="commid" />
			<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />
			<dsp:getvalueof var="productid" value="${productRecord['product.repositoryId'] }" />
			<dsp:droplet name="LZBPDPURLDroplet">
				<dsp:param name="productId" value="${productid}" />
				<dsp:param name="elementName" value="url" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="pdpurl" param="url"/>
				</dsp:oparam>
			</dsp:droplet>
			<dsp:getvalueof var="currentDealerId" bean="ProfileTools.priceListId" />
			<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />
			
			<dsp:include page="${pageContext.request.contextPath}/browse/pdp/selectedSkuDisplay.jsp">
				<dsp:param name="defaultCover" value="${productRecord['sku.defaultCover']}" />
			</dsp:include>

			<div class="sticky-container">
				<div class="sticky">
					<div class="left">
						<dsp:include page="${pageContext.request.contextPath}/browse/pdp/product-menu.jsp" />
					</div>
					<div class="right">

						<div class="pdp-discontinued-message">
							<fmt:message key="pdp.discontinued" />
						</div>
						
						<%-- <div class="add-to-cart simple-add-to-cart" data-module="addToCart">
							<span id="inStoreOnly" class="discontinued-product"><fmt:message key="pdp.in.store.label" /></span>
						</div> --%>
					</div>
				</div>
			</div>

		</section>

    <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpInfo.jsp"/>


	</section>
<%-- <script>
	Webtrends.multiTrack({
		element: this,
		argsa: [
			'WT.dl', '99',
			'WT.tx_e', 'v',
			'WT.pn_sku', '${productRecord["styleNumber"]}${defaultCoverSkuId}',
			'WT.pn_gr', '${cg_s}',
			'WT.pn_id', '${productRecord["sku.displayName"]}',
			'WT.si_n', 'Extended Purchase Funnel',
			'WT.si_x', '2'
		]
	});
</script> --%>
</dsp:page>
