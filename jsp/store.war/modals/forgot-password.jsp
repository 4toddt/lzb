<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ForgotPasswordHandler" />

	<link rel="stylesheet" href="/css/min/desktop.css?ver=${assetVersion}" type="text/css" />
	<script src="/js/amp.js?ver=${assetVersion}"></script>

	<main role="main" class="forgot-password">

		<h1>Forgot Password</h1>

		<dsp:getvalueof bean="ForgotPasswordHandler.formError" var="formError" />
		<c:if test="${formError eq 'true'}">
			<dsp:include page="//global/errors.jsp">
				<dsp:param name="formHandler" bean="ForgotPasswordHandler" />
			</dsp:include>
		</c:if>

		<p>
			Enter the email address associated with your La-Z-Boy account.<br>
			We'll send you an email to reset your password.
		</p>

		<div id="forgotPasswordError" class="amp-error"></div>

		<form action="${pageContext.request.contextPath}/xhr/amplifiSubmit.jsp" method="post" id="forgotPasswordForm" class="forgot-password-form modal-jquery-validation amplifi-form" data-error-messaging="#forgotPasswordError">
			<fieldset>
				<legend>Forgot Password</legend>
				<fieldset>
					<legend>Please provide your email address</legend>
					<label for="forgot_email">Email Address</label>
					<input type="email" id="email" name=".value.login" class="amplifi-input" required="true"  />
				</fieldset>

				<input type="submit" value="Submit" class="btn-primary amplifi-submitter" id="forgotpassword" data-error-messaging="#forgotPasswordError" />
				<input type="hidden" name="amplifiHandler" value=".forgotPassword" class="amplifi-input" />
				<input type="hidden" name="amplifiBean" value="/atg/userprofiling/ForgotPasswordHandler" class="amplifi-input" />
				<input type="hidden" name="amplifiSuccessUrl" value="${pageContext.request.contextPath}/modals/forgotpassword-mailSent.jsp" />
			</fieldset>

			<dsp:include page="${pageContext.request.contextPath}/xhr/getAmplifiToken.jsp">
				<dsp:param name="class" value="amplifi-input" />
			</dsp:include>
		</form>

		<%--
 		<dsp:form id="forgotPasswordForm" iclass="forgot-password-form" name="forgotPasswordForm" method="post" action="#">
			<fieldset>
				<legend>Forgot Password</legend>
				<fieldset>
					<legend>Please provide your email address</legend>
					<label for="forgot_email">Email Address</label>
					<dsp:input type="email" name="forgot_email" id="email" required="true" bean="ForgotPasswordHandler.value.login"/>
				</fieldset>
				<dsp:input type="submit" bean="ForgotPasswordHandler.forgotPassword" iclass="btn-primary" id="forgotpassword" value="Submit" />
				<dsp:input type="hidden" bean="ForgotPasswordHandler.forgotPasswordErrorURL" value="/work/account/forgotPassword.jsp" />
				<dsp:input type="hidden" bean="ForgotPasswordHandler.forgotPasswordSuccessURL" value="/work/account/forgotpasswordMailsent.jsp" />
			</fieldset>
		</dsp:form>
		--%>

	</main>

</dsp:page>
