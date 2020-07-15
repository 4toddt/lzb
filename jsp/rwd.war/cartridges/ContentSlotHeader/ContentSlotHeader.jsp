<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content.contents}">
		<c:forEach items="${content.contents}" var="element">
			<dsp:renderContentItem contentItem="${element}" />
		</c:forEach>
	</c:if>
</dsp:page>