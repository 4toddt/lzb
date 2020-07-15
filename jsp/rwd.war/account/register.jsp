<%--
  - File Name: register.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the register page for create an account
  --%>

<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />

	<%-- Authentication Check --%>
	<dsp:droplet name="/atg/dynamo/droplet/Switch">
		<dsp:param bean="Profile.transient" name="value"/>
		<dsp:oparam name="true">
			<layout:default>
				<jsp:attribute name="pageTitle">Register</jsp:attribute>
				<jsp:attribute name="metaDescription"></jsp:attribute>
				<jsp:attribute name="metaKeywords"></jsp:attribute>
				<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
				<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
				<jsp:attribute name="lastModified"></jsp:attribute>
				<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
				<jsp:attribute name="section">account</jsp:attribute>
				<jsp:attribute name="pageType">register</jsp:attribute>
				<jsp:attribute name="bodyClass">account</jsp:attribute>
				<jsp:attribute name="analyticsPageType">accountRegisterPage</jsp:attribute>
				<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
				<jsp:attribute name="pageSpecificJS"></jsp:attribute>
				<jsp:body>
					<!-- breadcrumbs -->
					<section class="breadcrumbs">
						<ul aria-label="breadcrumbs" role="navigation">
							<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
							<li><span class="crumb active"><fmt:message key="register.signUp"/></span></li>
						</ul>
					</section>
					<div class="section-title">
						<h1><fmt:message key="register.create"/></h1>
					</div>
					
					<div class="section-content">
						<!--  Sign up benefits -->
						<div class="signup-benefits-section">
							<dsp:include src="includes/signUpBenefits.jsp"></dsp:include>
						</div>
						
						<!--  Sign up form -->
						<div class="signup-form-section">
							<dsp:include src="includes/registerForm.jsp"></dsp:include>
						</div>
					</div>
					
				</jsp:body>
			</layout:default>
		</dsp:oparam>
		<dsp:oparam name="false">
			<%-- if logged in redirect to my account page --%>
			<dsp:droplet name="/atg/dynamo/droplet/Redirect">
				<dsp:param name="url" value="${contextPath}/account/account.jsp"/>
			</dsp:droplet>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>


