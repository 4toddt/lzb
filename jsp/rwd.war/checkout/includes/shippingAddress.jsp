<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />

	<div class="shipping-address-form-panel js-info-section in-progress">
		<div>
			<span class="icon checkout-title-icon icon-radio"></span>
			<div class="checkout-title">
				<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
				<span class="status-step-num">1</span><fmt:message key="checkout.step.delivery" />
			</div>
		</div>

		<dsp:form id="shipping-address-form" formid="shipping-address-form" name="shipping-address-form" data-validate="">
			<dsp:include page="/checkout/includes/shippingAddressForm.jsp" />

			<div class="save-and-continue">
				<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" value="${contextPath}/checkout/json/setShippingAddressError.jsp"/>
				<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" value="${contextPath}/checkout/json/setShippingAddressSuccess.jsp"/>
				<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingInfo" value="submit" />
				<button class="button tertiary shipping-continue checkout-btn"><fmt:message key="checkout.shipping.continue" /></button>
			</div>
		</dsp:form>
	</div>
</dsp:page>
