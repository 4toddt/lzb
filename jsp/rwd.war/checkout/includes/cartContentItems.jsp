<%--
  This gadget renders the header for the item list on the Shopping Cart page. It then
  iterates through the cart, rendering each item. Details included with each item are:
  Required parameters:
    None.

  Optional parameters:
    None.
--%>

<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" var="profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	
	<dsp:getvalueof bean="CartModifierFormHandler.formError" var="formError" />
	
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/includes/errors.jsp">
			<dsp:param name="formHandler" bean="CartModifierFormHandler" />
		</dsp:include>
	</c:if>
			
	<%-- Form for adding/removing protection plan --%>
	<dsp:form id="addPlan" formid="addPlan" name="addPlan">
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${contextPath}/checkout/json/updateCartError.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${contextPath}/checkout/json/updateCartSuccess.jsp" />
		<dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value="" />
		<dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value="" />
		<dsp:input type="hidden" id="removePlan" bean="CartModifierFormHandler.removePlan" value="false" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.addTreatmentPlanToOrder" value="true" />
	</dsp:form>
	
	<%-- Form for update Commerce Item quantity --%>
	<dsp:form id="updateCartItemQty" formid="updateCartItemQty" name="updateCartItemQty">
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderSuccessURL" value="${contextPath}/checkout/json/updateCartSuccess.jsp"/>
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderErrorURL" value="${contextPath}/checkout/json/updateCartError.jsp"/>
		<dsp:input type="hidden" id="itemQuantity" bean="CartModifierFormHandler.updateItemQuantity" value="" />
		<dsp:input type="hidden" id="updateCommerceItemId" bean="CartModifierFormHandler.updateCommerceItemId" value="" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderByCommerceId" value="true" />
	</dsp:form>
	
	<%-- checkout form --%>
	<dsp:form id="cartCheckoutForm" formid="cartCheckoutForm" name="cartCheckoutForm">
		<%-- Empty out DigitalBuy token in the order --%>
		<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelIdSuccessURL" value="${contextPath}/checkout/json/cartDeliveryOptionsSuccess.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelIdErrorURL" value="${contextPath}/checkout/json/cartDeliveryOptionsError.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelId" value="submit" />
	</dsp:form>
	
	<%-- pay with DigitalBuy --%>
	<div id="dbuymodel1"></div> 
	<form name="dbuyform1" id="dbuyform1"> 
		<input type="hidden" id="processInd" value="1" /> 
		<input type="hidden" id="tokenId" value="" /> 
		<input type="hidden" id="merchantID" value="${storeConfig.digitalBuyMerchantID}" /> 
		<input type="hidden" id="clientTransId" value="<dsp:valueof bean="ShoppingCart.current.id"/>" /> 
	</form>
	
	<%-- To checkout page with billing info from DigitalBuy user account --%>
	<dsp:form id="digital-buy-shipping" method="post" name="digital-buy-shipping" formid="digital-buy-shipping">
	  	<dsp:input type="hidden" bean="PaymentGroupFormHandler.usingDigitalBuy" value="true" />
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" value="${contextPath}/checkout/json/applyDigitalBuyShippingError.jsp"/>
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" value="${contextPath}/checkout/json/applyDigitalBuyShippingSuccess.jsp"/>
	  	<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyDigitalBuyShippingInfo" value="submit" />
	</dsp:form>
	
	<%-- page header --%>
	<h1 class="title"><fmt:message key="cart.header.shoppingCart"/></h1>
						
	<%-- Get the items in the shopping cart --%>
	<dsp:droplet name="LZBDisplayCartItemsDroplet">
	<dsp:param name="order" bean="ShoppingCart.current" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:param name="cart" value="true" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="cartItems" param="cartItems" />
		
		<%-- cart module --%>
		<div class="shopping-cart">
			<div class="cart-header-row hide-for-small">
				<div class="cart-header-item"><fmt:message key="cart.header.item"/></div>
				<div class="cart-header-quantity"><fmt:message key="cart.header.qty"/></div>
				<div class="cart-header-price"><fmt:message key="cart.header.price"/></div>
			</div>
			<div class="cart-item-list">
				<dsp:droplet name="ForEach">
				<dsp:param name="array" param="cartItems" />
				<dsp:param name="elementName" value="cartItem" />
				<dsp:param name="count" value="count" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="productName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />

					<dsp:droplet name="ForEach">
					<dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories" />
					<dsp:param name="elementName" value="category" />
					<dsp:oparam name="output">
						<dsp:getvalueof var="categoryName" param="category.displayName" />
					</dsp:oparam>
					</dsp:droplet>
																				
					<dsp:include page="/checkout/includes/orderItem.jsp">
						<dsp:param name="cartItem" param="cartItem" />
						<dsp:param name="productName" value="${productName}" />
						<dsp:param name="categoryName" value="${categoryName}" />
						<dsp:param name="count" param="count" />
					</dsp:include>
				</dsp:oparam>
				</dsp:droplet>
			</div>
		</div>
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>
