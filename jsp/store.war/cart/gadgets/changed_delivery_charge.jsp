<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBChangedDeliveryChargeDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCalculateTaxByZipcodeDroplet" />
<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<main role="main" class="zip-code-content">
	<h1><fmt:message key="cart.changedDeliveryChargeMsg"/></h1>
	<dsp:getvalueof var="postalCode" param="postalCode"/>
	<dsp:getvalueof var="checkoutPage" param="checkoutPage"/>

	<dsp:droplet name="LZBChangedDeliveryChargeDroplet">
		<dsp:param name="postalCode" value="${postalCode}"/>
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="empty">
			<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
			<p class="text-msg"> No information available</p>
	   </dsp:oparam>
	   <dsp:oparam name="error">
	   			<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
	   	  		<p class="text-msg"><dsp:valueof param="message" valueishtml="true"/></p>
	   </dsp:oparam>
	   
          <dsp:oparam name="output">
                    <dsp:getvalueof param="zipCodeChangedItemInfo"  var="zipCodeChangedItemInfo"/>
                    <p class="text-msg">
                    	<fmt:message key="cart.delAddressChangMsg"/>
                    	<span><dsp:valueof value="${zipCodeChangedItemInfo.toPostalCode}" /></span>
                    	<fmt:message key="cart.insteadOf"/>
                    	<span><dsp:valueof value="${zipCodeChangedItemInfo.fromPostalCode}" /></span>
                    	<span><fmt:message key="cart.changedDelChargePostCodeMsg"/></span>
                    </p>
		   			<table>
		   			<tbody>
					<tr>
						<td>&nbsp;</td>
						<td><fmt:message key="cart.from"/></td>
						<td><fmt:message key="cart.to"/></td>
					</tr>
					<tr>
						<td>${zipCodeChangedItemInfo.shippingCharge.displayName}</td>
						<td><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.fromPrice}" converter="currency" /></td>
						<td><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.toPrice}" converter="currency" /></td>
					</tr>
					<tr>
						<td>${zipCodeChangedItemInfo.frieghtSurcharge.displayName}</td>
						<td><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.fromPrice}" converter="currency" /></td>
						<td><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.toPrice}" converter="currency" /></td>
					</tr>
					<tr>
						<td>${zipCodeChangedItemInfo.salesTax.displayName}</td>
						<td><dsp:valueof value="${zipCodeChangedItemInfo.salesTax.fromPrice}" converter="currency" /></td>
						<td>
							<dsp:droplet name="LZBCalculateTaxByZipcodeDroplet">
								<dsp:param name="postalCode" value="${zipCodeChangedItemInfo.toPostalCode}"/>
								<dsp:param name="zipCodeChangedItemInfo" value="${zipCodeChangedItemInfo}"/>
								<dsp:param name="order" bean="ShoppingCart.current"/>
								<dsp:oparam name="output">
									<dsp:valueof param="tax" converter="currency" />
								</dsp:oparam>
							</dsp:droplet>								
						</td>
					</tr>
					<c:if test="${not empty zipCodeChangedItemInfo.commerceItemList}">
						<c:forEach items="${zipCodeChangedItemInfo.commerceItemList}" var="commerceItem">
							<tr>
								<td>${commerceItem.displayName} <fmt:message key="cart.price"/></td>
								<td><dsp:valueof value="${commerceItem.fromPrice}" converter="currency" /></td>
								<td><dsp:valueof value="${commerceItem.toPrice}" converter="currency" /></td>
							</tr>
						</c:forEach>
					</c:if>
					</tbody>
					</table>
					<p class="promo-msg">To Proceed with ${postalCode} postal code. Please check the accept check box. </p>
					 <div class="zip-code-buttons">
			   			<c:choose>
			   				<c:when test="${not empty checkoutPage && checkoutPage eq 'payment'}">
							<a href="#" class="cancel-btn" >CANCEL</a>
							<a href="#" id="accepted"class="btn-primary accept" >ACCEPT</a>
			   				   <%--<dsp:form id="acceptForm" action="#" method="post" name="acceptForm" formid="acceptForm">
								<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoSuccessURL" type="hidden" value="/checkout/orderReview.jsp"/>
								<dsp:input bean="PaymentGroupFormHandler.applyShippingBillingInfoErrorURL" type="hidden" value="/checkout/deliveryAndPayment.jsp"/>
								<dsp:a iclass="cancel-btn" href="#"><fmt:message key="editPayment.cancel"/></dsp:a>
								<dsp:input iclass="btn-primary accept"  bean="PaymentGroupFormHandler.applyShippingBillingInfo" id="deliveryChargeInfo" type="submit" value="ACCEPT" />
							   </dsp:form>--%>
			   				</c:when>
			   				<c:otherwise>
			   				  <dsp:form id="acceptForm" action="/work/cart/gadgets/changed_delivery_charge.jsp?postalCode=${postalCode}" method="post" name="acceptForm" formid="acceptForm">
								<dsp:input bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" type="hidden" />
								<dsp:input bean="ProfileFormHandler.setChangeStoreErrorURL" value="${siteBaseUrl}/cart/gadgets/changed_delivery_charge.jsp?postalCode=${postalCode}" type="hidden" />
								<dsp:a iclass="cancel-btn" href="${siteBaseUrl}/cart/cart.jsp"><fmt:message key="editPayment.cancel"/></dsp:a>
								<dsp:input bean="ProfileFormHandler.zipCode" name="zipCode" type="hidden" maxlength="40" value="${postalCode}"/>
								<dsp:input bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode" iclass="btn-primary" id="deliveryChargeInfo" type="submit" value="ACCEPT" />
							   </dsp:form>
			   				</c:otherwise>
			   			</c:choose>
		   			</div>
         </dsp:oparam>
	</dsp:droplet>
</main>
</dsp:page>