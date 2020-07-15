<%@ page contentType="application/json" %>
<dsp:page>
	<dsp:importbean	bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBCurrentItemAddedToCartDroplet"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>

	<json:object prettyPrint="true" escapeXml="false">
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="CartModifierFormHandler.formExceptions"/>
			<dsp:oparam name="false">
				<json:property name="success" value="${false}" />
				<json:array name="errors">
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" bean="CartModifierFormHandler.formExceptions"/>
						<dsp:oparam name="output">
							<json:object>
								<json:property name="message">
									<dsp:valueof param="message" valueishtml="true"/>
								</json:property>
							</json:object>
						</dsp:oparam>
					</dsp:droplet>
				</json:array>
			</dsp:oparam>
			<dsp:oparam name="true">
				<json:property name="success" value="${true}" />
					<dsp:droplet name="LZBCurrentItemAddedToCartDroplet">
						<dsp:param name="order" bean="ShoppingCart.current"/>
						<dsp:param name="profile" bean="Profile"/>
						<dsp:param name="currentAddesItem" bean="CartModifierFormHandler.addItemsToOrderResult"/>
						<dsp:param name="pdpPageType" bean="CartModifierFormHandler.pdpPageType"/>
						<dsp:oparam name="output">
						<dsp:getvalueof var="commerceItemId" param="addedItemInfo.commerceItemId"/>
							<json:object name="addedItem">
								<json:property name="commerceItemId">
									<dsp:valueof param="addedItemInfo.commerceItemId" valueishtml="true"/>
								</json:property>
								<json:property name="coverId">
									<dsp:valueof param="addedItemInfo.coverSku.id" valueishtml="true"/>
								</json:property>
								<json:property name="configSkuDisplayName">
									<dsp:valueof param="addedItemInfo.sku.displayName" valueishtml="true"/>
								</json:property>
								<dsp:getvalueof param="addedItemInfo.commerceItem" var="addedItem" />
							<dsp:include page="/includes/styleCollectionsByItem.jsp">
								<dsp:param name="skuId"	value="${addedItem.catalogRefId}" />
								<dsp:param name="skuItem" value="${addedItemInfo.sku}"/>
								<dsp:param name="coverId" value="${addedItemInfo.coverSku.id}" />
							</dsp:include>
							<dsp:tomap var="product" value="${addedItem.auxiliaryData.productRef}"/>
							<dsp:tomap var="sku" value="${addedItem.auxiliaryData.catalogRef}"/>
							<c:set var="contentHostName" value="${pageContext.request.scheme}://${storeConfig.contentHostName}"/>
							<c:set var="storeConfigHostName" value="${contentHostName}" />
							<c:set var="imagePath" value="${storeConfig.imagePath}"/>
							<c:choose>
								<c:when test="${not empty product.type && product.type eq 'sectional'}">
									<c:set var="cdpImage" value="${product.cdpImage}"/>
								</c:when>
								<c:otherwise>
									<c:set var="cdpImage" value="${sku.cdpDefaultImage}"/>
								</c:otherwise>
							</c:choose>
							<c:set var="marxentImageURL" value="${storeConfigHostName}${imagePath}${cdpImage}"/>
							<json:property name="productImgURL">${marxentImageURL}</json:property>

									<dsp:droplet name="LZBPDPURLDroplet">
												<dsp:param name="productId" param="addedItemInfo.sku.id" />
												<dsp:param name="prodName" param="addedItemInfo.sku.displayName" />
												<dsp:param name="fromCDP" value="true" />
												<dsp:param name="elementName" value="produrl" />
												<dsp:oparam name="output">
													
														<dsp:getvalueof var="prodpdpurl" param="produrl"/>
														<json:property name="prodpdpurl">${cotextPath}${prodpdpurl}</json:property>
														<json:property name="editLink">${cotextPath}${prodpdpurl}?ac=edit&commid=${commerceItemId}</json:property>
													
												</dsp:oparam>
									</dsp:droplet>
								
								<json:property name="price">
									<dsp:valueof param="addedItemInfo.itemPrice" valueishtml="true" number="###,###.00" />
								</json:property>
								<json:property name="currencyCode">
									${currencyCode}
								</json:property>
								<json:property name="rating">
								</json:property>
								<json:property name="performanceFabric">
									<dsp:valueof param="addedItemInfo.coverSku.performanceFabricFlag" valueishtml="true"/>
								</json:property>
								<json:property name="coverType">
									<dsp:valueof param="addedItemInfo.coverSku.materialType" valueishtml="true"/>
								</json:property>
								<json:property name="color">
									<dsp:valueof param="addedItemInfo.coverSku.colorDescription" valueishtml="true"/>
								</json:property>
								<dsp:getvalueof param="sectional" var="sectionalFlag" />
								<dsp:getvalueof param="addedItemInfo.proctectionPlanPrice" var="protectionPlanPrice" />
								<c:if test="${protectionPlanPrice gt 0 && sectionalFlag eq false}">
								<json:property name="protectionPlanDisplayName">
									<dsp:valueof param="addedItemInfo.protectionPlanSku.displayName" valueishtml="true"/>
								</json:property>
								<json:property name="protectionPlan">
									<dsp:valueof param="addedItemInfo.protectionPlanSku" valueishtml="true"/>
								</json:property>
								<json:property name="protectionPlanSmallImgURL">
									<dsp:valueof param="addedItemInfo.protectionPlanSku.smallImage.url" valueishtml="true"/>
								</json:property>
								<json:property name="protectionPlanLargrImgURL">
									<dsp:valueof param="addedItemInfo.protectionPlanSku.largeImage.url" valueishtml="true"/>
								</json:property>
								<json:property name="protectionPlanPrice">
									<dsp:valueof param="addedItemInfo.proctectionPlanPrice" valueishtml="true" number="###,###.00" />
								</json:property>
								</c:if>
								<json:property name="numOfItemAdded">
									<dsp:valueof param="addedItemInfo.itemAddedCount" valueishtml="true"/>
								</json:property>
								<json:property name="totalItemInCart">
									<dsp:valueof param="addedItemInfo.totalNumberOfItems" valueishtml="true"/>
								</json:property>
								<json:property name="total">
									<dsp:valueof param="addedItemInfo.orderTotal" valueishtml="true" number="###,###.00" />
								</json:property>
								<json:property name="itemAlreadyAdded">
									<dsp:valueof param="addedItemInfo.alreadyIncart" valueishtml="true"/>
								</json:property>
								<json:array name="relatedProducts" escapeXml="false">
								<dsp:droplet name="/com/lzb/droplet/LZBYMLDisplayDroplet">
									<dsp:param name="relatedProductSet" param="addedItemInfo.commerceItem.auxiliaryData.productRef.relatedProducts"/>
									<dsp:param name="dealerId" value="${dealerId}" />
									<dsp:param name="priceRequest" value="${false}" />
									<dsp:oparam name="output">
									<dsp:getvalueof var="records" param="records"/>
									<c:forEach var="element" items="${records}" varStatus="status">
									<json:object>
										<dsp:droplet name="LZBPDPURLDroplet">
											<dsp:param name="productId" value="${element.attributes['sku.repositoryId']}" />
											<dsp:param name="prodName" value="${element.attributes['sku.displayName']}" />
											<dsp:param name="fromCDP" value="true" />
											<dsp:param name="elementName" value="url" />
										<dsp:oparam name="output">
											<dsp:getvalueof var="recordURL" param="url"/>
											<json:property name="url">${cotextPath}${recordURL}</json:property>
										</dsp:oparam>
										</dsp:droplet>
									<json:property name="name"><dsp:valueof value="${element.attributes['sku.displayName']}" valueishtml="true" /></json:property>
									<json:property name="imageUrl"><dsp:valueof value="${storeConfig.hostName}${storeConfig.imagePath}${element.attributes['sku.cdpDefaultImage']}" valueishtml="true" /></json:property>
									</json:object>
									</c:forEach>
									
								</dsp:oparam>
							</dsp:droplet>
									
									
								</json:array>
							</json:object>
						</dsp:oparam>
					</dsp:droplet>
			</dsp:oparam>
		</dsp:droplet>
	</json:object>
</dsp:page>