
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:if test="${not empty contentItem.titleLink }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.titleLink}" />
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
	
	<c:if test="${not empty contentItem.subLinks}">
		<c:set var="hasSubLinks" value="header" />
	</c:if>
	<li class="nav-subarea ${hasSubLinks}"><a href="${actionURLTitleLink}" title="${contentItem.title}">${contentItem.title}</a>
	
	<c:if test="${not empty contentItem.subLinks}">
		<ul>
			<c:forEach var="element" items="${contentItem.subLinks}">
				<li class="nav-detail"><dsp:renderContentItem contentItem="${element}" /></li>
			</c:forEach>
		</ul>
	</c:if>
	
	</li>

</dsp:page>