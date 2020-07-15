<dsp:page>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">
			two-column-equal checkout review
		</jsp:attribute>
		<jsp:body>
		<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
		<dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler"/>
		<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
		<dsp:importbean bean="/atg/userprofiling/Profile"/>

		<dsp:getvalueof var="isEmailOpted" bean="Profile.optInEmail"/>
		<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty"/>
		<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>

		<dsp:include page="/global/includes/reprice.jsp">
			<dsp:param name="pageReprice" value="checkout"/>
		</dsp:include>
		<%--
		<dsp:include page="includes/checkoutHeader.jsp">
			<dsp:param name="page" value="ordRew"/>
		</dsp:include>
		--%>
		<dsp:include page="/includes/webtrendsContent.jsp">
 			 <dsp:param name="page" value="Checkout"  />
  		</dsp:include>
  	    <c:set var="pageTypeForTracking" value="checkout" scope="request" />
		<main role="main">
			<dsp:form name="checkoutRegisterForm" id="checkoutRegisterForm" formid="checkoutRegisterForm" method="POST" autocomplete="off">

			<div class="main-section">
				<h1><fmt:message key="checkout.review.orderReview"/></h1>
				<div>
					<p><fmt:message key="checkout.review.instruction"/></p>
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param bean="CommitOrderFormHandler.formExceptions" name="exceptions" />
						<dsp:oparam name="output">
							<strong style="color: red;"><dsp:valueof param="message" />
							</strong>
							<br />
						</dsp:oparam>
					</dsp:droplet>
					<dsp:include page="gadgets/submitOrder.jsp"/>
				</div>
			</div><%-- .main-section --%>
			<section role="region">
				<section class="my-account-content guest-shopper" role="region">
				<dsp:include page="gadgets/deliveryInfo.jsp"/>
				<dsp:include page="gadgets/paymentInfo.jsp"/>
				<div class="email-sign-up">
				<c:if test="${!isEmailOpted}">
					<fieldset class="email-sign billadd-check">
						<legend>Email Sign Up?</legend>
						<label for="sign-up"><fmt:message key="checkout.review.emailSignUp"/></label>
						<dsp:input type="checkbox" id="sign-up" bean="CommitOrderFormHandler.optInEmail"/>
						<fmt:message key="checkout.review.signMeUp"/>
					</fieldset>
				</c:if>
				<c:if test="${securityStatus < 2}">
					<div class="creat-account">
						<h3><fmt:message key="checkout.review.createAnAccount"/></h3>
						<p><fmt:message key="checkout.review.experience"/></p>
					</div><%-- .creat-account --%>
					<fieldset>
						<legend>Please provide a password</legend>
						<label for="password"><fmt:message key="checkout.review.password"/></label>
						<dsp:input id="password" type="password" bean="CommitOrderFormHandler.password"/>
					</fieldset>
					<fieldset>
						<legend>Please provide a confirm password</legend>
						<label for="confirm-password"><fmt:message key="checkout.review.confirmPassword"/></label>
						<dsp:input id="confirm-password" type="password" bean="CommitOrderFormHandler.confirmPassword"/></br>
					</fieldset>
				</c:if>
				<dsp:include page="gadgets/submitOrder.jsp"/>
				</div><%-- .email-sign-up --%>
				</section>
			</section>
			<section class="payment-right" role="region">
				<dsp:droplet name="/atg/targeting/TargetingFirst">
					<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/SecuredShoppingContent" />
					<dsp:oparam name="output">
						<dsp:valueof param="element.content.data" valueishtml="true" />
					</dsp:oparam>
				</dsp:droplet>
				<c:if test="${cartEmpty eq 'false'}">
					<dsp:include page="/checkout/gadgets/checkout_order_summary.jsp">
						<dsp:param name="reviewPage" value="true"/>
					</dsp:include>
				</c:if>
				<dsp:droplet name="/atg/targeting/TargetingFirst">
					<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/OurGauranteeContent" />
					<dsp:oparam name="output">
						<dsp:valueof param="element.content.data" valueishtml="true" />
					</dsp:oparam>
				</dsp:droplet></br>

				<dsp:droplet name="/atg/targeting/TargetingFirst">
					<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/CustomerCareContent" />
					<dsp:oparam name="output">
						<dsp:valueof param="element.content.data" valueishtml="true" />
					</dsp:oparam>
				</dsp:droplet>
				<div class="need-help">
					<div class="order-base">
						<img src="../img/help_icon.png" alt="Need Help"/>
						<div class="help-content">
							<h3>Let us Help</h3>
							<p class="mobile"><span>CALL</span> 800-375-6890</p>
						</div>
						<%-- .help-content --%>
				</div><%-- .order-base --%>
				</div><%-- .need-help --%>
			</section>
			</dsp:form>
		</main>


		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
