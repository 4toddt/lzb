<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/com/lzb/content/record/LZBEndecaRecord" />
	<dsp:importbean var="storeConfig" bean="/atg/store/LZBStoreConfiguration"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="catName" param="${catName}" />
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />

	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>
	<c:set var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />

	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />

	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${contentHostName}" />
	<dsp:getvalueof var="term" param="Ntt" scope="page" />
	<dsp:getvalueof var="selectedFacet" param="selectedFacet" />

	<fmt:message var="productPagePath" key="pdp.storePath"/>

	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="${contentItem.navurl}" />
	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="${contentItem.navurl}" />
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL" value="${contentItem.navurl}" />
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsErrorURL" value="${contentItem.navurl}" />

	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>

	<dsp:setvalue bean="ProductList.prevPageURl" value="${contentItem.navurl}"/>

	<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar"/>

	<dsp:setvalue bean="SessionBean.addItemToWishListStatus" value="false" />

	<dsp:include page="/global/giftlisterrors.jsp">
		<dsp:param name="formHandler" bean="GiftlistFormHandler" />
	</dsp:include>
	<dsp:include page="/includes/global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler"/>
	</dsp:include>

	<%-- Display Records in Results List Start--%>
    <c:set var="cdpProductListForTracking" value="" scope="request" />

    <c:set var="cdpProductListSeparator" value="" />

    <%-- PromoSlots --%>
	<c:set var="promoslots" value="${contentItem.promoSlots}"/>

	<c:forEach var="element" items="${contentItem.records}" varStatus="i">
		<dsp:getvalueof var="recIndex" value="${i.index}"/>
		<dsp:getvalueof var="lastRec" value="${i.last}"/>
		<dsp:getvalueof var="recType" value="${element.attributes['type']}"/>
		<c:choose>
			<c:when test="${fn:contains(element.attributes['record.type'],'sectional')}">
				<c:set var="cdpImage" value="${element.attributes['product.cdpImage']}"/>
				<c:set var="cdpMouseOverImage" value="${element.attributes['product.cdpAltImage']}"/>
				<c:set var="displayName" value="${element.attributes['product.displayName']}"/>
				<c:set var="repositoryId" value="${element.attributes['sku.repositoryId']}"/>
			</c:when>
			<c:otherwise>
				<c:set var="cdpImage" value="${element.attributes['sku.cdpDefaultImage']}"/>
				<c:set var="cdpMouseOverImage" value="${element.attributes['sku.cdpMouseOverImage']}"/>
				<c:set var="displayName" value="${element.attributes['sku.displayName']}"/>
				<c:set var="repositoryId" value="${element.attributes['sku.repositoryId']}"/>
				<c:set var="categorydisplayName" value="${element.attributes['parentCategory.displayName']}"/>
			</c:otherwise>
		</c:choose>
		
		<dsp:getvalueof var="numericLowestSalePrice" value='' />
		<dsp:getvalueof var="numericLowestSalePriceBdg" value='' />
		<dsp:getvalueof var="numericLowestPrice" value='' />
		<dsp:getvalueof var="numericLowestPriceBdg" value='' />

		<c:set var="cdpProductListForTracking" value='${cdpProductListForTracking}${cdpProductListSeparator}"${repositoryId}"' scope="request" />
		<c:set var="cdpCategoryNameForTracking"	value="${element.attributes['parentCategory.displayName']}"	scope="request" />

		<c:set var="showStartingAtLabel" value="false"/>
		<c:if test="${element.attributes['record.type'] ne 'Licensed Sku'}">
            <%-- only show starting at label for configurable products --%>
            <c:set var="showStartingAtLabel" value="true"/>
        </c:if>

		<c:if test="${ i.index != contentItem.recsPerPage || not empty param.viewAll }">
			<c:choose>
			<c:when test="${recType eq 'promo'}">
				<c:forEach var="slot" items="${promoslots}">
					<dsp:getvalueof var="index" value="${slot.index}"/>
					<c:if test="${index == recIndex}">
						<%--<c:set var="lastRec" value="${(count+slot.indexOffset) eq size}"/> --%>
						<li class="cdp-item">
							<dsp:renderContentItem contentItem="${slot}"/>
						</li>
					</c:if>
				</c:forEach>
			</c:when>
			<c:when test="${recType eq 'promoext'}"><li class="cdp-item"/></c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${fn:contains(element.attributes['record.type'],'sectional')}">
						<dsp:getvalueof var="showFinancing" value="${false}" />
					</c:when>
					<c:otherwise>
						<dsp:getvalueof var="showFinancing" value="${true}" />
					</c:otherwise>
				</c:choose>
				
				<li class="cdp-item">
					<dsp:droplet name="LZBPDPURLDroplet">
						<dsp:param name="productId" value="${repositoryId}" />
						<dsp:param name="categorydisplayName" value="${categorydisplayName}" />
						<dsp:param name="prodName" value="${displayName}" />
						<dsp:param name="fromCDP" value="true" />
						<dsp:param name="elementName" value="url" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="pdpurl" param="url"/>
						</dsp:oparam>
					</dsp:droplet>
					<c:choose>
						<c:when test="${not empty pdpurl}">
							<c:set var="recordURL" value="${pdpurl}"/>
						</c:when>
						<c:otherwise>
							<c:set var="recordURL" value="${productPagePath}${element.detailsAction.recordState}"/>
						</c:otherwise>
					</c:choose>
					<div class="cdp-img-wrapper" style="height:230px;">
						<c:set var="badgeLeft" value="${element.attributes['sku.badge.left']}" />
						<c:set var="badgeRight" value="${element.attributes['sku.badge.right']}" />
						<c:set var="badgeOnSale" value="${element.attributes['onSale']}" />
						<c:set var="initialUrl" value="${contentHostName}" />
						<c:if test="${empty initialUrl}">
							<c:set var="initialUrl" value="http://${initialUrl}" />
						</c:if>
						<c:if test="${not empty element.attributes['topBadgeImage']}">
							<img src="${contentHostName}${storeConfig.baseImagePath}${element.attributes['topBadgeImage']}" alt="${displayName}"/>
						</c:if>
						<c:if test="${not empty element.attributes['leftBadgeImage']}">
							<img src="${contentHostName}${storeConfig.baseImagePath}${element.attributes['leftBadgeImage']}" class="sale" alt="${displayName}"/>
						</c:if>

						<c:if test="${not empty element.attributes['P_LowestSalePrice']}">
							<fmt:parseNumber var="numericLowestSalePriceBdg" type="number" value="${element.attributes['P_LowestSalePrice']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestSalePriceCA']}">
							<fmt:parseNumber var="numericLowestSalePriceBdg" type="number" value="${element.attributes['P_LowestSalePriceCA']}" />
						</c:if>
						<c:if test="${not empty element.attributes['P_LowestPrice'] }">
							<fmt:parseNumber var="numericLowestPriceBdg" type="number" value="${element.attributes['P_LowestPrice']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestPriceCA'] }">
							<fmt:parseNumber var="numericLowestPriceBdg" type="number" value="${element.attributes['P_LowestPriceCA']}" />
						</c:if>

						<%-- sales badge named badge right by endeca though it is on the left side --%>
						<c:if test="${not empty badgeRight && not empty numericLowestSalePriceBdg}">
							<img src="${initialUrl}${badgeRight}" class="cdp-img-badge img-badge-left" alt="sale"/>
						</c:if>
						<%-- urban attitude badge named left though it is on the right --%>
						<c:if test="${not empty badgeLeft}">
							<img src="${initialUrl}${badgeLeft}" class="cdp-img-badge img-badge-right" alt="urban attitude"/>
						</c:if>

						<c:if test="${fn:contains(badgeOnSale,'On Sale') && not empty numericLowestSalePriceBdg}">
							<img src="${initialUrl}/img/sale-overlay.png" class="cdp-img-badge img-badge-right" alt="sale" />
						</c:if>

						<c:if test="${fn:contains(badgeOnSale, 'Clearance')}">
							<img src="${initialUrl}/img/clearance-overlay.png" class="cdp-img-badge img-badge-right" alt="clearance" />
						</c:if>

						<c:set var="imagePath" value="${storeConfig.imagePath}" />
						<c:set var="altImagePath" value="/Images/product/categoryalt/" />
						<c:set var="storeConfigHostName" value="${contentHostName}" />

						<a href="${recordURL}" class="product-link">
							<c:choose>
								<c:when test="${not empty cdpImage}">
									<img src="${storeConfigHostName}${imagePath}${cdpImage}" alt="${displayName}" class="rollover-img img-base" onerror="this.onerror=null;this.src=''" />
								</c:when>
								<c:otherwise>
									<img src="" alt="${displayName}" class="rollover-img img-base" onerror="this.onerror=null;this.src=''" />
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${not empty cdpMouseOverImage}">
									<img src="${storeConfigHostName}${altImagePath}${cdpMouseOverImage}" alt="${displayName}" class="rollover-img img-over" onerror="this.onerror=null;this.src=''" style="display:none;"/>
								</c:when>
								<c:otherwise>
									<img src="" alt="${displayName}" class="rollover-img img-over" onerror="this.onerror=null;this.src=''" style="display:none;"/>
								</c:otherwise>
							</c:choose>
						</a>

						<c:if test="${not fn:contains(badgeOnSale, 'Clearance')}">
							<div class="quick-look-section" data-prodname="${displayName}" tabindex="0">
								<a class="quick-look-click" href="/modals/quickviewmodal.jsp?R=${repositoryId}" title="Opens a quick look modal" aria-label="Opens a quick look modal" aria-hidden="true" tabindex="-1">
									<input type="button" class="quick-look-button" value="QUICK LOOK" tabindex="-1" />
									<span class="offscreen">Opens a quick look modal</span>
								</a>
							</div>
						</c:if>

						<dsp:include page="/cart/cdpAddFavorites.jsp">
							<dsp:param name="record" value="${element}"/>
							<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
							<dsp:param name="refPage" value="cdp" />
							<dsp:param name="prodName" value="${displayName}" />
						</dsp:include>

					</div><%-- .cdp-img-wrapper --%>

					<div class="cdp-item-detail-wrapper">
						<p class="cdp-item-name">
							<a href="${recordURL}">${displayName}</a>
						</p>



						<c:set var="formattedListPrice" value="" />
						<c:set var="formattedSalePrice" value="" />

						<c:if test="${not empty element.attributes['P_LowestSalePrice']}">
							<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${element.attributes['P_LowestSalePrice']}" />
						</c:if>
						<c:if test="${not empty element.attributes['P_LowestPrice'] }">
							<fmt:parseNumber var="numericLowestPrice" type="number" value="${element.attributes['P_LowestPrice']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestSalePriceCA']}">
							<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${element.attributes['P_LowestSalePriceCA']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty element.attributes['P_LowestPriceCA'] }">
							<fmt:parseNumber var="numericLowestPrice" type="number" value="${element.attributes['P_LowestPriceCA']}" />
						</c:if>


						<div class="cdp-item-pricing-options">

							<c:choose>
								<c:when test="${element.records[0].attributes['sku.isPurchaseable'] ne 'true'}">
									<%-- show no price --%>
								</c:when>
								<c:when test="${fn:contains(element.attributes['record.type'],'sectional') && not empty element.attributes['sku.noOfCovers'] && element.attributes['sku.noOfCovers'] gt '0'}">
									<div class="cdp-item-pricing-title">
										<fmt:message key="price.configureForPricing"/>
										<dsp:getvalueof var="showFinancing" value="${false}" />
									</div>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${not empty numericLowestSalePrice && not empty numericLowestPrice && numericLowestSalePrice lt numericLowestPrice }">
											<fmt:parseNumber var="listPrice" value="${numericLowestPrice}"/>
											<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
											<fmt:parseNumber var="numericSalePrice" value="${numericLowestSalePrice}"/>
											<fmt:formatNumber var="formattedSalePrice" value="${numericSalePrice}" type="currency" />
											<c:set var="formattedListPrice" value="${formattedListPrice}" />
											<c:set var="formattedSalePrice" value="${formattedSalePrice}" />
											<dsp:getvalueof var="monthlyPriceRaw" value="${numericSalePrice/digitalBuyFinancingMonths}" />
											<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
												
											<div class="cdp-item-pricing-amount">
                                                <c:if test="${showStartingAtLabel}">
                                                    <div class="cdp-item-pricing-title">
                                                        <fmt:message key="price.startingAt"/>
                                                    </div>
                                                </c:if>

												<div class="cdp-item-pricing" aria-label="Actual Price: ${formattedSalePrice}">
													${formattedSalePrice}
												</div>
											</div>
											<div class="cdp-item-pricing-amount">
												<div class="cdp-item-pricing-title">
													<fmt:message key="price.was"/>
												</div>
												<div class="cdp-item-pricing-was strike" aria-label="Original Price: ${formattedListPrice}">
													${formattedListPrice}
												</div>
											</div>
										</c:when>
										<c:when test="${not empty numericLowestPrice}">
											<fmt:parseNumber var="listPrice" value="${numericLowestPrice}"/>
											<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
											<c:set var="formattedListPrice" value="${formattedListPrice}" />
											<dsp:getvalueof var="monthlyPriceRaw" value="${listPrice/digitalBuyFinancingMonths}" />
											<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
											
											<div class="cdp-item-pricing-amount">
                                                <c:if test="${showStartingAtLabel}">
                                                    <div class="cdp-item-pricing-title">
                                                        <fmt:message key="price.startingAt"/>
                                                    </div>
                                                </c:if>
												<div class="cdp-item-pricing" aria-label="Actual Price: ${formattedSalePrice}">
													${formattedListPrice}
												</div>
											</div>
										</c:when>
									</c:choose>
								</c:otherwise>
							</c:choose>

						</div>
						
						<c:if test="${showFinancing && not empty numericLowestPrice && country != 'CA'}">
							<div class="cdp-monthly-pricing">
								<a href="/content/financing-disclosures" target="_blank">or <span class="monthly-price">$${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
							</div>
						</c:if>
						
						<%-- Display Licensee Shipping indicator if global flag licenseeProductShippingIndicator is set to ture and licenseeProductShippingText is not empty --%>
						<c:if test="${element.attributes['record.type'] eq 'Licensed Sku' && storeConfig.licenseeProductShippingIndicator && not empty storeConfig.licenseeProductShippingText}">
							<div class="cdp-item-licensee-shipping-text">
								${storeConfig.licenseeProductShippingText}
							</div>
						</c:if>

						<div class="cdp-item-compare-checkbox-container">
							<div class="cdp-item-compare-checkbox-inner">
								<span class="checkbox-section-${element.attributes['sku.repositoryId']}" categoryId="${contentItem.categoryId}" productId="${element.attributes['product.repositoryId']}" skuId="${element.attributes['sku.repositoryId']}">
									<dsp:include page="/comparisons/productComparison.jsp">
										<dsp:param name="element" value="${element}"/>
									</dsp:include>
								</span>
							</div>
						</div>
					</div><%-- .cdp-item-detail-wrapper --%>
				</li><%-- .cdp-img-wrapper --%>
				<c:set var="cdpProductListSeparator" value="," />
			</c:otherwise>
			</c:choose>
		</c:if>
	</c:forEach>
</dsp:page>
