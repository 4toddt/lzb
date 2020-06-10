<dsp:page>
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
	<dsp:include page="includes/checkoutHeader.jsp">
		<dsp:param name="page" value="ordRew"/>
	</dsp:include>
	<h2><fmt:message key="checkout.review.orderReview"/></h2>
	<p><fmt:message key="checkout.review.instruction"/></p>
	
	
	<dsp:droplet name="ErrorMessageForEach">
		<dsp:param bean="CommitOrderFormHandler.formExceptions" name="exceptions" />
		<dsp:oparam name="output">
			<strong style="color: red;"><dsp:valueof param="message" />
			</strong>
			<br />
		</dsp:oparam>
	</dsp:droplet>
	<dsp:form  autocomplete="off">
		<dsp:include page="gadgets/submitOrder.jsp"/>
		<dsp:include page="gadgets/deliveryInfo.jsp"/>
		<dsp:include page="gadgets/paymentInfo.jsp"/>
		<c:if test="${!isEmailOpted}">
			<fmt:message key="checkout.review.emailSignUp"/></br>
			<dsp:input type="checkbox" bean="CommitOrderFormHandler.optInEmail"/>
			<fmt:message key="checkout.review.signMeUp"/></br></br></br>
		</c:if>
		<c:if test="${securityStatus < 2}">
			<fmt:message key="checkout.review.createAnAccount"/>
			<fmt:message key="checkout.review.experience"/><br/>
			<label><fmt:message key="checkout.review.password"/></label>
			<dsp:input type="password" bean="CommitOrderFormHandler.password"/></br>
			<label><fmt:message key="checkout.review.confirmPassword"/></label>
			<dsp:input type="password" bean="CommitOrderFormHandler.confirmPassword"/></br>
		</c:if>
		<dsp:include page="gadgets/submitOrder.jsp"/>
	</dsp:form>
	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/SecuredShoppingContent" />
		<dsp:oparam name="output">
			<dsp:valueof param="element.content.data" valueishtml="true" />
		</dsp:oparam>
	</dsp:droplet>
	<c:if test="${cartEmpty eq 'false'}">
		<dsp:include page="/checkout/gadgets/checkout_order_summary.jsp"/>
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
	<div style="border-top:1px solid #000;width:100%;">
		<dsp:a href="#" title="" onclick=""><fmt:message key="cart.liveChat"/></dsp:a> 
	</div>
</dsp:page>