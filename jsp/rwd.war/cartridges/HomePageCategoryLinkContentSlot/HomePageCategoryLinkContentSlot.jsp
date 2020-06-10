<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content.categoryLinks}">
		<ul class="categories">
			<c:forEach items="${content.categoryLinks}" var="element">
				<li>
					<dsp:renderContentItem contentItem="${element}" />
				</li>
			</c:forEach>
		</ul>
	</c:if>
</dsp:page>