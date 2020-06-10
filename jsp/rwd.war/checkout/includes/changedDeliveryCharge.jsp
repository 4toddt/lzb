<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBChangedDeliveryChargeDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCalculateTaxByZipcodeDroplet" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	
	<dsp:getvalueof var="postalCode" param="postalCode"/>

	<dsp:droplet name="LZBChangedDeliveryChargeDroplet">
	<dsp:param name="postalCode" value="${postalCode}"/>
	<dsp:param name="order" bean="ShoppingCart.current"/>
	<dsp:param name="profile" bean="Profile"/>
	<dsp:oparam name="empty">
		<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
		<p class="text-msg"><fmt:message key="checkout.changedDeliveryChargeModal.noInfo" /></p>
	</dsp:oparam>
	<dsp:oparam name="error">
		<dsp:getvalueof var="nodealer" value="yes" scope="request"/>
		<p class="text-msg"><dsp:valueof param="message" valueishtml="true"/></p>
	</dsp:oparam>
	<dsp:oparam name="output">
		<dsp:getvalueof param="zipCodeChangedItemInfo" var="zipCodeChangedItemInfo"/>
    	<p class="text-msg">
	        <fmt:message key="checkout.changedDeliveryChargeModal.delAddressChangMsg"/>
	     	<span class="bold"><dsp:valueof value="${zipCodeChangedItemInfo.toPostalCode}" /></span>
	        <fmt:message key="checkout.changedDeliveryChargeModal.insteadOf"/>
	    	<span class="bold"><dsp:valueof value="${zipCodeChangedItemInfo.fromPostalCode}" />.
	    	<fmt:message key="checkout.changedDeliveryChargeModal.changeMsg"/></span>
       	</p>
       	
       	<div class="delivery-charge-table">
       		<div class="delivery-charge-row">
       			<div class="charge-info delivery-charge-cell">&nbsp;</div>
       			<div class="from-price delivery-charge-cell"><fmt:message key="checkout.changedDeliveryChargeModal.from"/></div>
       			<div class="to-price delivery-charge-cell"><fmt:message key="checkout.changedDeliveryChargeModal.to"/></div>
       		</div>
       		<div class="delivery-charge-row">
       			<div class="charge-info delivery-charge-cell">${zipCodeChangedItemInfo.shippingCharge.displayName}</div>
       			<div class="from-price delivery-charge-cell"><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.fromPrice}" converter="currency" /></div>
       			<div class="to-price delivery-charge-cell"><dsp:valueof value="${zipCodeChangedItemInfo.shippingCharge.toPrice}" converter="currency" /></div>
       		</div>
       		<div class="delivery-charge-row">
				<div class="charge-info delivery-charge-cell">${zipCodeChangedItemInfo.frieghtSurcharge.displayName}</div>
				<div class="from-price delivery-charge-cell"><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.fromPrice}" converter="currency" /></div>
				<div class="to-price delivery-charge-cell"><dsp:valueof value="${zipCodeChangedItemInfo.frieghtSurcharge.toPrice}" converter="currency" /></div>
			</div>
<%--			
			<div class="delivery-charge-row">
				<div class="charge-info delivery-charge-cell">${zipCodeChangedItemInfo.salesTax.displayName}</div>
				<div class="from-price delivery-charge-cell"><dsp:valueof value="${zipCodeChangedItemInfo.salesTax.fromPrice}" converter="currency" /></div>
				<div class="to-price delivery-charge-cell">
					<dsp:droplet name="LZBCalculateTaxByZipcodeDroplet">
					<dsp:param name="postalCode" value="${zipCodeChangedItemInfo.toPostalCode}"/>
					<dsp:param name="zipCodeChangedItemInfo" value="${zipCodeChangedItemInfo}"/>
					<dsp:param name="order" bean="ShoppingCart.current"/>
					<dsp:oparam name="output">
						<dsp:valueof param="tax" converter="currency" />
					</dsp:oparam>
					</dsp:droplet>								
				</div>
			</div>
 --%>
			<c:if test="${not empty zipCodeChangedItemInfo.commerceItemList}">
				<c:forEach items="${zipCodeChangedItemInfo.commerceItemList}" var="commerceItem">
					<div class="delivery-charge-row">
						<div class="charge-info delivery-charge-cell">
							${commerceItem.displayName}&nbsp;<fmt:message key="checkout.changedDeliveryChargeModal.price"/>
							<div class="stock-change-message">${commerceItem.stockMessage}</div>
						</div>
						<div class="from-price delivery-charge-cell"><dsp:valueof value="${commerceItem.fromPrice}" converter="currency" /></div>
						<div class="to-price delivery-charge-cell"><dsp:valueof value="${commerceItem.toPrice}" converter="currency" /></div>
					</div>
				</c:forEach>
			</c:if>
       	</div>
		
		<p class="promo-msg"><fmt:message key="checkout.changedDeliveryChargeModal.proceed"/>&nbsp;${postalCode}&nbsp;<fmt:message key="checkout.changedDeliveryChargeModal.acceptInstruction" /></p>
					
		<div class="zip-code-buttons">
			<dsp:form id="changed-delivery-charge-modal" name="changed-delivery-charge-modal" formid="changed-delivery-charge-modal">
				<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreErrorURL" value="${contextPath}/checkout/json/setChangeStoreError.jsp"/>
				<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${contextPath}/checkout/json/setChangeStoreSuccess.jsp"/>
				<dsp:input type="hidden" bean="ProfileFormHandler.zipCode" name="zipCode" value="${postalCode}"/>
				<dsp:input type="hidden" bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode" value="submit" />
				
				<a href="#" class="cancel-link" data-dismiss="modal"><fmt:message key="checkout.changedDeliveryChargeModal.cancel"/></a>
				<a href="#" class="button tertiary accept-btn">Accept</a>
			</dsp:form>
		</div>
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>