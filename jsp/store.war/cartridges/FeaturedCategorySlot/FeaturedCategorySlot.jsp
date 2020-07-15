<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	
<ul>
<li>Search Tips</li>
<li>Check your spelling</li>
<li>Use a more general search word ('plaid' instead of 'Glenbrook')</li>
</ul>

<p>Or, browse one of the product categories below:</p>

	<c:if test="${not empty content.featuredCategory}">

		<c:forEach items="${content.featuredCategory}" var="element">
			<dsp:renderContentItem contentItem="${element}"/>
		</c:forEach>
	</c:if>
</dsp:page>