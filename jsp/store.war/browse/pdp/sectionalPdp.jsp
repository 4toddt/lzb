<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<dsp:page>
			<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
			<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
			<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
			<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
			<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
    		<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
			<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
			<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
			<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
			<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
			<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
			<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
			<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
			<dsp:importbean bean="/com/lzb/service/SessionBean"/>
			<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
			<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
			<dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>

			<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
			<dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
			<dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
			<dsp:getvalueof var="country" bean="Profile.currentStore.country" />
			<dsp:getvalueof var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />
			
			<c:set var="contentHostName" value="//content.la-z-boy.com"/>

			<dsp:getvalueof var="content"
				vartype="com.endeca.infront.assembler.ContentItem"
				value="${originatingRequest.contentItem}" />
			<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
			<dsp:getvalueof var="productSkuId" value="${productRecord['sku.repositoryId']}" />

			<!--  Assign default record for sectional -->
			<c:forEach var="element" items="${content.record.records}" varStatus="i">
				<dsp:getvalueof var="defaultStyleRecord" value="${element.attributes}" />
					<c:if test="${defaultStyleRecord['sectionalConfigSku.isDfltStyle'] eq 'true'}">
						<dsp:getvalueof var="productRecord" value="${productRecord}" />
					</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${isSectional eq 'true'}">
			 		<dsp:getvalueof var="prodId" value="${productRecord['product.repositoryId']}" scope="request"/>
				</c:when>
				<c:otherwise>
			 		<dsp:getvalueof var="prodId" value="${productRecord['sku.repositoryId']}" scope="request"/>
				</c:otherwise>
			</c:choose>
			 <!-- prodId = ${prodId} -->
			<dsp:getvalueof param="coverId" var="coverId"/>
		<c:choose>
			<c:when test ="${empty coverId}">
				<dsp:getvalueof var="defaultCoverSkuId" value="${fn:split(productRecord['sku.defaultCover'],'~')[0]}"/>
			</c:when>
			<c:otherwise>
				<dsp:getvalueof var="defaultCoverSkuId" value="${coverId}"/>
			</c:otherwise>
		</c:choose>
		<input type="hidden" class="pdpPageType" value="sectional" />
	
		<c:if test ="${not empty productRecord['product.daysAvailable'] }">
			<fmt:parseNumber var="productDaysAvailable" value="${productRecord['product.daysAvailable']}"/>
		</c:if>
	
