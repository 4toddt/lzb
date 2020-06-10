<%--
  This page renders login form for returned customers.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
  <dsp:importbean bean="/atg/commerce/ShoppingCart" />
  <dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount" />
  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
   <dsp:layeredBundle basename="com.lzb.common.WebAppResources">

<c:set var="headerUrl">${header.referer}</c:set>
<c:set var="strPositionOfPort" value=".com"/>
<c:set var="intPositionOfPort">${fn:indexOf(headerUrl, strPositionOfPort)}</c:set>
<c:set var="url">${fn:substring(headerUrl, 0, (intPositionOfPort + 4))}</c:set>

<!doctype html>
<html class="no-js">

	<head>

		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Sign-in</title>
		<meta name="description" content="">
		<meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="/css/min/desktop.css?ver=${assetVersion}" type="text/css" />
		<script src="/js/amp.js?ver=${assetVersion}"></script>

	</head>

	<body role="document" dir="ltr">

                <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
                  <dsp:param name="inUrl" value="/"/>
                  <dsp:oparam name="output">
                        <dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
                  </dsp:oparam>
                </dsp:droplet>

           <%--
          Check Profile's security status. If user is logged in from cookie,
          display default values, i.e. profile's email address in this case, otherwise
          do not populate form handler with profile's values.
         --%>
		<dsp:getvalueof var="successURL" value="${pageContext.request.contextPath}/rwd/checkout/cart.jsp"/>
		<c:choose>
	     	<c:when test="${commerceItemCount > 0}">
	     		<dsp:getvalueof var="guestSuccessURL" value="${pageContext.request.contextPath}/checkout/deliveryAndPayment.jsp"/>
			</c:when>
			<c:otherwise>
				<dsp:getvalueof var="guestSuccessURL" value="${pageContext.request.contextPath}/rwd/checkout/cart.jsp"/>
			</c:otherwise>
		</c:choose>

 	<main role="main" class="signin" data-module="modal-jquery-validation" data-domain="${updatedProtocolURL}" data-destination="${url}">
 			<%-- Form title --%>
    <h1>Sign In To Your La-Z-Boy Account</h1>

        <dsp:getvalueof bean="ProfileFormHandler.formError" var="formError"/>
				<c:if test="${formError eq 'true'}">
					<dsp:include page="/includes/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler"/>
					</dsp:include>
				</c:if>

        <div id="signInError" class="amp-error"></div>

		<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
		  <dsp:param name="inUrl" value="${hostName}/xhr/amplifiSubmit.jsp"/>
		  <dsp:oparam name="output">
		  	<dsp:getvalueof id="submitURL" param="secureUrl" idtype="java.lang.String" scope="request" />
		  </dsp:oparam>
		</dsp:droplet>

		<form action="${submitURL}" method="post" id="checkoutSignInForm" class="modal-jquery-validation sign-in-form amplifi-form" data-error-messaging="#signInError" autocomplete="off" data-domain="${updatedProtocolURL}" data-destination="${url}">
			<fieldset>
				<legend>Sign In</legend>
				<fieldset>
					<legend>Please provide an email address</legend>
				    <label for="email"><fmt:message key="common.loginEmailAddress"/>:</label>
				    <input type="email" id="email" name=".value.login" class="amplifi-input" maxlength="50" required="true" autofocus/>
			    </fieldset>
				<fieldset>
					<legend>Please provide a password</legend>
				    <label for="password"><fmt:message key="common.loginPassword"/>:</label>
					<input type="password" id="password" name=".value.password" maxlength="16" value="" class="amplifi-input pwAlphaNumeric" required="true" />
				</fieldset>
				<fieldset>
				    <legend>Choose to remember username and submit signin form</legend>
	                <input type="checkbox" id="remember" name=".value.rememberMe" name="remember" class="amplifi-input" checked="true"/>
					<label for="remember" class="checkout checkout1">Remember Me
						<a title="This means that we will save your password until you click 'sign out' even if you disconnect from the
	                    internet, close your browser or turn off your computer.  Just to keep you safe, we will automatically
	                    sign you out after 90 days even if you haven't clicked 'sign out'." class="tooltip" href="#">
	                      <div class="triangle-with-shadow"></div>
	                      <div title="" class="tooltip-img"></div>
	                    </a>

					</label>

					<input type="submit" value="SIGN IN" class="btn-primary submitBtn amplifi-submitter" data-error-messaging="#signInError" />
					<input type="hidden" name="amplifiHandler" value=".login" class="amplifi-input" />
					<input type="hidden" name="amplifiBean" value="/atg/userprofiling/ProfileFormHandler" class="amplifi-input" />
					<input type="hidden" name="amplifiSuccessUrl" value="" />
<%-- 					<input type="hidden" name="amplifiSuccessUrl" value="${successURL}" /> --%>
	             </fieldset>
	             <a href="${pageContext.request.contextPath}/modals/forgot-password.jsp" class="">Forgot Your Password?</a>
			</fieldset>
				<dsp:include page="${pageContext.request.contextPath}/xhr/getAmplifiToken.jsp">
					<dsp:param name="class" value="amplifi-input" />
				</dsp:include>
		</form>

        <section class="fb-signin-section">
            <h2>Sign Into La-Z-Boy.com With Your Facebook Account</h2>
			<p>Share videos, products, and special features with your friends and family in your Facebook Feed.</p>
			<span id="fb-connect-section"></span>
			<%-- <dsp:include page="/account/fbConnect.jsp" />--%>
        </section>
     </main>
     <footer class="cart-footer">
     	<a class="btn-primary" id="btnGuestCheckout" href="${guestSuccessURL}">CONTINUE AS GUEST</a>
     </footer>


     	

	</body>

</html>

    </dsp:layeredBundle>
</dsp:page>
