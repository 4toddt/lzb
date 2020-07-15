<%--
	- File Name: registerForm.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the register page for My Account
	- Parameters:
	-
--%>

<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
    <dsp:getvalueof var="fromFb" param="fromFb"/>
    <dsp:getvalueof var="fbFirstName" param="fName"/>
    <dsp:getvalueof var="fbLastName" param="lName"/>
    <dsp:getvalueof var="fbEmail" param="fbEmail"/>
    
	<dsp:form action="#" method="post" name="registerProfile" id="registerUser" formid="registerUser" autocomplete="false" data-validate>

		<p class="required-note">
			*&nbsp;<fmt:message key="form.required" />
		</p>
		<div class="field-group">
			<label for="account_login"><fmt:message key="register.email" />&nbsp;*<span class="sr-only"><fmt:message key="register.email" /></span></label>
			<dsp:input type="text" name="account_login" id="account_login" bean="ProfileFormHandler.value.login" maxlength="255" data-validation="required email" aria-required="true" autocomplete="off"/>
		</div>
		
		<div class="field-group">
			<fmt:message  var="password" key="register.pwdinfo"/>
			<label for="account_password"><fmt:message key="register.pwd" />&nbsp;*<span class="sr-only"><fmt:message key="register.pwd" /></span></label>
			<dsp:input type="password" name="account_password" id="account_password" bean="ProfileFormHandler.value.password" maxlength="25" data-validation="required password" aria-required="true" autocomplete="off" />
		</div>
		
		<div class="field-group">
			<fmt:message  var="rePassword" key="register.pwdinfo"/>
			<label for="account_verify_password"><fmt:message key="register.pwdverify" />&nbsp;*<span class="sr-only"><fmt:message key="register.pwdverify" /></span></label>
			<dsp:input type="password" name="account_verify_password" id="account_verify_password" bean="ProfileFormHandler.profileValueMap.confirmPassword" maxlength="25" data-validation="required matchPassword" aria-required="true" data-matchfield="#account_password" autocomplete="off"/>
		</div>
				
		<div class="field-group">
			<fmt:message  var="zipcode" key="register.zipcode"/>
			<fmt:message  var="zipcodeTooltip" key="register.zipcodeTooltip"/>
			<div class="zip-field">
				<label for="ZipCode"><fmt:message key="register.zipcode" />&nbsp;*<span class="sr-only"><fmt:message key="register.zipcode" /></span>
				</label>
				<span data-tooltip class="has-tip tip-bottom round icon icon-info" title="${zipcodeTooltip}">
                    <span class="sr-only">${zipcodeTooltip}</span>
                </span>
				<dsp:input type="text" name="account_postalCode" id="ZipCode" bean="ProfileFormHandler.value.homeAddress.postalCode" maxlength="10" data-validation="required uspostal" aria-required="true" autocomplete="off"/>
			</div>
		</div>
		
		<div class="field-group">
			<div class="checkbox custom-checkbox">
				<dsp:input type="checkbox" id="promoCheck" name="account_opt_in_email" checked="true" bean="ProfileFormHandler.optInEmail" value="on" />
				<label for="promoCheck">
					<span><fmt:message key="register.promos" /></span>
				</label>
				<fmt:message  var="promoTooltip" key="register.promoTooltip"/>
               	<span data-tooltip class="has-tip tip-bottom round icon icon-info" title="${promoTooltip}">
                	<span class="sr-only">${promoTooltip}</span>
               	</span>
			</div>
		</div>
		
		<div class="field-group">
			<div class="already-account"><fmt:message key="register.account" /> &nbsp;<dsp:a href="${contextPath}/account/ajax/loginModal.jsp" iclass="modal-trigger create-account-click" data-dismiss="modal" data-target="login-modal" data-size="small" aria-label="sign in" tabindex="0"> <fmt:message key="register.signin" /></dsp:a></div>
		</div>
		
		<dsp:input bean="ProfileFormHandler.createErrorURL" type="hidden" value="${contextPath}/account/json/profileError.jsp"/>
		<dsp:input bean="ProfileFormHandler.createSuccessURL" type="hidden" value="${contextPath}/account/json/registerSuccess.jsp"/>
		
		<dsp:input type="submit" value="CREATE ACCOUNT" name="createuser" id="createuser" bean="ProfileFormHandler.create" iclass="button primary createuser"/>

		<!-- For face book extension -->
		<c:if test="${ fromFb == 'true' && fbFirstName != null && fbLastName != null }">
            <dsp:input type="hidden" bean="ProfileFormHandler.fromFb" value="${fromFb}" />
            <dsp:input type="hidden" bean="ProfileFormHandler.value.firstName" value="${fbFirstName}" />
            <dsp:input type="hidden" bean="ProfileFormHandler.value.lastName" value="${fbLastName}" />
        </c:if>

		<%-- Eloqua form fields start  --%>
		<input type="hidden" name="elqFormName" value="createAccountMobile">
		<input type="hidden" name="elqSiteID" value="20103530">
		<input type="hidden" name="elqCustomerGUID" value="">
		<input type="hidden" name="elqCookieWrite" value="0">
		<input id="field3" type="hidden" name="lead_source_original_hidden" value="Website - Account Creation" />
		<%-- Eloqua form fields end  --%>

	</dsp:form>

	<%-- Eloqua Script start --%>
	<script type='text/javascript'>
		var timerId = null, timeout = 5;
	</script>
	<script type='text/javascript'>
		function WaitUntilCustomerGUIDIsRetrieved() {
		if (!!(timerId)) {
		if (timeout == 0)

		{ return; }
		if (typeof this.GetElqCustomerGUID === 'function')

		{ document.forms["createAccountMobile"].elements["elqCustomerGUID"].value = GetElqCustomerGUID(); return; }
		timeout -= 1;
		}
		timerId = setTimeout("WaitUntilCustomerGUIDIsRetrieved()", 500);
		return;
		}
		window.onload = WaitUntilCustomerGUIDIsRetrieved;
		_elqQ.push(['elqGetCustomerGUID']);
	</script>
	<%-- Eloqua Script end --%>
</dsp:page>