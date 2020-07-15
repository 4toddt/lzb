<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCalcOrderDepositBalanceAmountDroplet" />
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
	
	<dsp:getvalueof var="order" bean="ShoppingCart.current" />
	
	<%--
	<dsp:include page="/checkout/includes/cartTax.jsp">
		<dsp:param name="callTax" value="true" />
	</dsp:include>
	--%>
	
	<%-- reprice order
	<dsp:droplet name="RepriceOrderDroplet">
		<dsp:param value="ORDER_TOTAL" name="pricingOp"/>
	</dsp:droplet>
	--%>
	
	<dsp:droplet name="LZBOrderSummaryDroplet">
	<dsp:param name="order" value="${order}" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:param name="page" value="checkout"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="total" param="total"/>
		<dsp:getvalueof var="totalRecycleFee" param="totalRecycleFee"/>
		
		<dsp:droplet name="LZBCalcOrderDepositBalanceAmountDroplet">
		<dsp:param name="order" value="${order}" />
		<dsp:param name="deliveryAmount" param="shippingCharge"/>
		<dsp:param name="taxAmount" param="tax" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="depositAmount" param="depositAmount"/>
			<dsp:getvalueof var="balanceAmount" param="balanceAmount"/>
		</dsp:oparam>
		</dsp:droplet>
	
		<json:object>
			<%-- order totals --%>
			<json:object name="orderTotals">
				<%-- subtotal --%>
				<json:property name="orderSubtotal">
					<dsp:valueof param="totalItemCost" converter="currency"/>
				</json:property>
				
				<%-- shipping --%>
				<json:property name="orderShipping">
					<dsp:valueof param="shippingCharge" converter="currency"/>
				</json:property>
				
				<%-- Tax down flag --%>
				<json:property name="taxDown">
					${cartTaxDown}
				</json:property>
				
				<%-- tax --%>
				<json:property name="orderTax">
					<dsp:valueof param="tax" converter="currency"/>
				</json:property>
				
				<%-- recycling fee --%>
				<json:property name="recycleFee">
					<dsp:valueof value="${totalRecycleFee}" converter="currency"/>
				</json:property>
				
				<%-- total --%>
				<json:property name="orderTotal">
					<dsp:valueof value="${total}" converter="currency"/>
				</json:property>
			</json:object>
			
			<%-- deposit and balance --%>
			<json:object name="orderDepositBalance">
				<%-- deposit --%>
				<json:property name="orderDeposit">
					<dsp:valueof value="${depositAmount}" converter="currency"/>
				</json:property>
				
				<%-- balance --%>
				<json:property name="orderBalance">
					<dsp:valueof value="${balanceAmount}" converter="currency"/>
				</json:property>
			</json:object>
		</json:object>
	
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>
