<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/com/lzb/service/SessionBean" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

	<html>
<head>
<title>TEST LZB DELIVER</title>
</head>
<body>

	<dsp:getvalueof bean="PaymentGroupFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">	<dsp:param name="formHandler" bean="PaymentGroupFormHandler" />
		</dsp:include>
	</c:if>

	<dsp:droplet name="ForEach">
	<dsp:param name="array" bean="ShoppingCart.current.commerceItems" />
	<dsp:param name="elementName" value="comItems" />
	<dsp:oparam name="output">
		BAG: <dsp:valueof param="comItems.auxiliaryData.productRef.displayName"/></br>
	</dsp:oparam>
	<dsp:oparam name="empty">
			EMPTY CART</br>
	</dsp:oparam>
	</dsp:droplet>
	</br>
	<dsp:droplet name="ForEach">
	<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups" />
	<dsp:param name="elementName" value="SGroup" />
	<dsp:oparam name="output">
		ShippingGroup: <dsp:valueof param="SGroup.shippingAddress"/> </br>
	</dsp:oparam>
	<dsp:oparam name="error">
	error
	</dsp:oparam>
	</dsp:droplet>
	</br>
	<dsp:droplet name="ForEach">
	<dsp:param name="array" bean="ShoppingCart.current.paymentGroups" />
	<dsp:param name="elementName" value="PGroup" />
	<dsp:oparam name="output">
		PaymentGroup: <dsp:valueof param="PGroup.billingAddress"/> </br>
		CreditCardNum: <dsp:valueof param="PGroup.creditCardNumber"/> </br>
		CreditCardType: <dsp:valueof param="PGroup.creditCardType"/> </br>
		ExpirationYear <dsp:valueof param="PGroup.expirationYear"/></br>
		</br>		
	</dsp:oparam>
	<dsp:oparam name="error">
	error
	</dsp:oparam>
	</dsp:droplet>
	</br>


	</br>
	SHIPPING INFO TEST FORM
	</br>
	<dsp:form action="/checkout/delivery.jsp" name="deliveryForm" id="deliveryForm"	method="POST">
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.loggedInUser" type="hidden" value="false"/>
	<dsp:input bean="PaymentGroupFormHandler.addNewAddr" type="hidden" value="true"/>
	<dsp:input bean="PaymentGroupFormHandler.skipValidation" type="hidden" value="false"/>
	<dsp:input id="fName" name="fName "bean="PaymentGroupFormHandler.shippingAddress.firstName" type="text" value="Don" /></br>
	<dsp:input id="sName" name="sName " bean="PaymentGroupFormHandler.shippingAddress.lastName" type="text" value="Trump" /></br>
	<dsp:input id="country" name="country "bean="PaymentGroupFormHandler.shippingAddress.country" type="text" value="US" /></br>
	<dsp:input id="addr1" name="addr1 "bean="PaymentGroupFormHandler.shippingAddress.address1" type="text" value="1 B St" /></br>
	<dsp:input id="addr2" name="addr2 "bean="PaymentGroupFormHandler.shippingAddress.address2" type="text" value="" /></br>
	<dsp:input id="city" name="city "bean="PaymentGroupFormHandler.shippingAddress.city" type="text" value="Toledo" /></br>
	<dsp:input id="state" name="state "bean="PaymentGroupFormHandler.shippingAddress.state" type="text" value="OH" /></br>
	<dsp:input id="zipCode" name="zipCode "bean="PaymentGroupFormHandler.shippingAddress.postalCode" type="text" value="43623" /></br>
	<dsp:input id="phone" name="phone "bean="PaymentGroupFormHandler.shippingAddress.phoneNumber" type="text" value="222-333-2223" /></br>
	<dsp:input id="altphone" name="altphone "bean="PaymentGroupFormHandler.shippingAddress.altPhoneNumber" type="text" value="" /></br>
	<dsp:input id="emailAddress" name="emailAddress "bean="PaymentGroupFormHandler.shippingAddress.email" type="text" value="don@trump.com" /></br>
	<dsp:input bean="PaymentGroupFormHandler.specialInstructions" type="text" value="" /></br>
        <dsp:input type="submit" bean="PaymentGroupFormHandler.applyShippingInfo" value="SHIPPING INFO" />
	</dsp:form>
	</br>
	</br>
	</br>
	BILLING INFO TEST FORM
	</br>
	<dsp:form action="/checkout/testDelivery.jsp" name="paymentForm" id="paymentForm" method="POST">
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.loggedInUser" type="hidden" value="false"/>
	<dsp:input bean="PaymentGroupFormHandler.skipValidation" type="hidden" value="false"/>
	CC</br>
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.splitPayment" value="false" name="splitPay" id="splitPay" />
	<dsp:input bean="PaymentGroupFormHandler.addNewPaymtMethd" type="hidden" value="true"/>
	<dsp:input id="cardType0" bean="PaymentGroupFormHandler.creditCardType" type="text" value="Visa" /></br>
	<dsp:input id="CName0" bean="PaymentGroupFormHandler.cardHolderName" type="text" value="Test Test" /></br>
	<dsp:input id="ccNum0" bean="PaymentGroupFormHandler.creditCardNumber" type="text" value="4111111111111111" /></br>
	<dsp:input id="cardExpMonth0" bean="PaymentGroupFormHandler.expirationMonth" type="text" value="9" /></br>
	<dsp:input id="cardExpYear0" bean="PaymentGroupFormHandler.expirationYear" type="text" value="2020" /></br>
	<dsp:input id="secCode0" bean="PaymentGroupFormHandler.cardVerificationNumber" type="text" value="343" /></br>
	BILLING</br>
	<dsp:input bean="PaymentGroupFormHandler.addNewBillAddr" type="hidden" value="true"/>
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="false" id="shipToBill"/>
	<dsp:input id="billFName0" bean="PaymentGroupFormHandler.billingAddress[0].firstName" type="text" value="Don" /></br>
	<dsp:input id="billSName0" bean="PaymentGroupFormHandler.billingAddress[0].lastName" type="text" value="Trump" /></br>
	<dsp:input id="selCountry0" bean="PaymentGroupFormHandler.billingAddress[0].country" type="text" value="US" /></br>
	<dsp:input id="billAddr10" bean="PaymentGroupFormHandler.billingAddress[0].address1" type="text" value="1 B St" /></br>
	<dsp:input id="billAddr20" bean="PaymentGroupFormHandler.billingAddress[0].address2" type="text" value="" /></br>
	<dsp:input id="billCity0" bean="PaymentGroupFormHandler.billingAddress[0].city" type="text" value="Toledo" /></br>
	<dsp:input id="selState0" bean="PaymentGroupFormHandler.billingAddress[0].state" type="text" value="OH" /></br>
	<dsp:input id="billZipCode0" bean="PaymentGroupFormHandler.billingAddress[0].postalCode" type="text" value="43623" /></br>
	<dsp:input id="billPhone0" bean="PaymentGroupFormHandler.billingAddress[0].phoneNumber" type="text" value="304-333-2222" /></br>
	<dsp:input id="billAltPhone0" bean="PaymentGroupFormHandler.billingAddress[0].altPhoneNumber" type="text" value="" /></br>
	<dsp:input id="billEmailAddress0" bean="PaymentGroupFormHandler.billingAddress[0].email" type="text" value="don@trump.com" /></br>
	<dsp:input id="tAndS" bean="PaymentGroupFormHandler.termsAndConditions" type="hidden" value="true"/>
        <dsp:input type="submit" bean="PaymentGroupFormHandler.applyBillingInfo" value="BILLING INFO" />
	</dsp:form>
	</br>
	</br>
	BILLING INFO SPLIT PAYMENT TEST FORM
	</br>
	<dsp:form action="/checkout/testDelivery.jsp" name="paymentForm" id="paymentForm" method="POST">
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/testDelivery.jsp"/>
	<dsp:input bean="PaymentGroupFormHandler.loggedInUser" type="hidden" value="false"/>
	<dsp:input bean="PaymentGroupFormHandler.skipValidation" type="hidden" value="false"/>
	CC-0</br>
	<dsp:input bean="PaymentGroupFormHandler.addNewPaymtMethd" type="hidden" value="true"/>
	<dsp:input id="cardType0" bean="PaymentGroupFormHandler.creditCardType" type="text" value="Visa" /></br>
	<dsp:input id="CName0" bean="PaymentGroupFormHandler.cardHolderName" type="text" value="Test Test" /></br>
	<dsp:input id="ccNum0" bean="PaymentGroupFormHandler.creditCardNumber" type="text" value="4111111111111111" /></br>
	<dsp:input id="cardExpMonth0" bean="PaymentGroupFormHandler.expirationMonth" type="text" value="9" /></br>
	<dsp:input id="cardExpYear0" bean="PaymentGroupFormHandler.expirationYear" type="text" value="2020" /></br>
	<dsp:input id="secCode0" bean="PaymentGroupFormHandler.cardVerificationNumber" type="text" value="343" /></br>
	BILLING-0</br>
	<dsp:input bean="PaymentGroupFormHandler.addNewBillAddr" type="hidden" value="true"/>
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="false" id="shipToBill"/>
	<dsp:input id="billFName0" bean="PaymentGroupFormHandler.billingAddress[0].firstName" type="text" value="Don" /></br>
	<dsp:input id="billSName0" bean="PaymentGroupFormHandler.billingAddress[0].lastName" type="text" value="Trump" /></br>
	<dsp:input id="selCountry0" bean="PaymentGroupFormHandler.billingAddress[0].country" type="text" value="US" /></br>
	<dsp:input id="billAddr10" bean="PaymentGroupFormHandler.billingAddress[0].address1" type="text" value="1 B St" /></br>
	<dsp:input id="billAddr20" bean="PaymentGroupFormHandler.billingAddress[0].address2" type="text" value="" /></br>
	<dsp:input id="billCity0" bean="PaymentGroupFormHandler.billingAddress[0].city" type="text" value="Toledo" /></br>
	<dsp:input id="selState0" bean="PaymentGroupFormHandler.billingAddress[0].state" type="text" value="OH" /></br>
	<dsp:input id="billZipCode0" bean="PaymentGroupFormHandler.billingAddress[0].postalCode" type="text" value="43623" /></br>
	<dsp:input id="billPhone0" bean="PaymentGroupFormHandler.billingAddress[0].phoneNumber" type="text" value="304-333-2222" /></br>
	<dsp:input id="billAltPhone0" bean="PaymentGroupFormHandler.billingAddress[0].altPhoneNumber" type="text" value="" /></br>
	<dsp:input id="billEmailAddress0" bean="PaymentGroupFormHandler.billingAddress[0].email" type="text" value="don@trump.com" /></br>
	</br>	
	CC-1</br>
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.splitPayment" value="true" name="splitPay" id="splitPay" />
	<dsp:input bean="PaymentGroupFormHandler.addNewPaymtMethd" type="hidden" value="true"/>
	<dsp:input id="cardType1" bean="PaymentGroupFormHandler.creditCardType" type="text" value="Visa" /></br>
	<dsp:input id="CName1" bean="PaymentGroupFormHandler.cardHolderName" type="text" value="Test Test" /></br>
	<dsp:input id="ccNum1" bean="PaymentGroupFormHandler.creditCardNumber" type="text" value="4005550000000019" /></br>
	<dsp:input id="cardExpMonth1" bean="PaymentGroupFormHandler.expirationMonth" type="text" value="7" /></br>
	<dsp:input id="cardExpYear1" bean="PaymentGroupFormHandler.expirationYear" type="text" value="2021" /></br>
	<dsp:input id="secCode1" bean="PaymentGroupFormHandler.cardVerificationNumber" type="text" value="222" /></br>
	BILLING-1</br>
	<dsp:input bean="PaymentGroupFormHandler.addNewBillAddr" type="hidden" value="true"/>
	<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="false" id="shipToBill"/>
	<dsp:input id="billFName1" bean="PaymentGroupFormHandler.billingAddress[1].firstName" type="text" value="Melania" /></br>
	<dsp:input id="billSName1" bean="PaymentGroupFormHandler.billingAddress[1].lastName" type="text" value="Trump" /></br>
	<dsp:input id="selCountry1" bean="PaymentGroupFormHandler.billingAddress[1].country" type="text" value="US" /></br>
	<dsp:input id="billAddr11" bean="PaymentGroupFormHandler.billingAddress[1].address1" type="text" value="1 D St" /></br>
	<dsp:input id="billAddr21" bean="PaymentGroupFormHandler.billingAddress[1].address2" type="text" value="" /></br>
	<dsp:input id="billCity1" bean="PaymentGroupFormHandler.billingAddress[1].city" type="text" value="Toledo" /></br>
	<dsp:input id="selState1" bean="PaymentGroupFormHandler.billingAddress[1].state" type="text" value="OH" /></br>
	<dsp:input id="billZipCode1" bean="PaymentGroupFormHandler.billingAddress[1].postalCode" type="text" value="43623" /></br>
	<dsp:input id="billPhone1" bean="PaymentGroupFormHandler.billingAddress[1].phoneNumber" type="text" value="304-333-2222" /></br>
	<dsp:input id="billAltPhone1" bean="PaymentGroupFormHandler.billingAddress[1].altPhoneNumber" type="text" value="" /></br>
	<dsp:input id="billEmailAddress1" bean="PaymentGroupFormHandler.billingAddress[1].email" type="text" value="don@trump.com" /></br>
	<dsp:input id="tAndS" bean="PaymentGroupFormHandler.termsAndConditions" type="hidden" value="true"/>
	<dsp:input type="submit" bean="PaymentGroupFormHandler.applyBillingInfo" value="BILLING INFO" />
	</dsp:form>
</body>
	</html>

</dsp:page>
