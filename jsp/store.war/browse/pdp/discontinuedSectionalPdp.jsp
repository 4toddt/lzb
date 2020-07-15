<dsp:page>
			<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
			<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
			<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
			<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
			<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
			<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
			<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
			<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
			<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
			<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
			<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
			<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/com/lzb/service/SessionBean"/>
			<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
			<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
			<dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
			<dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
			<dsp:getvalueof var="content"
				vartype="com.endeca.infront.assembler.ContentItem"
				value="${originatingRequest.contentItem}" />
			<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
			<dsp:getvalueof var="productSkuId" value="${productRecord['sku.repositoryId']}" />

			<!--  Assign default record for sectional -->
			<c:forEach var="element" items="${content.record.records}" varStatus="i">
				<dsp:getvalueof var="defaultStyleRecord" value="${element.attributes}" />
					<c:if test="${defaultStyleRecord['sectionalConfigSku.isDfltStyle'] eq 'true'}">
						<dsp:getvalueof var="productRecord" value="${defaultStyleRecord}" />
					</c:if>
			</c:forEach>
<%--			<c:set var="protocol" value ="http://"/>
			<meta property="og:title" content="${productRecord['product.displayName']}"/>
			<meta property="og:type" content="product"/>
			<meta property="og:url" content="${protocol}${header['host']}${requestScope['javax.servlet.forward.request_uri']}"/>
			<meta property="og:site_name" content="La-Z-Boy"/>
			<meta property="og:price:currency" content="${currencyCode}"/>
			<!-- Schema.org markup for Google+ -->
			<meta itemprop="url" content="${protocol}${header['host']}${requestScope['javax.servlet.forward.request_uri']}"/> --%>
			<dsp:droplet name="LZBItemJsonRequestDroplet">
				<dsp:param name="commid" param="commid" />
				<dsp:oparam name="output">
				<dsp:getvalueof var="jsonreq" param="jsonrequest" />
				<!-- hiddenjson= ${jsonreq} -->
				</dsp:oparam>
			</dsp:droplet>
			<%-- Image start --%>

	<section itemscope itemtype="http://schema.org/Product">

		<!-- START Product Title/Price row -->
		<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
		<div class="pdp-title-row">

			<c:if test="${content['@type'] eq 'ProductDetail'}">
				<c:if test="${not empty productRecord['sku.displayName']}">
					<div class="pdp-title">
						<h1>${productRecord['sku.displayName']}</h1>
					</div>
				</c:if>
			</c:if>

			<!-- TurnTo star rating -->
			<dsp:include page="${pageContext.request.contextPath}/browse/pdp/starRatingSummary.jsp">
				<dsp:param name="productSkuId" value="${productSkuId}" />
			</dsp:include>

		</div>
		<!-- END Product Title/Price row -->

		<%-- Display Product Images --%>
		<dsp:include page="${pageContext.request.contextPath}/browse/pdp/productImages.jsp"/>

	<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
	<section role="region" class="discontinued-sectional-pdp">
					  <meta itemprop="sku" content="${productRecord['product.displayName']}">
						<fmt:parseNumber var="lowestSalePrice" value="${productRecord['P_LowestSalePrice']}"/>
						<fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
						<fmt:parseNumber var="lowestPrice" value="${productRecord['P_LowestPrice']}"/>
						<fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />

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

									<%-- <div class="add-to-cart" data-module="addToCart">
										<input id="addToCartDisabled" type="button" class="btn"	value="add to cart" />
									</div> --%>

								</div>
							</div>
						</div>

						

	</section>	<%-- right side --%>
</section><%-- endeca itemscope section --%>

<dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpInfo.jsp"/>
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
