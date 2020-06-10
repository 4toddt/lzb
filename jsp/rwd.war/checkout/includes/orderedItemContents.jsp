<%--
    - File Name: orderedItemContents.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the ordered item row on the order confirmation page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="commerceItems" param="orderNo"/>
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>
	
	<div class="order-item-list">
		<dsp:droplet name="LZBDisplayCartItemsDroplet">
		<dsp:param name="profile" bean="Profile"/>
		<dsp:param name="order" param="orderNo"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="cartItems" param="cartItems"/>
			<dsp:getvalueof var="commerceItemsForMenetate" param="commerceItems" scope="request"/>
	
			<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${cartItems}"/>
			<dsp:param name="elementName" value="cartItem"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
				<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
				<dsp:getvalueof var="quantity" param="cartItem.commerceItem.quantity" />
				
				<div class="order-item">
					<div class="item-image">
						<dsp:include page="/checkout/includes/cartItemImage.jsp">
							<dsp:param name="cartItem" param="cartItem" />
							<dsp:param name="productName" value="${prodName}" />
						</dsp:include>
					</div>	
					<div class="item-details">
						<div class="product-name">${prodName}</div>
						<div class="quantity-hide-for-small"><fmt:message key="cart.item.qty"/>&nbsp;${quantity}</div>
						<div class="item-price-unit"><fmt:message key="cart.item.price"/>&nbsp; 
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" param="cartItem.itemTotal" />
							</dsp:include>
						</div>
						<div class="quantity-hide-for-medium"><fmt:message key="cart.item.qty"/>&nbsp;${quantity}</div>
					</div>
					
					<c:if test="${not empty protectionPlan}">
						<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
						<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice'/>
						<dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice'/>
						<dsp:getvalueof var="planImagePath" param="cartItem.protectionPlan.auxiliaryData.catalogRef.smallImage.url"/>

						<div class="item-protection-plan">
							<c:if test="${not empty planImagePath}">
								<img src="${contentHostName}${planImagePath}" alt="${planName}" class="icon-protection-plan" align="left" />
							</c:if>

							<c:choose>
								<c:when test="${planSalePrice gt 0 }">
									<c:set var="planItemPrice" value="${planSalePrice}"/>
								</c:when>
								<c:otherwise>
									<c:set var="planItemPrice" value="${planListPrice}"/>
								</c:otherwise>
							</c:choose>

							<div class="item-protection-plan-detail">
								${planName}
								<span class="total-plan-price hide-for-medium">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${planItemPrice}" />
									</dsp:include>
								</span>
								<div class="total-plan-price hide-for-small">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${planItemPrice}" />
									</dsp:include>
								</div>
							</div>
						</div>
					</c:if>
				</div>		 				
			</dsp:oparam>
			</dsp:droplet>			
		</dsp:oparam>
		</dsp:droplet>
	</div>
</dsp:page>