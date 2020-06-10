<%--
    - File Name: billing.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the payment billing section on the checkout page.
    - Required Parameters:
        - orderCombination: string value; containing order item combination type.
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="orderCombination" param="orderCombination" />
	
	<%-- DigitalBuy variables --%>
	<dsp:getvalueof var="orderDBToken" bean="ShoppingCart.current.dbuyToken" />
	<dsp:getvalueof var="dbuyStep" bean="ShoppingCart.current.dbuyStep" />
	<dsp:getvalueof var="useDigitalBuyPayment" value="${false}" />
	<dsp:getvalueof var="country" bean="Profile.currentStore.country" />
	
	<c:if test="${dbuyStep == 'cart'}">
		<dsp:getvalueof var="useDigitalBuyPayment" value="${true}" />
	</c:if>

	<span id="useDigitalBuy" class="hide" >${useDigitalBuyPayment}</span>
	<div>
		<span class="icon checkout-title-icon icon-radio"></span>
		<div class="checkout-title">
			<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
			<span class="status-step-num">2</span><fmt:message key="checkout.step.payment" />
		</div>
	</div>
	
	<dsp:form id="paymentForm" formid="paymentForm" name="paymentForm" method="post" data-validate="">
		<div class="credit-card-types">
			<c:if test="${country != 'CA'}">
				<div class="lzb-cc-text js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
					<a href="javascript:void(0);" class="js-lzb-cc-link"><img class="to-digitalbuy-checkout-btn" src="${contextPath}/resources/images/checkout/pay_with_lzb_card.png" alt="Pay with LaZBoy credit card" title="Pay with LaZBoy credit card"></a>
					<span><fmt:message key="checkout.payment.lzbcard" /></span><a href="javascript:void(0);" class="js-lzb-cc-link apply-now-link"><fmt:message key="cart.financing.applynow" /></a>
					
					<div class="or-text">OR</div>
				</div>
			</c:if>
			
			<div class="js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
				<span class="sr-only"><fmt:message key="checkout.payment.visa" /></span>
				<span class="icon icon-visa" aria-hidden="true">
	                <span class="path1"></span><span class="path2"></span>
	            </span>
			</div>
			<div class="js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
				<span class="sr-only"><fmt:message key="checkout.payment.americanExpress" /></span>
				<span class="icon icon-amex" aria-hidden="true">
	                <span class="path1"></span><span class="path2"></span>
	            </span>
			</div>
			<div class="js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
				<span class="sr-only"><fmt:message key="checkout.payment.mastercard" /></span>
				<span class="icon icon-mastercard" aria-hidden="true">
	                <span class="path1"></span><span class="path2"></span><span class="path3"></span><span class="path4"></span>
	            </span>
			</div>
		</div>
		
		<dsp:include page="/checkout/includes/paymentMethodForm.jsp">
			<dsp:param name="index" value="0"/>
			<dsp:param name="useDigitalBuyPayment" value="${useDigitalBuyPayment}"/>
		</dsp:include>
		
		<div class="lzb-cc-selected js-db-content ${useDigitalBuyPayment ? '' : 'hide'}">
			<img src="${contextPath}/resources/images/checkout/lzb_card.jpg" class="lzb-cc" alt="LazyBoy Credit Card" title="LazyBoy Credit Card">
			<a href="javascript:void(0);" class="edit-payment edit-link"><fmt:message key="checkout.payment.editPayment" /></a>
		</div>	
		<div class="field-group custom-checkbox">
			<input type="checkbox" id="useDeliveryAddress" name="useDeliveryAddress" checked/> 
			<label for="useDeliveryAddress"><fmt:message key="checkout.payment.useDeliveryAddress" /></label>
		</div>
	
		<%-- Only render split payment form fields if order contains a configurable sku record.type --%>
		<c:if test="${orderCombination != 'onlyLicensed'}">
			<div class="field-group custom-checkbox js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
				<c:choose>
					<c:when test="${country == 'CA'}"> 
						<input type="checkbox" id="splitPaymentCheckbox" name="splitPaymentCheckbox" class="js-cc-field" /> 
						<label for="splitPaymentCheckbox"><fmt:message key="checkout.payment.splitPayment" /></label>
					</c:when>
					<c:otherwise>
						<input type="checkbox" id="splitPaymentCheckbox" name="splitPaymentCheckbox" class="js-cc-field" ${useDigitalBuyPayment ? 'disabled' : ''} /> 
						<label for="splitPaymentCheckbox"><fmt:message key="checkout.payment.splitPayment" /></label>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		
		<div class="billing-address">
			<div class="first-card-billing-addr"><fmt:message key="checkout.payment.firstCardBillingAddress" /></div>
			<dsp:include page="/checkout/includes/billingAddressForm.jsp">
				<dsp:param name="index" value="0"/>
			</dsp:include>
		</div>
		
		<%-- Only render split payment form fields if order contains a configurable sku record.type --%>
		<c:if test="${orderCombination != 'onlyLicensed'}">
			<div class="js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
				<div class="split-payment-message">
					<fmt:message key="checkout.payment.splitPaymentCardDepositMsg" />
				</div>
				
				<div class="second-card-container">
					<div class="split-payment-title"><fmt:message key="checkout.payment.secondCardPaymentInfo" /></div>
					<dsp:include page="/checkout/includes/paymentMethodForm.jsp">
						<dsp:param name="index" value="1"/>
						<dsp:param name="useDigitalBuyPayment" value="${useDigitalBuyPayment}"/>
					</dsp:include>
				</div>
				
				<div class="field-group custom-checkbox user-delivery-address-2">
					<c:choose>
						<c:when test="${country == 'CA'}"> 
							<input type="checkbox" id="useDeliveryAddress2" name="useDeliveryAddress2" class="js-cc-field" checked /> 
							<label for="useDeliveryAddress2"><fmt:message key="checkout.payment.useDeliveryAddress" /></label>
						</c:when>
						<c:otherwise>
							<input type="checkbox" id="useDeliveryAddress2" name="useDeliveryAddress2" class="js-cc-field" checked disabled="${useDigitalBuyPayment ? 'true' : ''}" /> 
							<label for="useDeliveryAddress2"><fmt:message key="checkout.payment.useDeliveryAddress" /></label>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="split-payment-message">
					<fmt:message key="checkout.payment.splitPaymentCardBalanceMsg" />
				</div>
				
				<div class="billing-address-2">
					<dsp:include page="/checkout/includes/billingAddressForm.jsp">
						<dsp:param name="index" value="1"/>
					</dsp:include>
				</div>
			</div>
		</c:if>

		<div class="field-group custom-checkbox">
			<dsp:input type="checkbox" bean="PaymentGroupFormHandler.termsAndConditions" id="termsAndConditions" data-validation="required" data-fieldname="Online Terms and Conditions" />
			<label for="termsAndConditions">I have read and agree to the <a href="/rwd/checkout/ajax/termsAndConditionsModal.jsp" class="modal-trigger" data-dismiss="modal" data-target="terms-and-conditions-modal" aria-label="Click to open information about online terms and conditions">online terms and conditions</a><span class="required-label">*</span></label>
		</div>

		<div class="save-and-continue">
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" value="${contextPath}/checkout/json/setBillingSuccess.jsp"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" value="${contextPath}/checkout/json/setBillingError.jsp"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.loggedInUser" value="false"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.skipValidation" value="false"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="true"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="false" id="shipToBill"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.splitPayment" value="false" name="splitPayment" id="splitPayment" />
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.usingDigitalBuy" value="false" name="usingDigitalBuy" id="usingDigitalBuy" />
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.applyBillingInfo" value="submit" />
				
			<button class="button tertiary payment-continue checkout-btn"><fmt:message key="checkout.payment.continue" /></button>
		</div>
	</dsp:form>
</dsp:page>
