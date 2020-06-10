<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:getvalueof var="fromFb" param="fromFb"/>
	<dsp:getvalueof var="fbFirstName" param="fName"/>
	<dsp:getvalueof var="fbLastName" param="lName"/>
	<dsp:getvalueof var="userID" param="userID"/>

	<h1>
		<%-- <fmt:message key="header.register" /> --%>
		Create your La-Z-Boy Account
	</h1>
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<div class="message-container">
				<div class="message-wrapper">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler" />
		</dsp:include>
		</div></div>
	</c:if>
	<dsp:form action="#" method="post" name="registerProfile" id="registerUser" autocomplete="false">

		<p class="required">
			<%-- <fmt:message key="form.required" /> --%>
			* Required fields
		</p>

		<fieldset>
			<div>
				<label for="account_login">
					<%-- <fmt:message key="profile.email" />
					<span class="required">*</span> --%>
					Email Address *
				</label>
				<dsp:input type="text" id="email" name="account_login" bean="ProfileFormHandler.value.login" />
				<span class="field_error"></span>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<label for="account_password">
					<!-- <fmt:message key="profile.password" /><span class="required">*</span> -->
					Password *
				</label>

				<dsp:input type="password" name="account_password" id="password"
					bean="ProfileFormHandler.value.password" maxlength="25" />
				<span class="field_error"></span>
				Passwords must be 5-15 characters, contain both
				letter(s) and number(s). No spaces or special
				characters (&, %, *)
				Verify Password *
			</div>
		</fieldset>
		<fieldset>
			<div>
				<label for="account_verify_password">
					<!-- <fmt:message key="profile.confirmPassword" /><span class="required">*</span> -->
					Verify Password *
				</label>
				<dsp:input type="password" name="account_verify_password" id="confirm" bean="ProfileFormHandler.profileValueMap.confirmPassword" maxlength="25" />
				<span class="field_error"></span>
				Reenter your password
			</div>
		</fieldset>
		<fieldset>
			<div>
				<%-- <label for="account_verify_password">
					<fmt:message key="profile.confirmPassword" /><span class="required">*</span>
				</label> --%>

				ZIP/Postal Code *
				<dsp:input type="text" name="account_postalCode" id="confirm" bean="ProfileFormHandler.value.homeAddress.postalCode" maxlength="10" />
				<span class="field_error"></span>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<dsp:input type="checkbox" id="chk01" name="chk01" bean="ProfileFormHandler.optInEmail" checked="true" value="on" />
				<%-- <label for="chk01" class="checkout checkout1">
					<fmt:message key="checkbox.promoEmail" />
				</label> --%>
				<label for="chk01" >I'd like to receive promotional emails.</label>
			</div>
		</fieldset>


		<dsp:input type="submit" value="CREATE ACCOUNT" name="createuser"	id="createuser" bean="ProfileFormHandler.create" />
		<dsp:input type="hidden" bean="ProfileFormHandler.createSuccessURL" value="${pageContext.request.contextPath}/account/account.jsp" />
		<dsp:input type="hidden" bean="ProfileFormHandler.createErrorURL" value="${pageContext.request.contextPath}/account/register.jsp" />

		<!-- For face book extension -->

		<c:if test="${ fromFb == 'true' && fbFirstName != null && fbLastName != null }">
			<dsp:input type="hidden" bean="ProfileFormHandler.fromFb" value="${fromFb}" />
			<dsp:input type="hidden" bean="ProfileFormHandler.value.firstName" value="${fbFirstName}" />
			<dsp:input type="hidden" bean="ProfileFormHandler.value.lastName" value="${fbLastName}" />
			<dsp:input type="hidden" bean="ProfileFormHandler.fbUserId" value="${userID}" />
		</c:if>
		
		<%-- Eloqua form fields start  --%>
		<input type="hidden" name="elqFormName" value="createAccount">
		<input type="hidden" name="elqSiteID" value="20103530">
		<input type="hidden" name="elqCustomerGUID" value="">
		<input type="hidden" name="elqCookieWrite" value="0">
		<input id="field3" type="hidden" name="lead_source_original_hidden" value="Website - Account Creation" />
		<%-- Eloqua form fields end  --%>

		Already have an account? <dsp:a href="${pageContext.request.contextPath}/account/login.jsp" > Sign In</dsp:a>

	</dsp:form>
</dsp:page>