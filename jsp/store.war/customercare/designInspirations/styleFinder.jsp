<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="title">Profile</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />

		<main role="main">
			<main role="main">
				<dsp:include page="/includes/designInspirationsNav.jsp">
					<dsp:param name="selpage" value="STYLE_FINDER" />
				</dsp:include>
				<section role="region" class="profile-account-content" data-module="form-validate">
					<h1>Style Finder</h1>
				</section>
			</main>

	</lzb:pageContainer>

</dsp:page>
