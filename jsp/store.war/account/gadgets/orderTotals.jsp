<dsp:page>
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:getvalueof var="order" param="order" />
	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" value="${order}"/>
		<dsp:param name="profile" bean="Profile" />
	         <dsp:oparam name="output">
	       				<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
	         			<dsp:getvalueof var="shippingCurrency" param="shippingCharge"/>
	         			<dsp:getvalueof var="taxCost" param="tax"/> 
	         			<dsp:getvalueof var="totalRecycleFee" param="totalRecycleFee"/>
	         			<dsp:getvalueof var="totalItemCosts" param="totalItemCost"/>
	         			<dsp:getvalueof var="coverPlanItems" param="planItems"/>
	         			<dsp:getvalueof var="totalPrice" param="total"/>	
	         			<dsp:getvalueof var="surCharge" param="surCharge"/>
	         			<dsp:getvalueof var="promoAmount" param="promoAmount"/>	
	         </dsp:oparam>
    </dsp:droplet>
	<tfoot>
		<tr>
			<td colspan="4">
				<dsp:valueof param="order.totalCommerceItemCount"/>&nbsp;
				<fmt:message key="orderTotal.itemTotal"/> 
				</td>
			<td>
				<!-- get total item amount -->
				<!-- <fmt:message key="orderTotal.itemAmount"/> -->
				<dsp:include page="/pricing/displayPrice.jsp">
         				<dsp:param name="currency" value="${totalItemCosts}"/>
     			 </dsp:include>
			</td>
		</tr>
		<c:if test="${not empty coverPlanItems}">
			<tr><!-- <fmt:message key="orderTotal.fabricPlan" /> -->

				<dsp:droplet name="ForEach">
					<dsp:param name="array" value="${coverPlanItems}" />
					<dsp:param name="elementName" value="planItem" />
					<dsp:oparam name="output">
						<td colspan="4">
							<dsp:valueof param="planItem.planItemInfo.displayName"/>(<dsp:valueof param="planItem.quantity"/>&nbsp;item):
						</td>
						<td>
							<dsp:include page="/pricing/displayPrice.jsp">
						    	<dsp:param name="currency" param="planItem.amount"/>
						    </dsp:include>
							
						</td>
					</dsp:oparam>
				</dsp:droplet>
			</tr>
		</c:if>
		<tr>
			<td colspan="4"><fmt:message key="orderTotal.homeDelivery" /></td>
			<td>
				<dsp:include page="/pricing/displayPrice.jsp">
					<dsp:param name="currency" value="${shippingCurrency}"/>
				</dsp:include>
			</td>
		</tr>
		<c:if test="${not empty promoAmount and promoAmount ne 0}">
			<tr>
				<td colspan="4">
					<fmt:message key="orderTotal.discount"/>
				</td>
				<td>
					<dsp:include page="/pricing/displayPrice.jsp">
						<dsp:param name="currency" value="${promoAmount}"/>
					</dsp:include>
				</td>
			</tr>
		</c:if>
		<c:if test="${not empty surCharge and surCharge ne 0}">
			<tr>
				<td colspan="4">
					<fmt:message key="orderTotal.surCharge"/>
				</td>
				<td>
					<dsp:include page="/pricing/displayPrice.jsp">
						<dsp:param name="currency" value="${surCharge}"/>
					</dsp:include>
				</td>
			</tr>
		</c:if>
						
		<tr>
			<td colspan="4"><fmt:message key="orderTotal.saleTax" /></td>
			<td>
				<dsp:include page="/pricing/displayPrice.jsp">
		 			<dsp:param name="currency" value="${taxCost}"/>
		 		</dsp:include>
			</td>
		</tr>
		
		<c:if test="${not empty totalRecycleFee}">
			<tr>
				<td colspan="4"><fmt:message key="orderTotal.recyclingFee" /></td>
				<td>
					<dsp:include page="/pricing/displayPrice.jsp">
						<dsp:param name="currency" value="${totalRecycleFee}"/>
					</dsp:include>
				</td>
			</tr>
		</c:if>
		
		<hr />
		<tr>
			<td colspan="2">&nbsp;</td>
			<td colspan="2" class="totalprice"><fmt:message key="orderTotal.total" /></td>
			<td class="totalprice">
				<dsp:include page="/pricing/displayPrice.jsp">
			     	 <dsp:param name="currency" value="${totalPrice}"/>
				</dsp:include>
			</td>
		</tr>
	</tfoot>

</dsp:page>