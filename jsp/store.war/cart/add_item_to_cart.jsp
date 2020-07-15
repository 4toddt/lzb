<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />


  <dsp:form name="addItemToCart1" method="post" action="#">

	<dsp:getvalueof bean="CartModifierFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="CartModifierFormHandler" />
		</dsp:include>
	</c:if>

	Configurable Item 1: <dsp:input type="text" bean="CartModifierFormHandler.catalogRefIds" value="sku10005" />  <br />
	Quantity	: <input type="text" name="sku10005" value="1"/>	<br />
	Product id: <dsp:input type="text" bean="CartModifierFormHandler.productId" value="prod10002" />	<br />
	Sub Item1 : <input type="text" name="subsku_sku10005" value="sku10010"/>
	Sub Item1 Qty: <input type="text" name="sku10010" value="1"/>
	<br />
	Sub Item2 :  <input type="text" name="subsku_sku10005" value="sku10008"/>
	Sub Item2 Qty:  <input type="text" name="sku10008" value="1"/>
	>br />
	Generic quantity: (until PDP logic is finalized) : <dsp:input type="text" bean="CartModifierFormHandler.quantity" value="1" /> 
	<br>
	price information : <dsp:getvalueof var="suboptions" value="@sku10010@sku10008" />
	<dsp:droplet name="/atg/commerce/pricing/PriceItem">
		<dsp:param name="item" value="sku10005"  />
		<dsp:param name="quantity" value="1"/>
		<dsp:param name="product" value="prod10002"/>
		<dsp:param name="subitems" value="${suboptions}"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:param name="dealerId" bean="PriceListManager.tempDealer"/>
		<dsp:param value="pricedItem" name="elementName"/>
		<dsp:oparam name="output">
   			<dsp:valueof param="pricedItem.priceInfo.amount" converter="currency" />
		</dsp:oparam>
	</dsp:droplet>
	<br />
	<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/cart/cart.jsp" />
	<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/cart/add_item_to_cart.jsp" />
	<br />
	<dsp:input type="submit" value="Add to Cart1" bean="CartModifierFormHandler.addConfigurableItemToOrder" />

 </dsp:form>
 
   <dsp:form name="addItemToCart2" method="post" action="#">

	<dsp:getvalueof bean="CartModifierFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="CartModifierFormHandler" />
		</dsp:include>
	</c:if>

	Configurable Item 2: <dsp:input type="text" bean="CartModifierFormHandler.catalogRefIds" value="sku30002" />  <br />
	Quantity	: <input type="text" name="sku30002" value="1"/>	<br />
	Product id: <dsp:input type="text" bean="CartModifierFormHandler.productId" value="prod20002" />	<br />
	Sub Item1 : <input type="text" name="subsku_sku30002" value="sku30011"/>
	Sub Item1 Qty: <input type="text" name="sku30011" value="1"/>
	<br />
	Sub Item2 :  <input type="text" name="subsku_sku30002" value="sku30012"/>
	Sub Item2 Qty:  <input type="text" name="sku30012" value="1"/>
	
	Generic quantity: (until PDP logic is finalized) : <dsp:input type="text" bean="CartModifierFormHandler.quantity" value="1" /> 
	
	<br>
	
	price information : <dsp:getvalueof var="suboptions" value="@sku30011@sku30011" />
	
	<dsp:droplet name="/atg/commerce/pricing/PriceItem">
		<dsp:param name="item" value="sku30002"  />
		<dsp:param name="quantity" value="1"/>
		<dsp:param name="product" value="prod20002"/>
		<dsp:param name="subitems" value="${suboptions}"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:param name="dealerId" bean="PriceListManager.tempDealer"/>
		<dsp:param value="pricedItem" name="elementName"/>
		<dsp:oparam name="output">
		
   			<dsp:valueof param="pricedItem.priceInfo.amount" converter="currency" />

		</dsp:oparam>
	</dsp:droplet>
	
	
	<br />
	
	<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/cart/cart.jsp" />
	<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/cart/add_item_to_cart.jsp" />

	<br />
	
	<dsp:input type="submit" value="Add to Cart2" bean="CartModifierFormHandler.addConfigurableItemToOrder" />

 </dsp:form>
 
 <dsp:form name="addItemToWishList" method="post" action="#">

	<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="GiftlistFormHandler" />
		</dsp:include>
	</c:if>

	Configurable Item: <dsp:input type="text" bean="GiftlistFormHandler.catalogRefIds" value="sku10005" />  <br />
	Quantity	: <input type="text" name="sku10005" value="1"/>	<br />
	Product id: <dsp:input type="text" bean="GiftlistFormHandler.productId" value="prod10002" />	<br />
	
	<br />
	Sub Item1 : <dsp:input type="text" bean="GiftlistFormHandler.subSkuCatalogRefIds" value="sku10010" />
	Sub Item1 : <input type="text" name="sku10010" value="1"/>
	Sub Item2 : <dsp:input type="text" bean="GiftlistFormHandler.subSkuCatalogRefIds" value="sku10008" />
	Sub Item2 :  <input type="text" name="sku10008" value="1"/>
	
	<br />
	
	<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="/account/wish_list_items.jsp" />
	<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="/cart/add_item_to_cart.jsp" />

	<br />
	
	<dsp:input type="submit" value="Add to wish list" bean="GiftlistFormHandler.addItemToWishlist" />

 </dsp:form>
</dsp:page>
