<dsp:page>

	<dsp:importbean bean="/atg/commerce/order/purchase/ExpressCheckoutFormHandler"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<p>
		<fmt:message key="cartorder.expressCheckoutMsg"/>
	</p>
	<fmt:message var="expressCheckout" key="cartorder.expressCheckout"/>
	<dsp:form name="expressCheckoutForm" id="expressCheckoutForm" formid="expressCheckoutForm" action="/cart/cart.jsp">
		<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.expressCheckoutSuccessURL" value="/checkout/orderReview.jsp"/>
		<dsp:input type="hidden" bean="ExpressCheckoutFormHandler.expressCheckoutErrorURL" value="/cart/cart.jsp"/>
		<dsp:input type="submit" bean="ExpressCheckoutFormHandler.expressCheckout" value="${expressCheckout}"/>
	</dsp:form>
	<fmt:message key="cartorder.use"/>
	<dsp:a href="/rwd/checkout/deliveryAndPayment.jsp"  bean="CartModifierFormHandler.moveToPurchaseInfoByRelId" value="true" >
		<dsp:param name="successUrl" value="/rwd/checkout/deliveryAndPayment.jsp" />
		<dsp:param name="errorUrl" value="/rwd/checkout/cart.jsp" />
		<fmt:message key="cartorder.standardCheckout"/> >
	</dsp:a>
</dsp:page>