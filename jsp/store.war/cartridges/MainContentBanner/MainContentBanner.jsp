<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content}">
		<c:if test="${not empty content.link}">
				<%-- Get the URL for the action passed within content item --%>
			<dsp:droplet name="ActionURLDroplet">
				<dsp:param name="action" value="${content.link}" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="actionURL" param="actionURL" />
				</dsp:oparam>
				<dsp:oparam name="empty">
				</dsp:oparam>
			</dsp:droplet>
		</c:if> 
		<c:if test="${empty actionURL}">
			<c:set var="actionURL" value="#" />
		</c:if>
		<a title="" href="${actionURL}">
			<img src="http://localhost:8006/ifcr/sites/LZB/media/${content.media.uri}" alt="${content.imageAlt}" height="${content.media.contentHeight}" width="${content.media.contentWidth}" />
		</a>
	</c:if>
</dsp:page>