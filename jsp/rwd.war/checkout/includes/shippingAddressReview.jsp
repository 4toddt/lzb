<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	
    <dsp:getvalueof var="shippingGroups" vartype="java.lang.Object" bean="ShoppingCart.current.ShippingGroups" />
    	
    <div>
		<span class="icon checkout-title-icon icon-radio"></span>
		<div class="checkout-title">
			<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
			<span class="status-step-num">1</span><fmt:message key="checkout.step.delivery" />
			<a href="javascript:void(0);" class="edit-shipping edit-link hide-for-medium">
				<fmt:message key="checkout.edit.link" />
				<span class="sr-only"><fmt:message key="checkout.edit.link.srDelivery" /></span>
			</a>
		</div>
	</div>
		
		<dsp:getvalueof var="shippingAddress" value="${shippingGroups[0].shippingAddress}" />
	
		<div class="shipping-address-review js-review-content">
			<div class="selected-shipping-address">
				<span class="customer-name"><span class="ship-addr-firstname">${shippingAddress.firstName}</span>&nbsp;<span class="ship-addr-lastname">${shippingAddress.lastName}</span></span>
				<p>
					<span class="ship-addr-1">${shippingAddress.address1}</span><br/>
					<c:if test="${not empty shippingAddress.address2}">
						<span class="ship-addr-2">${shippingAddress.address2}</span><br/>
					</c:if>
					<span class="ship-addr-city">${shippingAddress.city}</span>,&nbsp;<span class="ship-addr-state">${shippingAddress.state}</span>&nbsp;<span class="ship-addr-zip">${shippingAddress.postalCode}</span><br/>
					<span class="phone ship-addr-phone">${shippingAddress.phoneNumber}</span><br/>
					<span class="email ship-addr-email">${shippingAddress.email}</span>
				</p>
				
				<fmt:message key="checkout.shipping.specialDeliveryInstructions" /> 
				<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${currentShippingGroup.specialInstructions}" />
				<dsp:param name="elementName" value="specialInstr" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="displaySpecialInstr" param="specialInstr"/>
					<c:choose>
						<c:when test="${not empty displaySpecialInstr }">
							<dsp:valueof value="${displaySpecialInstr}"/>
						</c:when>
						<c:otherwise>
					 		<fmt:message key="checkout.shipping.noInstructionsEnterd"/>
					  	</c:otherwise>
					</c:choose>
				</dsp:oparam>
				</dsp:droplet>
			</div>
				
			<a href="javascript:void(0);" class="edit-shipping edit-link hide-for-small" data-target="checkout-shipping">
				<fmt:message key="checkout.edit.link" />
				<span class="sr-only"><fmt:message key="checkout.edit.link.srDelivery" /></span>
			</a>
		</div>
</dsp:page>
