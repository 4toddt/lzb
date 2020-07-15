<dsp:page>

	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/TableForEach"/>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/common/LZBBVConfiguration" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="hostName" value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="reviewUrl" bean="LZBBVConfiguration.reviewUrl" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="numberOfProduct" bean="ProductList.count" />
	<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="${cotextPath}/account/wish_list_items.jsp"/>
	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="${cotextPath}/comparisons/compare.jsp"/>

	<lzb:pageContainer>
		<jsp:attribute name="pageSpecificJS">
			<script type="text/javascript" src="https://${reviewUrl}"></script>
		</jsp:attribute>
		<jsp:attribute name="bodyClass">cdp dir="ltr" role="document"</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:body>

			<main role="main" class="cdp-compare-main">

				<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
				<div class="title">
					<h1><fmt:message key="compare.heading"/></h1>
					<a href="#" class="browser-back"><fmt:message key="compare.prevpage.link"/></a><span class="vert-spacer"> | </span><a href="javascript:window.print()">Print</a>
					<c:if test="${ numberOfProduct lt 2 }">
						<br> You must select at least 2 items to compare.
					</c:if>
				</div>

				<c:if test="${ numberOfProduct ge 2 }">

					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="GiftlistFormHandler" />
					</dsp:include>
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProductListHandler" />
					</dsp:include>

					<dsp:droplet name="TableForEach">
						<dsp:param bean="ProductList.items" name="array"/>
						<dsp:param name="numColumns" value="${numberOfProduct}"/>
						<dsp:oparam name="outputStart"><table data-module="cdpCompare" aria-label="product comparison table"></dsp:oparam>
						<dsp:oparam name="outputEnd"></table></dsp:oparam>
						<dsp:oparam name="outputRowStart">
							<thead class="compare-frozen-header">
								<tr>
						</dsp:oparam>

						<dsp:oparam name="output">
							<dsp:getvalueof var="count" param="count" />
							<dsp:getvalueof var="skuId" param="element.sku.repositoryId" />
							<dsp:getvalueof var="productId" param="element.product.repositoryId" />
							<dsp:getvalueof var="categoryId" param="element.category.repositoryId" />
							<dsp:getvalueof var="priceInfo" param="element.priceInfo" />
							<dsp:getvalueof var="ratingCount" param="element.product.rating" />
							<dsp:getvalueof var="reviewCount" param="element.product.reviewCount" />
							<dsp:getvalueof var="entriesId" param="element.id" />
							<dsp:getvalueof var="imgurl" param="element.imageLink" />
							<dsp:getvalueof var="pdpPageUrl" param="element.productLink" />
							<dsp:getvalueof var="element" param="element" />

									<td>
										<div>
											<a href="#" class="remove-comparepage-item ${entriesId}" role="button" data-entryIds="${entriesId}">
												<img src="/img/compare-remove-red.png" alt="Remove Item" />
												<span><fmt:message key="compare.removeitem"/></span>
											</a>
										</div>
										<div>
											<a href="${pageContext.request.contextPath}${pdpPageUrl}" aria-label="product link">
												<img src="${storeConfig.hostName}${storeConfig.baseImagePath}${element.CDPDefaultImage}" class="compare-img" alt="" />
											</a>
										</div>
										<div>
											<p>
												<a href="${pageContext.request.contextPath}${pdpPageUrl}">
													<dsp:valueof param="element.product.displayName"/>
												</a>
											</p>
											<p class="cdp-item-stars" data-star-value="${ratingCount}" aria-label="${ratingCount} stars" tabindex="0">
												<fmt:parseNumber value="${ratingCount}" type="NUMBER" var="starvalue" />
												<c:choose>
													<c:when test="${empty starvalue || starvalue le 0.0}">
											            <div class="TTratingBox TTrating-0-0">
											          </c:when>
													<c:when test="${starvalue gt 0.0 && starvalue le 0.6}">
														<div class="TTratingBox TTrating-0-5">
													</c:when>
													<c:when test="${starvalue gt 0.5 && starvalue le 1.1}">
														<div class="TTratingBox TTrating-0-1">
													</c:when>
													<c:when test="${starvalue gt 1.0 && starvalue le 1.6}">
														<div class="TTratingBox TTrating-1-5">
													</c:when>
													<c:when test="${starvalue gt 1.5 && starvalue le 2.1}">
														<div class="TTratingBox TTrating-2-0">
													</c:when>
													<c:when test="${starvalue gt 2.0 && starvalue le 2.6}">
														<div class="TTratingBox TTrating-2-5">
													</c:when>
													<c:when test="${starvalue gt 2.5 && starvalue le 3.1}">
														<div class="TTratingBox TTrating-3-0">
													</c:when>
													<c:when test="${starvalue gt 3.0 && starvalue le 3.6}">
														<div class="TTratingBox TTrating-3-5">
													</c:when>
													<c:when test="${starvalue gt 3.5 && starvalue le 4.1}">
														<div class="TTratingBox TTrating-4-0">
													</c:when>
													<c:when test="${starvalue gt 4.0 && starvalue le 4.6}">
														<div class="TTratingBox TTrating-4-5">
													</c:when>
													<c:when test="${starvalue gt 4.5 && starvalue le 5.0}">
														<div class="TTratingBox TTrating-5-0">
													</c:when>
												</c:choose>
												<span class="compare-reviews" aria-label="${reviewCount} reviews" tabindex="0">(${reviewCount} reviews)</span>
												<%-- <c:if test="${not empty reviewCount}">
													<span class="compare-reviews" aria-label="${reviewCount} reviews" tabindex="0">(${reviewCount} reviews)</span>
												</c:if> --%>
												</div>
											</p>
											<p>
												<c:if test="${(not empty priceInfo.listPrice && priceInfo.listPrice gt '0.00') || (not empty priceInfo.salePrice && priceInfo.salePrice gt '0.00')}">
													<c:set var="ariaPrice" value="Price as low as ${priceInfo.listPrice}" />
													<c:if test="${priceInfo.salePrice gt 0.0}">
														<c:set var="ariaPrice" value="Price reduced from ${priceInfo.listPrice} to ${priceInfo.salePrice}" />
													</c:if>
													<span aria-label="${ariaPrice}" tabindex="0">
														<span aria-hidden="true">
															<fmt:message key="compare.aslowas"/>
															<dsp:include page="/global/gadgets/priceLookup.jsp">
																<dsp:param name="listPrice" value="${priceInfo.listPrice}"/>
																<dsp:param name="salePrice" value="${priceInfo.salePrice}"/>
															</dsp:include>
														</span>
													</span>
												</c:if>
											</p>
										</div>
									</td>
						</dsp:oparam>
						<dsp:oparam name="outputRowEnd">
								</tr>
							</thead>
							<tbody>
								<dsp:droplet name="/com/lzb/droplet/LZBProductOptionDroplet">
									<dsp:oparam name="output">
										<dsp:getvalueof param="productInfo" var="productInfo"/>
										<dsp:getvalueof param="option" var="option"/>
										<dsp:getvalueof param="urlparam" var="urlparam"/>
										<dsp:getvalueof param="jsonString" var="jsonString"/>
										<tr>
											<dsp:include page="/comparisons/gadgets/customizedIt.jsp">
												<dsp:param name="jsonString" param="jsonString"/>
												<dsp:param name="urlparam" param="urlparam"/>
											</dsp:include>
										</tr>

										<dsp:droplet name="/atg/dynamo/droplet/ForEach">
											<dsp:param name="array" param="productInfo" />
											<dsp:oparam name="output">
												<dsp:getvalueof var="key" param="key"/>
												<dsp:getvalueof var="listStringinfos" param="element"/>
												<tr><td colspan="${numberOfProduct}" scope="row"><dsp:valueof param="key" /></td></tr>
												<tr>
													<c:forEach var="listStringinfo" items="${listStringinfos}" varStatus="status">
														<td>
															<ul>
																<li>
																	<c:choose>
																		<c:when test="${ key eq 'Covers' && not empty listStringinfo}">
																			<dsp:param name="indexvalue" value="${status.count-1}"/>
																			<dsp:getvalueof var="pdpurl" param="urlparam[param:indexvalue]"/>
																			<a href="${cotextPath}${pdpurl}">${listStringinfo}&nbsp;<fmt:message key="compare.available.cover"/></a>
																		</c:when>
																		<c:otherwise>
																			${listStringinfo}
																		</c:otherwise>
																	</c:choose>
																</li>
															</ul>
														</td>
													</c:forEach>
												</tr>
											</dsp:oparam>
										</dsp:droplet>

										<!--   iterating option -->
										<dsp:droplet name="/atg/dynamo/droplet/ForEach">
											<dsp:param name="array" param="option" />
											<dsp:oparam name="output">
												<tr>
													<td colspan="${numberOfProduct}" scope="row"><dsp:valueof param="key" /></td>
												</tr>
												<dsp:getvalueof var="listString" param="element"/>
												<tr>
													<c:forEach var="listStr" items="${listString}" varStatus="status">
														<td>
															<ul>
																<c:forEach var="listStr2" items="${listStr}" varStatus="status">
																	<li>${listStr2}</li>
																</c:forEach>
															</ul>
														</td>
													</c:forEach>
												</tr>
											</dsp:oparam>
										</dsp:droplet>

										<tr>
											<dsp:include page="/comparisons/gadgets/customizedIt.jsp">
											<dsp:param name="jsonString" param="jsonString"/>
												<dsp:param name="urlparam" param="urlparam"/>
											</dsp:include>
										</tr>
									</dsp:oparam>
								</dsp:droplet>
							</tbody>
						</dsp:oparam>
					</dsp:droplet>
				</c:if>

				<dsp:form name="addItemToWishList" id="addItemToWishList" method="post" action="${cotextPath}/comparisons/compare.jsp">
					<dsp:input type="text" bean="GiftlistFormHandler.catalogRefIds" type="hidden" value="" id="addcatalogRefId" />
					<input type="hidden" value="" id="addIdItemInfo" name="iteminfo" />
					<dsp:input type="text" bean="GiftlistFormHandler.productId" type="hidden" value="" id="addIdproductIdwishList" />
					<dsp:input type="submit" bean="GiftlistFormHandler.addItemToWishlist" type="hidden" value="true" />
					<input type="hidden" value="true" id="compare" name="compare" />
				</dsp:form>

			</main>

		</jsp:body>
	</lzb:pageContainer>

</dsp:page>
