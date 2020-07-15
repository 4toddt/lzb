<%--
  - File Name: saveCover.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the users save cover
  --%>

<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />

	<%-- Page Variables --%>
	
	<layout:default>
		<jsp:attribute name="pageTitle">Save Cover</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="section">account</jsp:attribute>
		<jsp:attribute name="pageType">saveCover</jsp:attribute>
		<jsp:attribute name="bodyClass">account save-cover</jsp:attribute>
		<jsp:attribute name="analyticsPageType">saveCoverPage</jsp:attribute>
		<jsp:body>
		
  			<dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
			<dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />
  			
  			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a class="crumb" href="${contextPath}/account/account.jsp"><fmt:message key="breadcrumb.dashboard"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.designCenter"/></span></li>
				</ul>
			</section>
			
			<!-- page title -->
			<div class="section-title hide-for-large">
				<h1><fmt:message key="account.designCenter.pageHeading"/></h1>
			</div>
			
			<!-- page content-->
			<div class="section-row">
				<div class="account-two-column-container">
					<div class="account-two-column-left hide">
						<dsp:include page="/account/includes/leftnavigation.jsp">
							<dsp:param name="selpage" value="SAVECOVER" />
						</dsp:include>
					</div>
					<div class="account-two-column-right">
						<dsp:droplet name="IsEmpty">
							<dsp:param name="value" param="savedCoversItem" />
							<dsp:oparam name="true">
								<p><fmt:message key="account.designCenter.noItemsCoverList"/></p>
								<a class="button secondary" href="${contextPath}/index.jsp"><fmt:message key="account.designCenter.continueShopping" /></a>
							</dsp:oparam>
							<dsp:oparam name="false">
								<dsp:include page="/account/includes/saveCover_view.jsp"/>
							</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>
			</div>

		</jsp:body>
	</layout:default>
</dsp:page>
