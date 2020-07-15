<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<dsp:importbean bean="/com/lzb/commerce/customercare/LZBProductRegisterFormHandler" />
		<dsp:importbean bean="/atg/commerce/util/StateListDroplet" />
		<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<main role="main">
			<dsp:include page="/includes/custCareNav.jsp">
				<dsp:param name="selpage" value="PRODUCTREG" />
			</dsp:include>
			<dsp:include page="/customercare/productRegistrationInfo.jsp"/>
		</main>

		<script>
			$("#departStoreNameButton").click(function() {
				$("#departStoreNameInput").css("display", "block");
				$("#localStoreNameInput").css("display", "none");
			});

			$("#localStoreNameButton").click(function() {
				$("#localStoreNameInput").css("display", "block");
				$("#departStoreNameInput").css("display", "none");
			});

			$("#furnitureGallery").click(function() {
				$("#departStoreNameInput").css("display", "none");
				$("#localStoreNameInput").css("display", "none");
			});
		</script>
	</lzb:pageContainer>

</dsp:page>
