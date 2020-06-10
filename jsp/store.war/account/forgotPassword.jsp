<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ForgotPasswordHandler" />
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
		<main role="main">
		<section role="region" class="my-account-content">
			<h1>
				<!-- 						<fmt:message key="forgot.heading" /> -->
				<fmt:message key="dealertools.forgot.password" />
			</h1>
			<dsp:getvalueof bean="ForgotPasswordHandler.formError"
				var="formError" />
			<c:if test="${formError eq 'true'}">
				<dsp:include page="/global/errors.jsp">
					<dsp:param name="formHandler" bean="ForgotPasswordHandler" />
				</dsp:include>
			</c:if>
			<p>

				<!-- 					<fmt:message key="forgot.message" /> -->
				<fmt:message key="forgotPswd.emailAddrs" />
				<br>
				<fmt:message key="forgotPswd.sendEmailAddrsText" />
			</p>
			<dsp:form id="forgotPasswordForm" name="forgotPasswordForm"
				method="post" action="#">
				<fieldset>
					<label for="forgot_email"><fmt:message
							key="dealertools.managedealer.email" /> </label>
					<dsp:input type="text" name="forgot_email" id="email"
						required="true" bean="ForgotPasswordHandler.value.login" />
					<br>

					<dsp:input type="submit"
						bean="ForgotPasswordHandler.forgotPassword" value="Submit"
						iclass="btn-primary" />
					<dsp:input type="hidden"
						bean="ForgotPasswordHandler.forgotPasswordErrorURL"
						value="${pageContext.request.contextPath}/account/forgotPassword.jsp" />
					<dsp:input type="hidden"
						bean="ForgotPasswordHandler.forgotPasswordSuccessURL"
						value="${pageContext.request.contextPath}/account/forgotpasswordMailsent.jsp" />
				</fieldset>
		</section>
		</main>
		</dsp:form>
	</lzb:pageContainer>
</dsp:page>
