<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />

	<dsp:getvalueof var="token" param="token" />
	<dsp:getvalueof var="postback" param="postback" />

	<dsp:form id="digital-buy-shipping" method="post" name="digital-buy-shipping" formid="digital-buy-shipping">
	  	<dsp:input type="hidden" bean="PaymentGroupFormHandler.usingDigitalBuy" value="true" />
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" value="/rwd/checkout/cart.jsp"/>
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" value="/rwd/checkout/checkout.jsp?dbuyToken=${token}"/>
	  	<dsp:input type="submit" bean="PaymentGroupFormHandler.applyDigitalBuyShippingInfo" iclass="button tertiary review-continue checkout-btn" value="GO TO CHECKOUT" />
	</dsp:form>


</dsp:page>
