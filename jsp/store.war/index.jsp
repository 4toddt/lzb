<dsp:page>
	<c:set var="isHomePage" value="${true}" scope="request" />
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="includePath" value="/pages/home" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
		</dsp:oparam>
	</dsp:droplet>
	<c:choose>
		<c:when test="${not empty contentItem}">
			<dsp:renderContentItem contentItem="${contentItem}" />
		</c:when>
		<c:otherwise>
			<b>Content Empty</b>
		</c:otherwise>
	</c:choose>
</dsp:page>