<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<c:set var="groupText" value="${contentItem.title}" />
	<c:set var="linkUrl" value="${contentItem.titleLink}" />

	<c:if test="${groupText eq 'Color'}">
		<c:set var="colorSwatches" value="color-swatches" />
	</c:if>
	<li>
		
		<c:if test="${not empty groupText}">
			<p class="title">${groupText}</p>
		</c:if>

		<%-- Render sublinks of header--%>
		
		<c:if test="${not empty contentItem.subLinks}">
		<ul>
			<c:forEach var="element" items="${contentItem.subLinks}">
				<li><dsp:renderContentItem contentItem="${element}" /></li>
			</c:forEach>
		</ul>
		</c:if>
	</li>	
</dsp:page>