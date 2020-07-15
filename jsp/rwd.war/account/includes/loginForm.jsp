<%--
	- File Name: loginform.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the sign in form for My Account. It is a shared include file.
	- Parameters:
		- headerType: request scoped variable for header type (mobile, desktop),
		- pageType: logic based on page type
	-
--%>
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
    <dsp:importbean bean="/atg/userprofiling/CookieManager"/>
    <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
    
    <%-- Page Variables --%>
	<dsp:getvalueof id="requestURL" idtype="java.lang.String" bean="/OriginatingRequest.requestURI"/>
	<dsp:getvalueof var="scheme" value="${originatingRequest.scheme}"/>
	<dsp:getvalueof var="serverName" value="${originatingRequest.serverName}"/>
    <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
    <dsp:getvalueof var="connectedToFaceBook" param="faceBookConnected"/>
	<dsp:getvalueof var="pdpURL" param="destPDPURL"/>
	<c:set var="url" value="${scheme}://${serverName}" />
	<dsp:getvalueof var="success" param="success"/>
	<dsp:getvalueof param="pageType" var="pageType"/>
	<c:set var="signInButtonText" value="OK" />
	<c:set var="FacebookConnectText" value="Continue with Facebook" />
	<fmt:message var="forgotPasswordText" key="forgot.title" />
		
	<c:choose>
		<c:when test="${pageType eq 'loginPage'}">
			<dsp:getvalueof var="email" value="loginEmail"/>
			<dsp:getvalueof var="password" value="loginPassword"/>
			<dsp:getvalueof var="remember" value="loginRemember"/>
			<dsp:getvalueof var="loginForm" value="loginForm"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="email" value="email"/>
			<dsp:getvalueof var="password" value="password"/>
			<dsp:getvalueof var="remember" value="remember"/>
			<dsp:getvalueof var="loginForm" value="loginPageForm"/>
		</c:otherwise>
	</c:choose>

	<%-- Defines Desktop specific classes for usage in the desktop header utility navigation bar --%>
	<c:if test="${headerType eq 'desktop'}">
		<c:set var="desktopSubNavMenuClass" value="sub-nav-menu" />
		<c:set var="desktopClass" value="-desktop" />
		<fmt:message var="signInButtonText" key="login.signInButton"/>
		<fmt:message var="forgotPasswordText" key="forgot.password" />
		<c:set var="FacebookConnectText" value="Connect With Facebook" />
	</c:if>

	<div class="signin-menu ${desktopSubNavMenuClass}">
		<div class="signin-dropdown">
	      	<div class="signin">
	      		<h4><fmt:message key="login.Signin"/></h4>
	        	<dsp:form action="#" method="post" id="${loginForm}${desktopClass}" formid="${loginForm}${desktopClass}" name="loginForm${desktopClass}" autocomplete="false" iclass="sign-in-form" data-validate>
	        		<div class="field-group">
						<label for="${email}"><fmt:message key="common.loginEmailAddress"/>&nbsp;*<span class="sr-only"><fmt:message key="common.loginEmailAddress"/></span></label>
						<dsp:input id="${email}${desktopClass}" type="email" name="login_email_address" bean="ProfileFormHandler.value.login" maxlength="255" aria-required="true">
							<dsp:tagAttribute name="data-validation" value="required email"/>
			                <dsp:tagAttribute name="autocomplete" value="off"/>
			                <dsp:tagAttribute name="placeholder" value="Email Address"/>
			                <dsp:tagAttribute name="data-fieldName" value="Email"/>
						</dsp:input>
					</div>
	          		
	            	<div class="field-group">
						<label for="${password}"><fmt:message key="common.loginPassword"/>&nbsp;*<span class="sr-only"><fmt:message key="common.loginPassword"/></span></label>
						<dsp:input id="${password}${desktopClass}" type="password" name="login_password" bean="ProfileFormHandler.value.password" aria-required="true" value="" maxlength="25">
							<dsp:tagAttribute name="data-validation" value="required"/>
	                		<dsp:tagAttribute name="autocomplete" value="off"/>
	                		<dsp:tagAttribute name="placeholder" value="Password"/>
	                		<dsp:tagAttribute name="data-fieldName" value="Password"/>
						</dsp:input>
					</div>
	            	<div class="field-group">
	              		<div class="custom-checkbox">
	              			<fmt:message  var="rememberMe" key="remember.me"/>
	              			<fmt:message  var="rememberTooltip" key="remember.tooltip"/>
		                	<dsp:input type="checkbox" bean="ProfileFormHandler.value.rememberMe" checked="true" id="${remember}${desktopClass}"/>
		                	<label for="${remember}${desktopClass}" class="remember-me">${rememberMe}</label>
		                  	<span data-tooltip class="has-tip tip-bottom round icon icon-info" title="${rememberTooltip}">
                                <span class="sr-only">${rememberTooltip}</span>
                            </span>
	             	 	</div>
	            	</div>
	            	
	            	<dsp:input type="hidden" bean="ProfileFormHandler.loginErrorURL" value="${contextPath}/account/json/profileError.jsp" />
	            	<c:choose>
		                <c:when test="${not empty pdpURL}">
							<dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL" value="${url}${pdpURL}?wishListMsg=true" />
						</c:when>
						<c:otherwise>
							<dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL" value="${contextPath}/account/json/loginSuccess.jsp?pageType=${pageType}" />
					   </c:otherwise>
	               </c:choose>
	               
	               <dsp:input type="submit" value="${signInButtonText}" bean="ProfileFormHandler.login" iclass="button primary submitBtn"/>
	            	
	 			</dsp:form> 
	      	</div>
	      	<a href="${contextPath}/account/ajax/forgotPasswordModal.jsp" class="modal-trigger forgotpw forgot-password-click" data-dismiss="modal" data-target="forgot-password-modal" data-size="small" aria-label="${forgotPasswordText}" tabindex="0">${forgotPasswordText}</a>
	    </div>
	    <div class="content">
	      	<div class="fb-signin-section">
	      		<a href="#" class="btn-primary button fb-login-button" onclick="FB.login(); checkLoginState(); return false;"><span class="icon icon-facebook"></span>${FacebookConnectText}</a>
				<!-- <div class="fb-login-button" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div> -->
				
	 		</div> 
			<div class="create-account">
	  			<h4><fmt:message key="login.createAccountHeading"/></h4>
	  			<p class="small"><fmt:message key="login.createAccountDescription"/></p> 
	  			<a href="${contextPath}/account/ajax/createRegisterModal.jsp" class="modal-trigger button secondary create-account-click" data-dismiss="modal" data-target="create-account-modal" data-size="small" aria-label="Create an Account" tabindex="0"><fmt:message key="create.account" /></a> 
			</div> 
	 	</div> 
	 </div>
</dsp:page>
