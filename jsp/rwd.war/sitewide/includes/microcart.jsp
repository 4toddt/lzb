<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean var="profile" bean="/atg/userprofiling/Profile" />

	<div id="micro-cart-items" class="hide">
		<c:if test="${commerceItemCount gt '0' }">
			<dsp:droplet name="LZBDisplayCartItemsDroplet">
				<dsp:param name="order" bean="ShoppingCart.current"/>
				<dsp:param name="profile" bean="Profile"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="cartItems" param="cartItems" />
					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="cartItems" />
						<dsp:param name="elementName" value="cartItem" />
						<dsp:oparam name="output">
							<%-- This is done for Adobe Analytics in DTM script Mini-Cart-Details.js --%>
							<dsp:getvalueof var="cartItemSKU" param="cartItem.commerceItem.catalogRefId" />
							<dsp:getvalueof var="cartItemCoverSKU" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
							<dsp:getvalueof var="cartItemQty" param="cartItem.commerceItem.quantity" />
							<dsp:getvalueof var="cartItemPrice" param="cartItem.itemTotal"/>
							<input class="micro-cart-item" type="hidden" value="${cartItemSKU}${cartItemCoverSKU};${cartItemQty};${cartItemPrice}" />
						</dsp:oparam>
					</dsp:droplet>
				</dsp:oparam>
			</dsp:droplet>
		</c:if>
	</div>
</dsp:page>