<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<div class="primary-promo">

	</div>
	<main role="main" class="row home"><%-- ends in HorizontalRecordSpotlight.jsp --%>
		<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />
		<%--
		<dsp:include page="/storecontent/umbracoHome.jsp">
			<dsp:param name="dealerId" value="${dealerId }" />
		</dsp:include>
		 --%>
		<section class="hero"><%-- ends in HomePageCarouselContentSlot.jsp --%>

<%-- 		<c:if test="${not empty content.categoryLinks}">
			<ul class="categories" role="navigation">
				<c:forEach items="${content.categoryLinks}" var="element">
					<li>
						<figure>
							<dsp:renderContentItem contentItem="${element}" />
						</figure>
					</li>
				</c:forEach>
			</ul>
		</c:if> --%>
</dsp:page>