<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/com/lzb/service/SessionBean" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

	<html>
<head>
<title>LZB Card</title>
</head>
<body>
	<h1>LZB Card version 1.2</h1>
	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />
	deliveryAndPaymentSynchronyCard version 1.8<br />
	OrderId=<dsp:valueof bean="ShoppingCart.current.id" />
	<br />
	From Session:ShopperId=<dsp:valueof bean="SessionBean.gEShopperId" />
	<br />
        From Session:Token=<dsp:valueof bean="SessionBean.gEToken" />
	<br />

	<dsp:getvalueof bean="PaymentGroupFormHandler.formError"
		var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">	<dsp:param name="formHandler" bean="PaymentGroupFormHandler" />
		</dsp:include>
	</c:if>
	<dsp:setvalue bean="PaymentGroupFormHandler.termsAndConditions" value="true"/>
	<dsp:setvalue bean="PaymentGroupFormHandler.skipValidation" value="true"/>



	<dsp:droplet name="ForEach">
			<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups" />
			<dsp:param name="elementName" value="SGroup" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="ship" param="SGroup" />
			</dsp:oparam>
			<dsp:oparam name="error">
			error
			</dsp:oparam>
		</dsp:droplet>

	<dsp:form action="/checkout/delivery.jsp"	method="POST">
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/orderReview.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/delivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.termsAndConditions" type="hidden" value="true"/>
	<dsp:input bean="PaymentGroupFormHandler.skipvalidation" type="hidden" value="true"/>

	<c:if test="${displayNickName}">
			<label><fmt:message
					key="checkout.deliveryAndPayment.nickName" /></label>
			<dsp:input bean="PaymentGroupFormHandler.shippingAddrNickName"
				beanvalue="PaymentGroupFormHandler.shippingAddrNickName"
				maxlength="20" type="text" />
			<br />
		</c:if>

		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" value="${ship.shippingAddress}" />
			<dsp:oparam name="false">
				<dsp:getvalueof var="prevfirstname"
					value="${ship.shippingAddress.firstName}" />
				<dsp:getvalueof var="prevlastname"
					value="${ship.shippingAddress.lastName}" />
				<dsp:getvalueof var="prevaddress1"
					value="${ship.shippingAddress.address1}" />
				<dsp:getvalueof var="prevaddress2"
					value="${ship.shippingAddress.address2}" />
				<dsp:getvalueof var="prevcity" value="${ship.shippingAddress.city}" />
				<dsp:getvalueof var="prevpostalcode"
					value="${ship.shippingAddress.postalCode}" />
				<dsp:getvalueof var="prevphonenumber"
					value="${ship.shippingAddress.phoneNumber}" />
				<dsp:getvalueof var="prevAltphonenumber"
					value="${ship.shippingAddress.altPhoneNumber}" />
				<dsp:getvalueof var="prevemail"
					value="${ship.shippingAddress.email}" />
				<dsp:getvalueof var="prevstate"
					value="${ship.shippingAddress.state}" />
				<dsp:getvalueof var="prevcountry"
					value="${ship.shippingAddress.country}" />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message
				key="checkout.deliveryAndPayment.firstName" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.firstName" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.firstName"
					value="${prevfirstname}" maxlength="20" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.firstName"
					beanvalue="PaymentGroupFormHandler.shippingAddress.firstName"
					maxlength="20" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>


		<label><fmt:message key="checkout.deliveryAndPayment.lastName" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.lastName" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.lastName"
					value="${prevlastname}" size="30" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.lastName"
					beanvalue="PaymentGroupFormHandler.shippingAddress.lastName"
					size="30" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>


		<label><fmt:message key="checkout.deliveryAndPayment.country" /></label>
		<dsp:getvalueof var="statePicker" vartype="java.lang.String"
			value="atg_store_stateSelect" />
		<dsp:getvalueof var="countryPicker" vartype="java.lang.String"
			value="atg_store_countryNameSelect" />
		<dsp:param name="countryCode"
			bean="PaymentGroupFormHandler.shippingAddress.country" />
		<c:if test="${empty countryCode}">
			<dsp:getvalueof var="countryCode" value="${prevcountry}" />
		</c:if>
		<c:choose>
			<c:when test="${not empty countryCode}">
				<dsp:param name="countryCode" value="${countryCode}" />
				<dsp:param name="country" value="${countryCode}" />
			</c:when>
		</c:choose>

		<span class="selct"> <dsp:select iclass="custom_select"
				bean="PaymentGroupFormHandler.shippingAddress.country"
				id="selCountry" name="selCountry" onchange='populateState(this)'>
				<%@include file="/includes/global/countryList.jsp"%>
			</dsp:select>
		</span>
		<br />

		<label><fmt:message
				key="checkout.deliveryAndPayment.addressOne" /></label>


		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.address1" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address1"
					value="${prevaddress1}" size="30" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address1"
					beanvalue="PaymentGroupFormHandler.shippingAddress.address1"
					size="30" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message
				key="checkout.deliveryAndPayment.addressTwo" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.address2" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address2"
					value="${prevaddress2}" size="30" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.address2"
					beanvalue="PaymentGroupFormHandler.shippingAddress.address2"
					size="30" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message key="checkout.deliveryAndPayment.city" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.city" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.city"
					value="${prevcity}" size="30" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.city"
					beanvalue="PaymentGroupFormHandler.shippingAddress.city" size="30"
					type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>


		<label><fmt:message
				key="checkout.deliveryAndPayment.stateProvince" /></label>
		<dsp:getvalueof var="state"
			bean="PaymentGroupFormHandler.shippingAddress.state" />
		<c:if test="${empty state}">
			<dsp:getvalueof var="state" value="${prevstate}" />
		</c:if>
		<dsp:param name="statePicker" value="${state}" />

		<span class="selct"> <dsp:select name="atg_store_stateSelect"
				id="atg_store_stateSelect"
				bean="PaymentGroupFormHandler.shippingAddress.state"
				nodefault="true">
				<%@include file="/includes/global/countryState.jsp"%>
			</dsp:select>
		</span>
		<br />

		<label><fmt:message
				key="checkout.deliveryAndPayment.zipPostalCode" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.postalCode" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.postalCode"
					value="${prevpostalcode}" size="10" type="text" id="shiPostalCode" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.postalCode"
					beanvalue="PaymentGroupFormHandler.shippingAddress.postalCode"
					id="shiPostalCode" size="10" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message
				key="checkout.deliveryAndPayment.phoneNumber" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" />
			<dsp:oparam name="true">
				<dsp:input
					bean="PaymentGroupFormHandler.shippingAddress.phoneNumber"
					value="${prevphonenumber}" size="11" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input
					bean="PaymentGroupFormHandler.shippingAddress.phoneNumber"
					beanvalue="PaymentGroupFormHandler.shippingAddress.phoneNumber"
					size="11" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message
				key="checkout.deliveryAndPayment.altPhoneNumber" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" />
			<dsp:oparam name="true">
				<dsp:input
					bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber"
					value="${prevAltphonenumber}" size="11" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input
					bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber"
					beanvalue="PaymentGroupFormHandler.shippingAddress.altPhoneNumber"
					size="11" type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<label><fmt:message
				key="checkout.deliveryAndPayment.emailAddress" /></label>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value"
				bean="PaymentGroupFormHandler.shippingAddress.email" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.email"
					value="${prevemail}" size="30" type="text" />
				<br />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.shippingAddress.email"
					beanvalue="PaymentGroupFormHandler.shippingAddress.email" size="30"
					type="text" />
				<br />
			</dsp:oparam>
		</dsp:droplet>

		<dsp:param name="payGroup" param="payGroup" />
		<dsp:getvalueof var="payGroupvar" param="payGroup" />
		<dsp:setvalue bean="PaymentGroupFormHandler.termsAndConditions"
			value="true" />


	  <label><fmt:message
				key="checkout.deliveryAndPayment.creditCardNumber" /></label>

		<dsp:input type="text"	bean="PaymentGroupFormHandler.synchronyCardNumber" />  <br/>


		<label><fmt:message
				key="checkout.deliveryAndPayment.cardExpiration" /></label>
		<dsp:select bean="PaymentGroupFormHandler.expirationMonth">
			<dsp:option>
				<fmt:message key="common.month" />
			</dsp:option>
			<%-- Display months --%>
			<c:forEach var="count" begin="1" end="12" step="1" varStatus="status">
				<dsp:option value="${count}">
					<fmt:message key="common.month${count}" />
				</dsp:option>
			</c:forEach>
		</dsp:select>
		<jsp:useBean id="date" class="java.util.Date" />
		<c:set var="currentYear">
			<fmt:formatDate value="${date}" pattern="yyyy" />
		</c:set>

		<dsp:select bean="PaymentGroupFormHandler.expirationYear" id="year">
			<dsp:option value="">
				<fmt:message key="common.year" />
			</dsp:option>
			<c:forEach var="i" begin="${currentYear}" end="${currentYear+15}">
				<dsp:option value="${i}">${i}</dsp:option>
			</c:forEach>
		</dsp:select>

                <dsp:input type="submit" bean="PaymentGroupFormHandler.applyShippingBillingInfo" value="SUBMIT NEXT" />
	</dsp:form>

</body>
	</html>

</dsp:page>
