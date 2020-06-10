<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content.contents}">
			<c:forEach var="slide" items="${content.contents}">
					<dsp:renderContentItem contentItem="${slide}" />
			</c:forEach>
	</c:if>
</dsp:page>