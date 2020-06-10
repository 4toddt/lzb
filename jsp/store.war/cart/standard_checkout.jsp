<dsp:page>
	 <dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	 <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	 <dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
 		<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
		<c:choose>
			<c:when test="${securityStatus >3}">
			<c:set var="successUrl" value="${cotextPath}/checkout/deliveryAndPayment.jsp" />
			</c:when>
			<c:otherwise>
				<c:set var="successUrl" value="${cotextPath}/checkout/checkout.jsp" />
			</c:otherwise>
		</c:choose>
	<fmt:message key="cartorder.standardCheckout" var="checkout"/>
	<dsp:form name="standardCheckoutForm" id="standardCheckoutForm" action="#" method="post">
    	<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoSuccessURL" value="${successUrl}"/>
     	<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoErrorURL" value="${cotextPath}/cart/cart.jsp"/>
        <span class="button_example"><u><dsp:input bean="CartModifierFormHandler.moveToPurchaseInfoByCommerceId"  type="submit" value="${checkout}"/></u></span>
 	 </dsp:form>
</dsp:page>