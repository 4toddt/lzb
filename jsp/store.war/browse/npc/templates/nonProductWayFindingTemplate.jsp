<dsp:page>
	<dsp:getvalueof var="pageItem" param="page" />
		
	<section role="region" class="cust-support" data-template-name="nonProductWayFinding">	
	
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>			

		<dsp:getvalueof var="templateItem" param="templateItem" />
		<img src="${templateItem.heroImage.url}" alt="${templateItem.heroCaption}" />
		<p>${templateItem.heroCaption}</p>

		<div class="cust-contant style-measure">
			<dsp:getvalueof var="features" value="${templateItem.features}" />
			<c:if test="${not empty features}">
				<c:forEach items="${features}" var="feature">
					<div class="room-measure">
						<img src="${feature.image.url}" alt="${feature.image.description}" />
						<div class="insps-txt">
							<h3>${feature.subTitle}</h3>
							<p><dsp:valueof value="${feature.contentBlock}" valueishtml="true"/></p>
							<a href="${feature.linkURL}">${feature.linkText}</a>
						</div>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</section>
</dsp:page>