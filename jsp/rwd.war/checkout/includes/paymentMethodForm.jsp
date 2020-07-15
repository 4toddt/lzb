<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	
	<dsp:getvalueof var="index" param="index" />
	<dsp:getvalueof var="useDigitalBuyPayment" param="useDigitalBuyPayment" />
	
	<div class="js-cc-content ${useDigitalBuyPayment ? 'hide' : ''}">
		<%-- screen reader required field instructions --%>
		<div class="sr-only"><fmt:message key="form.required.srInstructions" /></div>
	
		<div class="field-group credit-card">
			<label for="ccNum${index}"><fmt:message key="checkout.payment.ccNum" /><span class="required-label ">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.creditCardNumber${index}" id="ccNum${index}" iclass="cardtype-unknown js-cc-field" name="ccNum${index}" type="tel" maxlength="19" autocapitalize="off" data-validation="required" data-fieldname="Credit Card Number" data-card-type="cardType${index}" value="" placeholder="1234567891012131" aria-required="true" disabled="${useDigitalBuyPayment ? 'true' : ''}" />
			<span class="cc-img"></span>
		</div>
		
		<div class="field-group credit-card">
			<div class="field">
				<label for="ccExpDate${index}"><fmt:message key="checkout.payment.ccExpDate" /><span class="required-label ">*</span></label>
				<input class="ccExpDate js-cc-field" id="ccExpDate${index}" name="ccExpDate${index}" type="tel" maxlength="5" autocapitalize="off" data-validation="required creditcardExpiration" data-fieldname="Expiration Date" value="" placeholder="xx/xx" aria-required="true" ${useDigitalBuyPayment ? 'disabled' : ''} />
			</div>
			<div class="field">
				<label for="secCode${index}"><fmt:message key="checkout.payment.securityCode" /><span class="required-label">*</span></label>
				<dsp:input bean="PaymentGroupFormHandler.cardVerificationNumber${index}" id="secCode${index}" name="secCode${index}" iclass="js-cc-field" type="password" maxlength="4" autocapitalize="off" data-validation="required numeric" data-fieldname="Security Code" value="" aria-required="true" disabled="${useDigitalBuyPayment ? 'true' : ''}" />
				<a href="${contextPath}/checkout/ajax/securityCodeModal.jsp" class="secCode-info-link modal-trigger" data-dismiss="modal" data-target="cc-secCode-modal" data-size="medium" aria-label="Click to open information about where to find your credit card security code">
					<span class="sr-only"></span>
					<span class="icon icon-info" aria-hidden="true"></span>
				</a>
			</div>
		</div>
		
		<dsp:input type="hidden" iclass="js-cc-field" id="cardType${index}" bean="PaymentGroupFormHandler.creditCardType${index}" value="" disabled="${useDigitalBuyPayment ? 'true' : ''}" />
		<dsp:input type="hidden" iclass="js-cc-field" id="cardExpMonth${index}" bean="PaymentGroupFormHandler.expirationMonth${index}" value="" disabled="${useDigitalBuyPayment ? 'true' : ''}" />
		<dsp:input type="hidden" iclass="js-cc-field" id="cardExpYear${index}" bean="PaymentGroupFormHandler.expirationYear${index}" value="" disabled="${useDigitalBuyPayment ? 'true' : ''}" />
	</div>
</dsp:page>