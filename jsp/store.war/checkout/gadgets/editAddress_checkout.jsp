<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError"/>
	<dsp:importbean bean="/atg/commerce/util/StateListDroplet" />

	<dsp:getvalueof var="nickName" param="nickName" />
	<dsp:getvalueof var="defaultAddress" bean="Profile.shippingAddress.repositoryId" />
	<dsp:getvalueof var="address" bean="Profile.secondaryAddresses.${nickName}" />
	<dsp:getvalueof var="countryValue" value="${address.country }" scope="page" />

	<dsp:getvalueof var="state" value="${address.state }" scope="page"/>
	<dsp:getvalueof var="defaultBilling" bean="Profile.billingAddress.repositoryId" />
	<dsp:getvalueof var="defaultShipping" bean="Profile.shippingAddress.repositoryId" />

	<dsp:getvalueof var="isCheckoutFlow" param="isCheckoutFlow"/>


	<div style="width: 650px;padding: 25px;">
		<c:if test="${formError eq 'true'}">
			<dsp:include page="/global/errors.jsp">
				<dsp:param name="formHandler" bean="ProfileFormHandler"/>
			</dsp:include>
		</c:if>

		<h1><fmt:message key="address.editAddress"/></h1>

		<dsp:form name="editAddressInfo" method="post" action="#" iclass="standard-border">
			<fieldset>
				<fieldset>
					<legend><fmt:message key="address.nickname"/></legend>
					<label for="addNickName"><fmt:message key="address.nickname"/> <span>&#42</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.newNickName" name="newNickName"
						value="${nickName}" maxlength="50" required="required" iclass="cv-check" />
					<dsp:input type="hidden" bean="ProfileFormHandler.profileValueMap.nickName" name="nickName" value="${nickName}"  />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.firstName"/></legend>
					<label for="fname"><fmt:message key="address.firstName"/> <span>&#42</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.firstName"
						value="${address.firstName}" maxlength="50"  />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.lastName"/></legend>
					<label for="lname"><fmt:message key="address.lastName"/> <span>*</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.lastName"
						value="${address.lastName}" maxlength="50"  />
				</fieldset>

				<fieldset></fieldset>
					<legend><fmt:message key="address.country"/></legend>
					<label for="atg_store_countryNameSelect"><fmt:message key="address.country"/> <span>*</span></label>
		            <dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
		            <dsp:getvalueof var="countryPicker" vartype="java.lang.String" value="atg_store_countryNameSelect" />

		            <dsp:getvalueof var="country" bean="ProfileFormHandler.profileValueMap.country"/>
					<c:if test="${empty country}">
						<dsp:getvalueof var="country" value="${address.country}" />
					</c:if>
					<dsp:param name="country" value="${country}" />
					<dsp:param name="countryCode" value="${country}" />

					<span>
					   <dsp:select id="atg_store_countryNameSelect" name="atg_store_countryNameSelect" bean="ProfileFormHandler.profileValueMap.country"
						required="${requiredTrueText}" onchange='populateState(this)'>
						<%@include file="/includes/global/countryList.jsp"%>
						</dsp:select>
					</span>
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.address1"/></legend>
					<label for="addrss1"><fmt:message key="address.address1"/> <span>*</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.address1"
						value="${address.address1}" maxlength="80"  />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.address2"/></legend>
					<label for="addrss2" ><fmt:message key="address.address2"/></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.address2"
						value="${address.address2}" maxlength="80"  />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.city"/></legend>
					<label for="city"><fmt:message key="address.city"/> <span>*</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.city"
						value="${address.city}" maxlength="40"  />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.state"/></legend>
					<label for="atg_store_stateSelect"><fmt:message key="address.state"/> <span>*</span></label>
				    <dsp:getvalueof var="state" bean="ProfileFormHandler.profileValueMap.state"/>
					<c:if test="${empty state}">
						<dsp:getvalueof var="state" value="${address.state}" />
					</c:if>

					<dsp:param name="statePicker" value="${state}" />
					<span class="selct">
						<dsp:select name="atg_store_stateSelect" id="atg_store_stateSelect"
								bean="ProfileFormHandler.profileValueMap.state" nodefault="true">
								<%@include file="/includes/global/countryState.jsp"%>
						</dsp:select>
					</span>
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.postalCode"/></legend>
					<label for="postal"><fmt:message key="address.postalCode"/> <span>*</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.postalCode"
						value="${address.postalCode }" maxlength="10" />
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.phoneNumber"/></legend>
					<label for="phoneNumber"><fmt:message key="address.phoneNumber"/> <span>*</span></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.phoneNumber"
						value="${address.phoneNumber}" maxlength="14"/>
				</fieldset>

				<fieldset>
					<legend><fmt:message key="address.altPhoneNumber"/></legend>
					<label for="altPhoneNumber"><fmt:message key="address.altPhoneNumber"/></label>
					<dsp:input type="text"
						bean="ProfileFormHandler.profileValueMap.altPhoneNumber"
						value="${address.altPhoneNumber}" maxlength="14"/>
				</fieldset>

				<fieldset>
					<label for="emailAddress"><fmt:message key="address.emailAddress"/></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.email"
						value="${address.email}" maxlength="50"/>
				</fieldset>

				<fieldset class="editaddrBox">
			        <dsp:input type="checkbox" id="atg_store_useShippingAddressAsDefault"
			            bean="ProfileFormHandler.useShippingAddressAsDefault" checked="${address.repositoryId == defaultShipping}" />
			        <legend><fmt:message key="address.setAsPrimaryDelAddr"/></legend>
			        <label for="atg_store_useShippingAddressAsDefault"><fmt:message key="address.setAsPrimaryDelAddr"/></label>
				</fieldset>

				<fieldset class="editaddrBox">
			        <dsp:input type="checkbox" id="atg_store_userBillingAddressAsDefault"
			            bean="ProfileFormHandler.useBillingAddressAsDefault" checked="${address.repositoryId == defaultBilling}" />
			        <legend><fmt:message key="address.setAsPrimaryBillAddr"/></legend>
			        <label for="atg_store_userBillingAddressAsDefault"><fmt:message key="address.setAsPrimaryBillAddr"/></label>
				</fieldset>

				<fieldset>
			        <dsp:input type="hidden" bean="ProfileFormHandler.profileValueMap.addressSuccessURL" value="/checkout/deliveryAndPayment.jsp?successMsg=edit" />
					<dsp:input type="hidden" bean="ProfileFormHandler.profileValueMap.addressErrorURL" value="/checkout/gadgets/editAddress_checkout.jsp?nickName=${nickName}" />

					<dsp:a href="/checkout/deliveryAndPayment.jsp" title="" iclass="linkCancel push01" beanvalue="ProfileFormHandler.cancel">cancel</dsp:a>
					<dsp:input type="submit" value="Save" bean="ProfileFormHandler.updateAddress" />
				</fieldset>
			</fieldset>
		</dsp:form>

	</div>

</dsp:page>
