<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
	<dsp:importbean bean="/atg/dynamo/service/CurrentDate" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/order" />
	<dsp:getvalueof var="orderId" param="orderId" />
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="title">Order Detail</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">/account/orderDetails.jsp</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.orderSummary" divClass="breadcrumb" >
			<dsp:param name="orderId" value="${orderId}"/>
		</lzb:breadCrumb>
		<main role="main">
		<dsp:include page="/includes/leftnavigation.jsp">
	        <dsp:param name="selpage" value="ORDERHISTORY" />
	    </dsp:include>

	    <section role="region" class="my-account-content">
		<h1><fmt:message key="orderDetail.orderNo"/> ${orderId}</h1>
		<p>
			<fmt:message key="orderDetail.orderContact"/> <a href="mailto:email@la-z-boy.com"><fmt:message key="orderDetail.salesEmailId"/></a>
		</p>
		<dsp:droplet name="OrderLookup">
				<dsp:param name="orderId" param="orderId" />
				<dsp:oparam name="output">
		<div class="cust-order-details account-orderdetail">
			<div class="order-title">
				<h2><fmt:message key="orderSummary.yourOrder"/></h2>
				<div class="order-no">
					<fmt:message key="orderDetail.orderNo"/>: <span class="style-upercase">${orderId}</span>
				</div>
				<div class="order-no">
					<dsp:getvalueof var="submittedDate" vartype="java.util.Date" param="result.submittedDate" />
					<fmt:message key="orderDetail.date"/> <fmt:formatDate pattern="yyyy-MM-dd" value="${submittedDate}" />
				</div>
			</div>

					<div class="order-details order-detailadds">
						<h4 class="style-upercase"><fmt:message key="orderDetail.deliveryAddrs"/></h4>
						<dsp:getvalueof var="shippingGroups" param="result.shippingGroups" />
						<dsp:droplet name="ForEach">
							<dsp:param name="array" value="${shippingGroups}" />
							<dsp:param name="elementName" value="shippingGroup" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="instruction"
									param="shippingGroup.specialInstructions" />
								<div class="customer-name">
								<dsp:valueof param="shippingGroup.shippingAddress.firstName" />&nbsp;
								<dsp:valueof param="shippingGroup.shippingAddress.lastName" />
								</div>
								<p>
									<dsp:valueof param="shippingGroup.shippingAddress.address1" /></br>
									<dsp:valueof param="shippingGroup.shippingAddress.city" />,&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.state" />&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.country" />&nbsp;<dsp:valueof param="shippingGroup.shippingAddress.postalCode" />
								</p>
							</dsp:oparam>
						</dsp:droplet>
					</div>
					<div class="order-details order-special-int">
						<h4>
							<fmt:message key="orderDetail.spclInstrctn" />
						</h4>
						<dsp:droplet name="ForEach">
			          	<dsp:param name="array" param="result.shippingGroups[0].specialInstructions"/>
						<dsp:param name="elementName" value="specialInstr"/>
						<dsp:oparam name="output">
							<c:if test="${not empty specialInstr}">
								<p><dsp:valueof param="specialInstr"/></p>
							</c:if>
						</dsp:oparam>
						</dsp:droplet>
					</div>
					<div class="order-details">
						<h4 class="style-upercase">
							<fmt:message key="orderDetail.billingAddr" />
						</h4>
						<dsp:include page="/global/gadgets/billingAddressContent.jsp">
							<dsp:param name="order" param="result" />
						</dsp:include>
					</div>

					<div class="order-details order-detailadds">
						<h4 class="style-upercase">
							<fmt:message key="orderDetail.paymentMethod" />
						</h4>
						<dsp:include page="/global/gadgets/paymentMethodsContent.jsp">
							<dsp:param name="order" param="result" />
						</dsp:include>
					</div>
					<div class="customer-order">
						<table >
									<dsp:include page="/global/gadgets/orderedItems.jsp">
										<dsp:param name="order" param="result" />
									</dsp:include>
									<dsp:include page="/account/gadgets/orderTotals.jsp">
										<dsp:param name="order" param="result" />
									</dsp:include>

							</table>
					</div>
			</div>
		 </dsp:oparam>
		</dsp:droplet>
		</section>
		</main>
	</lzb:pageContainer>
</dsp:page>
