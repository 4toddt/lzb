<%--
renders the contents of YC HomePage Category Link Content
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	
<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:set var="linkText" value="${contentItem.text}" />
	<c:set var="linkUrl" value="${contentItem.link}" />
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

	<c:if test ="${not empty contentItem.imageUrl}">
		<a href="${actionURLTitleLink}"><img src="${contentItem.imageUrl}" alt="${linkText}"/></a>
	</c:if>
<%-- 	<a href="${actionURLTitleLink}"> ${linkText} </a> --%>
	
</dsp:page>