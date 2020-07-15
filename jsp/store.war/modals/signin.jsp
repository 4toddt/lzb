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
	<dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
  <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
  <dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="guestCheckout" param="guestCheckout"/>
	<c:set var="pageTypeForTracking" value="login" scope="request" />
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

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

				<%-- Adobe tag manager script include --%>
				<c:if test="${not empty storeConfig.adobeTagMgrScriptPath}">
					<script src="//${storeConfig.adobeTagMgrScriptPath}"></script>
				</c:if>

				<dsp:include page="/includes/monetateHeader.jsp" flush="true"></dsp:include>
				<%-- Monetate tag Initialization --%>
				<script>
					window.monetateQ = window.monetateQ || [];
				</script>

			</head>
			<body role="document" dir="ltr">

				<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
					<dsp:param name="inUrl" value="/"/>
					<dsp:oparam name="output">
						<dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
					</dsp:oparam>
				</dsp:droplet>

				<%-- <c:set var="req" value="${pageContext.request}" />
				<c:set var="baseURL" value="${fn:replace(req.requestURL, fn:substring(req.requestURI, 1, fn:length(req.requestURI)), req.contextPath)}" /> --%>
				<c:set var="baseURL" value="${originatingRequest.scheme}://${originatingRequest.serverName}" />

				<%-- <c:set var="req" value="${pageContext.request}" />
				<c:set var="url">${req.requestURL}</c:set>--%>
				<%-- <c:set var="uri" value="${req.requestURI}" /><br> --%>
				<%-- ${fn:substring(url, 0, fn:length(url) - fn:length(uri))} --%>

				<c:set var="headerUrl">${header.referer}</c:set>
				<c:set var="strPositionOfPort" value=".com"/>
				<c:set var="intPositionOfPort">${fn:indexOf(headerUrl, strPositionOfPort)}</c:set>
				<c:set var="url">${fn:substring(headerUrl, 0, (intPositionOfPort + 4))}</c:set>

				<section id="sign-in">
					<main role="main" class="signin" data-module="modal-jquery-validation" data-domain="${updatedProtocolURL}" data-destination="${url}">
						<%-- Form title --%>
						<h1>Sign In To Your La-Z-Boy Account</h1>
						<dsp:getvalueof var="Url" param="Url" scope="page" />
							<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError"/>
							<c:if test="${formError eq 'true'}">
								<dsp:include page="/includes/global/errors.jsp">
									<dsp:param name="formHandler" bean="ProfileFormHandler"/>
								</dsp:include>
							</c:if>

							<%--
								Check Profile's security status. If user is logged in from cookie,
								display default values, i.e. profile's email address in this case, otherwise
								do not populate form handler with profile's values.
							 --%>

							<div id="signInError" class="amp-error"></div>

						<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
							<dsp:param name="inUrl" value="${hostName}/xhr/amplifiSubmit.jsp"/>
							<dsp:oparam name="output">
								<dsp:getvalueof id="submitURL" param="secureUrl" idtype="java.lang.String" scope="request" />
							</dsp:oparam>
						</dsp:droplet>

						<form action="${submitURL}" method="post" id="signInForm" class="modal-jquery-validation sign-in-form amplifi-form" data-error-messaging="#signInError" autocomplete="off">

							<fieldset>
								<legend><fmt:message key="login.signInLegend"/></legend>
								<fieldset>
									<legend><fmt:message key="login.signInEmailLegend"/></legend>
										<label for="email"><fmt:message key="common.loginEmailAddress"/>:</label>
										<input type="email" id="email" name=".value.login" class="amplifi-input" maxlength="50" required="true" />
									</fieldset>
								<fieldset>
									<legend><fmt:message key="login.signInPasswordLegend"/></legend>
										<label for="password"><fmt:message key="common.loginPassword"/>:</label>
									<input type="password" id="password" name=".value.password" maxlength="16" value="" class="amplifi-input pwAlphaNumeric" required="true" />
								</fieldset>
								<fieldset>
										<legend><fmt:message key="login.signInSubmitLegend"/></legend>
													<input type="checkbox" id="remember" name=".value.rememberMe" name="remember" class="amplifi-input" checked="true"/>
                  <fmt:message key="remember.me" var="rememberMe"/>
                  <fmt:message key="remember.tooltip" var="rememberMeTooltip"/>
                  <label for="remember" class="checkout checkout1">${rememberMe}
										<a title="${rememberMeTooltip}" class="tooltip" href="#" data-tip="Remember Me">
																<div class="triangle-with-shadow"></div>
																<div title="" class="tooltip-img"></div>
															</a>

									</label>
                  <fmt:message key="login.signInButton" var="signInButton"/>
									<input type="submit" value="${signInButton}" class="btn-primary submitBtn amplifi-submitter" data-error-messaging="#signInError" />
									<input type="hidden" name="amplifiHandler" value=".login" class="amplifi-input" />
									<input type="hidden" name="amplifiBean" value="/atg/userprofiling/ProfileFormHandler" class="amplifi-input" />

												<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
													<dsp:param name="inUrl" value="/"/>
													<dsp:oparam name="output">
																<dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
													</dsp:oparam>
												</dsp:droplet>

								<input type="hidden" id="amplifiSuccessUrl" name="amplifiSuccessUrl" value="" />
								<input type="hidden" id="hostName" name="hostName" value="${updatedProtocolURL}" />
								<%--
								<c:choose>

								<c:when test="${not empty Url}">
									<input type="hidden" name="amplifiSuccessUrl" value="${Url}" />
								</c:when>
								<c:otherwise>
									<input type="hidden" name="amplifiSuccessUrl" value="${pageContext.request.contextPath}/account/account.jsp" />
								</c:otherwise>
								</c:choose>
								--%>
											 </fieldset>
                       <fmt:message key="forgot.password" var="forgotPassword"/>
											 <a href="${pageContext.request.contextPath}/modals/forgot-password.jsp" class="forgotpw modal-forgot-password">${forgotPassword}</a>
							</fieldset>
								<dsp:include page="${pageContext.request.contextPath}/xhr/getAmplifiToken.jsp">
									<dsp:param name="class" value="amplifi-input" />
								</dsp:include>
						</form>

						<section class="fb-signin-section">
							<h2>Sign Into La-Z-Boy.com With Your Facebook Account</h2>
							<p>Share videos, products, and special features with your friends and family in your Facebook Feed.</p>
							<%-- <span id="fb-connect-section"></span> --%>
							<jsp:include page="${pageContext.request.contextPath}/account/fbConnect.jsp" />
						</section>
					</main>

					<c:choose>
						<c:when test="${guestCheckout =='true' }">
							<dsp:getvalueof var="commerceItemCount" bean="/atg/commerce/ShoppingCart.current.totalCommerceItemCount" />
							<c:choose>
								<c:when test="${commerceItemCount > 0}">
									<dsp:getvalueof var="successURL" value="${pageContext.request.contextPath}/checkout/deliveryAndPayment.jsp"/>
								</c:when>
								<c:otherwise>
									<dsp:getvalueof var="successURL" value="${pageContext.request.contextPath}/rwd/checkout/cart.jsp"/>
								</c:otherwise>
							</c:choose>
							<footer class="cart-footer">
								<a class="btn-primary" href="${successURL}">CONTINUE AS GUEST</a>
							</footer>
						</c:when>
						<c:otherwise>
							<footer>
								<p><strong><fmt:message key="login.createAccountHeading"/></strong></p>
								<p><fmt:message key="login.createAccountDescription"/></p>
                <fmt:message key="login.createAccountButton" var="createAccountButton"/>
								<a href="${pageContext.request.contextPath}/modals/create-account.jsp" class="btn btn-primary reload fb-connect-section modal-create-account-link">${createAccountButton}</a>
							</footer>
						</c:otherwise>
					</c:choose>

				</section>

				

				<%-- Adobe tag manager script end tag  start --%>
				<c:if test="${not empty storeConfig.adobeTagMgrScriptPath}">
					<script type="text/javascript">_satellite.pageBottom();</script>
				</c:if>
				<%-- Adobe tag manager script end tag end --%>
					<%-- Monetate script page type update  --%>
				<dsp:include page="/includes/monetatePageType.jsp" flush="true">
					<dsp:param name="pageType" value="${pageTypeForTracking}"/>
				</dsp:include>
				<%-- Monetate tag data submit --%>
				<script>
					window.monetateQ.push(["trackData"]);
				</script>

			</body>
		</html>

	</dsp:layeredBundle>

</dsp:page>

