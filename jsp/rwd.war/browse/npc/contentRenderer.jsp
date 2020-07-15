<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach"/>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="catId" param="catId" />
	<dsp:getvalueof var="pageId" param="pageId" />
	
	<dsp:droplet name="RQLQueryForEach">
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
		<c:when test="${ not empty pageId}">
			<c:set var="SEOKey" value="${ pageId }" />
		</c:when>
		<c:when test="${ not empty pageCatItem.id}">
			<c:set var="SEOKey" value="${ pageCatItem.id }" />
		</c:when>
	</c:choose>
	
	<!-- SEO Key : NPC_${SEOKey} -->
	<dsp:include page="/sitewide/includes/SEOTagData.jsp">
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
	
	<c:choose>
		<c:when test="${not empty sEOTagTitle}">
			<c:set var="pageTitle" value="${sEOTagTitle}" />
		</c:when>
		<c:when test="${empty pageId and not empty title123}">
			<c:set var="pageTitle" value="${title123}" />
		</c:when>
		<c:otherwise>
			<c:if test="${not empty currentChildPageItem.name}">
				<c:set var="pageTitle" value="${currentChildPageItem.name}" />
			</c:if>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when test="${not empty sEOMetaTagDescription }">
			<c:set var="metaDescription" value="${sEOMetaTagDescription}" />
		</c:when>
		<c:when test="${empty pageId and not empty description}">
			<c:set var="metaDescription" value="${description}" />
		</c:when>
		<c:otherwise>
			<c:if test="${not empty currentChildPageItem.description}">
				<c:set var="metaDescription" value="${currentChildPageItem.description}" />
			</c:if>
		</c:otherwise>
	</c:choose>
			
	<c:choose>
		<c:when test="${not empty sEOKeywords }">
			<c:set var="metaKeywords" value="${sEOKeywords}" />
		</c:when>
		<c:otherwise>
			<c:set var="metaKeywords" value="" />
		</c:otherwise>
	</c:choose>

	<layout:default>
		<jsp:attribute name="pageTitle">${pageTitle}</jsp:attribute>
		<jsp:attribute name="metaDescription">${metaDescription}</jsp:attribute>
		<jsp:attribute name="metaKeywords">${metaKeywords}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${requestScope['javax.servlet.forward.request_uri']}</jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content npc mobile-site</jsp:attribute>
		<jsp:attribute name="analyticsPageType">staticContentPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">
			<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
		</jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
			<c:choose>
				<c:when test="${empty pageId}">
					<dsp:getvalueof value="${pageCatItem.categoryPage}" var="categoryPage" />
					<%-- breadcrumbs --%>
					<section class="breadcrumbs" aria-label="breadcrumb" role="navigation">
						<dsp:include page="contentBreadCrumb.jsp">
							<dsp:param name="categoryPage" value="${pageCatItem}" />
							<dsp:param name="selectedPage" value="${childPage }" />
						</dsp:include>
					</section>
					
					<%-- title  --%>
					<c:if test="${not empty categoryPage.name}">
						<div class="section-title">
							<dsp:include page="/browse/npc/pageTitle.jsp">
								<dsp:param name="pageTitle" value="${categoryPage.name}"  />
							</dsp:include>	
						</div>
					</c:if>
					
					<%-- content container--%>
					<div class="section-row" role="main">
						<div class="section-content">
							<dsp:include page="templateSelector.jsp">
								<dsp:param name="page" value="${categoryPage}" />
							</dsp:include>
						</div>
					</div>
						
				</c:when>
				<c:otherwise>
					<dsp:getvalueof value="${pageCatItem.childPages}" var="childPages" />
					<c:if test="${not empty childPages}">
						<c:forEach items="${childPages}" var="childPage">

							<%-- set class names based on page --%>
							<c:choose>
								<c:when test="${childPage.name == 'Cover Search'}">
									<c:set var="titleClass" value="section-title--coverSearch" />
									<c:set var="contentClass" value="section-content--coverSearch" />
								</c:when>
								<c:otherwise>
									<c:set var="titleClass" value="section-title--genericPage" />
									<c:set var="contentClass" value="section-content--genericPage" />
								</c:otherwise>
							</c:choose>
							
							<dsp:getvalueof var="templateName" value="${childPage.pageTemplate.templateName}" />
							<c:if test="${fn:containsIgnoreCase(childPage.id, pageId)}">
								<%-- breadcrumbs --%>
								<section class="breadcrumbs">
									<dsp:include page="contentBreadCrumb.jsp">
										<dsp:param name="categoryPage" value="${pageCatItem}" />
										<dsp:param name="selectedPage" value="${childPage}" />
									</dsp:include>
								</section>
								<%-- title  --%>
								<c:if test="${not empty childPage.name && childPage.name != 'Catalogs'}">
									<div class="section-title ${titleClass}">
										<dsp:include page="/browse/npc/pageTitle.jsp">
											<dsp:param name="pageTitle" value="${childPage.name}"  />
										</dsp:include>	
									</div>
								</c:if>
								
								<div class="section-row" role="main">
									<div class="section-content ${contentClass}">
										<dsp:include page="templateSelector.jsp">
											<dsp:param name="page" value="${childPage}" />
											<dsp:param name="categoryPage" value="${pageCatItem}" />
										</dsp:include>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</c:if>
				</c:otherwise>
			</c:choose>
		</jsp:body>
	</layout:default>
</dsp:page>