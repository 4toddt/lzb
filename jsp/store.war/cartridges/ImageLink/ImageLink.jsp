<%--
renders the contents of YC Rich Text Footer
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:set var="imgURL" value="${contentItem.imageUrl}" />
	<c:set var="linkUrl" value="${contentItem.link}" />
	<c:set var="linkName" value="${contentItem.name}" />
	<c:if test="${not empty linkUrl }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${linkUrl}" />
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

	<a href="${actionURLTitleLink}" data-colorfamily="Color.${linkName }" aria-label="${linkName}-swatch-link"><img src="${imgURL}" alt="${linkName}-swatch"/></a>
</dsp:page>