<%--	<c:set var="protocol" value ="http://"/>
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
			<dsp:getvalueof var="jsonrequest" param="jsonrequest" />
			<dsp:getvalueof var="item_qty" param="item_qty" />
			<c:set var="jsonRequestValue" scope="request" value="${jsonrequest}"/>
			<c:set var="itemQtyValue" scope="request" value="${item_qty}"/>
			</dsp:oparam>
		</dsp:droplet>
		<dsp:getvalueof var="jsonreq" value="${jsonRequestValue}" />
		<input type="hidden" id="jsonReqInput" class="sectionalJsonReqInput" name="jsonReqInput" value='${jsonreq}' />
		<input type="hidden" id="itemQtyValue" value="${itemQtyValue}" />

		<dsp:droplet name="LZBSectionalPDPPriceDroplet">
				<dsp:param name="sectionalProductId" value="${productRecord['product.repositoryId']}" />
				<dsp:param name="dealerId" param="dealer" />
				<dsp:param name="coverId" value="${defaultCoverSkuId}" />
				<dsp:param name="dealerId" bean="ProfileTools.priceListId"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="listPrice" param="listPrice" />
					<dsp:getvalueof var="salePrice" param="salePrice" />
					<dsp:getvalueof var="onSale" param="hasSalePrice" />
					<dsp:getvalueof var="defaultStyleSku" param="defaultStyleSkuItem" />
				</dsp:oparam>
			</dsp:droplet>

		<!-- START Product Title/Price row -->
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

			<div class="pdp-price-rating-container">

				<div class="pdp-price">
					<meta itemprop="sku" content="${productRecord['product.displayName']}">
					<fmt:parseNumber var="lowestSalePrice" value="${salePrice}"/>
					<fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
					<fmt:parseNumber var="lowestPrice" value="${listPrice}"/>
					<fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />

					<%-- JIRA DMI-1712: hiding initial page load price display and replacing with static message --%>
					<div class="configure-for-pricing">
						<fmt:message key="price.configureForPricing"/>
				  	</div>
          <div id="pdp-price-info" class="hide" data-module="tool-tips">
						<c:choose>
							<c:when test="${not empty productDaysAvailable and productDaysAvailable lt 0}">
									<%-- don't display price if the product is not available  --%> <!--    ${ productDaysAvailable } : ${ productDaysAvailable } -->
									<span hidden id="pdp-price"></span>
							</c:when>
							<c:when test="${not empty salePrice && onSale}">
								<span aria-label="Original price: ${formatLowestPrice} Price is now: ${formatLowestSalePrice}">
									<div class="pdp-pricing-amount">
										<div class="pdp-pricing-title" aria-hidden="true">
											<fmt:message key="price.startingAt"/>
										</div>
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
							</c:when>
							<c:otherwise>
								<span aria-label="Original price: ${formatLowestPrice}">
									<div class="pdp-pricing-amount">
										<div class="pdp-pricing-title" aria-hidden="true">
											<fmt:message key="price.startingAt"/>
										</div>
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
							</c:otherwise>
						</c:choose>
          </div>

	      </div>

				<dsp:include src="${pageContext.request.contextPath}/browse/pdp/starRatingSummary.jsp">
					<dsp:param name="productSkuId" value="${productSkuId}" />
				</dsp:include>
				
				<c:if test="${country != 'CA'}">
					<div class="pdp-monthly-pricing hide" data-financingmonths="${digitalBuyFinancingMonths}">
						<dsp:getvalueof var="monthlyPriceRaw" value="${lowestPrice/digitalBuyFinancingMonths}" />
						<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
										
						<a href="/content/financing-disclosures" target="_blank">or $<span class="monthly-price">${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
					</div>
				</c:if>
			</div>
		</div>
		<!-- END Product Title/Price row -->

	<section itemscope itemtype="http://schema.org/Product" data-module="sectional-price-change">

		<%-- Display Product Images --%>
		<dsp:include page="${pageContext.request.contextPath}/browse/pdp/productImages.jsp">
			<dsp:param name="defaultCover" value="${defaultCoverSkuId}" />
		</dsp:include>

	<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
	<section role="region">

							<%-- <dsp:include page="selectedSkuDisplay.jsp">
							<dsp:param name="defaultCover" value="${productRecord['sku.defaultCover']}"/>
						</dsp:include> --%>

						<c:choose>
		            <c:when test ="${empty coverId}">
		                <dsp:getvalueof var="defaultCover" value="${productRecord['sku.defaultCover']}" scope="request"/>
		            </c:when>
		            <c:otherwise>
		                <dsp:droplet name="LZBSKUCoverParserDroplet">
		                    <dsp:param name="skuCoverList" value="${productRecord['sku.cover'] }" />
		                    <dsp:param name="coverId" value="${coverId}" />
		                    <dsp:oparam name="output">
		                        <dsp:getvalueof var="defaultCover" param="coverDetails" scope="request"/>
		                    </dsp:oparam>
		                </dsp:droplet>
		            </c:otherwise>
		        </c:choose>

						<div style="display:none;">
							<div id="addedToCartModal"></div>
						</div>

								<dsp:getvalueof var="currentDealerId" bean="ProfileTools.priceListId" />
								<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />


								<div id="addToCartModalLink" data-module="cbox" data-transition="elastic" data-speed="350" data-initial-height="640" data-inline="true">
									<a href="#addedToCartModal" type="button" class="modal"></a>
								</div>
								<div id="addToCartError"></div>
									<dsp:getvalueof var="productId" value="${productRecord['product.repositoryId'] }" />
									<dsp:getvalueof var="prodDisplayName" value="${productRecord['product.displayName']}"/>
									<dsp:getvalueof var="skuId" param="sku.id" />
									<dsp:getvalueof var="editCommerceItemId" param="commid" />
									<dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />

					<dsp:getvalueof var="defaultCoverSkuForImgCover" value="${productRecord['sku.defaultCover']}" />
					<dsp:getvalueof var="defaultCoverSkuForImg" value="${fn:split(defaultCoverSkuForImgCover,'~')[0]}" />
					<%-- START Sectional configurable Options --%>
					<div id="pdpCustomizationOptions" class="sectional">
						<div class="accordion-group" data-module="accordion-group" data-group="cover-main">
							<%-- START Cover Selection Section  --%>
							<div class="accordion-section active cover-selector">
								<div class="section-header">
									<!-- defaultCover = ${defaultCover} -->
									<dsp:include page="coverSelectorHeader.jsp" >
										<dsp:param name="defaultCover" value="${defaultCover}"/>
									</dsp:include>
								</div>
								<div class="section-content">
									<dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpCoverSelectorContent.jsp">
										<dsp:param name="dealerId" value="${currentDealerId}" />
									</dsp:include>
								</div>
							</div>
							<%-- END Cover Selection Section  --%>
							<%-- START Sectional Configuration Section  --%>
							<div class="accordion-section  sectional-section" data-module="sectional-configurator">
								<c:set var="sectionTitle"><fmt:message key="pdp.sectionalPiecesSelection" /></c:set>
								<div class="section-header material-details new-ui" data-title="${sectionTitle}">
									<%--<h4><fmt:message key="pdp.sectionalPiecesSelection" /></h4>--%>
								</div>
								<div class="section-content">
									<%-- XXXXXXXXXXXXXXXXXXXXXXXX Sectional Pieces Selection XXXXXXXXXXXXXXXXXXXXXXXX--%>
									<div id="pdpSectionalSelections" class="tab-content active" >
										<dsp:droplet name="LZBSectionalDisplayDroplet">
											<dsp:param name="productId" value="${productRecord['product.repositoryId']}" />
											<dsp:param name="isJsonOutput" value="true"/>
											<dsp:oparam name="output">
											<%-- <dsp:valueof param="defaultSectionalStyleSkuPiecesJson"/> --%>
											<dsp:getvalueof var="defaultSectStyleLeft" param="defaultSectionalStyleSkuPieces.defaultLeftItem"/>
											<dsp:getvalueof var="defaultSectStyleMiddle" param="defaultSectionalStyleSkuPieces.defaultMiddleItems"/>
											<dsp:getvalueof var="defaultSectStyleRight" param="defaultSectionalStyleSkuPieces.defaultRightItem"/>
												<%-- <dsp:getvalueof var="defaultSectStyle" param="defaultSectionalStyleSkuPieces.defaultLeftItem.subSkuId" />
												xxx${defaultSectStyle} --%>
												<b><p class="padded">Step 1: Choose your starter configuration</p></b>
												<form action="#" method="post" id="pdpSectionalSelectionsForm" class="pdp-sectional-selections">
													<legend><b>Step 1: Choose your starter configuration</b></legend>
													<fieldset class="pdp-sectional-selections-options">
														<div id="sectionalConfig" class="sectional-config" data-module="carousel-sectional-config">

														<dsp:droplet name="ForEach">
															<dsp:param name="array" param="styleSkus" />
															<dsp:param name="elementName" value="stylesku" />
															<dsp:getvalueof var="optionSkuCount" param="index" />
															<dsp:getvalueof var="optionSkuCount" value="${optionSkuCount + 1}" />
															<dsp:getvalueof var="imagePath" param="stylesku.imagePath" />
															<dsp:getvalueof var="thumbImg" param="stylesku.cdpDefaultImage" />
															<dsp:getvalueof var="imgHostName" bean="LZBStoreConfiguration.hostName" />
															<dsp:getvalueof var="skuID" param="stylesku.id" />

															<c:set var="optionSkuChecked" value="" />
															<c:if test="${optionSkuCount eq 1}" >
																<c:set var="optionSkuChecked" value="checked='checked'" />
															</c:if>
															<dsp:oparam name="output">

															<div>
																<figure>
																	<figcaption>
																		<fieldset>
																			<label for="config-opt${optionSkuCount}">Option ${optionSkuCount}</label>
																			<input type="radio" id="config-opt${optionSkuCount}" data-catalogrefid="${skuID}" data-sectional-name="${productRecord['sku.displayName']}" name="sectional-option" value="config-option${optionSkuCount}" ${optionSkuChecked} data-path="includes/sectionalConfigImg1.html" />
																		</fieldset>
																	</figcaption>
																	<label for="config-opt${optionSkuCount}">
																		<img src="${contentHostName}${imagePath}${thumbImg}" alt="thumb" />
																	</label>
																</figure>
															</div>

															</dsp:oparam>
														</dsp:droplet>

														</div><%-- #sectionalConfig --%>
													</fieldset>

													<b><p class="padded">Step 2: Customize your configuration</p></b>
													<dsp:include page="${pageContext.request.contextPath}/browse/pdp/sectionalPdpOptionRight.jsp">
														<dsp:param name="dealer"  value="${currentDealerId}" />
														<dsp:param name="defaultCover"  value="${defaultCoverSkuId}" />
														<dsp:param name="rightUnits" param="rightUnits" />
														<dsp:param name="defaultSectStyleRight" value="${defaultSectStyleRight}"/>
														<dsp:param name="buildName" value="${productRecord['sku.displayName']}" />
													</dsp:include>
													<dsp:include page="${pageContext.request.contextPath}/browse/pdp/sectionalPdpOptionCenter.jsp" >
														<dsp:param name="dealer"  value="${currentDealerId}" />
														<dsp:param name="defaultCover"  value="${defaultCoverSkuId}" />
														<dsp:param name="middleUnits" param="middleUnits" />
														<dsp:param name="defaultSectStyleMiddle" param="defaultSectionalStyleSkuPieces.defaultMiddleItems"/>
														<dsp:param name="buildName" value="${productRecord['sku.displayName']}" />
													</dsp:include>
													<%-- /////${defaultSectStyleLeft[0].id}<br> --%>
													<dsp:include page="${pageContext.request.contextPath}/browse/pdp/sectionalPdpOptionLeft.jsp">
														<dsp:param name="dealer"  value="${currentDealerId}" />
														<dsp:param name="defaultCover"  value="${defaultCoverSkuId}" />
														<dsp:param name="defaultSectStyleLeft" value="${defaultSectStyleLeft}"/>
														<dsp:param name="leftUnits" param="leftUnits" />
														<dsp:param name="buildName" value="${productRecord['sku.displayName']}" />
													</dsp:include>

													<div class="callout left">
														<img src="/img/loader2.gif" alt="Sectional Diagram 1" id="configImg" class="config-img droppable" />
														<b><p class="padded">Drag or remove the pieces below to rearrange the sectional diagram above.</p></b>
														<div class="pdp-thumbs-container">
															<ul class="sortable grid" id="sectionalsThumbs"></ul>
														</div>
													</div><%-- .callout left --%>
												</form><%-- #pdpSectionalSelectionsForm --%>
											</dsp:oparam>
										</dsp:droplet>	<%-- LZBSectionalDisplayDroplet --%>
									</div>
								</div>
							</div>
							<%-- END Sectional Configuration Section  --%>
							<%-- START Options And Upgrades Section  --%>
							<div class="accordion-section opts" data-module="opt-upg-section" name="optionsUpgradesAccordionSection" >
								<div class="section-header">
									<dsp:include src="${pageContext.request.contextPath}/browse/pdp/optionsAndUpgradesHeader.jsp"/>
								</div>
								<div class="section-content">
									<div class="loading-gif" style="display:none;" data-module="pdp-options-upgrades">
										<img src="/img/loading.gif" />
									</div>
									<div class="accordion-group pdp-opt-upg" id="optionsUpgrades" data-module="showPDPOptionSwatches"></div>
								</div>
							</div>
							<%-- END Options And Upgrades Section  --%>
						</div>


					</div>
					<%-- END Sectional configurable Options --%>

					<%-- START Add to Cart --%>
					<div class="sticky-container">
						<div class="sticky">
							<div class="left">
								<dsp:include page="${pageContext.request.contextPath}/browse/pdp/product-menu.jsp" />
							</div>
							<div class="right">
								<div class="add-to-cart" data-module="addToCart">
									<c:choose>
										<c:when test="${(empty currentDealerId || (currentDealerId eq defaultUSDealer || currentDealerId eq defaultCANDealer)) ||	empty productRecord['sku.cover']}">
											<div id="inStoreOnly">
		                    <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
		                  </div>
											<input id="dealerid" type="hidden" name="dealer" value="${currentDealerId}" />
											<input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productRecord['product.repositoryId'] }" />
											<input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productRecord['sku.repositoryId']}" />
											<input id="exceptionid" type="hidden" name="exceptionid" value="" />
											<input id="iteminfo" type="hidden" name="iteminfo" value="" />
											<input id="defaultCoverId" type="hidden" name="defaultCover"  value="${defaultCoverSkuId}" />
											<input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />
										</c:when>
										<c:otherwise>
											<div id="inStoreOnly" class="hide">
		                    <a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" class="button secondary-btn" aria-label="<fmt:message key='pdp.in.store.label'/>" tabindex="0"><fmt:message key="pdp.in.store.label"/><span class="asterisk hide">*</span></a>
		                  </div>
											<dsp:getvalueof var="productid" value="${productRecord['product.repositoryId'] }" />
											<dsp:droplet name="LZBPDPURLDroplet">
												<dsp:param name="productId" value="${productid}" />
													<dsp:param name="elementName" value="url" />
													<dsp:oparam name="output">
														<dsp:getvalueof var="pdpurl" param="url"/>
													</dsp:oparam>
											</dsp:droplet>
											<div id="cartDiaglog" title="Add to Cart">
											</div>

											<dsp:form id="addToCart" name="addToCart" method="post" action="${requestScope['javax.servlet.forward.request_uri']}">
												<input id="dealerid" type="hidden" name="dealer" value="${currentDealerId}" />
												<dsp:input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productRecord['product.repositoryId'] }" />
												<dsp:input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productRecord['sku.repositoryId']}" />
												<input id="exceptionid" type="hidden" name="exceptionid" value="" />
												<input id="iteminfo" type="hidden" name="iteminfo" value="" />
												<input id="defaultCoverId" type="hidden" name="defaultCover"  value="${defaultCoverSkuId}" />
												<input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />


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


												<input id="editCommerceItemId" type="hidden" name="editCommerceItemId"  value="${editCommerceItemId }" />

												<dsp:input  type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/cart/json/cartSuccessJson.jsp" />
												<dsp:input  type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/cart/json/cartSuccessJson.jsp" />
												<dsp:input  type="hidden" bean="CartModifierFormHandler.pdpPageType" value="sectionals" />
												<dsp:input  type="hidden" bean="CartModifierFormHandler.addConfigurableItemToOrder" value="true" />
												<fmt:message var="addToCart" key="pdp.addToCart" />

												<input id="addToCartIdSectional" type="button" class="button primary-btn modal addToCartButton" aria-label="${addToCart}" value="${addToCart}&nbsp;&nbsp;|&nbsp;&nbsp;${formatLowestPrice}" />

											</dsp:form>

											<dsp:form action="/rwd/checkout/cart.jsp" method="post" id="addPlan" formid="addPlan" name="addPlan">
												<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/rwd/checkout/cart.jsp" />
												<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/rwd/checkout/cart.jsp" />
												<dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value=""/>
												<dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value=""/>
												<dsp:input type="hidden" id="removePlan" bean="CartModifierFormHandler.removePlan" value="false"/>
												<dsp:input type="hidden" bean="CartModifierFormHandler.addTreatmentPlanToOrder" value="true"  />
											</dsp:form>

										<%-- <dsp:a id="continueToCart" href="/work/cart/cart.jsp" > Continue to cart</dsp:a> --%>
										</c:otherwise>
									</c:choose>
								</div><%-- .add-to-cart --%>

								<%-- START Wishlist & Social Icons --%>
								<div class="pdp-icons-row">

									<div class="share-icons" data-module="social-share-icons social-share">
										<ul class="share-list" data-pdptype="sectional">
											<%-- JIRA DMI-1763 Hide Wishlist UI
											<li>	
												<a class="pdp-favorite add-to-wishlist" data-pdptype="sectional">
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
													<dsp:param name="skuId" value="${productRecord['sku.repositoryId']}"/>
													<dsp:param name="coverId" value="${coverNo}"/>
												</dsp:a>
											</li>
										</ul>
									</div>
								</div>

								<dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpUtilityLinks.jsp">
				          <dsp:param name="skuId" value="${productRecord['sku.repositoryId']}"/>
				          <dsp:param name="lowestSalePrice" value="${lowestSalePrice}"/>
				          <dsp:param name="lowestPrice" value="${lowestPrice}"/>
				        </dsp:include>
								<%-- END Wishlist & Social Icons --%>

								<div class="custom-order-notice">      
					        <p class="small">*&nbsp;<fmt:message key="pdp.custom.order.notice" /></p>
				        </div>

							</div> <!-- .right -->
						</div>
					</div>
					<%-- END Add to Cart --%>

				</section>

			</section>

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
