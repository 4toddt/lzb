<%--
	- File Name: oderDetails.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the order details page
	- Parameters: orderId
	-
--%>

<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="orderId" param="orderId"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	
	<section role="region" class="order-details-content">
		<p>
			<fmt:message key="orderDetail.introText"/>&nbsp;
			<fmt:message key="orderDetail.introText2"/>&nbsp;				
			<b><fmt:message key="orderDetail.contactNumber"/></b>&nbsp;<fmt:message key="orderDetail.introText3"/></br>										
			<b><fmt:message key="orderDetail.emailAddress"/></b>
		</p>

		<dsp:droplet name="OrderLookup">
			<dsp:param name="orderId" param="orderId"/>
			<dsp:oparam name="output">
				<div class="order-info">
					<%--   order header  --%>
					<div class="order-items-header">
						<fmt:message key="orderSummary.details"/> 
					</div>
					<%--   order information  --%>
					<div class="order-items order-history-items">
						<div class="order-item">
							<div class="item-order-number order-item-section">
								<span class="label"><fmt:message key="orderHistory.number1"/></span>
								<span class="right"><strong>${orderId}</strong></span>
							</div>
							<div class="item-date order-item-section">
								<dsp:getvalueof var="submittedDate" vartype="java.util.Date" param="result.submittedDate" />
								<span class="label"><fmt:message key="orderHistory.date2"/></span> 
								<span class="right"><fmt:formatDate pattern="yyyy-MM-dd" value="${submittedDate}" /></span>
							</div>
							<div class="item-status order-item-section">
								<dsp:getvalueof var="state" vartype="java.util.Date" param="result.stateAsString" />
								<span class="label"><fmt:message key="orderHistory.status"/></span>
								<span class="right">${state}</span>
							</div>
						</div>
					</div>
				</div>
				<div class="order-info order-summary-info">
					<%--   order summary header  --%>
					<div class="order-items-header">
						<fmt:message key="orderSummary.Summary"/> 
					</div>
					<%--   order summary information  --%>
					<div class="order-summary-details order-history-items">
						<dsp:include page="/account/includes/orderSummaryTotals.jsp">
	        				<dsp:param name="order" param="result"/>
	    			 	</dsp:include>
					</div>
				</div>
				<div class="order-items-info">
					<%--   order items header  --%>  
					<div class="order-items-header">
						<fmt:message key="orderSummary.items"/> 
					</div>
					<%--   order items information  --%>
					<div class="order-items order-history-items">
                        <!-- items -->
                        <dsp:include page="/account/includes/orderSummaryItems.jsp">
                            <dsp:param name="order" param="result"/>
                        </dsp:include>
					</div>
				</div>

				<%--   shipping information  --%>
				<div class="shipping-section">
					<div class="shipping-header">
						<fmt:message key="orderSummary.address"/> 
					</div>
					<div class="shipped-address-info">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="result.shippingGroups"/>
							<dsp:param name="elementName" value="shippingGroup"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="instruction" param="shippingGroup.specialInstructions"/>
									<p><dsp:valueof param="shippingGroup.shippingAddress.firstName"/>&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.lastName"/></p>
									<p><dsp:valueof param="shippingGroup.shippingAddress.address1"/>,&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.city"/></p>
									<p><dsp:valueof param="shippingGroup.shippingAddress.state"/>,&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.country"/>,&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.postalCode"/></p>
								</dsp:oparam>
						</dsp:droplet>
					</div>
					<div class="special-delivery-section">
						<div class="special-delivery-header">
                            <fmt:message key="orderSummary.instructions"/>
                        </div>
                        <c:choose>
                            <c:when test="${not empty instruction}">
                                <span>${instruction}</span>
                            </c:when>
                            <c:otherwise>
                                <dsp:droplet name="ForEach">
                                    <dsp:param name="array" param="result.shippingGroups[0].specialInstructions"/>
                                    <dsp:param name="elementName" value="specialInstr"/>
                                    <dsp:oparam name="output">
                                        <c:choose>
                                            <c:when test="${not empty specialInstr}">
                                                <span><dsp:valueof param="specialInstr"/></span>
                                            </c:when>
                                            <c:otherwise>
                                                <span><fmt:message key="orderDetail.delivery" /></span>
                                            </c:otherwise>
                                        </c:choose>
                                    </dsp:oparam>
                                </dsp:droplet>
                            </c:otherwise>
                        </c:choose>
					</div>
				</div>
						
				<%--   billing information  --%>
				<div class="billing-section">
					<div class="billing-header">
						<fmt:message key="orderSummary.billingadd"/> 
					</div>
					<div class="billed-address-info">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="result.paymentGroups"/>
							<dsp:param name="elementName" value="paymentGroup"/>
								<dsp:oparam name="output">
									<p><dsp:valueof param="paymentGroup.billingAddress.firstName"/>&nbsp;<dsp:valueof param="paymentGroup.billingAddress.lastName"/></p>
									<p><dsp:valueof param="paymentGroup.billingAddress.address1"/>,&nbsp;<dsp:valueof param="paymentGroup.billingAddress.city"/></p>
									<p><dsp:valueof param="paymentGroup.billingAddress.state"/>,&nbsp;<dsp:valueof param="paymentGroup.billingAddress.country"/>,&nbsp;<dsp:valueof param="paymentGroup.billingAddress.postalCode"/></p>
								</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>
						
				<%--   payment information  --%>
				<div class="payment-section">
					<div class="payment-header">
						<fmt:message key="orderSummary.method"/> 
					</div>
					<div class="payment-info">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="result.paymentGroups"/>
							<dsp:param name="elementName" value="paymentGroup"/>
								<dsp:oparam name="output">
									<div class="payment-to-info-block">
										<dsp:getvalueof var="ccType" param="paymentGroup.creditCardType"/>
										
										<c:choose>
											<c:when test="${ccType == 'MasterCard'}">
												<dsp:getvalueof var="ccType" value="MC" />
											</c:when>
											<c:when test="${ccType == 'Discover'}">
												<dsp:getvalueof var="ccType" value="DISC" />
											</c:when>
											<c:when test="${ccType == 'AmericanExpress'}">
												<dsp:getvalueof var="ccType" value="AMEX" />
											</c:when>
											<c:when test="${ccType == 'digitalBuy'}">
												<dsp:getvalueof var="ccType" value="LZB" />
											</c:when>
										</c:choose>
										<p>${ccType}</p>
										
										<dsp:getvalueof var="ccnum" param="paymentGroup.creditCardNumber"/>
										<c:set var="cclength" value="${fn:length(ccnum)}" />
										<c:set var="cc" value="${fn:substring(ccnum,cclength-4, cclength)}" />
										<p>${cc}</p>
										<p>
											<dsp:include page="/global/includes/formattedPrice.jsp">
										     	 <dsp:param name="price" param="paymentGroup.amount"/>
											</dsp:include>
											&nbsp;<dsp:valueof param="result.priceInfo.currencyCode"/>
										</p>
									</div>
								</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>
						
				<div class="action back-to-history">
					<c:choose>
						<c:when test="${transient eq 'false'}">
							<dsp:a href="${contextPath}/account/orderHistory.jsp"><span class="icon icon-arrow-left"></span><fmt:message key="orderSummary.back2"/></dsp:a>
						</c:when>
						<c:otherwise>
							<dsp:a href="${contextPath}/order/anonymousOrders.jsp"><span class="icon icon-arrow-left"></span><fmt:message key="orderSummary.back1"/></dsp:a>
						</c:otherwise>
					</c:choose>
				</div>
			</dsp:oparam>
		</dsp:droplet>
	</section>
</dsp:page>