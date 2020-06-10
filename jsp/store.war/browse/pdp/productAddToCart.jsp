<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
  <dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
  <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
  <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
  <dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
  <dsp:importbean bean="/atg/userprofiling/Profile" />
  <dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
  <dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
  <dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
  <dsp:importbean bean="/com/lzb/service/SessionBean"/>
  <dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>
  <dsp:importbean bean="/atg/store/LZBStoreConfiguration" />

  <dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
  <dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />

	<dsp:getvalueof var="record" param="recordAttrib" scope="request"/>
	<dsp:getvalueof param="prodId" var="productId"/>
	<dsp:getvalueof param="ProdName" var="prodDisplayName"/>
	<dsp:getvalueof param="skuId" var="skuId"/>
	<dsp:getvalueof param="coverSkuId" var="coverNo"/>

	<dsp:getvalueof param="lowestSalePrice" var="lowestSalePrice" />
	<dsp:getvalueof param="lowestPrice" var="lowestPrice" />
	<dsp:getvalueof param="formatLowestSalePrice" var="formatLowestSalePrice" />
	<dsp:getvalueof param="lowestPriceDecimal" var="lowestPriceDecimal" />
	<dsp:getvalueof param="formatLowestPrice" var="formatLowestPrice" />

  <dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
  <dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
  <dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
  <dsp:getvalueof var="transient" bean="Profile.transient" />
  <dsp:getvalueof param="coverId" var="coverId"/>
  <dsp:getvalueof var="editCommerceItemId" param="editCommerceItemId" />  
	<div class="sticky-container">
		<div class="sticky">
			<div class="left">
				<dsp:include page="/browse/pdp/product-menu.jsp" />
			</div>
			<div class="right">
					<div class="add-to-cart" data-module="addToCart">
						<c:choose>
							<c:when test="${(empty currentDealerId || (currentDealerId eq defaultUSDealer || currentDealerId eq defaultCANDealer)) ||	empty productRecord['sku.cover']}">
                <div id="inStoreOnly">
                  <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
                </div>
                <input id="dealerid" type="hidden" name="dealer"	value="${currentDealerId}" />
                <input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productRecord['product.repositoryId'] }" />
                <input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productRecord['sku.repositoryId']}" />
                <input id="exceptionid" type="hidden" name="exceptionid" value="" />
                <input id="iteminfo" type="hidden" name="iteminfo" value="" />
                <input id="isSelectPrice" type="hidden" name="isSelectPrice" value="" />
                <input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />
                <input id="coverId" type="hidden" name="coverId" value="${defaultCoverSkuId}" />
							</c:when>
							<c:otherwise>
								<c:if	test="${discontinued eq 'true'}">
                  <div id="inStoreOnly" class="hide">
                    <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
                  </div>
									<div class="add-actions">
										<dsp:form id="addToCart" name="addToCart" method="post" action="${requestScope['javax.servlet.forward.request_uri']}">
											<input id="dealerid" type="hidden" name="dealer"	value="${currentDealerId}" />
											<dsp:input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productRecord['product.repositoryId'] }" />
											<dsp:input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productRecord['sku.repositoryId']}" />
											<input id="exceptionid" type="hidden" name="exceptionid" value="" />
											<input id="iteminfo" type="hidden" name="iteminfo" value="" />
											<input id="isSelectPrice" type="hidden" name="isSelectPrice" value="" />
											<input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />
											<input id="coverId" type="hidden" name="coverId" value="${defaultCoverSkuId}" />

											<div class="changeQuantity" data-module="lzb-quantify" data-quantify>
												<label for="quantity"><fmt:message key="pdp.quantity" /></label>
												<div class="quantity-group">
													<div class="current-quantity">
														<input id="quantity" name="quantity" type="text" class="counter" value="1" />
														<div class="qty-arrows">
															<div class="plus-icon"></div>
															<div class="minus-icon inactive"></div>
														</div>
													</div>
												</div>
											</div>

											<input id="editCommerceItemId" type="hidden" name="editCommerceItemId"	value="${editCommerceItemId }" />
											<dsp:input	type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/cart/json/cartSuccessJson.jsp" />
											<dsp:input	type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/cart/json/cartSuccessJson.jsp" />
											<dsp:input	type="hidden" bean="CartModifierFormHandler.addConfigurableItemToOrder" value="true" />
											<fmt:message var="addToCart" key="pdp.addToCart" />
                      <c:choose>
      		              <c:when test="${onSale}">
                          <c:set var="buttonPrice" value="${formatLowestSalePrice}" />
                        </c:when>
                        <c:otherwise>
                          <c:set var="buttonPrice" value="${formatLowestPrice}" />
                        </c:otherwise>
                      </c:choose>
			                <input id="addToCartId" type="button" class="button primary-btn modal addToCartButton" aria-label="${addToCart}" value="${addToCart }&nbsp;&nbsp;|&nbsp;&nbsp;${buttonPrice}" data-shoppinglink="${continueShopping }" />

										</dsp:form>
										<dsp:form action="/rwd/checkout/cart.jsp" method="post" id="addPlan" formid="addPlan" name="addPlan">
											<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/rwd/checkout/cart.jsp" />
											<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/rwd/checkout/cart.jsp" />
											<dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value=""/>
											<dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value=""/>
											<dsp:input type="hidden" id="removePlan" bean="CartModifierFormHandler.removePlan" value="false"/>
											<dsp:input type="hidden" bean="CartModifierFormHandler.addTreatmentPlanToOrder" value="true"	/>
										</dsp:form>
									</div>
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>

				<c:if	test="${discontinued eq 'true'}">
					<div class="pdp-icons-row">

						<div class="share-icons" data-module="social-share-icons social-share">
							<ul class="share-list" data-pdptype="configurable">

								<%-- JIRA DMI-1763 Hide Wishlist UI
                                <li>
									<a class="pdp-favorite add-to-wishlist" data-pdptype="configurable">
										<dsp:include page="/cart/cdpAddFavorites.jsp">
											<dsp:param name="record" value="${content.record }"/>
											<dsp:param name="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
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
									<dsp:a href="${contextPath}/global/includes/shareThisProduct.jsp"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List">
										<dsp:param name="prodId" value="${productId}"/>
										<dsp:param name="ProdName" value="${prodDisplayName}"/>
										<dsp:param name="skuId" value="${skuId}"/>
										<dsp:param name="coverId" value="${coverNo}"/>
									</dsp:a>
								</li>
							</ul>
						</div>
					</div>
				</c:if>
				<!-- </div> -->

        <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpUtilityLinks.jsp">
          <dsp:param name="skuId" value="${skuId}"/>
          <dsp:param name="lowestSalePrice" value="${lowestSalePrice}"/>
          <dsp:param name="lowestPrice" value="${lowestPrice}"/>
        </dsp:include>

        <div class="custom-order-notice">
	        <p class="small">*&nbsp;<fmt:message key="pdp.custom.order.notice" /></p>
        </div>

			</div> <!-- .right -->
		</div>
	</div>
</dsp:page>