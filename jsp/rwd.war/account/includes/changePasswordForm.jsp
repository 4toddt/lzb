<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

	<dsp:setvalue bean="ProfileFormHandler.password" value=""/>
	
	<div class="field-group">
		<label for="current-password"><fmt:message key="profile.oldPassword"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.oldPassword"/></span></label>
		<dsp:input bean="ProfileFormHandler.oldPassword" id="current-password" name="curpasswrd" type="password" autocapitalize="off" data-validation="required" aria-required="true" data-fieldname="Current Password" />
	</div>

	<div class="field-group">
		<fmt:message var="passwordFormat" key="profile.passwordInfo"/>
		<label for="new-password"><fmt:message key="profile.newPassword"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.newPassword"/></span></label>
		<dsp:input bean="ProfileFormHandler.password" id="new-password" name="account_password" type="password" autocapitalize="off" data-validation="required password" aria-required="true" data-fieldname="New Password" placeholder="${passwordFormat}"/>
		<p><fmt:message key="profile.passwordInfo" /></p>
	</div>

	<div class="field-group">
		<label for="confirm"><fmt:message key="profile.retypePassword"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.retypePassword"/></span></label>
		<dsp:input bean="ProfileFormHandler.value.confirmPassword" id="confirm" name="account_verify_password" type="password" autocapitalize="off" data-validation="required matchPassword" aria-required="true" data-fieldname="Confirm Password" data-matchfield="#new-password" placeholder="re-enter new password"/>
	</div>

</dsp:page>