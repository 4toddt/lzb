<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	
	<dsp:getvalueof param="orderId" var="orderId"/>${orderId}
	<dsp:getvalueof param="postalCode" var="postalCode"/>
	<dsp:getvalueof param="selectedShipAddressId" var=""/>
	
	<dsp:setvalue bean="ProfileFormHandler.validateZipCodeSuccessUrl" value="${contextPath}/checkout/json/validateShippingZipCodeSuccess.jsp"/>
	<dsp:setvalue bean="ProfileFormHandler.validateZipCodeErrorUrl" value="${contextPath}/checkout/json/validateShippingZipCodeError.jsp"/>
	<dsp:setvalue bean="ProfileFormHandler.selectedShippingAddressId" value="${selectedShipAddressId}" />
	<dsp:setvalue bean="ProfileFormHandler.zipShipCode" value="${postalCode}" />
	<dsp:setvalue bean="ProfileFormHandler.orderNumber" value="${orderId}" />
	
	<!-- validateZipCode is an actual form handler being invoked by a setvalue -->
	<dsp:setvalue bean="ProfileFormHandler.validateZipCode" value="true" />
</dsp:page>