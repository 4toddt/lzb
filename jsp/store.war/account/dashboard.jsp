<dsp:page>

	<lzb:pageContainer>
		<jsp:attribute name="pageSpecificCSS">
		</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
		</jsp:attribute>
		<jsp:body>
			<!-- dash board content -->
			<dsp:include src="${pageContext.request.contextPath}/account/gadgets/dashboardContent.jsp"></dsp:include>
		</jsp:body>
	</lzb:pageContainer>
</dsp:page>