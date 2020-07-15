<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfigVar"/>

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
		<c:if test="${not empty storeConfigVar.adobeTagMgrScriptPath}">
			<script src="//${storeConfigVar.adobeTagMgrScriptPath}"></script>
		</c:if>

	</head>

	<body role="document" dir="ltr">

	                <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
                  <dsp:param name="inUrl" value="/"/>
                  <dsp:oparam name="output">
                        <dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
                  </dsp:oparam>
                </dsp:droplet>

<c:set var="headerUrl">${header.referer}</c:set>
<c:set var="strPositionOfPort" value=".com"/>
<c:set var="intPositionOfPort">${fn:indexOf(headerUrl, strPositionOfPort)}</c:set>
<c:set var="url">${fn:substring(headerUrl, 0, (intPositionOfPort + 4))}</c:set>


<section id="sign-in" data-module="cbox modal-jquery-validation" data-domain="${updatedProtocolURL}" data-destination="${url}">

    <main role="main" class="create-account" data-module="cbox" data-module="modal-jquery-validation">
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>

	<dsp:getvalueof var="fromFb" param="fromFb"/>
	<dsp:getvalueof var="fbFirstName" param="fName"/>
	<dsp:getvalueof var="fbLastName" param="lName"/>
	<dsp:getvalueof var="fbEmail" param="fbEmail"/>
	<h1><fmt:message key="register.create" /></h1>
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="//global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler" />
		</dsp:include>
	</c:if>

	<div id="createAccountError" class="amp-error" ></div>

	<form action="${pageContext.request.contextPath}/xhr/amplifiSubmit.jsp" method="post" id="createAccount" class="create-account-form modal-jquery-validation amplifi-form" data-error-messaging="#createAccountError" autocomplete="off" data-module="eloqua-submit">
		<h5><fmt:message key="form.required" /></h5>
		<fieldset>
			<legend>Create an Account</legend>
			<fieldset>
				<legend>Please provide your email address</legend>
				<label for="email"><fmt:message key="register.email" /> *</label>
				<input type="email" id="email" class="amplifi-input" name=".value.login" required="true" maxlength="50" />
				<span class="field_error"></span>
			</fieldset>
			<fieldset>
		        <legend>Please provide your password</legend>
				<label for="password"><fmt:message key="register.password" /> *</label>
				<input type="password" id="password" class="amplifi-input pwAlphaNumeric" name=".value.password" maxlength="16" required="true" />
				<span class="field_error"></span>
			</fieldset>
			<fieldset>
			    <legend>Please verify your password</legend>
				<label for="verifypassword"><fmt:message key="register.verifyPassword" /> *</label>
				<input type="password" id="verifyPassword" class="amplifi-input pwEqualTo" name=".profileValueMap.confirmPassword" maxlength="16" required="true" />
				<span class="field_error"></span>
			</fieldset>
			<fieldset>
			    <legend>Please provide a zip/postal code</legend>
				<label for="confirm"><fmt:message key="register.postalCode" /> *
                        <a title="By providing your ZIP code, you can help us estimate your shipping fees,
                        so your order total is accurate with no surprises." class="tooltip" href="#" data-tip="Provide zip code">
                        <div class="triangle-with-shadow"></div>
                        <div title="" class="tooltip-img"></div>
                        </a>
				</label>
				<input type="text" id="confirm" class="amplifi-input" name=".value.homeAddress.postalCode" maxlength="10" required="true" />
				<span class="field_error"></span>
		    </fieldset>
		    <fieldset>
				<legend>I'd like to recieve promotional emails</legend>
				<input type="checkbox" id="promoemail" class="amplifi-input" name=".optInEmail" checked="true" value="on" />
				<label for="promoemail"><fmt:message key="register.promoEmail" />
					<a title="Checking this box adds you to our mailing list, so you don't miss out on
                         sales, special events and promotions throughout the year." class="tooltip" href="#" data-tip="Email opt in">
                         <div class="triangle-with-shadow"></div>
                         <div title="" class="tooltip-img"></div>
                    </a>

				</label>
			</fieldset>
			<p><fmt:message key="register.alreadyAccount" /> <a href="${pageContext.request.contextPath}/modals/signin.jsp" class="modal-sign-in"><fmt:message key="register.signin" /></a></p>

			<fmt:message var="createAccount" key="register.createAccount" />
 			<input type="submit" value="${createAccount}" class="btn btn-primary amplifi-submitter" id="createuser" data-error-messaging="#createAccountError" />
			<input type="hidden" name="amplifiHandler" value=".create" class="amplifi-input" />
			<input type="hidden" name="amplifiBean" value="/atg/userprofiling/ProfileFormHandler" class="amplifi-input" />
			<input type="hidden" name="amplifiSuccessUrl" id="amplifiSuccessUrl" value="" />

			<dsp:include page="${pageContext.request.contextPath}/xhr/getAmplifiToken.jsp">
				<dsp:param name="class" value="amplifi-input" />
			</dsp:include>

			<%--
			<dsp:input type="submit" value="CREATE ACCOUNT" name="createuser" iclass="btn btn-primary" id="createuser" bean="ProfileFormHandler.create" />
			<dsp:input type="hidden" bean="ProfileFormHandler.createSuccessURL" value="${pageContext.request.contextPath}/account/profile.jsp" />
			<dsp:input type="hidden" bean="ProfileFormHandler.createErrorURL" value="${pageContext.request.contextPath}/modals/create-account.jsp" />
			--%>
			<%-- Eloqua form fields start  --%>
			<input type="hidden" name="elqFormName" value="createAccount">
			<input type="hidden" name="elqSiteID" value="20103530">
			<input type="hidden" name="elqCustomerGUID" value="">
			<input type="hidden" name="elqCookieWrite" value="0">
			<input id="field3" type="hidden" name="lead_source_original_hidden" value="Website - Account Creation" />
			<%-- Eloqua form fields end  --%>

		</fieldset>
	</form>

	<%--
	<dsp:form action="#" method="post" name="registerProfile" id="createAccount" iclass="create-account-form">
		<h5>*Required fields</h5>
		<fieldset>
			<legend>Create an Account</legend>
			<fieldset>
				<legend>Please provide your email address</legend>
				<label for="email">Email Address *</label>
				<dsp:input type="email" id="email" name="email" bean="ProfileFormHandler.value.login" />
				<span class="field_error"></span>
			</fieldset>
			<fieldset>
		        <legend>Please provide your password</legend>
				<label for="password">Password *</label>
				<dsp:input type="password" name="password" id="password" bean="ProfileFormHandler.value.password" maxlength="25" />
				<span class="field_error"></span>
			</fieldset>
			<fieldset>
			    <legend>Please verify your password</legend>
				<label for="verifypassword">Verify Password *</label>
				<dsp:input type="password" name="verifypassword" id="verifyPassword" bean="ProfileFormHandler.profileValueMap.confirmPassword" maxlength="25" />
				<span class="field_error"></span>
			</fieldset>
		    <fieldset>
			    <legend>Please provide a zip/postal code</legend>
				<label for="confirm">ZIP/Postal Code *
                        <a title="By providing your ZIP code, you can help us estimate your shipping fees,
                        so your order total is accurate with no surprises." class="tooltip" href="#">
                        <div class="triangle-with-shadow"></div>
                        <div title="" class="tooltip-img"></div>
                        </a>
				</label>
				<dsp:input type="text" name="account_postalCode" id="confirm" bean="ProfileFormHandler.value.homeAddress.postalCode" maxlength="25" />
				<span class="field_error"></span>
		    </fieldset>
			<fieldset>
				<legend>I'd like to recieve promotional emails</legend>
				<dsp:input type="checkbox" id="promoemail" name="promoemail" bean="ProfileFormHandler.value.optInEmail" checked="true" value="true" />
				<label for="promoemail">I'd like to recieve promotional emails
					<a title="Checking this box adds you to our mailing list, so you don't miss out on
                         sales, special events and promotions throughout the year." class="tooltip" href="#">
                         <div class="triangle-with-shadow"></div>
                         <div title="" class="tooltip-img"></div>
                    </a>

				</label>
			</fieldset>

			<p>Already have an account? <a href="${pageContext.request.contextPath}/modals/signin.jsp" class="modal cboxElement">Sign In</a></p>
			<dsp:input type="submit" value="CREATE ACCOUNT" name="createuser" iclass="btn btn-primary" id="createuser" bean="ProfileFormHandler.create" />
			<dsp:input type="hidden" bean="ProfileFormHandler.createSuccessURL" value="${pageContext.request.contextPath}/account/profile.jsp" />
			<dsp:input type="hidden" bean="ProfileFormHandler.createErrorURL" value="${pageContext.request.contextPath}/modals/create-account.jsp" />
		</fieldset>
	</dsp:form>
	--%>

	<section>
		<h2><fmt:message key="register.signUp"/></h2>
		<p>
			<fmt:message key="register.signUp1"/>
			<ul>
			<li><fmt:message key="register.signUp2"/></li>
			<li><fmt:message key="register.signUp3"/></li>
			<li><fmt:message key="register.signUp4"/></li>
			<li><fmt:message key="register.signUp5"/></li>
			</ul>
		</p>
	</section>
	</main>
	


		<%-- Eloqua Script start --%>
			<script type='text/javascript'>
				var timerId = null, timeout = 5;
			</script>

			<script type='text/javascript'>
				function WaitUntilCustomerGUIDIsRetrieved() {
					if (!!(timerId)) {
					    if (timeout == 0) {
					return;
					}
					if (typeof this.GetElqCustomerGUID === 'function') {
					        document.forms["createAccount"].elements["elqCustomerGUID"].value = GetElqCustomerGUID();
					return;
					}
					timeout -= 1;
					}
					timerId = setTimeout("WaitUntilCustomerGUIDIsRetrieved()", 500);
					return;
				}
				window.onload = WaitUntilCustomerGUIDIsRetrieved;
				var _elqQ = _elqQ || [];
				_elqQ.push(['elqGetCustomerGUID']);
			</script>
		<%-- Eloqua Script end --%>

		<%-- Adobe script end start --%>

		<%-- Adobe tag manager script end tag  start --%>
		<c:if test="${not empty storeConfigVar.adobeTagMgrScriptPath}">
			<script type="text/javascript">_satellite.pageBottom();</script>
		</c:if>
		<%-- Adobe tag manager script end tag end --%>

		</body>

</html>
</dsp:page>
