<dsp:page>

	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="productId" param="productId"/>
	<dsp:getvalueof var="relatedProductSet" param="relatedProductSet"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />
	<div id="mightAlsoLike" class="pdp-ymal">
	<div style="display:none;">${dealerId }</div>
		<div>
			<div data-module="pdp-carousel" data-slides-to-show="4">
				<div class="wrapper">
					<dsp:droplet name="/com/lzb/droplet/LZBYMLDisplayDroplet">
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

								<div>
									<a href="${recordURL}" data-productname="${element.attributes['sku.displayName']}" data-groupname="">
										<%-- <c:if test="${not empty element.attributes['topBadgeImage']}">
											<img src="${storeConfig.hostName}${storeConfig.imagePath}${element.attributes['topBadgeImage']}"/>
										</c:if> --%>
										<img src="${storeConfig.hostName}${storeConfig.imagePath}${element.attributes['sku.cdpDefaultImage']}"/>
										<%-- <img src="${storeConfig.hostName}${storeConfig.baseThumbailImagePath}${element.attributes['sku.cdpMouseOverImage']}"/>
										<c:if test="${not empty element.attributes['leftBadgeImage']}">
											<img src="${storeConfig.hostName}${storeConfig.imagePath}${element.attributes['leftBadgeImage']}"/>
										</c:if> --%>
									</a>

									<div class="product-info">
									<a href="${recordURL}" data-productname="${element.attributes['sku.displayName']}" data-groupname="">
										<h3>${element.attributes['sku.displayName']}</h3>
										<div class="price">
										<c:choose>
										<c:when test="${element.attributes['isSectional'] eq 'true'}">
											<fmt:message key="price.configureForPricing"/>
										</c:when>
											<c:otherwise>
											<c:choose>
												<c:when test="${not empty element.attributes['P_LowestSalePrice'] && not empty element.attributes['P_LowestPrice']}">
													Starting at
													<fmt:parseNumber var="listPrice" value="${element.attributes['P_LowestPrice']}"/>
													<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
													<fmt:parseNumber var="numericSalePrice" value="${element.attributes['P_LowestSalePrice']}"/>
													<fmt:formatNumber var="formattedSalePrice" value="${numericSalePrice}" type="currency" />
													<strike>${formattedListPrice}</strike><br />
													<strong>${formattedSalePrice}</strong>
												</c:when>
												<c:when test="${not empty element.attributes['P_LowestPrice']}">
													<fmt:parseNumber var="listPrice" value="${element.attributes['P_LowestPrice']}"/>
													<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
													Starting at  <br />
													<strong>${formattedListPrice}</strong>
												</c:when>
											</c:choose>
											</c:otherwise>
										</c:choose>

										</div>
										</a>
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