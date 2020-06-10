<dsp:page>
		<dsp:getvalueof var="templateItem" param="templateItem" />
		<img src="${templateItem.heroImage.url}" /> 
		<h2>Custom features for your personal style</h2>
		<p>${templateItem.heroCaption}</p>
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
		<c:forEach items="${tabs}" var="tab" varStatus="theCount">
				<c:choose>
					<c:when test="${theCount.index eq 0}">
						<c:set var="classActive" value="active" />
					</c:when>
					<c:otherwise>
						<c:set var="classActive" value="" />
					</c:otherwise>					
				</c:choose>
				<dsp:getvalueof var="features" value="${tab.features}" />
				<c:if test="${not empty features}">
					<c:forEach items="${features}" var="feature">
						<div class="tab-content ${classActive}" id="tab${theCount.index}" data-tab-content="tab${theCount.index}">
							<div class="style-options">
								<img src="${feature.image.url}" />
								<h3>${feature.subTitle}</h3>
								<p>${feature.contentBlock}</p>					
							</div>
						</div>	
					</c:forEach>
				</c:if>
		</c:forEach>
</dsp:page>