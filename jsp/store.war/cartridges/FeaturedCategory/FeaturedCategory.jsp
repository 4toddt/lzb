<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
        <dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLTitleLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
<c:if test="${empty actionURLTitleLink}">
		<c:set var="actionURLTitleLink" value="#" />
	</c:if>

	<figure>
		<a href="${actionURLTitleLink}">
			<img alt="plaholder image" src="http://placehold.it/100x100">
		</a>
		<figcaption>
			<a href="${actionURLTitleLink}">
				${contentItem.name} 
			</a>
		</figcaption>
	
	</figure>

	 

</dsp:page>