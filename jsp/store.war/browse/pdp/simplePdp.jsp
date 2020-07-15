<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBCanshipLicensedItem"/>
	<dsp:importbean bean="/atg/commerce/inventory/InventoryManager"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="productSkuId" value="${productRecord['sku.repositoryId']}" />
	<dsp:getvalueof var="country" bean="Profile.currentStore.country" />

  	<!-- price display -->
  	<meta itemprop="sku" content="${productRecord['product.displayName']}">
	<fmt:parseNumber var="lowestSalePrice" value="${salePrice}"/>
	<fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
	<fmt:parseNumber var="lowestPrice" value="${listPrice}"/>
	<fmt:formatNumber var="lowestPriceDecimal" value="${lowestPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
	<fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />

  <!-- for TurnTo product item -->
  <dsp:getvalueof var="prodId" value="${productRecord['sku.repositoryId']}" scope="request"/>

	<section itemscope itemtype="http://schema.org/Product">

		<dsp:getvalueof var="record" param="recordAttrib" scope="request"/>
		<dsp:getvalueof param="coverSkuId" var="coverNo"/>

		<dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
	  <dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
	  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
	  <dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
      <dsp:getvalueof var="dealerIdNumeric" bean="/atg/userprofiling/ProfileTools.dealerId" />
	  <dsp:getvalueof var="transient" bean="Profile.transient" />
	  <dsp:getvalueof param="coverId" var="coverId"/>
		
	<dsp:getvalueof var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />
	
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

			<meta itemprop="availability" content="http://schema.org/InStock" />
			<meta itemprop="priceCurrency" content="${currencyCodeForOGTag}" />
		</div>
		<!-- END Product Title/Price row -->

		<%-- Display Product Images --%>
		<dsp:include page="${pageContext.request.contextPath}/browse/pdp/productImages.jsp"/>

		<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
		<section role="region" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
			
			<div class="pdp-price-rating-container simplePdp">
				<div class="pdp-price">
					<c:choose>
	          			<c:when test="${isPurchasable eq 'true'}">
							<div id="pdp-price-info" data-module="tool-tips">
			            		<c:choose>
			              			<c:when test="${onSale}">
						                <fmt:parseNumber var="saveAmount123" value="${saveAmount}"/>
						                <fmt:formatNumber var="formattedSaveAmount" value="${saveAmount123}" type="currency" />
						                <fmt:formatNumber var="saveAmountDecimal" value="${saveAmount123}" type="number" minFractionDigits="2" maxFractionDigits="2" />

			                			<span aria-label="Original price: ${formatLowestPrice} Price is now: ${formatLowestSalePrice}">
					                		<div class="pdp-pricing-amount">
					                  			<div class="amount">
					                    			<span aria-hidden="true" id="pdp-price">${formatLowestSalePrice}</span>
					                  			</div>
					                		</div>

					                		<div class="pdp-pricing-amount">
					                			<div class="pdp-pricing-title" aria-hidden="true">
					                				<fmt:message key="price.was"/>
					                			</div>
					                			<div class="pdp-pricing-was strike">
					                				<span data-price="${lowestPrice}" aria-hidden="true">${formatLowestPrice}</span>
					                			</div>
					                		</div>
			                			</span>

	                    				<meta itemprop="price" content="${lowestPriceDecimal}" />
	                    				<div class="pdp-save-amount-info">
		                    				<c:if test="${not empty saveAmount}">
		                      					<span aria-label="You are saving: ${formattedSaveAmount}">
		                        					<div class="pdp-sale-price" id="pdp-price-save-amount" aria-hidden="true">Save&nbsp;${formattedSaveAmount}</div>
		                      					</span>
		                    				</c:if>
	                    				</div>
	                  				</c:when>
	                  				<c:otherwise>
										<span aria-label="Original price: ${formatLowestPrice}">
				                			<div class="pdp-pricing-amount">
				                  				<div class="amount">
				                    				<span aria-hidden="true" id="pdp-price">${formatLowestPrice}</span>
				                  				</div>
				                			</div>
				                			<div class="pdp-pricing-amount">
				                				<div class="pdp-pricing-title" aria-hidden="true" style="display: none;">
				                					<fmt:message key="price.was"/>
				                				</div>
				                				<div class="pdp-pricing-was strike">
				                					<span data-price="${lowestPrice}" aria-hidden="true"></span>
				                				</div>
				                			</div>
			                			</span>

	                    				<meta itemprop="price" content="${lowestPriceDecimal}" />
	                    				<div class="pdp-save-amount-info">
	                    					<span aria-label="You are saving:">
	                      						<div class="pdp-sale-price" id="pdp-price-save-amount" aria-hidden="true"></div>
	                    					</span>
	                    				</div>
	                  				</c:otherwise>
		              			</c:choose>
	            			</div>
	          			</c:when>
		          		<c:otherwise>
		          			<%-- Don't render anything --%>
		          		</c:otherwise>
		      		</c:choose>
      			</div>

	      <!-- TurnTo star rating -->
				<dsp:include page="${pageContext.request.contextPath}/browse/pdp/starRatingSummary.jsp">
					<dsp:param name="productSkuId" value="${productSkuId}" />
				</dsp:include>
				
				<c:if test="${country eq 'US' && isPurchasable eq 'true'}">
					<div class="pdp-monthly-pricing" data-financingmonths="${digitalBuyFinancingMonths}">
						<dsp:getvalueof var="monthlyPriceRaw" value="${lowestPrice/digitalBuyFinancingMonths}" />
						<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
										
						<a href="/content/financing-disclosures" target="_blank">or $<span class="monthly-price">${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
					</div>
				</c:if>
			</div>
			
			<dsp:getvalueof var="productId" value="${productRecord['product.repositoryId']}" />
			<dsp:getvalueof var="prodDisplayName" value="${productRecord['product.displayName']}"/>
			<dsp:getvalueof var="skuId" value="${productRecord['sku.repositoryId']}"/>
			<dsp:getvalueof var="editCommerceItemId" param="commid" />
			<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />

			<c:choose>
				<c:when test="${country eq 'US'}">
					<dsp:getvalueof var="stockMsg" bean="InventoryManager.inStockMsgUS"/>
				</c:when>
				<c:otherwise>
					<dsp:getvalueof var="stockMsg" bean="InventoryManager.inStockMsgCA"/>
				</c:otherwise>
			</c:choose>

			<dsp:droplet name="LZBPDPURLDroplet">
				<dsp:param name="productId" value="${productId}" />
				<dsp:param name="elementName" value="url" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="pdpurl" param="url"/>
				</dsp:oparam>
			</dsp:droplet>
			<dsp:getvalueof var="currentDealerId" bean="ProfileTools.priceListId" />
			<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />
			<dsp:include page="/browse/pdp/selectedSkuDisplay.jsp">
					<dsp:param name="defaultCover" value="${productRecord['sku.defaultCover']}" />
					<dsp:param name="defaultCoverType" value="${productRecord['sku.defaultCover']}" />
			</dsp:include>

            <%-- Droplet: Define if a Licensed Product Can Ship to the Current Dealer --%>
            <dsp:droplet name="LZBCanshipLicensedItem">
                <dsp:param name="skuId" value="${skuId}" />
                <dsp:param name="dealerId" value="${dealerIdNumeric}" />
                <dsp:oparam name="output">
                    <%-- canShip param returns true if record.type is not 'Licensed SKU' --%>
                    <dsp:getvalueof var="canShip" param="canShip"/>
                </dsp:oparam>
            </dsp:droplet>

            <%-- START Add to Cart --%>
            <c:if test="${canShip eq 'true'}">
                <div class="sticky-container">
                    <div class="sticky">
                        <div class="left">
                            <dsp:include page="${pageContext.request.contextPath}/browse/pdp/product-menu.jsp" />
                        </div>
                        <div class="right simple-product">
                            <div class="add-to-cart simple-add-to-cart" data-module="addToCart">
								<div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
                                <c:choose>
                                    <c:when test="${isPurchasable eq 'true' && (not empty currentDealerId || (currentDealerId ne defaultUSDealer || currentDealerId ne defaultCANDealer))}">
                                        <div style="display:none;">
                                            <div id="addedToCartModal" data-module="cbox"></div>
                                        </div>
                                        <div id="addToCartModalLink" data-module="cbox" data-transition="elastic" data-speed="350" data-initial-height="640" data-inline="true">
                                            <a href="#addedToCartModal" type="button" class="modal"></a>
                                        </div>
                                        <div id="addToCartError"></div>

                                        <%-- Render Contact Store Button in DOM hidden by default --%>
                                        <div id="inStoreOnly" class="hide">
                                            <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
                                        </div>

                                        <%-- Render Add to Cart Form. Shown by default --%>
                                        <div class="add-actions">
                                            <dsp:form id="addToCart" name="addToCart" method="post" action="${requestScope['javax.servlet.forward.request_uri']}">
                                                <input id="dealerid" type="hidden" name="dealer" value="${currentDealerId}" />
                                                <dsp:input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productRecord['product.repositoryId'] }" />
                                                <dsp:input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productRecord['sku.repositoryId']}" />

                                                <div class="changeQuantity" data-module="lzb-quantify" data-quantify>
                                                    <label for="quantity"><fmt:message key="pdp.quantity" /></label>
                                                    <div class="quantity-group">
                                                        <div class="current-quantity">
                                                            <dsp:input id="quantity" type="text" bean="CartModifierFormHandler.quantity" iclass="counter" value="1" />
                                                            <div class="qty-arrows">
                                                                <div class="plus-icon"></div>
                                                                <div class="minus-icon inactive"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <input id="editCommerceItemId" type="hidden" name="editCommerceItemId"	value="${editCommerceItemId}" />
                                                <dsp:input	type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/cart/json/cartSuccessJson.jsp" />
                                                <dsp:input	type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/cart/json/cartSuccessJson.jsp" />
                                                <dsp:input	type="hidden" bean="CartModifierFormHandler.addItemToOrder" value="true" />
                                                <fmt:message var="addToCart" key="pdp.addToCart" />

                                                <c:choose>
                                                    <c:when test="${onSale}">
                                                        <c:set var="buttonPrice" value="${formatLowestSalePrice}" />
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="buttonPrice" value="${formatLowestPrice}" />
                                                    </c:otherwise>
                                                </c:choose>
                                                <input id="addToCartId" type="button" class="button primary-btn modal addToCartButton addToCartButtonSimple" aria-label="${addToCart}" value="${addToCart}&nbsp;&nbsp;|&nbsp;&nbsp;${buttonPrice}" data-shoppinglink="${continueShopping}" />
                                            </dsp:form>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- Render Contact Store Button if product is NOT available for online purchase --%>
                                        <div id="inStoreOnly">
                                            <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="pdp-icons-row">

                                <div class="share-icons simple-pdp-social" data-module="social-share-icons social-share">
                                    <ul class="share-list" data-pdptype="configurable">
                                        <%-- JIRA DMI-1763 Hide Wishlist UI
                                        <li>
                                            <a class="pdp-favorite add-to-wishlist" data-pdptype="simple">
                                                <dsp:include page="${pageContext.request.contextPath}/cart/cdpAddFavorites.jsp">
                                                    <dsp:param name="record" value="${content.record }"/>
                                                    <dsp:param name="dealerId" bean="ProfileTools.priceListId" />
                                                    <dsp:param name="refPage" value="pdp" />
                                                </dsp:include>
                                                <input id="wishlistinfoId" type="hidden" name="wishlistinfo"	value="" />
                                            </a>
                                        </li>
                                        --%>

                                        <li>
                                            <a class="icon-share social-share-click" alt="Share icon" tabindex="0"></a>
                                        </li>

                                        <li class="btn-print" alt="Print page">
                                            <a href="#" class="icon-print" data-service="print" data-sharesku="${record.attributes['sku.repositoryId']}?WT.mc_id=sharedfromsite" tabindex="0"></a>
                                        </li>
                                    </ul>

                                    <ul class="pdp-social-bubble">
                                        <li>
                                            <a href="https://www.facebook.com/lazboy" data-service="facebook" data-sharesku="${record.attributes['sku.repositoryId']}" title="Facebook">
                                            <%-- <img width="36" height="35" src="//content.la-z-boy.com/Images/elementsImages/share_fb.png" alt="Like on Facebook"> --%>
                                            <img src="//${storeConfig.contentHostName}/Images/social-share-icons/fb-share-button-35h.png" alt="Like on Facebook" />
                                            </a>
                                        </li>
                                        <li>
                                            <a href="https://twitter.com/intent/tweet" data-service="twitter" data-sharesku="${record.attributes['sku.repositoryId']}?WT.mc_id=sharedfromsite" title="Twitter"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Twit.png" alt="Twitter"></a>
                                        </li>
                                        <li>
                                            <dsp:a href="${pageContext.request.contextPath}/global/includes/shareThisProduct.jsp"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List">
                                                <dsp:param name="prodId" value="${productId}"/>
                                                <dsp:param name="ProdName" value="${prodDisplayName}"/>
                                                <dsp:param name="skuId" value="${skuId}"/>
                                                <dsp:param name="coverId" value="${coverNo}"/>
                                            </dsp:a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <c:if test="${isLicensed ne 'true'}">
                                <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpUtilityLinks.jsp">
                                    <dsp:param name="skuId" value="${skuId}"/>
                                    <dsp:param name="lowestSalePrice" value="${lowestSalePrice}"/>
                                    <dsp:param name="lowestPrice" value="${lowestPrice}"/>
                                </dsp:include>
                            </c:if>

                        </div> <!-- .right -->
                    </div>
			    </div>
            </c:if>
			<%-- END Add to Cart --%>
		</section>

		<dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpInfo.jsp"/>

	</section>
<%-- <script>

window.onload = function(){
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
}

</script> --%>
</dsp:page>
