<dsp:page>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">
			two-column-equal checkout shipping-billing
		</jsp:attribute>
		<jsp:body>
		<dsp:getvalueof param="acceptZipcode" var="acceptZipcode" />
			<dsp:importbean bean="/atg/commerce/ShoppingCart" />
			<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
			<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
			<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
			<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
			<dsp:importbean bean="/com/lzb/service/SessionBean" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<dsp:getvalueof bean="ShoppingCart.current" var="order"/>
			<dsp:include page="/global/includes/reprice.jsp">
				<dsp:param name="pageReprice" value="checkout"/>
			</dsp:include>
		<dsp:include page="/includes/webtrendsContent.jsp">
  			<dsp:param name="page" value="Checkout"  />
  		</dsp:include>
  		<c:set var="pageTypeForTracking" value="checkout" scope="request" />
		  		<dsp:getvalueof var="commerceItemCount"
			bean="ShoppingCart.current.commerceItemCount" />
		<c:choose>
							<c:when test='${commerceItemCount > 0}'>
					<dsp:include page="/global/includes/cartTax.jsp">
									<dsp:param name="callTax" value="true" />
								</dsp:include>
		</c:when>
		</c:choose>
			<dsp:getvalueof bean="PaymentGroupFormHandler.formError" var="formError" />
			<dsp:getvalueof var="loginStatus" bean="Profile.transient"/>
			<input type="hidden" class="loginStatus" value="${loginStatus}" />

			<c:if test="${formError eq 'true'}">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="PaymentGroupFormHandler" />
					</dsp:include>
				</div>
			</c:if>

			<main role="main" class="table-display">
	<dsp:getvalueof bean="ProfileFormHandler.zipCode" var="zipCode" /><span id="postalCode">${zipCode}</span>
					<c:if test="${not empty zipCode}">

						<div data-module="delivery-zipcode"
							data-href="/cart/gadgets/changed_delivery_charge.jsp?postalCode=${fn:replace(zipCode,' ', '+')}&checkoutPage=payment"
							id="delivery-zipcode">
						</div>

					 </c:if>
				<%-- formhandler Errors --%>
				<%-- formhandler Synchrony error --%>
				<dsp:droplet name="IsEmpty">
					<dsp:param name="value"	bean="PaymentGroupFormHandler.synchronyMessageHtml"/>
					<dsp:oparam name="false">
						<dsp:valueof bean="PaymentGroupFormHandler.synchronyMessageHtml" valueishtml="true"/>
					</dsp:oparam>
				</dsp:droplet>

				<dsp:form id="paymentForm" name="paymentForm" method="post" action="/checkout/deliveryAndPayment.jsp">

					<div class="main-section">
						<h1><fmt:message key="checkout.deliveryAndPaymentText"/></h1>
						<div>
							<p><fmt:message key="checkout.deliveryAndPayment.instruction"/></p>
							<dsp:include page="gadgets/continueToReviewButton.jsp"></dsp:include>
						</div>
					</div>

					<div class="fe-validation-msgs" style="display:none">
						<h2>Validation Error Messages</h2>
						<ul id="errLineMsgs">

						</ul>
					</div>

					<section role="region" class="my-account-content delivery-address" data-module="delivery-address">
					<input type="hidden" value="${order.id}" id="orderId"/>
					<input type="hidden" value="${loginStatus}" id="profileTransient"/>
		<c:if test="${acceptZipcode eq true}">
			<dsp:input id="acceptedChangedAddress" bean="PaymentGroupFormHandler.acceptedChangedAddress" type="hidden" value="true"/> </c:if>
						<%-- <c:if test="${not empty zipCode &&  empty nodealer}">--%>
							<!-- <dsp:input id="acceptedChangedAddress" bean="PaymentGroupFormHandler.acceptedChangedAddress" type="checkbox" /> Accept New Zip Code<br/> -->
						<%-- </c:if> --%>

						<div class="required-fields-label">
							<sup>&#42;</sup> Required fields
						</div>

						<section id="addAddressForm" class="standard-border" data-module="form-validate">
							<dsp:include page="shipping.jsp" />
							<dsp:droplet name="IsEmpty">
								<dsp:param name="value" param="paymentMethod" />
								<dsp:oparam name="true">
									<dsp:include page="payment.jsp" />
								</dsp:oparam>
								<dsp:oparam name="false">
									<dsp:droplet name="Switch">
										<dsp:param name="value" param="paymentMethod" />
										<dsp:oparam name="lzb">
											<dsp:include page="paymentSynchronyCard.jsp" />
										</dsp:oparam>
									</dsp:droplet>
								</dsp:oparam>
							</dsp:droplet>
							<fieldset class="address-primaries">
								<legend>Terms and Conditions</legend>
								<label for="tAndS" style="display:none">terms and conditions</label>
								<dsp:input type="checkbox" id="tAndS" bean="PaymentGroupFormHandler.termsAndConditions"/><sup>&#42</sup>
									I have read and agree to the <a href="/modals/onlineTermsCondition.jsp" target="_blank">online terms and conditions of sale</a>
							</fieldset>
							<dsp:include page="gadgets/continueToReviewButton.jsp"></dsp:include>

						</section><%-- #addAddressForm --%>
					</section>

					<section role="region" class="payment-right">
						<dsp:include page="/checkout/gadgets/checkout_order_summary.jsp"/>

						<div class="payment-article">
							<h3>Return Policy / La-Z-Boy Guarantee</h3>
								<p>With every La-Z-Boy product, you receive the famous La-Z-Boy limited warranty; one of the best in the industry</p>
									<a href="/content/CustomerCare/WarrantyInformation" target="_blank">Review Our Warranty</a>
									<dsp:droplet name="/atg/targeting/TargetingFirst">
										<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/WarrantyInformationContent" />
										<dsp:oparam name="output">
											<dsp:valueof param="element.content.data" valueishtml="true" />
										</dsp:oparam>
									</dsp:droplet>
								<p>Have a return? Read our online return policy to find out all of the details that you will need to know.</p>
									<a href="/content/policies/return-policy" target="_blank">Learn About Returns</a>
									<dsp:droplet name="/atg/targeting/TargetingFirst">
										<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/ReturnPolicyContent" />
										<dsp:oparam name="output">
											<dsp:valueof param="element.content.data" valueishtml="true" />
										</dsp:oparam>
									</dsp:droplet>

							<dsp:droplet name="/atg/targeting/TargetingFirst">
								<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/CustomerCareContent" />
								<dsp:oparam name="output">
									<dsp:valueof param="element.content.data" valueishtml="true" />
								</dsp:oparam>
							</dsp:droplet>
						</div>

						<div class="order-base need-help">
							<img src="../img/help_icon.png" alt="Need Help"/>
							<div class="help-content">
								<h3>Let us Help</h3>
								<p class="mobile"><span>CALL</span> 800-375-6890</p>
							</div>
						</div>

						<div class="need-help secure-shop">
							<div class="order-base">
								<img src="../img/secure_icon.png" alt="Secure Shopping"/>
								<div class="help-content">
									<h3>Secure Shopping</h3>
									<p>We work to protect the security of your information during transmission by using Secure Sockets Layer (SSL) software.</p>
									<a href="/content/policies/privacy-policy" target="_blank">Read How We Protect Your Info</a>
								</div>
							</div>
							<dsp:droplet name="/atg/targeting/TargetingFirst">
								<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/SecuredShoppingContent" />
								<dsp:oparam name="output">
									<dsp:valueof param="element.content.data" valueishtml="true" />
								</dsp:oparam>
							</dsp:droplet>
							<dsp:droplet name="/atg/targeting/TargetingFirst">
								<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/OurGauranteeContent" />
								<dsp:oparam name="output">
									<dsp:valueof param="element.content.data" valueishtml="true" />
								</dsp:oparam>
							</dsp:droplet>
						</div>

					</section>

				</dsp:form>

			</main>

		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
