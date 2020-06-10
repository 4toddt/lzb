<%--
	- File Name: productTile.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page lays out a product tile
	- Required Parameters:
		- record: single product record
	- Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean var="storeConfig" bean="/atg/store/LZBStoreConfiguration"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="record" param="record" />
	<c:set var="repositoryId" value="${record.attributes['sku.repositoryId']}"/>
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>
	<c:set var="imagePath" value="${storeConfig.imagePath}" />
	<c:set var="productPagePath" value="${storeConfig.mobileProductUrl}" />
    <c:set var="showStartingAtLabel" value="false"/>
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />
    <c:set var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />

	<c:choose>
		<c:when test="${fn:contains(record.attributes['record.type'],'sectional')}">
			<c:set var="cdpImage" value="${record.attributes['product.cdpImage']}"/>
			<c:set var="cdpMouseOverImage" value="${record.attributes['product.cdpAltImage']}"/>
			<c:set var="displayName" value="${record.attributes['product.displayName']}"/>
		</c:when>
		<c:otherwise>
			<c:set var="cdpImage" value="${record.attributes['sku.cdpDefaultImage']}"/>
			<c:set var="cdpMouseOverImage" value="${record.attributes['sku.cdpMouseOverImage']}"/>
			<c:set var="displayName" value="${record.attributes['sku.displayName']}"/>
			<c:set var="categorydisplayName" value="${record.attributes['parentCategory.displayName']}"/>
		</c:otherwise>
	</c:choose>

    <c:if test="${record.attributes['record.type'] ne 'Licensed Sku'}">
        <%-- only show starting at label for configurable products --%>
        <c:set var="showStartingAtLabel" value="true"/>
    </c:if>

	<dsp:droplet name="LZBPDPURLDroplet">
		<dsp:param name="productId" value="${repositoryId}" />
		<dsp:param name="categorydisplayName" value="${categorydisplayName}" />
		<dsp:param name="prodName" value="${displayName}" />
		<dsp:param name="fromCDP" value="true" />
		<dsp:param name="isMobile" value="true" />
		<dsp:param name="elementName" value="url" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="pdpurl" param="url"/>
		</dsp:oparam>
	</dsp:droplet>

	<c:choose>
		<c:when test="${not empty pdpurl}">
			<c:set var="recordURL" value="${contextPath}${pdpurl}"/>
		</c:when>
		<c:otherwise>
			<c:set var="recordURL" value="${contextPath}${productPagePath}${record.detailsAction.recordState}"/>
		</c:otherwise>
	</c:choose>


	<%-- START: Product Tile --%>
	<div class="product-tile">
		<%-- START: Product Image --%>
		<div class="product-image">
			<%-- START: Product Badge --%>
			<c:set var="badgeOnSale" value="${record.attributes['onSale']}" />
			<c:set var="badgeLeft" value="${record.attributes['sku.badge.left']}" />
			<c:if test="${not empty record.attributes['P_LowestSalePrice']}">
				<fmt:parseNumber var="numericLowestSalePriceBdg" type="number" value="${record.attributes['P_LowestSalePrice']}" />
			</c:if>
			<c:if test="${country eq 'CA' && not empty record.attributes['P_LowestSalePriceCA']}">
				<fmt:parseNumber var="numericLowestSalePriceBdg" type="number" value="${record.attributes['P_LowestSalePriceCA']}" />
			</c:if>

			<%-- top left badge: sale --%>
			<c:if test="${(fn:contains(badgeOnSale, 'On Sale') && not empty numericLowestSalePriceBdg) && record.attributes['record.type'] ne 'sectional'}">
				<%-- NOTE: DMI-2094: do not show sale badge for sectional since pricing is not displayed yet on mobile. --%>
				<div class="badge badge-top-left">
					<a href="${recordURL}">
						<img src="${assetPath}/images/badges/sale.png" alt="sale">
					</a>
				</div>
			</c:if>
			<%-- top left badge: clearance --%>
			<c:if test="${(fn:contains(badgeOnSale, 'Clearance')) && record.attributes['record.type'] ne 'sectional'}">
				<%-- NOTE: DMI-2094: do not show sale badge for sectional since pricing is not displayed yet on mobile. --%>
				<div class="badge badge-top-left">
					<a href="${recordURL}">
						<img src="${assetPath}/images/badges/clearance.png" alt="clearance">
					</a>
				</div>
			</c:if>
			<%-- bottom left badge: collections; reference JIRA DMI-1717 for sku.badge.left logic --%>
			<c:if test="${not empty badgeLeft}">
				<div class="badge badge-bottom-left">
					<a href="${recordURL}">
						<img src="${contentHostName}${badgeLeft}" alt="product badge">
					</a>
				</div>
			</c:if>
			<%-- END: Product Badge --%>

			<%-- Product Add To Wishlist --%>
			<%-- Commenting out Wishlist functionality until it can be re-written in a later project.
			<dsp:include page="/browse/includes/addToWishlist.jsp">
				<dsp:param name="record" value="${record}"/>
				<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
				<dsp:param name="refPage" value="cdp" />
				<dsp:param name="prodName" value="${displayName}" />
			</dsp:include>
			--%>

			<%-- Product Quick View --%>
			<%-- Quick View has not been setup in rwd.war. Commenting out incase of future itegration. --%>
			<%-- <a href="../browse/ajax/quickViewModal.jsp" class="modal-trigger button button-quickview" data-target="modal-quickview">
				Quick View
				<span class="sr-only">Opens a quick view modal</span>
			</a> --%>

			<%-- Product Display Image --%>
			<a class="main-image" href="${recordURL}">
			
				<dsp:droplet name="/com/lzb/commerce/droplet/LZBImagePathDroplet">
				<dsp:param name="imPath" value="${cdpImage}" />
					<dsp:oparam name="output">
					   	<dsp:getvalueof var="smallImUrl" param="smallImgUrl"/>
					   	<dsp:getvalueof var="mediumImUrl" param="mediumImgUrl"/>
					   	<dsp:getvalueof var="defaultImUrl" param="defaultImgUrl"/>
					   	    <picture>
								<!--[if IE 9]><video style="display: none;"><![endif]-->
								<source srcset="//${smallImUrl}" media="(min-width: 246px) and (max-width: 380px)">
								<source srcset="//${mediumImUrl}" media="(min-width: 381px) and (max-width: 640px)">
								<!--[if IE 9]></video><![endif]-->
								<img src="//${defaultImUrl}" alt="${displayName}" id="${cdpImage}"/>
							</picture>
					   
					</dsp:oparam>
					<dsp:oparam name="empty">
					</dsp:oparam>
				</dsp:droplet>			
				
			</a>
		</div>
		<%-- END: Product Image --%>

		<div class="product-details-container">
			<%-- Product Name --%>
			<div class="product-name">
				<a href="${recordURL}">${displayName}</a>
			</div>

			<%-- START: Product Price --%>
			<fmt:parseNumber var="listPrice" value="${record.attributes['P_LowestPrice']}"/>
			<c:if test="${country eq 'CA' && not empty record.attributes['P_LowestPriceCA']}" >
				<fmt:parseNumber var="listPrice" value="${record.attributes['P_LowestPriceCA']}"/>
			</c:if>
			<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
			<fmt:parseNumber var="numericSalePrice" value="${record.attributes['P_LowestSalePrice']}"/>
			<c:if test="${country eq 'CA' && not empty record.attributes['P_LowestSalePriceCA']}" >
				<fmt:parseNumber var="numericSalePrice" value="${record.attributes['P_LowestSalePriceCA']}"/>
			</c:if>
			<fmt:formatNumber var="formattedSalePrice" value="${numericSalePrice}" type="currency" />
			<fmt:message key="price.ariaLabel.salePrice" var="labelSalePrice"/>
			<fmt:message key="price.ariaLabel.originalPrice" var="labelOriginalPrice"/>
			<fmt:message key="price.ariaLabel.startingPrice" var="labelStartingPrice"/>

			<c:if test="${not empty numericSalePrice && not empty listPrice}">
				<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${numericSalePrice}" />
				<fmt:parseNumber var="numericLowestPrice" type="number" value="${listPrice}" />
			</c:if>

			<c:choose>
				<c:when test="${record.records[0].attributes['sku.isPurchaseable'] ne 'true'}">
					<%-- show no price --%>
				</c:when>
				<c:when test="${fn:contains(record.attributes['record.type'],'sectional') && not empty record.attributes['sku.noOfCovers'] && record.attributes['sku.noOfCovers'] gt '0'}">
					<%-- DMI-2092: Remove pricing label for sectional since they are not configurable yet on mobile.
					<div class="price">
						<div class="regular-label">
							<fmt:message key="price.configureForPricing"/>
						</div>
					</div>
					--%>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${not empty numericSalePrice && not empty listPrice && numericLowestSalePrice lt numericLowestPrice}">
							<%-- Display Sale Price --%>
							<div class="price">
								<div class="side-by-side">
									<div class="right">
                                        <c:if test="${showStartingAtLabel}">
                                            <div class="sale-label">
                                                <fmt:message key="price.startingAt"/>
                                            </div>
                                        </c:if>
										<div class="sale-price" aria-label="${labelSalePrice} ${formattedSalePrice}">
											${formattedSalePrice}
										</div>
									</div>
								</div>
								<div class="side-by-side">
									<div class="left">
										<div class="original-label">
											<fmt:message key="price.was"/>
										</div>
										<div class="original-price" aria-label="${labelOriginalPrice} ${formattedListPrice}">
											${formattedListPrice}
										</div>
									</div>
								</div>
							</div>
							<c:if test="${country != 'CA'}">
								<div class="cdp-monthly-pricing">
									<dsp:getvalueof var="monthlyPriceRaw" value="${numericSalePrice/digitalBuyFinancingMonths}" />
									<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
								
									<a href="/content/financing-disclosures" target="_blank">or <span class="monthly-price">$${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
								</div>
							</c:if>
						</c:when>
						<c:when test="${not empty listPrice}">
							<dsp:getvalueof var="monthlyPriceRaw" value="${listPrice/digitalBuyFinancingMonths}" />
							<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
											
							<%-- Display Starting Price --%>
							<div class="price">
                                <c:if test="${showStartingAtLabel}">
                                    <div class="regular-label">
                                        <fmt:message key="price.startingAt"/>
                                    </div>
                                </c:if>
								<div class="regular-price" aria-label="${labelStartingPrice} ${formattedListPrice}">
									${formattedListPrice}
								</div>
							</div>
							<c:if test="${country != 'CA'}">
								<div class="cdp-monthly-pricing">
									<a href="/content/financing-disclosures" target="_blank">or <span class="monthly-price">$${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
								</div>
							</c:if>
						</c:when>
						<c:otherwise>
							<%-- Display No Price --%>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			<%-- END: Product Price --%>
			
			<%-- Display Licensee Shipping indicator if global flag licenseeProductShippingIndicator is set to ture and licenseeProductShippingText is not empty --%>
			<c:if test="${record.attributes['record.type'] eq 'Licensed Sku' && storeConfig.licenseeProductShippingIndicator && not empty storeConfig.licenseeProductShippingText}">
				<div class="cdp-item-licensee-shipping-text">
					${storeConfig.licenseeProductShippingText}
				</div>
			</c:if>
		</div>
	</div>
	<%-- END: Product Tile --%>
</dsp:page>