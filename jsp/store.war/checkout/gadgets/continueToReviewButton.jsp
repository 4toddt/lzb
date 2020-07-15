<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
    <dsp:importbean bean="/com/lzb/service/SessionBean" />

	<fmt:message var="continueToReview" key="checkout.deliveryAndPayment.continueToReview"/>

	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/orderReview.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/deliveryAndPayment.jsp"/>
	<dsp:droplet name="IsEmpty">
		<dsp:param name="value"	bean="SessionBean.gEToken"/>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/work/checkout/deliveryAndPayment.jsp?paymentMethod=lzb"/>
			</dsp:oparam>
	</dsp:droplet>
	<input type="button" value="${continueToReview}" class="btn-primary review-button cont-review-btn" />
	<dsp:input type="submit" style="display:none" bean="PaymentGroupFormHandler.applyShippingBillingInfo" value="${continueToReview}" iclass="btn-primary review-button continueToReview"/>
	
</dsp:page>