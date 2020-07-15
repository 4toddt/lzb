<%--
  This page renders login form for returned customers.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>

		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		<dsp:importbean bean="/atg/userprofiling/CookieManager" />
		<dsp:importbean var="originatingRequest" bean="/OriginatingRequest" />
		<dsp:getvalueof var="currentLocale" vartype="java.lang.String"
			bean="/atg/dynamo/servlet/RequestLocale.localeString" />
		<dsp:getvalueof var="fromFb" param="fromFb" />
		<dsp:getvalueof var="userID" param="userID" />
		<dsp:getvalueof var="Url" param="dest" scope="page" />
		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
			<%-- Form title --%>

			<link rel="stylesheet" href="/css/min/desktop.css?ver=${assetVersion}" type="text/css" />

			<c:if test="${formError eq 'true'}">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					</dsp:include>
				</div>
			</c:if>
			<main role="main" class="iPad-login">
			<section role="region" class="my-account-content">
				<h1 style="margin:0 20px;">Sign In to your La-Z-Boy Account</h1>
				<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />


				<%--
          Check Profile's security status. If user is logged in from cookie,
          display default values, i.e. profile's email address in this case, otherwise
          do not populate form handler with profile's values.
         --%>

				<fieldset>
					<dsp:form action="#" method="post" id="loginForm" formid="loginForm" name="loginForm" style="margin:20px; width:400px !important;" autocomplete="off">

<%--					<dsp:form action="#" method="post" id="loginForm" formid="loginForm" name="loginForm"> --%>
						<p class="required">
							<fmt:message key="form.required" />
						</p>
						<fieldset>
							<div>
								<label for="account_login"><fmt:message
										key="common.loginEmailAddress" />: <span class="required">*</span></label>
								<c:choose>
									<c:when test="${not empty cookie['rememberMe'].value}">
										<dsp:input type="text" id="email" name="login_email_address"
											bean="ProfileFormHandler.value.login"
											value="${cookie['rememberMe'].value}" />
									</c:when>
									<c:otherwise>
										<dsp:input type="text" id="email" name="login_email_address"
											bean="ProfileFormHandler.value.login" />
									</c:otherwise>
								</c:choose>

								<span class="field_error"></span>
							</div>
						</fieldset>
						<fieldset>
							<label for="account_password"><fmt:message
									key="common.loginPassword" />: <span class="required">*</span></label>
							<dsp:input type="password" name="login_password" id="password"
								bean="ProfileFormHandler.value.password" maxlength="25" value="" />
							<span class="field_error"></span>
						</fieldset>
						<fieldset>
							<div>
								<dsp:input type="checkbox"
									bean="ProfileFormHandler.value.rememberMe" checked="false" id="chk01"/>
								<label for="chk01" class="checkout checkout1"><fmt:message
										key="remember.me" /></label>


								<%-- 'Login' button --%>
								<dsp:input type="submit" value="SIGN IN" iclass="btn-primary"
									bean="ProfileFormHandler.login" />
								<br />
							</div>
						</fieldset>
						<dsp:input type="hidden" bean="ProfileFormHandler.loginErrorURL"
							value="${pageContext.request.contextPath}/user/siteLoginModal.jsp" />

					<c:choose>
						<c:when test="${not empty Url}">
							<dsp:input bean="ProfileFormHandler.loginSuccessURL" type="hidden"
								value="${pageContext.request.contextPath}/user/userDetails.jsp" />
						</c:when>
						<c:otherwise>

						<dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL"
							value="${pageContext.request.contextPath}/user/userDetails.jsp" />
						</c:otherwise>
					</c:choose>

					</dsp:form>
				</fieldset>
		</section>
		</main>
</dsp:layeredBundle>

</dsp:page>

