<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:getvalueof var="index" param="index"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<c:choose>
		<c:when test="${index eq 1}">
			<c:set var="shipToBill" value="shipToBill1"/>
			<c:set var="sameAddr" value="sameAddr1"/>
			<c:set var="billAddr" value="billAddr1"/>
		</c:when>
		<c:otherwise>
			<c:set var="shipToBill" value="shipToBill"/>
			<c:set var="sameAddr" value="sameAddr"/>
			<c:set var="billAddr" value="billAddr"/>
		</c:otherwise>
	</c:choose>

	<dsp:getvalueof var="payGroup" param="payGroup"/>

	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" value="${payGroup}" />
		<dsp:oparam name="false">
			<dsp:getvalueof var="prevfirstname" value="${payGroup.billingAddress.firstName}"/>
			<dsp:getvalueof var="prevlastname" value="${payGroup.billingAddress.lastName}"/>
			<dsp:getvalueof var="prevaddress1" value="${payGroup.billingAddress.address1}"/>
			<dsp:getvalueof var="prevaddress2" value="${payGroup.billingAddress.address2}"/>
			<dsp:getvalueof var="prevcity" value="${payGroup.billingAddress.city}"/>
			<dsp:getvalueof var="prevpostalcode" value="${payGroup.billingAddress.postalCode}"/>
			<dsp:getvalueof var="prevphonenumber" value="${payGroup.billingAddress.phoneNumber}"/>
			<dsp:getvalueof var="prevaltphoneNumber" value="${payGroup.billingAddress.altPhoneNumber}"/>
			<dsp:getvalueof var="prevemail" value="${payGroup.billingAddress.email}"/>
			<dsp:getvalueof var="prevstate" value="${payGroup.billingAddress.state}"/>
			<dsp:getvalueof var="prevcountry" value="${payGroup.billingAddress.country}"/>
		</dsp:oparam>
	</dsp:droplet>

	<fieldset data-module="toggle" class="billadd-check toggle" class="toggle" data-module="toggle">
		<legend><fmt:message key="checkout.deliveryAndPayment.sameAsDelivery" /></legend>
		<label for="${shipToBill}"></label>
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="true" id="${shipToBill}"/>
		<input type="checkbox" name="billAdd" class="billAdd" checked="true" id="${sameAddr}"/>
		<label for="${sameAddr}" class="sameAddrLabel"><fmt:message key="checkout.deliveryAndPayment.sameAsDelivery" /></label>
	</fieldset>

	<fieldset class="${billAddr} billadd-check data-instructions">
		<legend>Delivery Address Form</legend>
		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.firstName"/></legend>
			<label for="billFName${index}"><fmt:message key="checkout.deliveryAndPayment.firstName"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].firstName" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].firstName" value="${prevfirstname}" maxlength="20" type="text" name="billFName${index}" id="billFName${index}" required="required"/><br/>
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].firstName" beanvalue="PaymentGroupFormHandler.billingAddress[param:index].firstName" maxlength="20" type="text" name="billFName${index}" id="billFName${index}" required="required"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<label for="billSName${index}"><fmt:message key="checkout.deliveryAndPayment.lastName"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].lastName" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].lastName"  value="${prevlastname}" maxlength="30" type="text" name="billSName${index}" id="billSName${index}" required="required" /><br/>
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].lastName"  beanvalue="PaymentGroupFormHandler.billingAddress[param:index].lastName" maxlength="30" type="text" name="billSName${index}" id="billSName${index}" required="required"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.city"/></legend>
			<dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_bill_stateSelect${index}" />
			<dsp:getvalueof var="countryPicker" vartype="java.lang.String" value="atg_store_bill_countryNameSelect${index}" />
			<dsp:param name="countryCode" bean="PaymentGroupFormHandler.billingAddress[param:index].country"/>
			<c:choose>
				<c:when test="${not empty countryCode}">
					<dsp:param name="countryCode" value="${countryCode}"/>
					<dsp:param name="country" value="${countryCode}"/>
				</c:when>
			</c:choose>
			<label for="selCountry${index}"><fmt:message key="checkout.deliveryAndPayment.country"/></label>
			<c:choose>
				<c:when test="${empty currentStore || empty currentStore.country}">
					<dsp:select iclass="custom_select" bean="PaymentGroupFormHandler.billingAddress[param:index].country" id="selCountry${index}" name="selCountry${index}" onchange='populateState(this)'>
					<%@include file="/includes/global/countryList.jsp"%>
				</dsp:select>
				</c:when>
			<c:otherwise>
				<dsp:param name="countryCode" value="${currentStore.country}"/>
				<dsp:select iclass="custom_select" bean="PaymentGroupFormHandler.billingAddress[param:index].country" id="selCountry${index}" name="selCountry${index}" onchange='populateState(this)'>
					<dsp:option value="${currentStore.country}" selected="true"><fmt:message key="country.${currentStore.country}"/></dsp:option>
				</dsp:select>
			</c:otherwise>
			</c:choose>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.addressOne"/></legend>
			<label for="billAddr1${index}"><fmt:message key="checkout.deliveryAndPayment.addressOne"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].address1" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address1" value="${prevaddress1}" size="30" type="text" name="billAddr1${index}" id="billAddr1${index}" required="required"/><br/>
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address1" beanvalue="PaymentGroupFormHandler.billingAddress[param:index].address1" size="30" type="text" name="billAddr1${index}" id="billAddr1${index}" required="required"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.addressTwo"/></legend>
			<label for="billAddr2${index}"><fmt:message key="checkout.deliveryAndPayment.addressTwo"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].address2" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address2"  value="${prevaddress2}" size="30" type="text" name="billAddr2${index}" id="billAddr2${index}"/><br/>
				</dsp:oparam>		
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].address2"  beanvalue="PaymentGroupFormHandler.billingAddress[param:index].address2" size="30" type="text" name="billAddr2${index}" id="billAddr2${index}"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.city"/></legend>
			<label for="billCity${index}"><fmt:message key="checkout.deliveryAndPayment.city"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].city" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].city"   value="${prevcity}" size="30" type="text" name="billCity${index}" id="billCity${index}" required="required" /><br/>
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].city"  beanvalue="PaymentGroupFormHandler.billingAddress[param:index].city" size="30" type="text" name="billCity${index}" id="billCity${index}" required="required" /><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.stateProvince"/></legend>
			<label for="selState${index}"><fmt:message key="checkout.deliveryAndPayment.stateProvince"/><sup>&#42</sup></label>
			<dsp:getvalueof var="state" bean="PaymentGroupFormHandler.billingAddress[param:index].state"/>
			<c:if test="${empty state}">
				<dsp:getvalueof var="state" value="${prevstate}" />
			</c:if>
			<dsp:param name="statePicker" value="${state}"/>
			
			<dsp:select bean="PaymentGroupFormHandler.billingAddress[param:index].state" nodefault="true" name="selState${index}" id="selState${index}" required="required">
				<%@include file="/includes/global/countryState.jsp"%>
			</dsp:select>
		</fieldset>

		<fieldset>
			<label for="billZipCode${index}"><fmt:message key="checkout.deliveryAndPayment.zipPostalCode"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].postalCode" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].postalCode"  value="${prevpostalcode}" size="10" type="text" name="billZipCode${index}" id="billZipCode${index}" /><br/>
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].postalCode"  beanvalue="PaymentGroupFormHandler.billingAddress[param:index].postalCode" size="10" type="text" name="billZipCode${index}" id="billZipCode${index}" /><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.phoneNumber"/></legend>
			<label for="billPhone${index}"><fmt:message key="checkout.deliveryAndPayment.phoneNumber"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].phoneNumber" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].phoneNumber" value="${prevphonenumber}" size="11" type="text" name="billPhone${index}" id="billPhone${index}"/><br/>				
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].phoneNumber" beanvalue="PaymentGroupFormHandler.billingAddress[param:index].phoneNumber" size="11" type="text" name="billPhone${index}" id="billPhone${index}"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.altPhoneNumber"/></legend>
			<label for="billAltPhone${index}"><fmt:message key="checkout.deliveryAndPayment.altPhoneNumber"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].altPhoneNumber" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].altPhoneNumber" value="${prevaltphoneNumber}" size="11" type="text" name="billAltPhone${index}" id="billAltPhone${index}"/><br/>				
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].altPhoneNumber" beanvalue="PaymentGroupFormHandler.billingAddress[param:index].altPhoneNumber" size="11" type="text" name="billAltPhone${index}" id="billAltPhone${index}"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.emailAddress"/></legend>
			<label for="billEmailAddress${index}"><fmt:message key="checkout.deliveryAndPayment.emailAddress"/></label>
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" bean="PaymentGroupFormHandler.billingAddress[param:index].email" />
				<dsp:oparam name="true">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].email"  value="${prevemail}" size="30" type="text" name="billEmailAddress${index}" id="billEmailAddress${index}" required="required"/><br/>				
				</dsp:oparam>
				<dsp:oparam name="false">
					<dsp:input bean="PaymentGroupFormHandler.billingAddress[param:index].email"  beanvalue="PaymentGroupFormHandler.billingAddress[param:index].email" size="30" type="text" name="billEmailAddress${index}" id="billEmailAddress${index}" required="required"/><br/>
				</dsp:oparam>
			</dsp:droplet>
		</fieldset>

	</fieldset>
</dsp:page>