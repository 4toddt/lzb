<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
		<dsp:getvalueof var="email" bean="Profile.login" />
		<dsp:getvalueof var="optIn" bean="ProfileFormHandler.optInEmail" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<jsp:attribute name="title">Profile</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />

		<c:if test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					</dsp:include>
				</div>
			</div>
		</c:if>

		<dsp:getvalueof var="updateSuccess" param="success" />
		<c:if test="${updateSuccess}">
		<div class="message-container" data-module="messaging-close">

			<div class="message-wrapper">

				<p class="message-txt">

					<fmt:message key="success.message" />

					<a href="#" class="hide-message close">Hide</a>
					<a href="#" class="close-message close">X</a>

				</p>

			</div>

		</div>
		</c:if>

		<main role="main">
			<dsp:include page="/includes/leftnavigation.jsp">
				<dsp:param name="selpage" value="PROFILE" />
			</dsp:include>

		<section role="region" class="profile-account-content"
			data-module="profile-validate">
			<h1><fmt:message key="profile.message"/></h1>
			<dsp:form name="profileupdate" method="post" id="profileupdate" autocomplete="false">
				<div class="standard-border">
					<fieldset>
						<label for="firstName"><fmt:message key="profile.firstName"/> <sup>&#42</sup></label>
						<dsp:input type="text" bean="ProfileFormHandler.value.firstName"
							name="firstName" maxlength="20"></dsp:input>
					</fieldset>
					<fieldset>
						<label for="lName"><fmt:message key="profile.lastName"/> <sup>*</sup></label>
						<dsp:input type="text" bean="ProfileFormHandler.value.lastName"
							name="lastName" maxlength="20"></dsp:input>
					</fieldset>
					<fieldset>
						<label for="phoneNumber"><fmt:message key="profile.phoneNumber"/> <sup>&#42;</sup></label>
						<fmt:message  var="phoneNum" key="address.phoneNumFormat"/>
						<dsp:input type="text"
							bean="ProfileFormHandler.value.homeAddress.phoneNumber"
							name="phoneNumber" maxlength="20">
							<dsp:tagAttribute name="placeholder" value="${phoneNum}"/>
						</dsp:input>
					</fieldset>
					<fieldset>
						<label for="altPhoneNumber"><fmt:message key="profile.altPhoneNumber"/></label>
						<dsp:input type="text"
							bean="ProfileFormHandler.value.homeAddress.altPhoneNumber"
							name="altPhoneNumber" maxlength="20">
							<dsp:tagAttribute name="placeholder" value="${phoneNum}"/>
						</dsp:input>
					</fieldset>
					<fieldset>
						<dsp:getvalueof var="firstName"
							bean="ProfileFormHandler.value.firstName" />
						<span class="psuedo-label"><fmt:message
								key="profile.gender" /></span> &nbsp;
						<c:choose>
							<c:when test="${empty firstName}">

								<dsp:input type="radio" bean="ProfileFormHandler.value.gender"
									name="gender" value="female" checked="checked">

								</dsp:input>&nbsp;
									<label for="femalegender" class="short-label"><fmt:message key="profile.genderFemale"/></label>


								<dsp:input type="radio" bean="ProfileFormHandler.value.gender"
									name="gender" value="male" checked="checked">
								</dsp:input>&nbsp;
									<label for="malegender" class="short-label"><fmt:message key="profile.genderMale"/></label>

							</c:when>
							<c:otherwise>
								<dsp:input type="radio" bean="ProfileFormHandler.value.gender"
									name="gender" value="female">

								</dsp:input>

								<label for="femalegender" class="short-label"><fmt:message key="profile.genderFemale"/></label>&nbsp;


								<dsp:input type="radio" bean="ProfileFormHandler.value.gender"
									name="gender" value="male">

								</dsp:input>
								<label for="malegender" class="short-label"><fmt:message key="profile.genderMale"/></label>&nbsp;
							</c:otherwise>
						</c:choose>
						<fmt:message key="profile.genderMsg" var="genderMessage"/>
						<a href="#" title="${genderMessage}"><fmt:message key="profile.genderInfo" /></a>
					</fieldset>
					<fieldset>
						<p class="psuedo-label">
							<fmt:message key="profile.email"/> <sup>&#42;</sup>
						</p>
						<fieldset class="change-email">
							<p>${email}</p>
							<small><fmt:message key="profile.emailInfo"/></small>

							<div class="toggle" data-module="toggle">
								<a href="#"><fmt:message key="profile.changeEmail"/></a>
								<div class="change-arrow"></div>
							</div>
							<div id="change-email">
								<fieldset>
									<label for="newEmailAddress"><fmt:message key="profile.newEmail"/><sup>&#42;</sup></label>
									<fmt:message var="emailFormat" key="address.emailFormat"/>
									<dsp:input type="text" name="login" value=""
										bean="ProfileFormHandler.value.login">
										<dsp:tagAttribute name="placeholder" value="${emailFormat}"/>
									</dsp:input>
								</fieldset>
								<fieldset>
									<label for="confirmNewEmailAddress"><fmt:message key="profile.retypeEmail"/><sup>&#42;</sup>
									</label>
									<dsp:input type="text" bean="ProfileFormHandler.confirmEmail">
										<dsp:tagAttribute name="placeholder" value="${emailFormat}"/>
									</dsp:input>
								</fieldset>
							</div>
							<div class="toggle change-personal" data-module="toggle">
								<a href="#"><fmt:message key="profile.changePassword"/></a>
								<div class="change-arrow"></div>
							</div>
							<div id="change-password">
								<fieldset>
									<label for="oldpwd"><fmt:message key="profile.oldPassword"/> <sup>&#42;</sup></label>
									<dsp:input type="password"
										bean="ProfileFormHandler.oldPassword" name="curpasswrd"
										id="curpasswrd" />
								</fieldset>
								<fieldset>
									<label for="newPwd"><fmt:message key="profile.newPassword"/> <sup>&#42;</sup></label>
									<dsp:input type="password" bean="ProfileFormHandler.password"
										name="account_password" id="newpasswd" value="" />
									<p>
										<fmt:message key="profile.passwordInfo" />
									</p>
								</fieldset>
								<fieldset>
									<label for="confirmNewPwd"><fmt:message key="profile.retypePassword"/> <sup>&#42;</sup></label>
									<dsp:input type="password"
										bean="ProfileFormHandler.value.confirmPassword"
										name="account_verify_password" id="confpasswrd" />
								</fieldset>
							</div>
						</fieldset>
						<h2><fmt:message key="profile.subscriptions"/></h2>

						<p><fmt:message key="profile.subscriptionsInfo"/></p>
						<fieldset>
							<c:choose>
								<c:when test="${optIn eq 'on'}">
									<dsp:input type="checkbox" id="chk01" name="chk01"
										bean="ProfileFormHandler.optInEmail" checked="true" value="on"/>
									<label class="subscribe-label" for="chk01"><fmt:message key="profile.biMonth"/></label>
								</c:when>
								<c:otherwise>
									<dsp:input type="checkbox" id="chk01" name="chk01"
										bean="ProfileFormHandler.optInEmail" value="on"/>
									<label class="subscribe-label" for="chk01"><fmt:message key="profile.biMonth"/></label>
								</c:otherwise>
							</c:choose>

						</fieldset>
						<fieldset class="buttons-wrapper">
							<dsp:input type="hidden" bean="ProfileFormHandler.updateErrorURL"
								value="/account/profile.jsp?success=false" />
							<dsp:input type="hidden"
								bean="ProfileFormHandler.updateSuccessURL"
								value="/account/profile.jsp?success=true" />
							<dsp:a bean="ProfileFormHandler.cancel" value="Cancel"
								href="/account/account.jsp">
								<fmt:message key="profile.cancel" />
								<dsp:input type="submit" name="updateuser" id="updateuser"
									value="Save" bean="ProfileFormHandler.update"
									iclass="btn-primary" />

							</dsp:a>
						</fieldset>
						<fieldset>
							<div>
								<p class="deactive-account"><fmt:message key="profile.DeactivateInfo"/></p>
								<dsp:a href="/account/deactivateAccount.jsp">
								<fmt:message key="profile.Deactivate"/>
							</dsp:a>
							</div>
						</fieldset>
				</div>
			</dsp:form>
		</section>
		</main>
	</lzb:pageContainer>
</dsp:page>
