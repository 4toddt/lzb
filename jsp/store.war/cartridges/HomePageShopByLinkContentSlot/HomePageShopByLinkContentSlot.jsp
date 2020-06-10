<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<div class="secondary-nav">
		<c:if test="${not empty content.text}">
			<h2>${content.text}</h2>
		</c:if>
		<c:if test="${not empty content.imageUrl}">
			<img src="${content.imageUrl}" width="299px" height="200px" alt="${content.imageAltText}"/>
		</c:if>
		<c:if test="${not empty content.categoryLinks}">
			<ul>
				<c:forEach items="${content.categoryLinks}" var="element">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</ul>
		</c:if>
	</div><%-- .secondary-nav --%>
</dsp:page>