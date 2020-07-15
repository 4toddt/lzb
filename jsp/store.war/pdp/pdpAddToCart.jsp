<dsp:page>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<dsp:form action="/rwd/checkout/cart.jsp" method="post">
   
   <br><a href="/rwd/checkout/cart.jsp">My Cart</a><br/>
   Enter SkuID1:<dsp:input type="text" size="20" bean="CartModifierFormHandler.catalogRefIds" value="BRE-4PC-R"/><br/>
   Enter ProductID:<dsp:input type="text" size="20" bean="CartModifierFormHandler.productId" value="prodBRE-4PC-R"/><br/>
   Enter Quantity:<dsp:input type="text" size="5" bean="CartModifierFormHandler.quantity" value="1"/><br/>
   <hr><br>
   
   <dsp:input type="submit" bean="CartModifierFormHandler.addItemToOrder" value="Add to Cart"/>
   <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/rwd/checkout/cart.jsp"/>
   <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="pdpAddToCart.jsp"/>     
</dsp:form>

<script>



</script>

</dsp:page>