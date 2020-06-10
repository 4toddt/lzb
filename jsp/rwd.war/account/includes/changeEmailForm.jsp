<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

	<fmt:message var="emailFormat" key="address.emailFormat"/>
	<div class="field-group">
		<label for="newEmailAddress"><fmt:message key="profile.newEmail"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.newEmail"/></span></label>
		<dsp:input id="new-email" type="email" name="login" value="" bean="ProfileFormHandler.value.login" autocapitalize="off" data-validation="required email" aria-required="true" data-fieldname="New Email Address" placeholder="${emailFormat}" maxlength="255"/>
	</div>

	<div class="field-group">
		<label for="confirmNewEmailAddress"><fmt:message key="profile.retypeEmail"/>&nbsp;*<span class="sr-only"><fmt:message key="profile.retypeEmail"/></span></label>
		<dsp:input id="confirm-email" bean="ProfileFormHandler.confirmEmail" name="confirm-email" type="email" autocapitalize="off" data-validation="required matchEmail" aria-required="true" data-fieldname="Confirm Email Address" data-matchfield="#new-email" placeholder="${emailFormat}" maxlength="255"/>
	</div>

</dsp:page>