<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ForgotPasswordHandler" />

	<div class="forgot-password">
		<p><fmt:message key="forgot.EmailMsg" /></p>

		<dsp:form action="" method="post" id="forgotPasswordForm" formid="forgotPasswordForm" iclass="forgot-password-form" data-validate>

			
			<div class="field-group">
				<fmt:message key="forgot.placeholder" var="forgotPlaceholder"/>
				<label for="forgot_email"><fmt:message key="forgot.emailAddress" />&nbsp;*<span class="sr-only"><fmt:message key="forgot.emailAddress" /></span></label>
				<dsp:input id="forgot_email" type="email" name="forgot_email" bean="ForgotPasswordHandler.value.login" maxlength="255" data-validation="required email" aria-required="true" autocomplete="off" placeholder="${forgotPlaceholder}"/>
			</div>

			<dsp:input type="hidden" bean="ForgotPasswordHandler.forgotPasswordErrorURL" value="${contextPath}/account/json/passwordResetError.jsp" />
			<dsp:input type="hidden" bean="ForgotPasswordHandler.forgotPasswordSuccessURL" value="${contextPath}/account/json/passwordResetSuccess.jsp" />

			<dsp:input type="submit" bean="ForgotPasswordHandler.forgotPassword" value="Submit" iclass="button primary signin-button" />

		</dsp:form>
	</div>

</dsp:page>
