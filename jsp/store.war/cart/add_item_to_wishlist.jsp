<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />


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
	
	<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="/work/account/wish_list_items.jsp" />
	<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="/work/cart/add_item_to_cart.jsp" />

	<br />
	
	<dsp:input type="submit" value="Add to wish list" bean="GiftlistFormHandler.addItemToWishlist" />

 </dsp:form>
 
</dsp:page>
