<dsp:page>

	<dsp:getvalueof var="catId" param="catId" />
	<dsp:getvalueof var="pageId" param="pageId" />
	
	
	<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
		<dsp:param name="queryRQL" value="id EQUALS IGNORECASE :catId" />
		<dsp:param name="catId" value="${catId}" />
		<dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository" />
		<dsp:param name="itemDescriptor" value="pageCategory" />
		<dsp:param name="elementName" value="pageCatItem" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="templateName" param="pageCatItem.categoryPage.pageTemplate.templateName" />
      <dsp:getvalueof var="pageTemplate" param="pageCatItem.categoryPage.pageTemplate" />
			<dsp:getvalueof var="title123" param="pageCatItem.categoryPage.name" />
			<dsp:getvalueof var="description" param="pageCatItem.categoryPage.description" />
			<dsp:getvalueof var="pageCatItem" param="pageCatItem" />
		</dsp:oparam>
	</dsp:droplet>

	<c:choose>
    <c:when test="${templateName eq 'wiredTemplate'}">
      <c:set var="showLeftNav" value="${pageTemplate.showLeftNav}" />
    </c:when>
    <c:otherwise>
      <c:set var="showLeftNav" value="true" />
    </c:otherwise>
  </c:choose>
  
	<c:choose>
		<c:when test="${ not empty pageId}">
			<c:set var="SEOKey" value="${ pageId }" />
		</c:when>
		<c:when test="${ not empty pageCatItem.id}">
			<c:set var="SEOKey" value="${ pageCatItem.id }" />
		</c:when>
	</c:choose>

	<!-- SEO Key : NPC_${SEOKey} -->
	<dsp:include page="/includes/SEOTagData.jsp">
		<dsp:param name="paramKeyForSEOTagData" value="NPC_${SEOKey}"/>
	</dsp:include>

	<dsp:getvalueof value="${pageCatItem.childPages}" var="childPages" />

	<c:if test="${not empty childPages and not empty pageId}">
			<c:forEach items="${childPages}" var="childPage">
				<c:if test="${fn:containsIgnoreCase(childPage.id, pageId)}">
				<c:set var="currentChildPageItem" value="${childPage}" scope="request"/>
				</c:if>
			</c:forEach>
			</c:if>

	<lzb:pageContainer>

		<jsp:attribute name="bodyClass">
			<c:choose>
		 		<c:when test="${templateName eq 'wiredTemplate'}">
	 			two-column-first npc
		 		</c:when>
				<c:otherwise>
				two-column-first npc
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="title">
			<c:choose>
				<c:when test="${not empty sEOTagTitle}">
					${sEOTagTitle}
				</c:when>
				<c:when test="${empty pageId}">
				<c:if test="${not empty title123}">
					${title123}
				</c:if>
				</c:when>
				<c:otherwise>
				<c:if test="${not empty currentChildPageItem.name}">
					${currentChildPageItem.name}
				</c:if>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty sEOMetaTagDescription }">
					${sEOMetaTagDescription}
				</c:when>
				<c:when test="${empty pageId}">
					<c:if test="${not empty description}">
					${description}
					</c:if>
				</c:when>
				<c:otherwise>
				<c:if test="${not empty currentChildPageItem.description}">
					${currentChildPageItem.description}
				</c:if>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>

		<jsp:attribute name="metaKeywords">
			<c:choose>
				<c:when test="${not empty sEOKeywords }">
					${sEOKeywords}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.metaKeywords" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${requestScope['javax.servlet.forward.request_uri']}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${requestScope['javax.servlet.forward.request_uri']}</jsp:attribute>

		<jsp:body>
						<c:choose>
							<c:when test="${empty pageId}">
								<dsp:getvalueof value="${pageCatItem.categoryPage}" var="categoryPage" />
								<dsp:include page="contentBreadCrumb.jsp">
									<dsp:param name="categoryPage" value="${pageCatItem}" />
									<dsp:param name="selectedPage" value="${childPage }" />
								</dsp:include>

	 							<main role="main">
	 								<c:if test="${templateName ne 'fullBlankTemplate' and showLeftNav!=false}">
	 									<dsp:include page="leftRail.jsp">
											<dsp:param name="categoryPage" value="${pageCatItem}" />
										</dsp:include>
	 								</c:if>

									<dsp:include page="templateSelector.jsp">
										<dsp:param name="page" value="${categoryPage}" />
									</dsp:include>

							</c:when>
							<c:otherwise>
								<dsp:getvalueof value="${pageCatItem.childPages}" var="childPages" />
								<c:if test="${not empty childPages}">
									<c:forEach items="${childPages}" var="childPage">

										<dsp:getvalueof var="templateName" value="${childPage.pageTemplate.templateName}" />

										<c:if test="${fn:containsIgnoreCase(childPage.id, pageId)}">
											<dsp:include page="contentBreadCrumb.jsp">
												<dsp:param name="categoryPage" value="${pageCatItem}" />
												<dsp:param name="selectedPage" value="${childPage }" />
											</dsp:include>

											<main role="main">
											
											<c:if test="${templateName eq 'wiredTemplate'}">
												<c:set var="showLeftNav" value="${childPage.pageTemplate.showLeftNav}" />
											</c:if>

											<c:if test="${templateName ne 'fullBlankTemplate' and showLeftNav!=false}">
												<dsp:include page="leftRail.jsp">
													<dsp:param name="categoryPage" value="${pageCatItem}" />
													<dsp:param name="selectedPage" value="${childPage }" />
												</dsp:include>
											</c:if>



											<dsp:include page="templateSelector.jsp">
												<dsp:param name="page" value="${childPage}" />
												<dsp:param name="categoryPage" value="${pageCatItem}" />
												<dsp:param name="showLeftNav" value="${showLeftNav}" />
											</dsp:include>

										</c:if>
									</c:forEach>
								</c:if>
							</c:otherwise>
						</c:choose>
			</main>
		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
