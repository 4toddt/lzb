<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/endeca/cache/DimensionValueCacheDroplet" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<dsp:getvalueof var="spotligtCat" vartype="com.endeca.infront.navigation.model.DvalSpec" value="${contentItem.SpotLightedCategries}" />
	<fmt:message var="facetSelection" key="facetSelection" />
	<div class="cdp-subtitle">${contentItem.Title}</div>
	<ul class="search-nav">
	<c:forEach var="cat" items="${spotligtCat}">
		<c:if test="${not empty(contentItem.refinements)}">				
			<c:forEach var="refinement" items="${contentItem.refinements}">
			<c:set var="cPath" value="${fn:replace(refinement.contentPath ,'//', '/')}" />
			<li>
				<c:if test="${cat.name eq refinement.label}">
				  <c:choose>
						<c:when test="${not empty refinement.count}">	
							<c:choose>
								<c:when test ="${originatingRequest.isFacet}">
									<a href="${cPath}${refinement.navigationState}"> ${refinement.label}  <span class="refinement-count">(${refinement.count})</span></a>
								</c:when>
								<c:otherwise>
									<a href="${cPath}${refinement.navigationState}${facetSelection}"> ${refinement.label}  <span class="refinement-count">(${refinement.count})</span></a>
								</c:otherwise>
							</c:choose>	
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test ="${originatingRequest.isFacet}">
									<a href="${cPath}${refinement.navigationState}"> ${refinement.label} <span class="refinement-count">(${contentItem.resultsCount})</span></a>
								</c:when>
								<c:otherwise>
									<a href="${cPath}${refinement.navigationState}${facetSelection}"> ${refinement.label} <span class="refinement-count">(${contentItem.resultsCount})</span></a>
								</c:otherwise>
							</c:choose>	
						</c:otherwise>
					</c:choose>
			</c:if>
			</li>
			</c:forEach>
		</c:if>
	</c:forEach>
	</ul>	
</dsp:page>