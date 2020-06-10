<dsp:page>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />

	<section role="region" class="cust-support" data-template-name="productWayFindingWithTabs" data-module="cbox" data-pagename="${pageItem.name}">
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<img src="${templateItem.heroImage.url}" alt="${templateItem.heroImage.description}"/>
		<p><dsp:valueof value="${templateItem.heroCaption}" valueishtml="true"/></p>
		<style>

			div.style-options {
				margin-bottom: 20px;
				border-bottom: 1px #ccc dotted; }
				div.style-options:before, div.style-options:after {
				content: "";
				display: table; }

			div.style-options:after {
				clear: both; }

			.style-options img {
				margin: 0 20px 20px 0;
				float: left; }

			.style-options h3 {
				font-size: 12px; }

		</style>

		<div class="tab-wrapper" role="tabpanel">
			<dsp:getvalueof var="tabs" value="${templateItem.tabs}" />
			<c:if test="${not empty tabs}">
				<ul class="tabs" data-module="tabs" role="tablist">
				<c:forEach items="${tabs}" var="tab" varStatus="theCount">
					<c:choose>
						<c:when test="${theCount.index eq 0}">
							<c:set var="classActive" value="active" />
						</c:when>
						<c:otherwise>
							<c:set var="classActive" value="" />
						</c:otherwise>
					</c:choose>

					<li class="${classActive}" data-rel="tab${theCount.index}" role="tab" aria-controls="tab${theCount.index}">
						${tab.tabName}
					</li>
		        </c:forEach>
				</ul>
			</c:if>
		</div><%-- .tab-wrapper --%>
		<%-- tab content --%>
		<c:set var="active" value="" />
		<c:forEach items="${tabs}" var="tab" varStatus="theCount">
				<dsp:getvalueof var="features" value="${tab.features}" />
				<c:choose>
					<c:when test="${theCount.index eq 0}">
						<c:set var="classActive" value="active" />
					</c:when>
					<c:otherwise>
						<c:set var="classActive" value="" />
					</c:otherwise>
				</c:choose>

				<div id="tab${theCount.index}" class="tab-content ${classActive}" data-tab-content="tab${theCount.index}">
					<c:if test="${not empty features}">
						<c:forEach items="${features}" var="feature">
								<div class="style-options">
									<img src="${feature.image.url}" alt="${feature.image.description}" />
									<h3>${feature.subTitle}</h3>
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
					</c:if>
				</div>
		</c:forEach>
	</section>
</dsp:page>