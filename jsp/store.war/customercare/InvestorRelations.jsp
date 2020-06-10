<dsp:page>

<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration"/>

<lzb:pageContainer>

	<jsp:attribute name="pageSpecificCSS">

	</jsp:attribute>

		<jsp:attribute name="bodyClass"></jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

<%--			<lzb:breadCrumb pageKey="breadcrumb.dashboard" divClass="breadcrumb" /> --%>
			<main role="main" data-module="iframe-resizer">
				<dsp:getvalueof bean="LZBStoreConfiguration.investorRelationSiteURL" var="investorRelationSiteURL"/>
				<iframe src="${investorRelationSiteURL}" id="irContent" class="ir-content"></iframe>

			</main>
			
	</lzb:pageContainer>

</dsp:page>
