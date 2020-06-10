<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content.content}">
			${content.content}
	</c:if>
</dsp:page>