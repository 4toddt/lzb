<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />

	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	
	<dsp:droplet name="ForEach">
		<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups"/>
		<dsp:param name="elementName" value="SGroup"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="ship" param="SGroup"/>
		</dsp:oparam>
	</dsp:droplet>

	<dsp:getvalueof param="displayNickNameField" var="displayNickName"/>
	<c:if test="${displayNickName}">
		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.nickName"/></legend>
			<label for="nickName" id="lblnickName"><fmt:message key="checkout.deliveryAndPayment.nickName"/><sup>&#42</sup></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddrNickName" beanvalue="PaymentGroupFormHandler.shippingAddrNickName" 
				maxlength="20" type="text" name="nickName" id="nickName" title="nickname"
				required="required" >
				<dsp:tagAttribute name="aria-labelledby" value="lblnickName errnickName" />
			</dsp:input>
		</fieldset>
	</c:if>
	
	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" value="${ship.shippingAddress}" />
		<dsp:oparam name="false">
			<dsp:getvalueof var="prevfirstname" value="${ship.shippingAddress.firstName}"/>
			<dsp:getvalueof var="prevlastname" value="${ship.shippingAddress.lastName}"/>
			<dsp:getvalueof var="prevaddress1" value="${ship.shippingAddress.address1}"/>
			<dsp:getvalueof var="prevaddress2" value="${ship.shippingAddress.address2}"/>
			<dsp:getvalueof var="prevcity" value="${ship.shippingAddress.city}"/>
			<dsp:getvalueof var="prevpostalcode" value="${ship.shippingAddress.postalCode}"/>
			<dsp:getvalueof var="prevphonenumber" value="${ship.shippingAddress.phoneNumber}"/>
			<dsp:getvalueof var="prevAltphonenumber" value="${ship.shippingAddress.altPhoneNumber}"/>
			<dsp:getvalueof var="prevemail" value="${ship.shippingAddress.email}"/>
			<dsp:getvalueof var="prevstate" value="${ship.shippingAddress.state}"/>
			<dsp:getvalueof var="prevcountry" value="${ship.shippingAddress.country}"/>
		</dsp:oparam>
	</dsp:droplet>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.firstName"/></legend>
		<label for="fName" id="lblfName"><fmt:message key="checkout.deliveryAndPayment.firstName"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.firstName" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.firstName"  value="${prevfirstname}"  
					maxlength="20" type="text" iclass="cv-check" name="fName" 
					id="fName" title="First Name" required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblfName errfName" />
				</dsp:input>
				<br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.firstName" beanvalue="PaymentGroupFormHandler.shippingAddress.firstName" 
					maxlength="20" type="text" iclass="cv-check" 
					name="fName" id="fName" title="First Name" required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblfName errfName" />
				</dsp:input>
				<br/>
			</dsp:oparam>
		</dsp:droplet>
		
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.lastName"/></legend>
		<label for="sName" id="lblsName"><fmt:message key="checkout.deliveryAndPayment.lastName"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.lastName" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.lastName"  value="${prevlastname}" 
					size="30" type="text" iclass="cv-check" 
					name="sName" id="sName" title="Last Name" required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblsName errsName" />
				</dsp:input>
				<br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.lastName"  beanvalue="PaymentGroupFormHandler.shippingAddress.lastName" 
					size="30" type="text" iclass="cv-check" 
					name="sName" id="sName" title="Last Name" required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblsName errsName" />
				</dsp:input>
				<br/>			
			</dsp:oparam>
		</dsp:droplet>
		
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.country"/></legend>
		<label for="country" id="lblcountry"><fmt:message key="checkout.deliveryAndPayment.country"/><sup>&#42</sup></label>
		<dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
		<dsp:getvalueof var="countryPicker" vartype="java.lang.String" value="atg_store_countryNameSelect" />
		<dsp:param name="countryCode" bean="PaymentGroupFormHandler.shippingAddress.country"/>
		<c:if test="${empty countryCode}">
			<dsp:getvalueof var="countryCode" value="${prevcountry}" />
		</c:if>
		<c:choose>
			<c:when test="${not empty countryCode}">
				<dsp:param name="countryCode" value="${countryCode}"/>
				<dsp:param name="country" value="${countryCode}"/>
			</c:when>
		</c:choose>
		<c:choose>
		<c:when test="${empty currentStore || empty currentStore.country}">
			<dsp:select iclass="custom_select" bean="PaymentGroupFormHandler.shippingAddress.country" 
				onchange='populateState(this)' name="country"  id="country" 
				iclass="cv-check" title="Country" required="required">
				<dsp:tagAttribute name="data-cv-type" value="dropdown" />
				<dsp:tagAttribute name="aria-labelledby" value="lblcountry errcountry" />
				<%@include file="/includes/global/countryList.jsp"%>
			</dsp:select>
		</c:when>
		<c:otherwise>
			<dsp:param name="countryCode" value="${currentStore.country}"/>
			<dsp:select iclass="custom_select" bean="PaymentGroupFormHandler.shippingAddress.country" 
				onchange='populateState(this)' name="country"  id="country" 
				iclass="cv-check" title="Country" required="required">
				<dsp:tagAttribute name="data-cv-type" value="dropdown"/>
				<dsp:tagAttribute name="aria-labelledby" value="lblcountry errcountry"/>
				<dsp:option value="${currentStore.country}" selected="true"><fmt:message key="country.${currentStore.country}"/></dsp:option>
			</dsp:select>
		</c:otherwise>
		</c:choose>		
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.addressOne"/></legend>
		<label for="addr1" id="lbladdr1"><fmt:message key="checkout.deliveryAndPayment.addressOne"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.address1" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address1" value="${prevaddress1}" 
					size="30" type="text" name="addr1" id="addr1" 
					iclass="cv-check" title="Address 1"  required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lbladdr1 erraddr1" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address1" beanvalue="PaymentGroupFormHandler.shippingAddress.address1" 
					size="30" type="text" name="addr1" id="addr1" 
					iclass="cv-check" title="Address 1"  required="required">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lbladdr1 erraddr1" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.addressTwo"/></legend>
		<label for="addr2" id="lbladdr2"><fmt:message key="checkout.deliveryAndPayment.addressTwo"/></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.address2" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address2"  value="${prevaddress2}" 
					size="30" type="text"  name="addr2" id="addr2" title="Address 2">
					<dsp:tagAttribute name="aria-labelledby" value="lbladdr2 erraddr2" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address2"  beanvalue="PaymentGroupFormHandler.shippingAddress.address2" 
					size="30" type="text"  name="addr2" id="addr2" title="Address 2">
					<dsp:tagAttribute name="aria-labelledby" value="lbladdr2 erraddr2" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.city"/></legend>
		<label for="city" id="lblcity"><fmt:message key="checkout.deliveryAndPayment.city"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.city" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.city"  value="${prevcity}" 
					size="30" type="text" name="city" id="city" 
					iclass="cv-check" required="required" title="City">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblcity errcity" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.city"  beanvalue="PaymentGroupFormHandler.shippingAddress.city" 
					size="30" type="text" name="city" id="city" 
					iclass="cv-check"  required="required" title="City">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblcity errcity" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.stateProvince"/></legend>
		<label for="state" id="lblstate"><fmt:message key="checkout.deliveryAndPayment.stateProvince"/><sup>&#42</sup></label>
		<dsp:getvalueof var="state" bean="PaymentGroupFormHandler.shippingAddress.state"/>
		<c:if test="${empty state}">
			<dsp:getvalueof var="state" value="${prevstate}" />
		</c:if>
		<dsp:param name="statePicker" value="${state}"/>
		
		<dsp:select bean="PaymentGroupFormHandler.shippingAddress.state" nodefault="true" 
			name="state" id="state" iclass="cv-check" 
			title="State" required="required">
			<dsp:tagAttribute name="data-cv-type" value="dropdown" />
			<dsp:tagAttribute name="aria-labelledby" value="lblstate errstate" />
			<%@include file="/includes/global/countryState.jsp"%>
		</dsp:select>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.zipPostalCode"/></legend>
		<label for="zipCode" id="lblzipCode"><fmt:message key="checkout.deliveryAndPayment.zipPostalCode"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.postalCode" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.postalCode" size="10" 
					type="text" iclass="cv-check"  
					name="zipCode" id="zipCode" title="ZIP / Postal Code">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblzipCode errzipCode" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.postalCode"  beanvalue="PaymentGroupFormHandler.shippingAddress.postalCode" 
					size="10" type="text" iclass="cv-check"  
					name="zipCode" id="zipCode" title="ZIP / Postal Code">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblzipCode errzipCode" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.phoneNumber"/></legend>
		<label for="phone" id="lblphone"><fmt:message key="checkout.deliveryAndPayment.phoneNumber"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" value="${prevphonenumber}" 
					size="11" type="text" name="phone" id="phone" 
					iclass="cv-check" required="required" title="Phone Number">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblphone errphone" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" beanvalue="PaymentGroupFormHandler.shippingAddress.phoneNumber" 
					size="11" type="text" name="phone" id="phone" 
					iclass="cv-check" required="required" title="Phone Number">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblphone errphone" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset class="alter-phone">
		<legend><fmt:message key="checkout.deliveryAndPayment.altPhoneNumber"/></legend>
		<label for="altphone" id="lblaltphone"><fmt:message key="checkout.deliveryAndPayment.altPhoneNumber"/></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" value="${prevAltphonenumber}" size="11" type="text" name="altphone" id="altphone" title="Alternative Phone Number">
					<dsp:tagAttribute name="aria-labelledby" value="lblaltphone erraltphone" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" beanvalue="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" size="11" type="text" name="altphone" id="altphone" title="Alternative Phone Number">
					<dsp:tagAttribute name="aria-labelledby" value="lblaltphone erraltphone" />
				</dsp:input><br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.emailAddress"/></legend>
		<label for="emailAddress" id="lblemailAddress"><fmt:message key="checkout.deliveryAndPayment.emailAddress"/><sup>&#42</sup></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" bean="PaymentGroupFormHandler.shippingAddress.email" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.email"  value="${prevemail}" 
					size="30" type="text" name="emailAddress" id="emailAddress" 
					iclass="cv-check" required="required" title="Email Address">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblemailAddress erremailAddress" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.email"  beanvalue="PaymentGroupFormHandler.shippingAddress.email" 
					size="30" type="text" name="emailAddress" id="emailAddress" 
					iclass="cv-check" required="required" title="Email Address">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblemailAddress erremailAddress" />
				</dsp:input>
				<br/>			
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

</dsp:page>