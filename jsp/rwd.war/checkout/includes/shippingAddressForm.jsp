<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	
	<dsp:droplet name="ForEach">
	<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups"/>
	<dsp:param name="elementName" value="SGroup"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="shippingGroup" param="SGroup"/>
		
		<dsp:droplet name="ForEach">
		<dsp:param name="array" value="${shippingGroup.specialInstructions}"/>
		<dsp:param name="elementName" value="specialInstr"/>
		<dsp:oparam name="output">
    		<dsp:getvalueof var="specialInstr" param="specialInstr"/>
    	</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
	</dsp:droplet>
	
	<c:if test="${not empty shippingGroup.shippingAddress}">
		<dsp:getvalueof var="prevFirstName" value="${shippingGroup.shippingAddress.firstName}"/>
		<dsp:getvalueof var="prevLastName" value="${shippingGroup.shippingAddress.lastName}"/>
		<dsp:getvalueof var="prevAddress1" value="${shippingGroup.shippingAddress.address1}"/>
		<dsp:getvalueof var="prevAddress2" value="${shippingGroup.shippingAddress.address2}"/>
		<dsp:getvalueof var="prevCity" value="${shippingGroup.shippingAddress.city}"/>
		<dsp:getvalueof var="prevPostalCode" value="${shippingGroup.shippingAddress.postalCode}"/>
		<dsp:getvalueof var="prevPhone" value="${shippingGroup.shippingAddress.phoneNumber}"/>
		<dsp:getvalueof var="prevEmail" value="${shippingGroup.shippingAddress.email}"/>
		<dsp:getvalueof var="prevState" value="${shippingGroup.shippingAddress.state}"/>
		<dsp:getvalueof var="prevCountry" value="${shippingGroup.shippingAddress.country}"/>
	</c:if>
	
	<dsp:getvalueof var="specialIntr" bean="PaymentGroupFormHandler.specialInstructions" />
	
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:param name="countryCode" bean="PaymentGroupFormHandler.shippingAddress.country"/>
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
	
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.shippingAddress.country" name="country" value="${countryVal}"/>

	<%-- screen reader required field instructions --%>
	<div class="sr-only"><fmt:message key="form.required.srInstructions" /></div>

	<div class="field-group">
		<div class="field">
			<label for="shippingAddrFirst"><fmt:message key="checkout.address.firstname" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddress.firstName" id="shippingAddrFirst" name="shippingAddrFirst" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="First Name" maxlength="40" value="${prevFirstName}" aria-required="true" />
		</div>
		<div class="field">
			<label for="shippingAddrLast"><fmt:message key="checkout.address.lastname" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddress.lastName" id="shippingAddrLast" name="shippingAddrLast" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="Last Name" maxlength="40" value="${prevLastName}" aria-required="true" />
		</div>
	</div>
		
	<div class="field-group">
		<label for="shippingAddrAddress"><fmt:message key="checkout.address.deliveryAddress1" /><span class="required-label">*</span></label>
		<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address1" id="shippingAddrAddress" name="shippingAddrAddress" type="text" autocapitalize="off" data-validation="required" data-fieldname="Delivery Address 1" placeholder="123 Main St." maxlength="50" value="${prevAddress1}" aria-required="true" />
	</div>
	
	<div class="field-group">
		<label for="shippingAddrAddress2"><fmt:message key="checkout.address.deliveryAddress2" /></label>
		<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address2" id="shippingAddrAddress2" name="shippingAddrAddress2" type="text" autocapitalize="off" data-fieldname="Delivery Address 2" placeholder="Apt #, Suite" maxlength="50" value="${prevAddress2}" />
	</div>
	
	<div class="field-group">
		<div class="field">
			<label for="shippingAddrCity"><fmt:message key="checkout.address.city" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddress.city" id="shippingAddrCity" name="shippingAddrCity" type="text" autocapitalize="off" data-validation="required alphaspace" data-fieldname="City" placeholder="City" maxlength="30" value="${prevCity}" aria-required="true" />
		</div>
		<div class="field">
			<dsp:getvalueof var="state" bean="PaymentGroupFormHandler.shippingAddress.state"/>
			<c:if test="${empty state}">
				<dsp:getvalueof var="state" value="${prevState}" />
			</c:if>
			<dsp:param name="statePicker" value="${state}"/>
			
			<label for="shippingAddrState"><fmt:message key="checkout.address.state" /><span class="required-label">*</span></label>
			<div class="custom-select">
				<dsp:select bean="PaymentGroupFormHandler.shippingAddress.state" data-validation="required" data-fieldname="State/Province" iclass="checkout-select-box dropdown" id="shippingAddrState" name="shippingAddrState" nodefault="true" aria-required="true">
					<%@include file="/sitewide/includes/countryState.jsp"%>
				</dsp:select>
				<span class="icon icon-arrow-down" aria-hidden="true"></span>
			</div>
		</div>
	</div>
	
	<div class="field-group">
		<div class="field">
			<label for="shippingAddrZip"><fmt:message key="checkout.address.zip" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddress.postalCode" id="shippingAddrZip" name="shippingAddrZip" type="${countryVal == 'CA' ? 'text' : 'tel'}" autocapitalize="off" data-validation="required postal" data-fieldname="Zip/Postal Code" placeholder="Zip/Postal Code" maxlength="10" value="${prevPostalCode}" aria-required="true" />
		</div>
		<div class="field">
			<label for="shippingAddrPhone"><fmt:message key="checkout.address.phone" /><span class="required-label">*</span></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" id="shippingAddrPhone" name="shippingAddrPhone" type="tel" autocapitalize="off" data-validation="required usphone" data-fieldname="Phone Number" placeholder="(555) 123-4567" iclass="phone" value="${prevPhone}" aria-required="true" />
		</div>
	</div>
	
	<div class="field-group">
		<label for="shippingAddrEmail"><fmt:message key="checkout.address.email" /><span class="required-label">*</span></label>
		<dsp:input bean="PaymentGroupFormHandler.shippingAddress.email" id="shippingAddrEmail" name="shippingAddrEmail" type="email" autocapitalize="off" data-validation="required email" data-fieldname="Email Address" placeholder="you@domain.com" maxlength="40" value="${prevEmail}" aria-required="true" />
	</div>
	
	<div class="field-group custom-checkbox">
		<input type="checkbox" id="shippingAddrInstruction" name="shippingAddrInstruction" /> 
		<label for="shippingAddrInstruction"><fmt:message key="checkout.shipping.deliveryInstruction" /></label>
		<div class="specialDeliveryInstructions">
			<div class="textCounterContainer counter"><span id="textCount">0</span>&nbsp;&#47;&nbsp;<fmt:message key="checkout.shipping.deliveryInstructionCharacter" /></div>
			<dsp:textarea bean="PaymentGroupFormHandler.specialInstructions" id="shippingAddrInstructionDetails" placeholder="" maxlength="400">${specialIntr}</dsp:textarea>
		</div>
	</div>
	
</dsp:page>
