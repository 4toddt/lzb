<dsp:page>
	<%-- Page Variables --%>
  <dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />

	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<fmt:message var="productPagePath" key="pdp.storePath"/>
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
		<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}" />
		<dsp:getvalueof var="imgPath" param="imgPath"/>
		<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
		<dsp:importbean bean="/com/lzb/droplet/LZBProductDeatilDroplet" var="pddd"/>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
		<dsp:importbean bean="/com/lzb/droplet/LZBInvokeAssemblerDroplet"/>
		<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
		<dsp:importbean bean="/com/lzb/service/SessionBean"/>
		<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
		<dsp:getvalueof var="country" bean="Profile.currentStore.country" />

		<c:set var="recordAttributeMap" value="${record.attributes}"/>
		<c:set var="imagePath" value="/Images/product/category/" />
			<c:set var="storeConfigHostName" value="${storeConfig.hostName}" />
		<c:if test="${empty storeConfigHostName}">
			<c:set var="storeConfigHostName" value="http://${storeConfigHostName}" />
		</c:if>
		<c:set var="contentHostName" value="//content.la-z-boy.com"/>

		<dsp:droplet name="LZBInvokeAssemblerDroplet">
			<dsp:param name="handlerPath" value="RecordDetail"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="contnetItem" vartype="com.endeca.infront.assembler.ContentItem" param="contnetItem" />
			</dsp:oparam>
			 <dsp:oparam name="error">
			 <%-- Error while querying to endeca --%>>
			</dsp:oparam>
		</dsp:droplet>

		<dsp:getvalueof var="record" value="${contnetItem.record}"/>
		<c:set var="recordAttributeMap" value="${record.attributes}"/>
		<dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
		<dsp:droplet name="LZBPDPURLDroplet">
			<dsp:param name="productId" value="${recordAttributeMap['sku.repositoryId']}" />
			<dsp:param name="categorydisplayName" value="${recordAttributeMap['parentCategory.displayName']}" />
			<dsp:param name="prodName" value="${recordAttributeMap['sku.displayName']}" />
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
				<c:set var="recordURL" value="${contextPath}${productPagePath}${element.detailsAction.recordState}"/>
			</c:otherwise>
		</c:choose>

		<c:set var="showStartingAtLabel" value="false"/>
		<c:if test="${recordAttributeMap['record.type'] ne 'Licensed Sku'}">
			<%-- only show starting at label for configurable products --%>
			<c:set var="showStartingAtLabel" value="true"/>
		</c:if>

		<c:set var="imagePath" value="/Images/product/category/" />
		<c:set var="altImagePath" value="/Images/product/categoryalt/" />
		<c:set var="storeConfigHostName" value="${contentHostName}" />
		<c:if test="${empty storeConfigHostName}">
			<c:set var="storeConfigHostName" value="http://${storeConfigHostName}" />
		</c:if>

		<dsp:include page="/browse/pdp/pdpImage.jsp">
			<dsp:param name="productRecord" value="${recordAttributeMap}"/>
		</dsp:include>

		<dsp:getvalueof var="prodId" value="${recordAttributeMap['sku.repositoryId']}" scope="request"/>

		<%-- facebook --%>
		<meta property="og:title" content="${recordAttributeMap['sku.displayName']}"/>
		<meta property="og:type" content="product"/>
		<meta property="og:url" content="${recordURL}"/>
		<meta property="og:site_name" content="La-Z-Boy"/>
		<meta property="og:description" content="${recordAttributeMap['product.longDescription']}"/>
		<meta property="fb:app_id" content="${storeConfig.fbAppId}"/>
		<meta property="og:image" content="${largeImageURLForOGTag}" />
		<meta property="og:image:type" content="image/jpeg" />
		<meta property="og:image:width" content="225" />
		<meta property="og:image:height" content="225" />

		<main class="qv-modal" id="qvModal">
			<div class="qv-panel">

				<c:choose>
						<c:when test="${empty recordAttributeMap['sku.isPurchaseable']}">
								<c:set var="productIsPurchasable" value="false" />
						</c:when>
						<c:otherwise>
								<c:set var="productIsPurchasable" value="${recordAttributeMap['sku.isPurchaseable']}" />
						</c:otherwise>
				</c:choose>
				<c:choose>
		        <c:when test="${empty recordAttributeMap['sku.status']}">
		            <c:set var="productIsActive" value="D" />
		        </c:when>
		        <c:otherwise>
		            <c:set var="productIsActive" value="${recordAttributeMap['sku.status']}" />
		        </c:otherwise>
		    </c:choose>

				<c:choose>
					<%-- Check if Marxent Composer is enabled and template matches --%>
					<c:when test="${(storeConfig.marxentComposerEnabled) && (recordAttributeMap['record.type'] eq 'Configurable SKU') && (productIsPurchasable eq 'true' && productIsActive eq 'A')}">
	            <!-- Purchasable Upholstered Products -->
	            <c:set var="isMarxentImageIntegration" value="true" />
	        </c:when>
					<c:when test="${recordAttributeMap['record.type'] eq 'sectional' && productIsActive eq 'A' }">
	            <!-- Sectionals Products - Active -->
	            <c:set var="isMarxentImageIntegration" value="true" />
	        </c:when>
					<c:otherwise>
						<c:set var="isMarxentImageIntegration" value="false" />
					</c:otherwise>
				</c:choose>

	<%-- Find the FIRST nailhead option, and if it's not null or NN, use as the default for Marxent to use. --%>
	<c:set var="standardNailhead" value="" />
	<%-- Commenting code for default Nailhead on initial page load as it is not working accurately for products where 'none' is pre-selected.
	<c:set var="option" value="${recordAttributeMap['Nail Head Options']}" />
	<c:if test="${not empty option}" >
		<c:set var="optionVal" value="${fn:split(option,'|')[0]}" />
		<c:set var="nailheadSku" value="${fn:split(optionVal,'~')[0]}" />
		<c:if test="${fn:contains(nailheadSku,'_') eq true }" >
			<c:set var="index" value="${fn:indexOf(nailheadSku,'_')}" />
			<c:set var="standardNailhead" value="${fn:substring(nailheadSku, index+1, index+3)}" />
		</c:if>
		<c:if test="${fn:contains(optionVal,'_NN') eq true }">
			<c:set var="standardNailhead" value="" />
		</c:if>
	</c:if>
	 --%>
	
	<c:set var="standardFinish" value="" />
	<%-- Loop through product options for a finish option and set the var to "default" for Marxent to use. --%>
	<c:forEach items="${fn:split(recordAttributeMap['sku.configurableOptionNames'],'|')}" var="parentOptionName">
		<c:set var="foption" value="${recordAttributeMap[parentOptionName]}" />
		<c:forEach items="${fn:split(foption,'++')}" var="subOption" varStatus="i">
			<c:if test="${fn:contains(subOption,'Finish') eq true }">
				<dsp:getvalueof var="standardFinish" value="Default" />
			</c:if>
		</c:forEach>
	</c:forEach>

				<%-- Set defaultCover --%>
				<c:set var="defaultCover" value="${fn:split(recordAttributeMap['sku.defaultCover'],'~')[0]}"/>

				<%-- Define large and xLarge default images --%>
				<c:set var="largeImage" value="${additionalImage[0].largeImage}" />
				<c:set var="xLargeImage" value="${additionalImage[0].XLargeImage}" />

				<meta itemprop="image" content="${largeImage}">

				<div id="pdp-main-image-container" data-imgid="pdp-main-image">
					<%-- START Marxent Integration --%>
					<c:if test="${isMarxentImageIntegration eq 'true'}">
						<c:set var="hideClass" value="hide" />
						<div id="divSpins" data-default-cover="${defaultCover}" data-default-finish="${standardFinish}" data-default-nailhead="${standardNailhead}"></div>
					</c:if>
					<%-- END Marxent Integration --%>
					<div id="pdp-main-image" class="${hideClass}">
						<img src="${largeImage}" data-zoom-image="${xLargeImage}" />
					</div>

					<%-- Render Product Video --%>
					<div class="product-video hide">
						<dsp:include page="/includes/global/videoPlayer.jsp">
							<dsp:param name="loop" value="true"/>
						</dsp:include>
					</div>

					<div class="hide">
						<dsp:include page="${pageContext.request.contextPath}/browse/pdp/imageViewer.jsp">
								<dsp:param name="isMarxentImageIntegration" value="${isMarxentImageIntegration}" />
								<dsp:param name="xLargeImage" value="${xLargeImage}" />
								<dsp:param name="defaultCover" value="${defaultCover}" />
								<dsp:param name="standardFinish" value="${standardFinish}" />
						</dsp:include>
					</div>
				</div>
				<div id="pdp-thumbs-container">
					<%-- include all thumbnail images  --%>
					<dsp:include page="${pageContext.request.contextPath}/browse/pdp/pdpAdditionalImage.jsp">
						<dsp:param name="isMarxentImageIntegration" value="${isMarxentImageIntegration}" />
						<dsp:param name="productRecord" value="${recordAttributeMap}"/>
						<dsp:param name="defaultCover" value="${defaultCover}" />
						<dsp:param name="standardFinish" value="${standardFinish}" />
						<dsp:param name="standardNailhead" value="${standardNailhead}" />
					</dsp:include>
				</div>
			</div>

			<div class="qv-panel">
				<div class="pdp-title">
					<h1>${recordAttributeMap['sku.displayName']}</h1>
				</div>


				<%-- TurnTo mini star rating  --%>
				<div data-module="star-ratings">
					<div class="turnto-star-rating">
						<a href="${recordURL}#customerFeedback" target="_parent">
							<div class="tt-reviews-count">
								<span class="numOfReviews">0</span> reviews
							</div>
							<div class="tt-stars">
								<div class="TTratingBox"></div>
							</div>
						</a>
					</div>

					<script>
						window.turnToCountsEndpoint = 'https://cdn-ws.turnto.com/v5/sitedata/${turnToSiteKey}/${prodId}/d/ugc/counts/en';

						// copying star rating scripts here temporarily, because the module won't run for some reason.
						(function() { // IIFE for namespacing -- star rating teaser
			
							// get JSON data
							$.getJSON(window.turnToCountsEndpoint, function(countsObj) {

								// get rounded average rating and turn into a usable class name
								var r = +countsObj.avgRating + 0.25;
								var avgRating = r - (r % 0.5); // round rating to nearest whole or half (0.5)
								var avgRatingStr = avgRating.toFixed(1).replace('.', '-');
								var ratingClass = 'TTrating-' + avgRatingStr;

								// update the DOM
								var TTratingBoxEl = document.querySelector('.TTratingBox');
								var numOfReviewsEl = document.querySelector('.numOfReviews');
								TTratingBoxEl.classList.add(ratingClass);
								numOfReviewsEl.textContent = countsObj.reviews;
							});
						})();
					</script>
				</div>

				<%-- Quick View pricing --%>
				<c:choose>
					<c:when test="${recordAttributeMap['record.type'] eq 'Configurable SKU' || recordAttributeMap['record.type'] eq 'sectional'}">
						<div class="qv-price-configure">
							<p><fmt:message key="price.configureForPricing"/></p>
						</div>
					</c:when>
					<c:otherwise>
					
						<c:if test="${not empty recordAttributeMap['P_LowestSalePrice']}">
							<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${recordAttributeMap['P_LowestSalePrice']}" />
						</c:if>
						<c:if test="${not empty recordAttributeMap['P_LowestPrice'] }">
							<fmt:parseNumber var="numericLowestPrice" type="number" value="${recordAttributeMap['P_LowestPrice']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty recordAttributeMap['P_LowestSalePriceCA']}">
							<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${recordAttributeMap['P_LowestSalePriceCA']}" />
						</c:if>
						<c:if test="${country eq 'CA' && not empty recordAttributeMap['P_LowestPriceCA'] }">
							<fmt:parseNumber var="numericLowestPrice" type="number" value="${recordAttributeMap['P_LowestPriceCA']}" />
						</c:if>
					
						<c:choose>
							<c:when test="${not empty numericLowestSalePrice && not empty numericLowestPrice}">
								<fmt:parseNumber var="listPrice" value="${numericLowestPrice}"/>
								<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
								<fmt:parseNumber var="numericSalePrice" value="${numericLowestSalePrice}"/>
								<fmt:formatNumber var="formattedSalePrice" value="${numericSalePrice}" type="currency" />

								<div class="qv-price">
									<div class="cdp-item-pricing-amount">
										<c:if test="${showStartingAtLabel}">
											<div class="cdp-item-pricing-title" aria-hidden="true">
												<fmt:message key="price.startingAt"/>
											</div>
										</c:if>
										<div class="cdp-item-pricing" tabindex="0" class="current-pricing" aria-label="Sale Price: ${formattedSalePrice}">
											${formattedSalePrice}
										</div>
									</div>

									<div class="cdp-item-pricing-amount">
										<div class="cdp-item-pricing-title" aria-hidden="true">
											<fmt:message key="price.was"/>
										</div>
										<div class="cdp-item-pricing-was strike" tabindex="0"  aria-label="List Price: ${formattedListPrice}" >
											${formattedListPrice}
										</div>
									</div>
								</div>
							</c:when>
							<c:when test="${not empty numericLowestPrice}">
								<fmt:parseNumber var="listPrice" value="${numericLowestPrice}"/>
								<fmt:formatNumber var="formattedListPrice" value="${listPrice}" type="currency" />
								<div class="qv-price">
									<div class="cdp-item-pricing-amount">
										<c:if test="${showStartingAtLabel}">
											<div class="cdp-item-pricing-title" aria-hidden="true">
												<fmt:message key="price.startingAt"/>
											</div>
										</c:if>
										<div class="cdp-item-pricing" tabindex="0" class="current-pricing" aria-label="List Price: ${formattedSalePrice}">
											${formattedListPrice}
										</div>
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>

				<%-- Product description --%>
				<c:if test ="${not empty recordAttributeMap['sku.longDescription']}">
					<div itemprop="description" class="qv-product-description">
							<dsp:getvalueof var="countcharacter" value="${storeConfig.numberOfCharacterInPDPdescripton}"/>
							<c:set var="descriptonString" value="${fn:substring(recordAttributeMap['sku.longDescription'], 0, countcharacter)}" />
							${descriptonString}...&nbsp;<a href="${recordURL}#prodDetails" class="underline" target="_parent"><fmt:message key="quick.look.read.more" /></a>
					</div>
				</c:if>

				<%-- Product Dimensions --%>
				<%--
				<c:set var="showExterior" value="false" scope="request" />
				<c:set var="showInterior" value="false" scope="request" />
				<c:if test="${not empty recordAttributeMap['sku.exteriorHeight'] || not empty recordAttributeMap['sku.exteriorWidth.prop'] || not empty recordAttributeMap['sku.exteriorDepth']}">
					<c:set var="showExterior" value="true" scope="request" />
				</c:if>
				<c:if test="${not empty recordAttributeMap['sku.interiorHeight'] || not empty recordAttributeMap['sku.interiorWidth'] || not empty recordAttributeMap['sku.interiorDepth']}">
					<c:set var="showInterior" value="true" scope="request" />
				</c:if>
				<c:if test="${showExterior || showInterior}">
					<div class="qv-dimensions">
						<c:if test="${showExterior}">
							<fmt:message key="quick.look.overall.label"/> Size ${recordAttributeMap['sku.exteriorHeight']}" H x ${recordAttributeMap['sku.exteriorWidth.prop']}" W x ${recordAttributeMap['sku.exteriorDepth']}" D<br/>
						</c:if>
						<c:if test="${showInterior}">
							<fmt:message key="quick.look.seat.label"/> Size ${recordAttributeMap['sku.interiorHeight']}" H x ${recordAttributeMap['sku.interiorWidth']}" W x ${recordAttributeMap['sku.interiorDepth']}" D<br/>
						</c:if>
					</div>
				</c:if>
				--%>

				<%-- Quick View covers --%>
				<c:if test="${not empty recordAttributeMap['sku.cover']}">
					<div class="qv-most-popular-covers">
						<h4>Most Popular Covers</h4>
						<ul class="qv-color-wrapper">
							<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
								<dsp:param name="defaultSkuCover" value="${recordAttributeMap['sku.defaultCover']}" />
								<dsp:param name="skuCoverList" value="${recordAttributeMap['sku.cover']}" />
								<dsp:param name="isQuickLook" value="true" />
								<dsp:oparam name="output">
									<dsp:getvalueof param="coverOptionList" var="coverOptionList" />
									<c:forEach var="colorSwatch" items="${coverOptionList}" begin="0" end="9" varStatus="status">
										<c:choose>
											<c:when test="${status.index eq 0}">
												<c:set var="swatchActiveClass" value="color-swatch-active"/>
											</c:when>
											<c:otherwise>
												<c:set var="swatchActiveClass" value=""/>
											</c:otherwise>
										</c:choose>
										<li class="${swatchActiveClass}">
										<c:set var="coverArr" value="${fn:split(colorSwatch,'~')}"/>
										<c:set var="map" value="${coverArr[1]}"/>
										<a class="coverskuid"  href="${recordURL}?coverId=${coverArr[0]}" title="${coverArr[1]}"
											data-cover-type="${coverArr[1]}" data-cover-pattern="${coverArr[1]}" data-cover-color-family="${coverArr[1]}" data-skuid="${recordAttributeMap['sku.repositoryId']}"
											data-productid="${recordAttributeMap['product.repositoryId']}" data-dealerid="${dealerId}"
											data-cover-price-grade="${priceGrade.key}" title="${coverArr[0]}"
											data-coverid="${coverArr[0]}" data-type="cover" data-vnt="${recordAttributeMap['product.vnt']}" >
											<img src="${contentHostName}${storeConfig.coverThumbnailBaseUrl}${coverArr[0]}.jpg" height="50" width="50" alt="${coverArr[1]}"/>
										</a>
										<meta itemprop="image" content="${contentHostName}${storeConfig.coverThumbnailBaseUrl}${coverArr[0]}.jpg" />
										</li>
									</c:forEach>
								</dsp:oparam>
							</dsp:droplet>
						</ul>
					</div>

					<div class="qv-options-available">
						<a href="${recordURL}">${recordAttributeMap['sku.noOfCovers']}&nbsp;<fmt:message key="quick.look.options.available"/></a>
					</div>
				</c:if>

				<%-- Quick View button row --%>
				<div class="customize-wishlist">
					<a href="${recordURL}" class="customize-it" target="_parent" tabindex="-1">
						<button class="button primary-btn" tabindex="0">
							<c:choose>
								<c:when test="${recordAttributeMap['record.type'] ne 'Configurable SKU' && recordAttributeMap['record.type'] ne 'sectional'}">
									<fmt:message key="quick.look.productDetails"/>
								</c:when>
								<c:otherwise>
									<fmt:message key="quick.look.customise.it"/>
								</c:otherwise>
							</c:choose>
						</button>
					</a>
					<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
					<div class="pdp-icons-row">

						<dsp:getvalueof var="skuId" value="${recordAttributeMap['sku.repositoryId']}"/>
						<dsp:getvalueof var="productId" value="${recordAttributeMap['product.repositoryId']}"/>
						<dsp:getvalueof var="prodDisplayName" value="${recordAttributeMap['sku.displayName']}"/>
						<dsp:getvalueof var="coverNo" value="${recordAttributeMap['defaultCoverSku']}"/>

						<div class="share-icons qv-social-share">
							<ul class="share-list" data-pdptype="configurable">

									<%-- old add to favorites  --%>
									<%-- <span class="cdp-wishlist quickview" data-skuid="${recordAttributeMap['sku.repositoryId']}"
								data-prodname="${recordAttributeMap['sku.displayName']}"
								data-productid="${recordAttributeMap['product.repositoryId']}"
								data-DefaultCover="${recordAttributeMap['defaultCoverSku']}"
								data-dealerid="${dealerId}" data-coverid="${recordAttributeMap['defaultCoverSku']}">
									<img src="/img/heart.png" class="heart" alt="heart icon"/>
								<a href="#"><fmt:message key="compare.add.wishlit"/></a></span> --%>

								<%-- JIRA DMI-1763 Hide Wishlist UI
								<li>
									<a class="pdp-favorite add-to-wishlist" data-pdptype="configurable">
										<dsp:include page="/cart/cdpAddFavorites.jsp">
											<dsp:param name="record" value="${recordAttributeMap }"/>
											<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
											<dsp:param name="refPage" value="quickView" />
											<dsp:param name="prodName" value="${prodDisplayName}" />
										</dsp:include>
										<input id="wishlistinfoId" type="hidden" name="wishlistinfo"	value="" />
									</a>
								</li>
								--%>
								<li>
									<a class="icon-share social-share-click" alt="Share icon" tabindex="0"></a>
								</li>
							</ul>

							<ul class="pdp-social-bubble">
								<li>
									<a href="https://www.facebook.com/lazboy" data-service="facebook" data-sharesku="${recordAttributeMap['sku.repositoryId']}" title="Facebook">
											<%-- <img width="36" height="35" src="//content.la-z-boy.com/Images/elementsImages/share_fb.png" alt="Like on Facebook"> --%>
										<img src="//${storeConfig.contentHostName}/Images/social-share-icons/fb-share-button-35h.png" alt="Like on Facebook" />
									</a>
								</li>
								<li>
									<a href="https://twitter.com/intent/tweet" data-service="twitter" data-sharesku="${recordAttributeMap['sku.repositoryId']}?WT.mc_id=sharedfromsite" title="Twitter"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Twit.png" alt="Twitter"></a>
								</li>
								<li>
									<dsp:a href="${contextPath}/global/includes/shareThisProduct.jsp" target="_parent"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List">
										<dsp:param name="prodId" value="${productId}"/>
										<dsp:param name="ProdName" value="${prodDisplayName}"/>
										<dsp:param name="skuId" value="${skuId}"/>
										<dsp:param name="coverId" value="${coverNo}"/>
									</dsp:a>
								</li>
							</ul>
						</div>
					</div>
				</div>

				<c:if test="${recordAttributeMap['record.type'] ne 'Licensed Sku'}">
					<div class="view-details">
						<a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" target="_parent">
							<fmt:message key="quick.look.see.in.store"/>
						</a>
					</div>
				</c:if>
			</div>

		</main>



	</dsp:layeredBundle>

</dsp:page>
