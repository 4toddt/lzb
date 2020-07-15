<%--
    - File Name: orderConfirmation.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the order confirmation page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBGetRelatedOrdersDroplet" />
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
	<%-- Page Variables --%>

	<%-- HEAD stuff--%>
	<layout:checkout>
		<jsp:attribute name="pageTitle">Order Confirmation</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">checkout</jsp:attribute>
		<jsp:attribute name="pageType">orderConfirmation</jsp:attribute>
		<jsp:attribute name="bodyClass">checkout orderConfirmation</jsp:attribute>
		<jsp:attribute name="analyticsPageType">orderConfirmationPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
			<%-- include analytics json data for order details --%>
			<script id="orderConfirmationDetails" type="application/json">
				<dsp:include page="/checkout/json/orderConfirmationDetails.jsp">
					<dsp:param name="order" bean="ShoppingCart.last"/>
				</dsp:include>
			</script>
		</jsp:attribute>
	
		<jsp:body>
			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextLinkPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.orderConfirmation"/></span></li>
				</ul>
			</section>
			<div class="secure-transaction"><span class="icon icon-lock"></span><fmt:message key="checkout.secure.transaction" /></div>

			<%-- Render hidden content for analytics --%>
			<div class="hide">
				<dsp:param name="orderNo" bean="ShoppingCart.last"/>
				
				<dsp:getvalueof var="shippingGroups" param="orderNo.shippingGroups"/>
				<dsp:droplet name="ForEach">
					<dsp:param name="array" value="${shippingGroups}"/>
					<dsp:param name="elementName" value="shippingGroup"/>
					<dsp:oparam name="output">
						<input type="hidden" id="shippingZip" value="<dsp:valueof param="shippingGroup.shippingAddress.postalCode"/>" />
						<input type="hidden" id="shippingState" value="<dsp:valueof param="shippingGroup.shippingAddress.state"/>" />
						<input type="hidden" id="shippingEmail" value="<dsp:valueof param="shippingGroup.shippingAddress.email"/>" />
						<input type="hidden" id="orderID" value="<dsp:valueof bean="ShoppingCart.last.id"/>" />
					</dsp:oparam>
				</dsp:droplet>
				<dsp:getvalueof var="paymentGroups" param="orderNo.paymentGroups"/>
				<dsp:droplet name="ForEach">
					<dsp:param name="array" value="${paymentGroups}"/>
					<dsp:param name="elementName" value="paymentGroup"/>
						<dsp:oparam name="output">
							<input type="hidden" id="billingZip" value="<dsp:valueof param="paymentGroup.billingAddress.postalCode"/>" />
							<input type="hidden" id="billingState" value="<dsp:valueof param="paymentGroup.billingAddress.state"/>" />
						</dsp:oparam>
				</dsp:droplet>
			</div>

			<dsp:droplet name="LZBGetRelatedOrdersDroplet" >
				<dsp:param name="order" bean="ShoppingCart.last" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="relatedOrders" param="relatedOrders" />
				</dsp:oparam>
			</dsp:droplet>

			<dsp:getvalueof var="relatedOrderNums" param="orderNo.relatedOrders"/>
			
			<!-- relOrderIDs : ${relatedOrderNums} -->
			
			<dsp:droplet name="InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/SharedMobile/Transaction Successful/Banner and Instructions" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<c:forEach var="content" items="${element.contents}">
					<dsp:renderContentItem contentItem="${content}" />
				</c:forEach>
			</dsp:oparam>
			<dsp:oparam name="error">
			</dsp:oparam>
			</dsp:droplet>
			<%-- 
			<img class="header-image" src="https://via.placeholder.com/980x290">
			<div class="heading-text">It's official, comfort is on its way!</div>
			<div class="order-info">
				<p>Order Number <span class="order-num">#<dsp:valueof bean="ShoppingCart.last.id"/></span></p>
				We will call you on Tuesday, May 15th between 12pm - 3pm.
			</div>
			--%>
			<div class="order-info">
				<p>Order Number <span class="order-num">#<dsp:valueof bean="ShoppingCart.last.id"/></span></p>
			</div>
			<div class="order-confirmation-content">
				<h2 class="title hide-for-medium"><fmt:message key="order.detail.title"/></h2>
				
				<dsp:include page="/checkout/includes/orderedItemContents.jsp">
					<dsp:param name="orderNo" bean="ShoppingCart.last"/>
				</dsp:include>
			</div>
			<div class="promo-and-totals">
				<dsp:include page="/checkout/includes/orderSummary.jsp?pageType=orderConfirmation" />
			</div>

			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${relatedOrders}"/>
				<dsp:param name="elementName" value="relOrder"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="relatedOrder" param="relOrder"/>
<%--  				
					<dsp:droplet name="OrderLookup" >
					<dsp:param name="orderId" value="${relOrder}" />
					<dsp:oparam name="output">
					    <dsp:getvalueof var="relatedOrder" param="result" />
					<!-- relOrder1 : ${relatedOrder} -->
					</dsp:oparam>
					</dsp:droplet>
					
					<!-- relOrder2 : ${relatedOrder} -->
--%>
					<div class="order-info related-order">
						<p>Order Number <span class="order-num">#${relatedOrder.id} </span></p>
					</div>
					<div class="order-confirmation-content related-order">
						<h2 class="title hide-for-medium"><fmt:message key="order.detail.title"/></h2>

						<dsp:include page="/checkout/includes/orderedItemContents.jsp">
							<dsp:param name="orderNo" value="${relatedOrder}"/>
						</dsp:include>
					</div>
					<div class="promo-and-totals">
						<dsp:include page="/checkout/includes/orderSummary.jsp?pageType=orderConfirmation" >
							<dsp:param name="relOrder" value="${relatedOrder}" />
						</dsp:include>
					</div>
				</dsp:oparam>
			</dsp:droplet>


			<%-- Marketing Slot Targeters, Bottom & right rail slots. Commented/Removed targeter per JIRA DMI-2006 --%>
			<%--
			<div class="page-targeter">
				<dsp:include page="/global/pageTargeter.jsp">
					<dsp:param name="targeterName" value="OrderConfirmBottomSlot"/>
				</dsp:include>
				<dsp:include page="/global/pageTargeter.jsp">
					<dsp:param name="targeterName" value="OrderConfirmRightRailSlot"/>
				</dsp:include>
			</div>
			--%>

			<%-- Include TurnTo Order Feed JavaScript --%>
			<dsp:include page="/checkout/includes/turnToOrderFeed.jsp">
				<dsp:param name="order" bean="ShoppingCart.last"/>
			</dsp:include>

			<%-- Include Monetate Order Confirmation Data JavaScript --%>
			<dsp:include page="/checkout/includes/monetateOrderConfirmationData.jsp">
				<dsp:param name="order" bean="ShoppingCart.last"/>
			</dsp:include>
		</jsp:body>
	</layout:checkout>
</dsp:page>