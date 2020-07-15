<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	
	<dsp:getvalueof var="index" param="index" />
	
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:param name="countryCode" bean="PaymentGroupFormHandler.billingAddress[param:index].country"/>
	<c:choose>
		<c:when test="${not empty prevCountry}">
			<dsp:param name="countryCode" value="${prevCountry}"/>
			<dsp:getvalueof var="countryVal" value="${prevCountry}"/>
		</c:when>
		<c:when test="${not empty currentStore}">
			<dsp:param name="countryCode" value="${currentStore.country}"/>
			<dsp:getvalueof var="countryVal" value="${currentStore.country}"/>
		</c:when>
		<c:otherwise>
			<dsp:param name="countryCode" value="US" />
			<dsp:getvalueof var="countryVal" value="US"/>
		</c:otherwise>
	</c:choose>

	<%-- screen reader required field instructions --%>
	<div class="sr-only"><fmt:message key="form.required.srInstructions" /></div>

	<dsp:input type="hidden" bean="PaymentGroupFormHandler.billingAddress[param:index].country" value="${countryVal}"/>
	
	<div class="field-group">
		<div class="field">
			<label for="billFName${index}"><fmt:message key="checkout.address.firstname" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].firstName" id="billFName${index}" iclass="js-billAdd-field-${index}" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="First Name" maxlength="40" value="" aria-required="true" />
		</div>
		<div class="field">
			<label for="billSName${index}"><fmt:message key="checkout.address.lastname" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].lastName" id="billSName${index}" iclass="js-billAdd-field-${index}" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="Last Name" maxlength="40" value="" aria-required="true" />
		</div>
	</div>
		
	<div class="field-group">
		<label for="billAddr1${index}"><fmt:message key="checkout.address.deliveryAddress1" /><span class="required-label">*</span></label>
		<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address1" id="billAddr1${index}" iclass="js-billAdd-field-${index}" type="text" autocapitalize="off" data-validation="required" data-fieldname="Billing Address 1" placeholder="123 Main St." maxlength="50" value="" aria-required="true" />
	</div>
	
	<div class="field-group">
		<label for="billAddr2${index}"><fmt:message key="checkout.address.deliveryAddress2" /></label>
		<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address2" id="billAddr2${index}" iclass="js-billAdd-field-${index}" type="text" autocapitalize="off" data-fieldname="Billing  Address 2" placeholder="Apt #, Suite" maxlength="50" value="" />
	</div>
	
	<div class="field-group">
		<div class="field">
			<label for="billCity${index}"><fmt:message key="checkout.address.city" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].city" id="billCity${index}" iclass="js-billAdd-field-${index}" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="City" placeholder="City" maxlength="30" value="" aria-required="true" />
		</div>
		<div class="field">
			<dsp:getvalueof var="state" bean="PaymentGroupFormHandler.billingAddress[param:index].state"/>
			<dsp:param name="statePicker" value="${state}"/>
			
			<label for="selState${index}"><fmt:message key="checkout.address.state" /><span class="required-label">*</span></label>
			<div class="custom-select">
				<dsp:select bean="PaymentGroupFormHandler.billingAddress[param:index].state" data-validation="required" data-fieldname="State/Province" iclass="checkout-select-box dropdown js-billAdd-field-${index}" id="selState${index}" nodefault="true" aria-required="true">
					<%@include file="/sitewide/includes/countryState.jsp"%>
				</dsp:select>
				<span class="icon icon-arrow-down" aria-hidden="true"></span>
			</div>
		</div>
	</div>
	
	<div class="field-group">
		<div class="field">
			<label for="billZipCode${index}"><fmt:message key="checkout.address.zip" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].postalCode" id="billZipCode${index}" iclass="js-billAdd-field-${index}" type="${countryVal == 'CA' ? 'text' : 'tel'}" autocapitalize="off" data-validation="required uspostal" data-fieldname="Zip/Postal Code" placeholder="Zip/Postal Code" maxlength="10" value="" aria-required="true" />
		</div>
		<div class="field">
			<label for="billingPhone${index}"><fmt:message key="checkout.address.phone" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].phoneNumber" id="billingPhone${index}" iclass="js-billAdd-field-${index}" type="tel" autocapitalize="off" data-validation="required usphone" data-fieldname="Phone Number" placeholder="(555) 123-4567" iclass="phone" value="" aria-required="true" />
		</div>
	</div>
	
	<dsp:input id="billEmailAddress${index}" bean="PaymentGroupFormHandler.billingAddress[param:index].email" iclass="js-billAdd-field-${index}" type="hidden" value="" /></br>
	
</dsp:page>
