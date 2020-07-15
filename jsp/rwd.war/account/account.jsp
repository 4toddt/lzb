<%--
	- File Name: account.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the login page for My Account
	- Parameters:
	-
--%>
<dsp:page>
	<%-- SET PAGE PARAMS --%>

	<%-- HEAD stuff--%>
	<layout:default>
		<jsp:attribute name="pageTitle">My Account</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">account</jsp:attribute>
		<jsp:attribute name="pageType">account</jsp:attribute>
		<jsp:attribute name="bodyClass">account</jsp:attribute>
		<jsp:attribute name="analyticsPageType">accountPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>

		<jsp:body>
			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextPath}/">Home</a></li>
					<li><span class="crumb active">My Account</span></li>
				</ul>
			</section>
			<div class="section-title hide-for-large">
				<h1><fmt:message key="dashboard.account"/></h1>
			</div>
			<div class="section-content">
				<div class="account-two-column-container">
					<div class="account-two-column-left hide">
						<dsp:include page="/account/includes/leftnavigation.jsp"/>
					</div>
					<div class="account-two-column-right">
						<dsp:include page="/account/includes/dashboard_view.jsp"/>
					</div>
				</div>
			</div>

		</jsp:body>
	</layout:default>
</dsp:page>