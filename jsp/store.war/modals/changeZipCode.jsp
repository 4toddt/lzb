<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBChangedDeliveryChargeDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<main role="main" class="zip-code-content" data-module="zip-code">

	<dsp:getvalueof var="postalCode" param="postalCode"/>
	<dsp:getvalueof var="checkoutPage" param="checkoutPage"/>


	<dsp:droplet name="LZBChangedDeliveryChargeDroplet">
		<dsp:param name="postalCode" value="${postalCode}"/>
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="empty">
			<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
			<p style="color:red"> No information available</p>
	   </dsp:oparam>
	   <dsp:oparam name="error">
	   			<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
	   	  		<p style="color:red"> <dsp:valueof param="message" valueishtml="true"/></p>
	   </dsp:oparam>
          <dsp:oparam name="output">
                    <dsp:getvalueof param="zipCodeChangedItemInfo"  var="zipCodeChangedItemInfo"/>
                    <fmt:message key="cart.delAddressChangMsg"/>  <dsp:valueof value="${zipCodeChangedItemInfo.toPostalCode}" />
                    <fmt:message key="cart.insteadOf"/>  <dsp:valueof value="${zipCodeChangedItemInfo.fromPostalCode}" />
                    <fmt:message key="cart.changedDelChargePostCodeMsg"/>
                <table>
                    <tbody>
                        <tr>
                            <td>&nbsp;</td>
                            <td>From</td>
                            <td>To</td>
                        </tr>
                        <tr>
                            <td>${zipCodeChangedItemInfo.shippingCharge.displayName}</td>
                            <td><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.fromPrice}" converter="currency" /></td>
                            <td><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.toPrice}" converter="currency" /></td>
                        </tr>
                         <tr>
                            <td>Freight Surcharge</td>
                            <td><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.fromPrice}" converter="currency" /></td>
                            <td><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.toPrice}" converter="currency" /></td>
                        </tr>
                        <c:if test="${not empty zipCodeChangedItemInfo.commerceItemList}">
						<c:forEach items="${zipCodeChangedItemInfo.commerceItemList}" var="commerceItem">
							<tr>
								<td>
									<div>
									      <h4>${commerceItem.displayName} <fmt:message key="cart.price"/></h4>
									</div>
								</td>
								<td>
									<div>
									      <h4><dsp:valueof value="${commerceItem.fromPrice}" converter="currency" /></h4>
									</div>
								</td>
								<td>
									<div>
									       <h4><dsp:valueof value="${commerceItem.toPrice}" converter="currency" /></h4>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
                </table>
                <p class="promo-msg"><span>PROMO</span> for Postal / ZIP code 90401. Use code: <span>ABCD14</span></p>
                <c:choose>
		   				<c:when test="${not empty checkoutPage && checkoutPage eq 'payment'}">
		   				  <h4 style="color:red">To Proceed with ${postalCode} postal code. Please check the accept check box. </h4>
		   				</c:when>
		   				<c:otherwise>
		   				  <dsp:form id="acceptForm" action="/work/cart/gadgets/changed_delivery_charge.jsp?postalCode=${postalCode}" method="post" name="acceptForm" formid="acceptForm">
							<dsp:input bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${siteBaseUrl}/rwd/checkout/cart.jsp" type="hidden" />
							<dsp:input bean="ProfileFormHandler.setChangeStoreErrorURL" value="${siteBaseUrl}/cart/gadgets/changed_delivery_charge.jsp?postalCode=${postalCode}" type="hidden" />
							<dsp:a href="${siteBaseUrl}/rwd/checkout/cart.jsp"><fmt:message key="editPayment.cancel"/></dsp:a>
							<dsp:input bean="ProfileFormHandler.zipCode" type="hidden" maxlength="40" value="${postalCode}"/>
							<dsp:input bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode" id="deliveryChargeInfo" type="submit" iclass="btn-primary accept" value="ACCEPT" />
						   </dsp:form>
		   				</c:otherwise>
		   			</c:choose>
			     </dsp:oparam>
	</dsp:droplet>
            </form>
        </main>
</dsp:page>