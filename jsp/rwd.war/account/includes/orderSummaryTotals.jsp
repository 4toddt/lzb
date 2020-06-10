<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<%-- Page Variables --%>
	
 	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" param="order"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
			<dsp:getvalueof var="shippingCurrency" param="shippingCharge"/>
			<dsp:getvalueof var="taxCost" param="tax"/>
			<dsp:getvalueof var="totalRecycleFee" param="totalRecycleFee"/>
			<dsp:getvalueof var="totalItemCosts" param="totalItemCost"/>
			<dsp:getvalueof var="coverPlanItems" param="planItems"/>
			<dsp:getvalueof var="totalPrice" param="total"/>
			<dsp:getvalueof var="currencyCode" param="currencyCode"/>		
		</dsp:oparam>
	</dsp:droplet>
	
	<div class="totals-container">
		<div class="totals">
			<div class="total-row subtotal">
				<div class="total-label"><dsp:valueof param="result.totalCommerceItemCount"/>&nbsp;<fmt:message key="orderSummary.total"/></div>
				<div class="total-amount"><dsp:valueof value="${totalItemCosts}" converter="currency"/></div>
			</div>
			
			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${coverPlanItems}" />
				<dsp:param name="elementName" value="planItem" />
				<dsp:oparam name="output">
					<div class="total-row planItem">
						<div class="total-label"><dsp:valueof param="planItem.planItemInfo.displayName"/>(<dsp:valueof param="planItem.quantity"/> &nbsp; item):</div>
						<div class="total-amount"><dsp:valueof param="planItem.amount" converter="currency"/></div>
					</div>
				</dsp:oparam>
			</dsp:droplet>
			
			<div class="total-row shipping">
				<div class="total-label"><fmt:message key="orderSummary.homedelivery"/></div>
				<div class="total-amount"><dsp:valueof value="${shippingCurrency}" converter="currency"/></div>
			</div>
			<div class="total-row tax">
				<div class="total-label"><fmt:message key="orderSummary.sales"/></div>
				<div class="total-amount"><dsp:valueof value="${taxCost}" converter="currency"/></div>
			</div>
			<c:if test="${not empty totalRecycleFee}">
				<div class="total-row recycling-fee">
					<div class="total-label"><fmt:message key="financialstack.label.recyclingFee"/></div>
					<div class="total-amount"><dsp:valueof value="${totalRecycleFee}" converter="currency"/></div>
				</div>
			</c:if>
			<div class="total-row">&nbsp;</div>
			<div class="total-row total">
				<div class="total-label"><fmt:message key="orderSummary.totalz"/></div>
				<div class="total-amount"><dsp:valueof value="${totalPrice}" converter="currency"/></div>
			</div>
		</div>
	</div>
		
</dsp:page>