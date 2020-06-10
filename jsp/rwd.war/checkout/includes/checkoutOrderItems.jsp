<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/userprofiling/Profile" var="profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
	
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount"/>
	
	<span class="cart-item-count hide">${commerceItemCount}</span>
	
	<dsp:droplet name="RepriceOrderDroplet">
		<dsp:param value="ITEMS" name="pricingOp"/>
	</dsp:droplet>
	
	<%-- Get the items in the order --%>
	<dsp:droplet name="LZBDisplayCartItemsDroplet">
	<dsp:param name="order" bean="ShoppingCart.current" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="cartItems" param="cartItems" />
		
		<dsp:droplet name="ForEach">
		<dsp:param name="array" param="cartItems" />
		<dsp:param name="elementName" value="cartItem" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="productName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
			<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
			<div class="order-item">															
				<div class="item-image">
					<dsp:include page="/checkout/includes/cartItemImage.jsp">
						<dsp:param name="cartItem" param="cartItem" />
						<dsp:param name="productName" value="${productName}" />
					</dsp:include>
				</div>
				<div class="item-details">
					<div class="product-name">${productName}</div>
						
					<dsp:include page="/global/includes/formattedPrice.jsp">
						<dsp:param name="price" param="cartItem.itemTotal" />
					</dsp:include>
						
					<c:if test="${not empty protectionPlan}">
						<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
						<dsp:getvalueof var="totalPlanPrice" param='cartItem.protectionPlan.priceInfo.amount' />
						<dsp:getvalueof var="quantity" param="cartItem.commerceItem.quantity" />
							
						<div class="item-protection-plan">
							${planName}:
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${totalPlanPrice*quantity}" />
							</dsp:include>
						</div>
					</c:if>
				</div>
			</div>
		</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>
