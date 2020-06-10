<%--
	- File Name: orderHistoryItem.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page lays out the order history items.
	- Parameters:
	-
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />

	<%-- Page Variables --%>

	<%-- Droplet: Order Summary --%>
	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" param="order"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="orderCombination" param="orderCombination"/>
			<dsp:getvalueof var="orderTotal" param="total"/>
		</dsp:oparam>
	</dsp:droplet>

	<%-- Render Order Item --%>
	<div class="order-item">
		<div class="item-order-number order-item-section">
			<span class="label"><fmt:message key="orderHistory.number1"/></span> 
			<span class="right highlight"><dsp:valueof param="order.id"/></span>
		</div>
		<div class="item-date order-item-section">
			<span class="label"><fmt:message key="orderHistory.date2"/></span>
			<span class="right highlight"><dsp:valueof param="order.submittedDate" converter="date" date="MM/dd/yyyy"/></span>
		</div>
		<div class="item-order-total order-item-section">
			<span class="label"><fmt:message key="orderHistory.total3"/></span>
			<dsp:getvalueof var="currencyCode" param="order.priceInfo.currencyCode" />
			<span class="right highlight">${orderTotal}&nbsp;${currencyCode}</span>
		</div>
		<dsp:getvalueof param="order.shippingGroups" var="shippingGroups"/>
		<c:if test="${not empty shippingGroups}" >
			<div class="item-delivery order-item-section">
				<span><fmt:message key="orderHistory.deliver"/></span>
				<span class="right highlight"><dsp:valueof param="order.shippingGroups[0].shippingAddress.firstName"/>&nbsp;<dsp:valueof param="order.shippingGroups[0].shippingAddress.lastName"/></span>
			</div>
		</c:if>
		<div class="item-status order-item-section">
			<span class="label"><fmt:message key="orderHistory.status"/></span>
			<span class="right">
				<dsp:include page="/account/includes/orderState.jsp">
					<dsp:param name="order" param="order"/>
					<dsp:param name="orderCombination" value="${orderCombination}"/>
				</dsp:include>
			</span>
		</div>
		<div class="item-action-links order-item-section">
			<dsp:a href="${contextPath}/account/orderDetails.jsp" class="button primary view-order-details">
				<fmt:message key="orderHistory.details3"/>
				<dsp:param name="orderId" param="order.id"/>
			</dsp:a>
		</div>
	</div>
	
</dsp:page>
