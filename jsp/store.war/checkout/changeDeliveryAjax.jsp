<dsp:page>
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:getvalueof param="order" var="order"/>${order}
<dsp:getvalueof param="postalCode" var="postalCode"/>
<dsp:getvalueof param="selectedShipAddressId" var="selectedShipAddressId"/>
<dsp:setvalue bean="ProfileFormHandler.validateZipCodeSuccessURL" value="/checkout/orderReview.jsp"/>
<dsp:setvalue bean="ProfileFormHandler.validateZipCodeErrorURL" value="/checkout/deliveryAndPayment.jsp"/>
<dsp:setvalue bean="/atg/userprofiling/ProfileFormHandler.selectedShippingAddressId" value="${selectedShipAddressId}" />
<dsp:setvalue bean="/atg/userprofiling/ProfileFormHandler.zipShipCode" value="${postalCode}" />
<dsp:setvalue bean="/atg/userprofiling/ProfileFormHandler.orderNumber" value="${order}" />
<!-- validateZipCode is an actual form handler being invoked by a setvalue -->
<dsp:setvalue bean="/atg/userprofiling/ProfileFormHandler.validateZipCode" value="true" />
</dsp:page>