<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
	<dsp:importbean bean="/atg/dynamo/service/CurrentDate" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/order" />
	<dsp:getvalueof var="orderId" value="orderId" />
	<lzb:pageContainer>

		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<jsp:attribute name="title">Order Detail</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
		<main role="main">
				<dsp:include page="/includes/leftnavigation.jsp">
					        <dsp:param name="selpage" value="ORDERHISTORY" />
					      </dsp:include>

			<dsp:droplet name="OrderLookup">

			<dsp:param name="orderId" param="orderId" />
			<section role="region" class="my-account-content">
			<h1>
				Order No. :
				<dsp:valueof param="result" />
			</h1>

			<p>
				If you have questions, please have your order number available and
				call us at 1-800-375-6890 or email us at <a
					href="mailto:email@la-z-boy.com">email@la-z-boy.com</a>
			</p>

			<div class="cust-order-details account-orderdetail">

				<div class="order-title">
					<h2>Your order details</h2>
					<div class="order-no">
						Order No.: <span><dsp:valueof param="result" /></span>
					</div>
				</div>

				<div class="order-details order-detailadds">
					<h4 class="style-upercase">Delivery Address</h4>
					<dsp:include page="/account/deliveryAddressContent.jsp">
						<dsp:param name="orderNo" param="result" />
					</dsp:include>
				</div>
				<div class="order-details">
					<h4>Special Delivery Instructions</h4>
					<p>
						<dsp:getvalueof param="order.shippingGroups" var="shippingGroups" />
						<c:choose>
							<c:when test="${ not empty shippingGroups }">
								<dsp:valueof param="order.shippingGroups[0].specialInstructions" />
							</c:when>
							<c:otherwise>
								<fmt:message key="orderDetail.delivery" />
							</c:otherwise>
						</c:choose>
					</p>
				</div>

				<div class="order-details">
					<h4 class="style-upercase">Billing Address</h4>
					<p>
						<dsp:include page="/account/billingAddressContent.jsp">
							<dsp:param name="orderNo" param="result" />
						</dsp:include>
					</p>
				</div>

				<div class="order-details">
					<h4 class="style-upercase">Payment Method</h4>
					<dsp:include page="/account/paymentMethodsContent.jsp">
						<dsp:param name="orderNo" param="result" />
					</dsp:include>
				</div>

				<div class="customer-order">
					<dsp:include page="/account/orderedItemContents.jsp">
						<dsp:param name="orderNo" param="result" />
					</dsp:include>
				</div>

			</div>


		</dsp:droplet>
		</section>
		</main>
	</lzb:pageContainer>

</dsp:page>
