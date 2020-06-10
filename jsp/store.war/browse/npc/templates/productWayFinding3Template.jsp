<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="heroImages" value="${templateItem.heroImages}" />
	<dsp:getvalueof var="features" value="${templateItem.features}" />
	<dsp:getvalueof var="pageItem" param="page" />

	<section role="region" class="cust-support" data-template-name="productWayFinding3" data-module="cbox">
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<c:if test="${not empty heroImages}">
			<c:forEach items="${heroImages}" var="heroImageItem">
				<img src="${heroImageItem.heroImage.url}" alt="${heroImageItem.heroCaption}" title="" />
				<p>${heroImageItem.heroCaption}</p>
	        </c:forEach>
		</c:if> 
		
		<c:if test="${not empty features}">
			<div class="cust-contant">
				<c:forEach items="${features}" var="feature">
					<div class="teaser-box">
						<c:if test="${not empty feature.image}">
							<img src="${feature.image.url}" alt="${feature.image.description}" />
						</c:if>
						<h2>${feature.subTitle}</h2>
						<p>${feature.contentBlock}</p>
						<c:if test="${not empty feature.linkURL}">

				<c:choose>
					<c:when test="${fn:contains(feature.linkURL, 'youtube')}">
						<a href="${feature.linkURL}" class="youtube">${feature.linkText}</a>      
					</c:when>

					<c:otherwise>
						<a href="${feature.linkURL}">${feature.linkText}</a>
					</c:otherwise>
				</c:choose>

						</c:if>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</section>
</dsp:page>