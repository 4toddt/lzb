<%--
  - File Name: login.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the login page for Checkout
  --%>

<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	
	<layout:checkout>
		<jsp:attribute name="pageTitle">Login</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">checkout</jsp:attribute>
		<jsp:attribute name="pageType">login</jsp:attribute>
		<jsp:attribute name="bodyClass">checkout login</jsp:attribute>
		<jsp:attribute name="analyticsPageType">checkoutLogin</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextLinkPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.signIn"/></span></li>
				</ul>
			</section>
			
			<%-- help Container section --%>
			<div class="checkout-help-wrapper">
				<div class="header-help-content-container hide-for-medium">
					<div class="header-help-content help-info-content">
						<div class="icon icon-close" aria-hidden="true"></div>
						<dsp:include page="/sitewide/includes/helpContent.jsp" />
					</div>
				</div>
			</div>

			<div class="section-content">
				<div class="login-form">
					<h1><fmt:message key="login.checkoutHeading" /></h1>

					<dsp:form name="checkout-login-form" id="checkout-login-form" formid="checkout-login-form" data-validate="">
						<div class="field-group">
							<label for="checkoutLoginEmail"><fmt:message key="common.email" /></label>
							<dsp:input bean="ProfileFormHandler.value.login" type="email" id="checkoutLoginEmail" maxlength="255">
								<dsp:tagAttribute name="data-fieldname" value="Email"/>
								<dsp:tagAttribute name="data-validation" value="required email"/>
								<dsp:tagAttribute name="autocomplete" value="off"/>
								<dsp:tagAttribute name="aria-required" value="true"/>
							</dsp:input>
						</div>
						
						<div class="field-group">
							<label for="checkoutLoginPassword"><fmt:message key="common.loginPassword" /></label>
							<dsp:input bean="ProfileFormHandler.value.password" type="password" id="checkoutLoginPassword" maxlength="25" value="">
								<dsp:tagAttribute name="data-fieldname" value="Password"/>
								<dsp:tagAttribute name="data-validation" value="required"/>
								<dsp:tagAttribute name="aria-required" value="true"/>
							</dsp:input>
							<a href="${contextPath}/account/ajax/forgotPasswordModal.jsp" class="modal-trigger forgot-password" data-dismiss="modal" data-target="forgot-password-modal" data-size="small">
								<fmt:message key="forgot.title" />
							</a>
						</div>
						
						<dsp:input type="hidden" bean="ProfileFormHandler.loginErrorURL" value="${contextPath}/account/json/profileError.jsp" />
						<dsp:input type="hidden" bean="ProfileFormHandler.loginSuccessURL" value="${contextPath}/account/json/loginSuccess.jsp" />
						<dsp:input bean="ProfileFormHandler.login" type="submit" iclass="button tertiary signin-btn" value="Sign In" />
					</dsp:form>
					<div class="or-text"><fmt:message key="common.or" /></div>
					<div class="fb-signin-section">
			      		<div class="fb-login-button" data-width="100%" data-max-rows="1" data-size="large" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false"></div>
			 		</div> 
				</div>
				<div class="guest-checkout-form">
					<h2><fmt:message key="login.checkoutYouMayAlso" /></h2>

					<a href="/rwd/checkout/checkout.jsp" class="button secondary checkout-as-guest-btn"><fmt:message key="login.checkoutAsGuest" /></a>

					<h2><fmt:message key="login.dontHaveAccount" /></h2>

					<div class="signup-details">
						<fmt:message key="login.createAccountDescription" />
					</div>
					<a href="${contextPath}/account/ajax/createRegisterModal.jsp" class="modal-trigger button secondary create-account-btn" data-target="create-account-modal" data-size="small"><fmt:message key="login.createAccountButton" /></a>
				</div>
			</div>
			
		</jsp:body>
	</layout:checkout>
</dsp:page>