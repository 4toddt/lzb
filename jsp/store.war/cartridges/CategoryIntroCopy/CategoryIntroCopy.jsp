<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" 	value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content.heading}">	
		<${content.heading}> 	
		<c:if test="${not empty content.categoryDescription}">	
			${content.categoryDescription} 		
		</c:if>
		</${content.heading}> 		
	</c:if>
	<c:if test="${empty content.heading}">	
		<c:if test="${not empty content.categoryDescription}">	
			${content.categoryDescription} 		
		</c:if>
	</c:if>
</dsp:page>