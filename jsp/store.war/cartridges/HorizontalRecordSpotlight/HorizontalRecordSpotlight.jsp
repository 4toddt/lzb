<%--
  This page lays out the elements that make up the Endeca driven horizontal spotlight.

  Required Parameters:
    None.

  Optional Parameters:
    None.
--%>
<dsp:page>
	<%-- 
	</section>
	--%>
	<%-- .shop-by have to include this here because there isn't a cartridge that wraps both ShopByRoom and ShopByStyle.  starts in HomePageCarouselContentSlot.jsp --%>
	<section class="top-sellers" id="mightAlsoLike">
		<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/multisite/Site"/>
		<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
		<dsp:getvalueof var="contextPath" bean="Site.contextRoot"/>
		<dsp:importbean bean="/atg/search/droplet/GetClickThroughId" />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
		<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet"/>
		<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

		<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

		<c:if test="${not empty contentItem.records}">
			<c:set var="columnCount" value="4" />
			<c:set var="recordsCount" value="${fn:length(contentItem.records)}" />
			<c:set var="recordsCountDiff" value="${4 - recordsCount}" />

			<c:set var="imagePath" value="/Images/product/category/" />
			<c:set var="storeConfigHostName" value="${storeConfig.hostName}" />
			<c:if test="${empty storeConfigHostName}">
				<c:set var="storeConfigHostName" value="http://${storeConfigHostName}" />
			</c:if>

			<h2>${contentItem.name}</h2>
			<div id="topSellersCarousel" class="top-sellers-carousel" data-module="carousel"  data-pager="false" data-moveslides="4" data-maxslides="4" data-minslides="4" data-slidewidth="212" data-slidemargin="25" data-hidecontrolonend="true">
				<!-- <div class="top-sellers-carousel" data-module="pdp-carousel" data-slides-to-show="4"> -->

					<ul>
						<c:forEach var="record" items="${contentItem.records}" varStatus="loopStatus">


						<c:choose>
							<c:when test="${record.attributes['record.type'] eq 'sectional'}">
								<c:set var="cdpImage" value="${record.attributes['product.cdpImage']}"/>
								<c:set var="cdpMouseOverImage" value="${record.attributes['product.cdpAltImage']}"/>
								<c:set var="displayName" value="${record.attributes['product.displayName']}"/>
								<c:set var="repositoryId" value="${record.attributes['product.repositoryId']}"/>
							</c:when>
							<c:otherwise>
								<c:set var="cdpImage" value="${record.attributes['sku.cdpDefaultImage']}"/>
								<c:set var="cdpMouseOverImage" value="${record.attributes['sku.cdpMouseOverImage']}"/>
								<c:set var="displayName" value="${record.attributes['sku.displayName']}"/>
								<c:set var="repositoryId" value="${record.attributes['sku.repositoryId']}"/>
								<c:set var="categorydisplayName" value="${element.attributes['parentCategory.displayName']}"/>
							</c:otherwise>
						</c:choose>


							<dsp:getvalueof var="index" value="${loopStatus.index}" />
							<dsp:getvalueof var="count" value="${loopStatus.count}" />
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
									<c:set var="recordURL" value="${record.detailsAction.contentPath}${element.detailsAction.recordState}"/>
								</c:otherwise>
							</c:choose>
							
							<c:if test="${not empty record.attributes['P_LowestSalePrice'] && not empty record.attributes['P_LowestPrice'] }">
									<fmt:parseNumber var="numericLowestSalePrice" type="number" value="${record.attributes['P_LowestSalePrice']}" />
									<fmt:parseNumber var="numericLowestPrice" type="number" value="${record.attributes['P_LowestPrice']}" />
							</c:if>
								
							<c:choose> 
								<c:when test="${not empty record.attributes['P_LowestSalePrice'] && not empty record.attributes['P_LowestPrice'] && numericLowestSalePrice lt numericLowestPrice }">
									<fmt:parseNumber var="recordSpotlightPrice" value="${record.attributes['P_LowestSalePrice']}"/>
								</c:when>
								<c:when test="${not empty record.attributes['P_LowestPrice']}">
									<fmt:parseNumber var="recordSpotlightPrice" value="${record.attributes['P_LowestPrice']}"/>
								</c:when>
							</c:choose>								
										
							<fmt:formatNumber var="formatrecordSpotlightPrice" value="${recordSpotlightPrice}" type="currency" />
		
							<li>
								<figure>
									<a href="${recordURL}" data-productname="${displayName}" data-groupname="${record.attributes['product.category']}">
									<c:choose>
										<c:when test="${not empty cdpImage}">
											<img src="${storeConfigHostName}${imagePath}${cdpImage}" alt="${displayName}"/>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>
									</a>
									<figcaption>
										<span><a href="${recordURL}">${displayName}</a></span><br>
										<c:choose>
											<c:when test="${record.attributes['record.type'] eq 'sectional'}">
												<fmt:message key="price.configureForPricing"/>
											</c:when>
										<c:otherwise>
												<span>Starting at <strong>${formatrecordSpotlightPrice}</strong></span>
										</c:otherwise>
										</c:choose>
									</figcaption>
								</figure>
							</li>
						</c:forEach>
						</ul>

				</div><%-- #top-sellers-carousel --%>
		</c:if>
	</section><%-- .top-sellers --%>
	<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />
	<dsp:include page="/storecontent/umbracoRightPromo.jsp">
		<dsp:param name="dealerId" value="${dealerId }" />
	</dsp:include>
</main><%-- main class="row home" role="main" started in HomePageCategorySlot.jsp --%>
</dsp:page>
