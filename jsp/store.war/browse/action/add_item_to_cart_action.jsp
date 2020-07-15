<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:form name="addItemToCart" method="post" action="#">
		<dsp:setvalue bean="CartModifierFormHandler.addWishlistItemToOrder" value="true"  />
	</dsp:form>
</dsp:page>