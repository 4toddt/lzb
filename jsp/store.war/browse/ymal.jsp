<dsp:page>

	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="productId" param="productId"/>
	<dsp:getvalueof var="relatedProductSet" param="relatedProductSet"/>
	<dsp:getvalueof var="displayMessage" param="displayMessage"/>
	<dsp:getvalueof var="cartRequest" param="cartRequest"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />
	<dsp:getvalueof var="numToShow" param="numToShow" /><%-- param number of data-slides-to-show --%>
	<dsp:getvalueof var="numToScroll" param="numToScroll" />
	<c:choose>
				<c:when test="${cartRequest eq true}">
					<c:set var="class" value="cart-ymal" />
				</c:when>
				<c:otherwise>
					<c:set var="class" value="pdp-ymal pdp-block-container" />
				</c:otherwise>
			</c:choose>
	<div id="mightAlsoLike" class="${class}">
		<div style="display:none;">${dealerId }</div>
		<h3 class="section-heading">${displayMessage}</h3>
		<div>
			<div data-module="pdp-carousel" data-slides-to-show="${numToShow}" data-slides-to-scroll="4"
				<c:if test="${not empty numToScroll}">
					data-slides-to-scroll="${numToScroll}"
				</c:if>
			>
				<div class="wrapper" data-module="detail-resize rollover-img">
					<dsp:droplet name="/com/lzb/droplet/LZBYMLDisplayDroplet">
						<dsp:param name="productId" value="${productId}" />
						<dsp:param name="relatedProductSet" value="${relatedProductSet}" />
						<dsp:param name="dealerId" value="${dealerId}" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="records" param="records"/>
							<c:forEach var="element" items="${records}" varStatus="status">
								<dsp:droplet name="LZBPDPURLDroplet">
									<dsp:param name="productId" value="${element.attributes['sku.repositoryId']}" />
									<dsp:param name="prodName" value="${element.attributes['sku.displayName']}" />
									<dsp:param name="fromCDP" value="true" />
									<dsp:param name="elementName" value="url" />
									<dsp:oparam name="output">
										<dsp:getvalueof var="recordURL" param="url"/>
									</dsp:oparam>
								</dsp:droplet>

								<c:set var="showStartingAtLabel" value="false"/>
                                <c:if test="${element.attributes['record.type'] ne 'Licensed Sku'}">
                                    <%-- only show starting at label for configurable products --%>
                                    <c:set var="showStartingAtLabel" value="true"/>
                                </c:if>

								<div>
									<div class="cdp-img-wrapper">
										<a href="${recordURL}" class="product-link" data-productname="${element.attributes['sku.displayName']}" data-groupname="" tabindex="0">
											<img src="${storeConfig.hostName}${storeConfig.imagePath}${element.attributes['sku.cdpDefaultImage']}" class="rollover-img img-base" onerror="this.onerror=null;this.src=''"/>
											<img src="" alt="${element.attributes['sku.displayName']}" class="rollover-img img-over" onerror="this.onerror=null;this.src=''" style="display:none;"/>
										</a>
										<div class="quick-look-section" data-module="cbox" data-prodname="${element.attributes['sku.displayName']}">
											<a href="/modals/quickviewmodal.jsp?R=${element.attributes['sku.repositoryId']}" class="cboxElement" title="Opens a quick look modal" aria-label="Opens a quick look modal">
												<input type="button" class="quick-look-button" value="QUICK LOOK" tabindex="-1" />
												<span class="offscreen">Opens a quick look modal</span>
											</a>
										</div>
									</div>
									<div class="cdp-item-detail-wrapper">
										<p class="cdp-item-name">
											<a href="${recordURL}" data-productname="${element.attributes['sku.displayName']}" data-groupname="" tabindex="0">${element.attributes['sku.displayName']}</a>
										</p>
										<div class="cdp-item-pricing-options">
											<c:choose>
												<c:when test="${element.attributes['isSectional'] eq 'true'}">
													<div class="cdp-item-pricing-title">
														<fmt:message key="price.configureForPricing"/>
													</div>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${not empty element.attributes['P_LowestSalePrice'] && not empty element.attributes['P_LowestPrice']}">
															<fmt:parseNumber var="listPrice" value="${element.attributes['P_LowestPrice']}"/>
															<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
															<fmt:parseNumber var="numericSalePrice" value="${element.attributes['P_LowestSalePrice']}"/>
															<fmt:formatNumber var="formattedSalePrice" value="${numericSalePrice}" type="currency" />
															<div class="cdp-item-pricing-amount">
                                                                <c:if test="${showStartingAtLabel}">
                                                                    <div class="cdp-item-pricing-title">
                                                                        <fmt:message key="price.startingAt"/>
                                                                    </div>
                                                                </c:if>
                                                                <div class="cdp-item-pricing" tabindex="0" aria-label="Actual Price: ${formattedSalePrice}">${formattedSalePrice}</div>
														  </div>
														  <div class="cdp-item-pricing-amount">
														    <div class="cdp-item-pricing-title">
																	<fmt:message key="price.was"/>
																</div>
														    <div class="cdp-item-pricing-was strike" tabindex="0" aria-label="Original Price: ${formattedListPrice}">${formattedListPrice}</div>
														  </div>
														</c:when>
														<c:when test="${not empty element.attributes['P_LowestPrice']}">
															<fmt:parseNumber var="listPrice" value="${element.attributes['P_LowestPrice']}"/>
															<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
															<div class="cdp-item-pricing-amount">
                                                                <c:if test="${showStartingAtLabel}">
                                                                    <div class="cdp-item-pricing-title">
                                                                        <fmt:message key="price.startingAt"/>
                                                                    </div>
                                                                </c:if>
                                                                <div class="cdp-item-pricing" tabindex="0" aria-label="Actual Price: ${formattedListPrice}">${formattedListPrice}</div>
														  </div>
														</c:when>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</div><%-- .price --%>
									</div>
								</div>

							</c:forEach>
						</dsp:oparam>
						<dsp:oparam name="empty"></dsp:oparam>
					</dsp:droplet>
				</div>
			</div>
		</div>
	</div>
</dsp:page>