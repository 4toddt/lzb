<dsp:importbean bean="/atg/userprofiling/ForgotPasswordHandler" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
<dsp:getvalueof var="urlParam" param="u" />
<dsp:getvalueof var="successMsg" param="successMsg" />
<dsp:page>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />

		<main role="main">

		<section role="region" class="profile-account-content">
			<h1><fmt:message key="resetpswd.resetPasswordText"/></h1>
			<dsp:getvalueof bean="ForgotPasswordHandler.formError"
				var="formError" />

			<c:if test="${formError eq 'true'}">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ForgotPasswordHandler" />
					</dsp:include>
				</div>
			</c:if>
			<c:if test="${successMsg eq 'change'}">
				<p><fmt:message key="resetpswd.successMsg"/></p>
			</c:if>
			<dsp:form name="resetPasswordForm" id="resetPasswordForm"
				method="post" autocomplete="off">
				<fieldset>



					<fieldset>
						<label><fmt:message key="myProfile.newPassword"/></label>
						<dsp:input type="password"
							bean="ForgotPasswordHandler.value.newPassword"
							name="new_password" id="resetPassword" value=""> </dsp:input>
					</fieldset>

					<!-- 								          <label for="rpass"><fmt:message key="reset.reTypeNewPassword" />Confirm New Password</label> -->
					<fieldset>
						<label><fmt:message key="resetpswd.cnfrmPswd"/></label>
						<dsp:input type="password"
							bean="ForgotPasswordHandler.value.confirmPassword"
							name="accountConfirmPassword" value="">

						</dsp:input>
					</fieldset>
					<dsp:input type="submit"
						bean="ForgotPasswordHandler.changePassword"
						value="Change Password" iclass="btn-primary" />
					<dsp:input type="hidden" bean="ForgotPasswordHandler.value.param"
						value="${urlParam}" />
					<dsp:input type="hidden"
						bean="ForgotPasswordHandler.changePasswordSuccessURL"
						value="${pageContext.request.contextPath}/account/resetPassword.jsp?successMsg=change" />
					<dsp:input type="hidden"
						bean="ForgotPasswordHandler.changePasswordErrorURL"
						value="${pageContext.request.contextPath}/account/resetPassword.jsp?param=${urlParam}" />

				</fieldset>
			</dsp:form>
		</section>
		<main>
	</lzb:pageContainer>
</dsp:page>action="#"
