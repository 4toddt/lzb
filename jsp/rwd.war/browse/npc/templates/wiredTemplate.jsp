<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<%-- Title - ${templateItem.title} --%>


	<c:if test="${pageItem.seoName eq 'CoverSearch'}">
		<dsp:droplet name="/atg/endeca/assembler/droplet/InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/Shared/CoverSearch/CoverSearch" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<dsp:renderContentItem contentItem="${element}" />
			</dsp:oparam>
			<dsp:oparam name="error">
				failed
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	<dsp:include page="${templateItem.url}" />
</dsp:page>
