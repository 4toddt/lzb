<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:form formid="removeAllPayment" name="removeAllPayment">
		<dsp:input bean="PaymentGroupFormHandler.removeAllPaymentSuccessURL" type="hidden" value="/checkout/deliveryAndPayment.jsp?success"/>
		<dsp:input bean="PaymentGroupFormHandler.removeAllPaymentErrorURL" type="hidden" value="/checkout/deliveryAndPayment.jsp?error"/>
		<dsp:input type="submit" bean="PaymentGroupFormHandler.removeAllPayment" value="REMOVE ALL PAYMENT >"/>
	</dsp:form>
</dsp:page>