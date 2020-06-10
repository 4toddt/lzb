<%--
	- File Name: profile_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the profile view page for My Account
	- Parameters:
	-
--%>
<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof param="originalURL" var="originalURL"/>
	<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	<dsp:getvalueof var="email" bean="Profile.login" />
	<dsp:getvalueof var="optIn" bean="ProfileFormHandler.optInEmail" />
	
	<section role="region" class="profile-account-content">
	
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="profile.message"/></h1>
		</div> --%>
		
		<dsp:getvalueof var="updateSuccess" param="success" />
		<c:if test="${updateSuccess}">
			<div class="alert-box success">
				<p class="alert-message">
					<fmt:message key="success.message" />
					<a href="#" class="hide-message close hide">Hide</a>
					<a href="#" class="close-message close right hide">X</a>
				</p>

			</div>
		</c:if>
		
		<div class="account-content standard-border">
			<dsp:form name="profileupdate" method="post" id="profileupdate" formid="profileupdate" autocomplete="false" data-validate>
				<div class="field-group">
					<label for="firstName"><fmt:message key="profile.firstName"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.firstName"/></span></label>
					<dsp:input id="firstName" type="text" bean="ProfileFormHandler.value.firstName" name="firstName" maxlength="20" autocapitalize="off" data-validation="required name" aria-required="true" data-fieldname="First Name" placeholder="First Name"/>
				</div>
			
				<div class="field-group">
					<label for="LastName"><fmt:message key="profile.lastName"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.lastName"/></span></label>
					<dsp:input id="LastName" type="text" bean="ProfileFormHandler.value.lastName" name="lastName" maxlength="20" autocapitalize="on" data-validation="required name" aria-required="true" data-fieldname="Last name" placeholder="Last Name"/>
				</div>
			
				<div class="field-group">
					<fmt:message  var="phoneNum" key="address.phoneNumFormat"/>
					<label for="phoneNumber"><fmt:message key="profile.phoneNumber"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.phoneNumber"/></span></label>
					<dsp:input id="phoneNumber" class="phone" type="tel" bean="ProfileFormHandler.value.homeAddress.phoneNumber" name="phoneNumber" maxlength="20" autocapitalize="on" data-validation="required phone" aria-required="true" data-fieldname="Phone Number" placeholder="${phoneNum}"/>
				</div>
				
				<div class="field-group">
					<fmt:message  var="phoneNum" key="address.phoneNumFormat"/>
					<label for="alternatePhoneNumber"><fmt:message key="profile.altPhoneNumber"/><span class="sr-only"><fmt:message key="profile.altPhoneNumber"/></span></label>
					<dsp:input id="alternatePhoneNumber" class="phone" type="tel" bean="ProfileFormHandler.value.homeAddress.altPhoneNumber" name="altPhoneNumber" maxlength="20" autocapitalize="on" data-validation="phone" data-fieldname="Alt Phone Number" placeholder="${phoneNum}"/>
				</div>
			
				<div class="field-group state-zip-group" role="radiogroup" aria-labelledby="Gender">
					<dsp:getvalueof var="firstName" bean="ProfileFormHandler.value.firstName" />
					<label for="Gender" id="Gender"><fmt:message key="profile.gender" /><span class="sr-only"><fmt:message key="profile.gender" /></span></label>
					<c:choose>
						<c:when test="${empty firstName}">
							<div class="field gender-field custom-radio" role="radio" aria-checked="true" tabindex="0">
								<dsp:input id="femalegender" type="radio" bean="ProfileFormHandler.value.gender" name="gender" value="female" checked="checked"/>
								<label for="femalegender" class="short-label"><fmt:message key="profile.genderFemale"/></label>
							</div>

							<div class="field gender-field custom-radio" role="radio" aria-checked="false" tabindex="-1">
								<dsp:input id="malegender" type="radio" bean="ProfileFormHandler.value.gender" name="gender" value="male" checked="checked"/>
								<label for="malegender" class="short-label"><fmt:message key="profile.genderMale"/></label>
							</div>
						</c:when>
						<c:otherwise>
							<div class="field gender-field custom-radio" role="radio" aria-checked="false" tabindex="0">
								<dsp:input id="femalegender" type="radio" bean="ProfileFormHandler.value.gender" name="gender" value="female"/>
								<label for="femalegender" class="short-label"><fmt:message key="profile.genderFemale"/></label>
							</div>

							<div class="field gender-field custom-radio" role="radio" aria-checked="false" tabindex="-1">
								<dsp:input id="malegender" type="radio" bean="ProfileFormHandler.value.gender" name="gender" value="male"/>
								<label for="malegender" class="short-label"><fmt:message key="profile.genderMale"/></label>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="field-group">
					<fmt:message key="profile.genderMsg" var="genderMessage"/>
					<a href="#" title="${genderMessage}" class="" data-tip="${genderMessage}" data-tooltip><fmt:message key="profile.genderInfo" /></a>
				</div>
			
				<div class="field-group">
					<h2><fmt:message key="profile.email"/></h2>
					<p>${email}</p>
					<p><fmt:message key="profile.emailInfo"/></p>
					<div class="change-email dropdown" aria-expanded="false" data-dropdown>
					    <a href="" class="dropdown-toggle" id="change-email">
					       <fmt:message key="profile.changeEmail" />
					        <span class="icon icon-arrow-down" aria-hidden="true"></span>
					    </a>
				        <div class="dropdown-menu">
				        	<div class="member-benefits" role="menu" aria-labelledby="change-email">
				        		<dsp:include page="/account/includes/changeEmailForm.jsp"/>
				        	</div>
				        </div>
				    </div>
				</div>
				<div class="field-group">
					<h2><fmt:message key="profile.password"/></h2>
					<div class="change-password dropdown" aria-expanded="false" data-dropdown>
					    <a href="" class="dropdown-toggle" id="change-password">
					       <fmt:message key="profile.changePassword" />
					        <span class="icon icon-arrow-down" aria-hidden="true"></span>
					    </a>
				        <div class="dropdown-menu">
				        	<div class="member-benefits" role="menu" aria-labelledby="change-password">
				        		<dsp:include page="/account/includes/changePasswordForm.jsp"/>
				        	</div>
				        </div>
				    </div>
				</div>
				<div class="field-group custom-checkbox">
					<h2><fmt:message key="profile.subscription"/></h2>
					<p><fmt:message key="profile.subscriptionsInfo"/></p>
					<c:choose>
						<c:when test="${optIn eq 'on'}">
							<dsp:input id="subscribe" type="checkbox" id="chk01" name="chk01" bean="ProfileFormHandler.optInEmail" value="on"/>
							<label for="subscribe"><fmt:message key="profile.biMonth"/></label>
						</c:when>
						<c:otherwise>
							<dsp:input id="subscribe" type="checkbox" id="chk01" name="chk01" bean="ProfileFormHandler.optInEmail" value="on" checked="true" />
							<label for="subscribe"><fmt:message key="profile.biMonth"/></label>
						</c:otherwise>
					</c:choose>
				</div>
				<dsp:input type="hidden"  bean="ProfileFormHandler.updateErrorURL" value="${contextPath}/account/json/profileError.jsp?success=false"/>
				<dsp:input type="hidden" bean="ProfileFormHandler.updateSuccessURL"	value="${contextPath}/account/json/profileSuccess.jsp?success=true"/>
				
				<dsp:input type="submit" name="updateuser" id="updateuser" class="button primary" value="Save Changes" bean="ProfileFormHandler.update"/>
			</dsp:form>
		</div>
	
	</section>
</dsp:page>