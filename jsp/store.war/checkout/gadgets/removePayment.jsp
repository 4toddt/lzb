<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:getvalueof var="paymentGrpId" param="paymentGrpId"/>
	<dsp:form formid="removePayment" name="removePayment">
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.paymentGroupId" value="${paymentGrpId}"/>
		<dsp:input bean="PaymentGroupFormHandler.removePaymentGroupSuccessURL" type="hidden" value="/checkout/deliveryAndPayment.jsp?success"/>
		<dsp:input bean="PaymentGroupFormHandler.removePaymentGroupErrorURL" type="hidden" value="/checkout/deliveryAndPayment.jsp?error"/>
		<dsp:input type="submit" bean="PaymentGroupFormHandler.removePaymentGroup" value="REMOVE PAYMENT >"/>
	</dsp:form>
</dsp:page>