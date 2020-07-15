<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	
	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>
	<dsp:getvalueof bean="PaymentGroupFormHandler.splitPayment" var="isSplit"/>
	<dsp:getvalueof var="payGrpRelCount" bean="ShoppingCart.current.paymentGroupRelationshipCount"/>
	<dsp:getvalueof var="orderTotal" bean="ShoppingCart.current.priceInfo.amount"/>
	<p>paymentSynchronyCard.jsp ver: 1.3</p>
	
	<h2><fmt:message key="checkout.deliveryAndPayment.payment"/></h2>
	<p><fmt:message key="checkout.deliveryAndPayment.payment.instruction"/></p>	
        <dsp:include page="gadgets/lzbCardForm.jsp">
	</dsp:include>
	
	<dsp:input type="checkbox" bean="PaymentGroupFormHandler.termsAndConditions"/>
    <fmt:message key="checkout.deliveryAndPayment.payment.termsAndConditions"/></br>
    
</dsp:page>
