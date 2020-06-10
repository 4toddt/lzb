<%--
  This page renders login form for returned customers.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		<dsp:importbean bean="/atg/userprofiling/CookieManager" />
		<dsp:importbean var="originatingRequest" bean="/OriginatingRequest" />
		<dsp:getvalueof var="currentLocale" vartype="java.lang.String"
			bean="/atg/dynamo/servlet/RequestLocale.localeString" />
		<dsp:getvalueof var="faceBookConnected" param="faceBookConnected" />
		<dsp:getvalueof var="fbFirstName" param="fbFirstName" />
		<dsp:getvalueof var="fbLastName" param="fbLastName" />
		<dsp:getvalueof var="userID" param="userID" />
		<dsp:getvalueof var="Url" param="Url" scope="page" />
		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
			<%-- Form title --%>

			<c:if test="${formError eq 'true'}">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					</dsp:include>
				</div>
			</c:if>
			<main role="main">
			<section role="region" class="my-account-content">
				<h1>Sign In to your La-Z-Boy Account</h1>
				<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />

				<c:if test="${faceBookConnected == 'true'}">
					<div id="#fbStatus">Thanks for logging in,${fbFirstName} ${fbLastName} !</div>
				</c:if>
				<%--
          Check Profile's security status. If user is logged in from cookie,
          display default values, i.e. profile's email address in this case, otherwise
          do not populate form handler with profile's values.
         --%>

				<fieldset>
					<dsp:form action="#" method="post" id="loginForm" formid="loginForm" name="loginForm" autocomplete="false">
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
							value="${pageContext.request.contextPath}/account/login.jsp" />

				<c:choose>
					<c:when test="${not empty Url}">
						<dsp:input bean="ProfileFormHandler.loginSuccessURL" type="hidden"
							value="${Url}" />
					</c:when>
					<c:otherwise>

						<dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL"
							value="${pageContext.request.contextPath}/account/account.jsp" />
		</c:otherwise>
		</c:choose>


						<dsp:input type="hidden"
							bean="ProfileFormHandler.value.resetPwdUrl"
							value="${pageContext.request.contextPath}/account/resetPassword.jsp" />
						<fieldset>
							<div>
								<dsp:a
									href="${pageContext.request.contextPath}/account/forgotPassword.jsp"
									title="" iclass="linkCancel push01 sign">
									<fmt:message key="forgot.password" />
								</dsp:a>
								&nbsp;&nbsp; <a
									href="${pageContext.request.contextPath}/account/register.jsp"
									title=""><fmt:message key="register.createAccount" /></a>
							</div>
						</fieldset>
						<!-- For face book extension -->
						<c:if test="${ fromFb == 'true' }">
							<dsp:input type="hidden" bean="ProfileFormHandler.fromFb"
								value="${fromFb}" />
							<dsp:input type="hidden" bean="ProfileFormHandler.fbUserId"
								value="${userID}" />
						</c:if>
					</dsp:form>
				</fieldset>
				<fieldset>
					<dsp:include
						src="${pageContext.request.contextPath}/account/fbConnect.jsp"></dsp:include>
				</fieldset>
		</dsp:layeredBundle>
		</section>
		</main>

	</lzb:pageContainer>

</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/10.2/Storefront/j2ee/store.war/myaccount/gadgets/login.jsp#2 $$Change: 788278 $--%>
