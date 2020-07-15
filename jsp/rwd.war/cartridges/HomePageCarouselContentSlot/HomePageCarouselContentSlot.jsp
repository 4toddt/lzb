<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<dsp:getvalueof var="carouselEnabled" value="${content.carouselEnabled}"/>
	<c:if test="${not empty content.contents}">
		<div class="hero-slider" id="hero-carousel">
			<c:forEach items="${content.contents}" var="element">
				<dsp:renderContentItem contentItem="${element}" />
			</c:forEach>
		</div>
	</c:if>
</dsp:page>