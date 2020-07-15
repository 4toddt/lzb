<dsp:page>		
	<dsp:importbean bean="/com/lzb/droplet/LZBChangedDeliveryChargeDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<h2><fmt:message key="cart.changedDeliveryChargeMsg"/></h2>

<div style="border-top:1px solid #000;width:100%;">
	<dsp:getvalueof var="postalCode" param="postalCode"/>
	<table>
	<dsp:droplet name="LZBChangedDeliveryChargeDroplet">
		<dsp:param name="postalCode" value="${postalCode}"/>
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:param name="profile" bean="Profile"/>
		   <dsp:oparam name="empty">
		   </dsp:oparam>
		   <dsp:oparam name="error">
		    <tr><td> <dsp:valueof param="message" valueishtml="true"/></td></tr>
		   </dsp:oparam>
          <dsp:oparam name="output">
          
         	  <tr>
					<td>
						<div>
						      <fmt:message key="cartorder.shipping"/>
						      <h4> <dsp:valueof param="ziCodeChangedItemInfo.shippingCharge.displayName" valueishtml="true"/></h4>
						</div>
					</td>
					<td>
						<div>
							<h4>From 
							<dsp:include page="/pricing/displayPrice.jsp">
		         				<dsp:param name="currency" param="ziCodeChangedItemInfo.shippingCharge.fromPrice"/>
		       				</dsp:include>
							 </h4>
						</div>
					</td>
					<td>
						<div>
							<h4>To <dsp:include page="/pricing/displayPrice.jsp">
		         				<dsp:param name="currency" param="ziCodeChangedItemInfo.shippingCharge.toPrice"/>
		       				</dsp:include> </h4>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div>
						      <fmt:message key="cartorder.shipping"/>
						      <h4> <dsp:valueof param="ziCodeChangedItemInfo.frieghtSurcharge.displayName" valueishtml="true"/></h4>
						</div>
					</td>
					<td>
						<div>
							<h4>From 
							<dsp:include page="/pricing/displayPrice.jsp">
		         				<dsp:param name="currency" param="ziCodeChangedItemInfo.frieghtSurcharge.fromPrice"/>
		       				</dsp:include>
							 </h4>
						</div>
					</td>
					<td>
						<div>
							<h4>To <dsp:include page="/pricing/displayPrice.jsp">
		         				<dsp:param name="currency" param="ziCodeChangedItemInfo.frieghtSurcharge.toPrice"/>
		       				</dsp:include> </h4>
						</div>
					</td>
				  </tr>
				  <dsp:droplet name="ForEach">
					<dsp:param name="array" param="ziCodeChangedItemInfo.commerceItemList" />
					<dsp:param name="elementName" value="lineItem" />
					<dsp:oparam name="output">
					  <tr>
						<td>
							<div>
							      <fmt:message key="cartorder.shipping"/>
							      <h4> <dsp:valueof param="lineItem.displayName" valueishtml="true"/></h4>
							</div>
						</td>
						<td>
							<div>
								<h4>From 
								<dsp:include page="/pricing/displayPrice.jsp">
			         				<dsp:param name="currency" param="lineItem.fromPrice"/>
			       				</dsp:include>
								 </h4>
							</div>
						</td>
						<td>
							<div>
								<h4>To <dsp:include page="/pricing/displayPrice.jsp">
			         				<dsp:param name="currency" param="lineItem.toPrice"/>
			       				</dsp:include> </h4>
							</div>
						</td>
					  </tr>
					</dsp:oparam>
				  </dsp:droplet>
		   		  <tr><td><h4> <dsp:valueof param="ziCodeChangedItemInfo.promotionalMessage" valueishtml="true"/></h4></td></tr>	
         </dsp:oparam>
	</dsp:droplet>
	<tr><td>
	 <div style="float:left;width:85%;">
		<dsp:form id="acceptForm"  method="post" name="acceptForm" formid="acceptForm">
	       <dsp:input bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" type="hidden" />
	       <dsp:input bean="ProfileFormHandler.setChangeStoreErrorURL" value="${siteBaseUrl}/cart/gadgets/changed_delivery_charge.jsp?postalCode=${postalCode}" type="hidden" />
	       <dsp:a href="${siteBaseUrl}/cart/cart.jsp"><fmt:message key="editPayment.cancel"/></dsp:a>
	       <dsp:input bean="ProfileFormHandler.zipCode" type="hidden" maxlength="40" value="${postalCode}"/>
	       <dsp:input bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode" id="deliveryChargeInfo" type="submit" value="ACCEPT" />
	     </dsp:form>
	 </div>
	 </td></tr>
	</table>
</div>
</dsp:page>