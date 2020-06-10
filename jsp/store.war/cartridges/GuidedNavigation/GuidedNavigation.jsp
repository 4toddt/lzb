<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />
		<%-- <c:if test="${not empty contentItem.navigation}"> --%>
			<!-- <div class="cdp-title" data-module="cdp-refinement">Narrow by -->


				<c:if test="${not empty selectedBreadcrumbs.clearAll}">
					<a href="${selectedBreadcrumbs.clearAll}">Clear All</a>
				</c:if>
			</div>
		<%-- </c:if> --%>

		<c:if test="${not empty selectedBreadcrumbs &&  not empty selectedBreadcrumbs.breadcrumbsMap}">
		     <%-- hideCDPSEOContent variable added to handle CDP page SEO content display  --%>
			<c:set var="hideCDPSEOContent" value="true" scope="request" />

			<%--
			Selected Refinements

				<c:if test="${not empty selectedBreadcrumbs.clearAll}">
					<a href="${contextPath}${selectedBreadcrumbs.clearAll}">
					 Clear All
					</a>
				</c:if>
			--%>

			<!-- *** APPLIED FACETS *** -->
			<div class="cdp-selected-facets">
				<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
					<div class="applied-facet-tile"><fmt:message key="facet.${breadCrumb.key}"/></div>
					<ul>
					<c:forEach items="${breadCrumb.value}" var="refinement">
							<c:set var="cPath" value="${fn:replace(refinement.removeAction.contentPath ,'//', '/')}" />
							<c:choose>
								<c:when test="${breadCrumb.key eq 'sku.covers'}">
									<c:set var="colorArr" value="${fn:split(refinement.label,'~')}" />
									<li class="applied-facet-tile"><dsp:a href="${cPath}${refinement.removeAction.navigationState}">
										${colorArr[1]}
									</dsp:a></li>
								</c:when>
								<c:otherwise>
									<li class="applied-facet-tile">
									<dsp:a  href="${cPath}${refinement.removeAction.navigationState}">
										${refinement.label}<span>&nbsp;x&nbsp;</span>
									</dsp:a></li>
								</c:otherwise>
							</c:choose>
					</c:forEach>
					</ul>
				</c:forEach>
			</div><%-- .cdp-selected-facets --%>
		</c:if>

		<c:forEach var="element" items="${contentItem.navigation}">
			<dsp:renderContentItem contentItem="${element}"/>
		</c:forEach>

		<dsp:include page="/cdp/gadgets/displayPreferredStore.jsp"/>

		<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />
		<dsp:include page="/storecontent/umbracoCategoryListPage.jsp">
			<dsp:param name="dealerId" value="${dealerId }" />
		</dsp:include>

</dsp:page>