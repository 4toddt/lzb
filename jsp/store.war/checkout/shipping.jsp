<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBGetShippingGroupAddressDroplet"/>

	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>

	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.secondaryAddresses"/>
		<dsp:oparam name="false">
			<c:set var="hasSecondaryAddresses" value="true"/>
		</dsp:oparam>
	</dsp:droplet>

	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.shippingAddress"/>
		<dsp:oparam name="false">
			<c:set var="hasPrimaryShippingAddress" value="true"/>
		</dsp:oparam>
	</dsp:droplet>

	<dsp:droplet name="ForEach">
		<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups"/>
		<dsp:param name="elementName" value="SGroup"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="ship" param="SGroup"/>
   			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${ship.specialInstructions}"/>
				<dsp:param name="elementName" value="specialInstr"/>
				<dsp:oparam name="output">
    				<dsp:getvalueof var="specialInstr" param="specialInstr"/>
    			</dsp:oparam>
			</dsp:droplet>
		</dsp:oparam>
	</dsp:droplet>

	<h2><fmt:message key="checkout.deliveryAndPayment.delivery"/></h2>

	<dsp:droplet name="LZBGetShippingGroupAddressDroplet">
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="contactAddressId" param="selectedAddressId"/>
		</dsp:oparam>
	</dsp:droplet>
	<c:choose>
		<c:when test="${securityStatus >=2}">
			<c:choose>
				<c:when test="${hasSecondaryAddresses}">
					<c:choose>
						<c:when test="${hasPrimaryShippingAddress}">
							<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewAddr" value="false" id="addNewAddrId" />
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${contactAddressId ne null}">
									<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewAddr" value="false" id="addNewAddrId" />
								</c:when>
								<c:otherwise>
									<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewAddr" value="true" id="addNewAddrId" />
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<dsp:include page="gadgets/displayShippingAddress.jsp"/>
				</c:when>
				<c:otherwise>
					<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewAddr" value="true"/>
					<dsp:include page="gadgets/shippingForm.jsp">
						<dsp:param name="displayNickNameField" value="true"/>
					</dsp:include>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.loggedInUser" value="false"/>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewAddr" value="true"/>
			<dsp:include page="gadgets/shippingForm.jsp"/>
		</c:otherwise>
	</c:choose>
	<fieldset class="address-primaries">
		<legend><fmt:message key="checkout.deliveryAndPayment.addSpecialInstructions"/></legend>
		<label for="specialDeliveryCheckBox" style="display:none"><fmt:message key="checkout.deliveryAndPayment.addSpecialInstructions"/></label> 
		<input type="checkbox" id="specialDeliveryCheckBox" name="specialDeliveryCheckBox" class="toggle" data-module="toggle"/>
		<fmt:message key="checkout.deliveryAndPayment.addSpecialInstructions"/>
		<div class="data-instructions" data-module="charLengthCounter">
			<div id="specialDeliveryInstructions">
				<label for="specialInstructionsInput">Add some intro about delivery instructions.</label>
				<p class="textCounterContainer counter"><span id="textCount">0</span>&nbsp;&#47;&nbsp;400 characters left</p>
				<dsp:droplet name="IsEmpty">
					<dsp:param name="value" bean="PaymentGroupFormHandler.specialInstructions" />
					<dsp:oparam name="true">
						<%-- <dsp:input type="textarea" bean="PaymentGroupFormHandler.specialInstructions"  />--%>
						<dsp:textarea  bean="PaymentGroupFormHandler.specialInstructions" id="specialInstructionsInput">${specialInstr}</dsp:textarea>
					</dsp:oparam>
					<dsp:oparam name="false">
					           <dsp:getvalueof var="specialIntr"   bean="PaymentGroupFormHandler.specialInstructions"  />
						<%--<dsp:input type="textarea" bean="PaymentGroupFormHandler.specialInstructions" beanvalue="PaymentGroupFormHandler.specialInstructions" id="specialInstructionsInput"/>--%>
						<dsp:textarea  bean="PaymentGroupFormHandler.specialInstructions" id="specialInstructionsInput"  >${specialIntr}</dsp:textarea>
					</dsp:oparam>
				</dsp:droplet>
			</div>
		</div>
	</fieldset>
</dsp:page>