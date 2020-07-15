<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCartTaxDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCalcOrderDepositBalanceAmountDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyFinanceEstimate" />

	<%-- reprice order --%>
	<dsp:droplet name="RepriceOrderDroplet">
		<dsp:param value="ORDER_SUBTOTAL" name="pricingOp"/>
	</dsp:droplet>
	
	<dsp:getvalueof var="order" bean="ShoppingCart.current" />
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount"/>
	
	<dsp:droplet name="LZBDisplayCartItemsDroplet">
	<dsp:param name="order" bean="ShoppingCart.current" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:param name="cart" value="true" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="cartItems" param="cartItems" />
	</dsp:oparam>
	</dsp:droplet>

<%--	
	<dsp:droplet name="LZBCartTaxDroplet">
	<dsp:param name="order" bean="ShoppingCart.current" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:oparam name="empty">
	</dsp:oparam>
	<dsp:oparam name="output">
		<dsp:getvalueof var="cartTaxAmount" param="taxAmount"/>
		<dsp:getvalueof var="cartTaxDown" param="taxDown"/>
	</dsp:oparam>
	</dsp:droplet>
--%>
	
	<dsp:droplet name="LZBOrderSummaryDroplet">
	<dsp:param name="order" value="${order}" />
	<dsp:param name="profile" bean="Profile" />
	<dsp:param name="page" value="cart"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="rawSubTotal" param="totalItemCost" />
		<dsp:getvalueof var="shippingCharge" param="shippingCharge" />
		<dsp:getvalueof var="cartTaxAmount" value="${cartTaxAmount}" />
		<dsp:getvalueof var="total" param="total"/>
		<dsp:getvalueof var="totalWithTax" value="${total+cartTaxAmount}"/>
	</dsp:oparam>
	</dsp:droplet>
	
	<dsp:droplet name="LZBCalcOrderDepositBalanceAmountDroplet">
	<dsp:param name="order" value="${order}" />
	<dsp:param name="deliveryAmount" value="${shippingCharge}"/>
	<dsp:param name="taxAmount" value="${cartTaxAmount}"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="depositAmount" param="depositAmount"/>
		<dsp:getvalueof var="balanceAmount" param="balanceAmount"/>
	</dsp:oparam>
	</dsp:droplet>

	<dsp:droplet name="GetDigitalBuyFinanceEstimate">
		<dsp:param name="order" value="${order}" />
		<%-- DMI-2921: Passing orderTotal to use it for calculation, this would include delivery fees if any --%> 	    	
		<dsp:param name="orderTotal" value="${totalWithTax}" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="estimate" param="estimate"/>
			<dsp:getvalueof var="financingMonths" param="financingMonths"/>
			<fmt:formatNumber value="${estimate+0.5-((estimate+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
		</dsp:oparam>
	</dsp:droplet>
				
	<json:object>
		<json:property name="success">true</json:property>
		
		<%-- cart item prices and quantities --%>
		<json:array name="cartItems">
			<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${cartItems}" />
			<dsp:param name="elementName" value="cartItem"/>
			<dsp:oparam name="output">
				<json:object>
					<json:property name="commerceItemId">
						<dsp:valueof param="cartItem.commerceItem.id" />
					</json:property>
					
					<dsp:getvalueof var="listPrice" param="cartItem.listPrice" />
					<dsp:getvalueof var="salePrice" param="cartItem.salePrice" />
					<dsp:getvalueof var="itemTotal" param="cartItem.itemTotal"/>
					<dsp:getvalueof var="itemQuantity" param="cartItem.commerceItem.quantity" />
					<dsp:getvalueof var="listPriceTotal" value="${itemQuantity*listPrice}" />
					<dsp:getvalueof var="salePriceTotal" value="${itemQuantity*salePrice}" />
					
					<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
					<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment" />
					<dsp:getvalueof var="afterTreatmentPlan" param="cartItem.afterTreatmentPlan" />
					
					<json:property name="salePriceRaw">
						<dsp:valueof value="${salePrice}" />
					</json:property>
					
					<json:property name="salePrice">
						<dsp:include page="/global/includes/formattedPrice.jsp">
							<dsp:param name="price" value="${salePrice}" />
						</dsp:include>
					</json:property>
					
					<c:if test="${hasTreatment =='true' && not empty protectionPlan}">
							<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
							<dsp:getvalueof var="totalPlanPrice" value="${totalPrice * itemQuantity}" />
					</c:if>
					
					<json:property name="listPriceTotal">
					<c:choose>
						<c:when test="${salePrice > 0.0}">
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${listPriceTotal - totalPlanPrice }" />
							</dsp:include>
						</c:when>
						<c:otherwise>
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${itemTotal}" />
							</dsp:include>
						</c:otherwise>
					</c:choose>		
					</json:property>
						
					<json:property name="salePriceTotal">
						<dsp:include page="/global/includes/formattedPrice.jsp">
							<dsp:param name="price" value="${itemTotal}" />
						</dsp:include>
					</json:property>
						
					<json:property name="itemQuantity">
						<dsp:valueof value="${itemQuantity}" />
					</json:property>
					
					<c:choose>
						<c:when test="${hasTreatment =='false' && not empty afterTreatmentPlan}">
							<%-- Cart does not have after treatment paln --%>
							<dsp:getvalueof var="planName" 	param="cartItem.afterTreatmentPlan.displayName" />
							<dsp:getvalueof var="salePrice" param="cartItem.protectionPlanAmount" />
							<dsp:getvalueof var="qty" param="cartItem.afterTreatmentPlan.quantity" />
							
							<json:property name="planName">
								<dsp:valueof value="${planName}" />
							</json:property>
							
							<json:property name="planPrice">
								<dsp:include page="/global/includes/formattedPrice.jsp">
									<dsp:param name="price" value="${salePrice}" />
								</dsp:include>
							</json:property>
						</c:when>
						<c:otherwise>
							<c:if test="${not empty protectionPlan}">
								<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
								<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
								
								<json:property name="planName">
									<dsp:valueof value="${planName}" />
								</json:property>
							
								<json:property name="totalPlanPrice">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${totalPrice * itemQuantity}" />
									</dsp:include>
								</json:property>
							</c:if>
						</c:otherwise>
					</c:choose>
				</json:object>
			</dsp:oparam>
			</dsp:droplet>
		</json:array>
	
		<%-- order totals --%>
		<json:object name="orderTotals">
			<%-- cart count --%>
			<json:property name="cartCount">
				${commerceItemCount}
			</json:property>
			
			<%-- subtotal --%>
			<json:property name="orderSubtotal">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${rawSubTotal}" />
				</dsp:include>
			</json:property>
			
			<%-- shipping --%>
			<json:property name="orderShipping">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${shippingCharge}" />
				</dsp:include>
			</json:property>
			
			<%-- Tax down flag --%>
			<json:property name="taxDown">
				${cartTaxDown}
			</json:property>
			
			<%-- tax --%>
			<json:property name="taxHidden">
				${true}
			</json:property>
			
			<%-- total --%>
			<json:property name="orderTotal">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${totalWithTax}" />
				</dsp:include>
			</json:property>
		</json:object>
		
		<%-- deposit and balance --%>
		<json:object name="orderDepositBalance">
			<%-- deposit --%>
			<json:property name="orderDeposit">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${depositAmount}" />
				</dsp:include>
			</json:property>
			
			<%-- balance --%>
			<json:property name="orderBalance">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${balanceAmount}" />
				</dsp:include>
			</json:property>
		</json:object>
		<%--Financing Cost --%>
		<json:object name="financingCost">
			<json:property name="estimate">
				${estimate}
			</json:property>
			<json:property name=="financingMonths">
				${financingMonths}
			</json:property>
			<json:property name="monthlyPrice">
				<dsp:include page="/global/includes/formattedPrice.jsp">
					<dsp:param name="price" value="${monthlyPrice}" />
				</dsp:include>
			</json:property>
		</json:object>
	</json:object>
</dsp:page>