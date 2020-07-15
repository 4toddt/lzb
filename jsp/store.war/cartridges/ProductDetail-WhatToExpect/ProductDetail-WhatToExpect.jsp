<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
    <div class="pdp-block-container what-to-expect" data-anchor="whatToExpect">
        <h3 class="section-heading">${content.title}</h3>
        <ul>
            <c:forEach var="step" items="${content.steps}" varStatus="status">
				<li>
					<dsp:renderContentItem contentItem="${step}">
						<dsp:param name="stepNum" value="${status.count}"/>
					</dsp:renderContentItem>
				</li>
			</c:forEach>
        </ul>
    </div>
</dsp:page>