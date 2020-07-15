<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:getvalueof var="fromFb" param="fromFb"/>
	<dsp:getvalueof var="fbFirstName" param="fName"/>
	<dsp:getvalueof var="fbLastName" param="lName"/>
	<dsp:getvalueof var="userID" param="userID"/>
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
	<h1>
		<fmt:message key="register.create" />
	</h1>
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="//global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler" />
		</dsp:include>
	</c:if>
	<dsp:form action="#" method="post" name="registerProfile" id="registerUser" autocomplete="false">
		
		<p class="required">
			<fmt:message key="form.required" />
		</p>

		<fieldset>
			<div>
				<label for="account_login"> 
					<fmt:message key="register.email" />
					<span class="required">*</span>
				</label>
				<dsp:input type="text" id="email" name="account_login" bean="ProfileFormHandler.value.login" />
				<span class="field_error"></span>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<label for="account_password">
					<fmt:message key="register.password" /><span class="required">*</span>
				</label>
				
				<dsp:input type="password" name="account_password" id="password"
					bean="ProfileFormHandler.value.password" maxlength="25" />
				<span class="field_error"></span>
				<fmt:message key="register.passwordInfo"/>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<label for="account_verify_password">
					<fmt:message key="register.verifyPassword" /><span class="required">*</span>
				</label>
				<dsp:input type="password" name="account_verify_password" id="confirm" bean="ProfileFormHandler.profileValueMap.confirmPassword" maxlength="25" />
				<span class="field_error"></span>
				<fmt:message key="register.reEnterPass"/>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<label for="account_verify_password">
					<fmt:message key="register.postalCode" /><span class="required">*</span>
				</label> 
				<dsp:input type="text" name="account_postalCode" id="confirm" bean="ProfileFormHandler.value.homeAddress.postalCode" maxlength="25" />
				<span class="field_error"></span>
			</div>
		</fieldset>
		<fieldset>
			<div>
				<dsp:input type="checkbox" id="chk01" name="chk01" bean="ProfileFormHandler.optInEmail" value="on" />
				<label for="chk01" class="checkout checkout1"> 
					<fmt:message key="register.promoEmail" />
				</label>
			</div>
		</fieldset>
	
		<fmt:message var="createAccount" key="register.createAccount" />
		<dsp:input type="submit" value="${createAccount}" name="createuser"	id="createuser" bean="ProfileFormHandler.create" />
		<dsp:input type="hidden" bean="ProfileFormHandler.createSuccessURL" value="${siteBaseUrl}/account/wish_list_items.jsp" />
		<dsp:input type="hidden" bean="ProfileFormHandler.createErrorURL" value="${siteBaseUrl}/cart/register.jsp" />
		
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
		
		<fmt:message key="register.alreadyAccount" /><dsp:a href="${siteBaseUrl}/cart/wishlistLogin.jsp" ><fmt:message key="register.signin" /></dsp:a>
	</dsp:form>
	</dsp:layeredBundle>
</dsp:page>