<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	<c:set var="variant" value="" />
	<c:if test="${contentItem.name eq 'Copyright Text' or contentItem.name eq 'Copyright'}">
		<c:set var="variant" value="copyright-info" />
	</c:if>
	<li class="${variant}">
		<c:choose>
			<c:when test="${actionURLLink eq '/#'}">
				<span class="utility-link" aria-label="${contentItem.text}" tabindex="0">${contentItem.text}</span>
			</c:when>
			<c:otherwise>
				<a href="${actionURLLink}" class="utility-link" aria-label="${contentItem.text}" tabindex="0">${contentItem.text}</a>
			</c:otherwise>
		</c:choose>
	</li>
</dsp:page>
