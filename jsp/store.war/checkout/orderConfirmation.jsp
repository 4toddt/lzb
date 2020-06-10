<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<c:set var="pageTypeForTracking" value="purchase" scope="request" />
	<lzb:pageContainer>
	<jsp:attribute name="bodyClass">two-column-last checkout</jsp:attribute>
	<jsp:attribute name="title">
			<c:choose>
			<c:when test="${not empty selectedFacet}">
				${selectedFacet}
			</c:when>
			<c:when test="${not empty content.title }">
				${content.title}
			</c:when>
			<c:otherwise>
				<fmt:message key="meta.home.title" />
			</c:otherwise>
			</c:choose>
	</jsp:attribute>
	<jsp:attribute name="metaDescription">
		<c:choose>
			<c:when test="${not empty content.metaDescription }">
				${content.metaDescription}
			</c:when>
			<c:otherwise>
				<fmt:message key="meta.home.metaDescription" />
			</c:otherwise>
		</c:choose>
	</jsp:attribute>
	<jsp:attribute name="metaKeywords">
		<c:choose>
			<c:when test="${not empty content.metaKeywords }">
				${content.metaKeywords}
			</c:when>
			<c:otherwise>
				<fmt:message key="meta.home.metaKeywords" />
			</c:otherwise>
		</c:choose>
	</jsp:attribute>
	<jsp:body>

	
	<main role="main">
		<div class="main-section">
			<h1><fmt:message key="checkout.confirmation.thankYou"/></h1>
			<div>
				<dsp:a href="javascript:window.print()">
				<input type="button" value="PRINT RECEIPT" class="btn-primary review-button print">
				</dsp:a>
			</div>
		</div><%-- .main-section --%>
		<section role="region" class="order-confirmation guest-shopper">
			<div class="cart-head">
				<div class="living-life" data-module="cbox">
					<p><span><fmt:message key="checkout.confirmation.instruction"/></span></p>
				</div>
			</div>
			<div class="cartForm">
				<div class="payment-delivery">
					<div class="delivery-address">
						<div>
							<h2><fmt:message key="checkout.confirmation.yourOrderDetails"/></h2>
							<span><fmt:message key="checkout.confirmation.orderNo"/>: <dsp:valueof bean="ShoppingCart.last.id"/></span>
						</div>
						<div class="saved-address">
							<h3><fmt:message key="checkout.confirmation.deliveryAddress"/></h3>
							<ul><%-- deliveryAddressContent.jsp --%>
							<dsp:param name="orderNo" bean="ShoppingCart.last"/>
							<dsp:getvalueof var="shippingGroups" param="orderNo.shippingGroups"/>

					      	<dsp:droplet name="ForEach">
								<dsp:param name="array" value="${shippingGroups}"/>
								<dsp:param name="elementName" value="shippingGroup"/>
								<dsp:oparam name="output">
									<li>
										<dsp:valueof param="shippingGroup.shippingAddress.firstName"/>&nbsp;
										<dsp:valueof param="shippingGroup.shippingAddress.lastName"/>
									</li>
									<li>
										<dsp:valueof param="shippingGroup.shippingAddress.address1"/>
									</li>
									<li>
										<dsp:valueof param="shippingGroup.shippingAddress.city"/>&nbsp;
										<dsp:valueof param="shippingGroup.shippingAddress.state"/>&nbsp;
										<dsp:valueof param="shippingGroup.shippingAddress.country"/>&nbsp;
										<dsp:valueof param="shippingGroup.shippingAddress.postalCode"/>&nbsp;
									</li>
									<input type="hidden" id="shippingZip" value="<dsp:valueof param="shippingGroup.shippingAddress.postalCode"/>" />
									<input type="hidden" id="shippingState" value="<dsp:valueof param="shippingGroup.shippingAddress.state"/>" />
									<input type="hidden" id="shippingEmail" value="<dsp:valueof param="shippingGroup.shippingAddress.email"/>" />
									<input type="hidden" id="orderID" value="<dsp:valueof bean="ShoppingCart.last.id"/>" />
								</dsp:oparam>
							</dsp:droplet>
							</ul>
						</div><%-- .saved-address --%>

						<div class="saved-address special-delivery">
							<h3><fmt:message key="checkout.confirmation.specialInstructions"/></h3>
							<p>
							<dsp:droplet name="ForEach">
								<dsp:param name="array" bean="ShoppingCart.last.shippingGroups[0].specialInstructions"/>
								<dsp:param name="elementName" value="specialInstr"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="specialInstuction" param="specialInstr"/>
									<c:choose>
										<c:when test="${ not empty specialInstuction}">
							    				<dsp:valueof value="${specialInstuction}"/>
							    			</c:when>
							    			<c:otherwise>
							    				<fmt:message key="checkout.review.noInstructionsEnterd"/>
							    			</c:otherwise>
						    			</c:choose>
								</dsp:oparam>
							</dsp:droplet>
							</p>
						</div><%-- .saved-address .special-delivery --%>
						<div class="saved-address"><%-- billingAddressContent.jsp --%>
							<h3><fmt:message key="checkout.confirmation.billingAddress"/></h3>
							<dsp:param name="orderNo" bean="ShoppingCart.last"/>
							<dsp:getvalueof var="paymentGroups" param="orderNo.paymentGroups"/>
							<dsp:droplet name="ForEach">
								<dsp:param name="array" value="${paymentGroups}"/>
								<dsp:param name="elementName" value="paymentGroup"/>
									<dsp:oparam name="output">
										<dsp:valueof param="paymentGroup.billingAddress.firstName"/>
										<dsp:valueof param="paymentGroup.billingAddress.lastName"/><br/>
										<dsp:valueof param="paymentGroup.billingAddress.address1"/><br/>
										<dsp:valueof param="paymentGroup.billingAddress.city"/>&nbsp;
										<dsp:valueof param="paymentGroup.billingAddress.state"/>&nbsp;
										<dsp:valueof param="paymentGroup.billingAddress.country"/>&nbsp;
										<dsp:valueof param="paymentGroup.billingAddress.postalCode"/><br/>
										<dsp:valueof param="paymentGroup.billingAddress.phoneNumber"/><br/>
										<input type="hidden" id="billingZip" value="<dsp:valueof param="paymentGroup.billingAddress.postalCode"/>" />
										<input type="hidden" id="billingState" value="<dsp:valueof param="paymentGroup.billingAddress.state"/>" />
									</dsp:oparam>
							</dsp:droplet>
						</div><%-- .saved-address --%>
						<div class="saved-address special-delivery"><%-- orderedItemContents.jsp --%>
							<h3><fmt:message key="checkout.confirmation.paymentMethod"/></h3>
							<dsp:getvalueof var="paymentGroups" param="orderNo.paymentGroups"/>
							<dsp:getvalueof var="payGrpCount" param="orderNo.paymentGroupCount"/>
							<dsp:param name="orderNo" bean="ShoppingCart.last"/>
							<dsp:droplet name="ForEach">
								<dsp:param name="array" value="${paymentGroups}"/>
								<dsp:param name="elementName" value="paymentGroup"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="pay" param="paymentGroup"/>
									<p>
									<dsp:valueof value="${pay.creditCardType}"/> <dsp:valueof converter="CreditCard" numcharsunmasked="4" maskcharacter=" " value="${pay.creditCardNumber}"/></br>
							    	</p>
							    		<c:choose>
							    			<c:when test="${payGrpCount eq 1}">
							    				<ul>
								    				<li>
									    				<fmt:message key="checkout.review.deposit"/>
									    				<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.depositAmount}" />
														</dsp:include>
													</li>
													<li>
									    				<fmt:message key="checkout.review.balance"/>
									    				<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.balanceAmount}" />
														</dsp:include>
													</li>
												</ul>
							    			</c:when>
							    			<c:when test="${payGrpCount eq 2}">
							    				<ul>
							    				<c:if test="${pay.lzbDebitType eq 'deposit'}">
							    					<li>
								    					<fmt:message key="checkout.review.deposit"/>
								    					<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.depositAmount}" />
														</dsp:include>
													</li>
							    				</c:if>
							    				<c:if test="${pay.lzbDebitType eq 'balance'}">
							    					<li>
								    					<fmt:message key="checkout.review.balance"/>
								    					<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.balanceAmount}" />
														</dsp:include>
													</li>
							    				</c:if>
							    				</ul>
							    			</c:when>
							    		</c:choose>
								</dsp:oparam>
							</dsp:droplet>
						</div><%-- .saved-address special-delivery --%>
					</div><%-- .delivery-address --%>
				</div><%-- .payment-delivery --%>
				<h2><fmt:message key="checkout.confirmation.orderedItems"/></h2>
				<dsp:include page="/account/includes/orderedItemContents.jsp">
					<dsp:param name="orderNo" bean="ShoppingCart.last"/>
				</dsp:include>

			</div><%-- #cartForm --%>
		</section>
		<aside class="order-review-sum" role="complmentary">
			<dsp:include page="/checkout/gadgets/receipt_order_summary.jsp"/>
		</aside>
		<%-- marketing slot Targeters, Bottom & right rail slots --%>
			<dsp:include page="/global/pageTargeter.jsp">
						<dsp:param name="targeterName" value="OrderConfirmBottomSlot"/>
			</dsp:include>
			<dsp:include page="/global/pageTargeter.jsp">
						<dsp:param name="targeterName" value="OrderConfirmRightRailSlot"/>
			</dsp:include>
		</main>


		<dsp:getvalueof var="submittedDateTime" param="orderNo.submittedDate" />
		<c:set var="submittedDateTimePart" value="${fn:split(submittedDateTime, ' ')}" />

		<dsp:include page="/includes/turnToOrderFeed.jsp">
			<dsp:param name="order" bean="ShoppingCart.last"/>
		</dsp:include>

		<dsp:include page="/checkout/monetateOrderConfirmationData.jsp">
			<dsp:param name="order" bean="ShoppingCart.last"/>
		</dsp:include>

		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
