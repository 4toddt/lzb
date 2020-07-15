
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<main>
	<h1> ${contentItem.title} test</h1>
		<%-- Render link group contents in mega menu on header--%>
		<c:if test="${not empty contentItem.SiteMapItem}">
		<c:set var="pageRequest" scope="request" value="${contentItem['@type']}"/>
			<c:forEach var="element" items="${contentItem.SiteMapItem}">
				<dsp:renderContentItem contentItem="${element}"/>
			</c:forEach>
		</c:if>
		</main>
</dsp:page>