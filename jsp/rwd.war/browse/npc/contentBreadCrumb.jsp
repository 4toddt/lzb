<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/atg/repository/seo/ContentItemLink" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof param="selectedPage" var="selectedPage" scope="request"/>
	<dsp:getvalueof param="categoryPage" var="categoryPage" />
	<dsp:getvalueof param="topicCategory" var="topicCategory" scope="request"/>
	
	<dsp:include page="/sitewide/includes/webtrendsContent.jsp">
		<dsp:param name="page" value="${categoryPage.name}"  />
	</dsp:include>
	
	<ul class="breadcrumb">
		<%-- <a itemprop="url" title="Home" href="${contextPath}">Home</a> --%>
		<li><a href="${contextPath}" class="crumb" itemprop="url"><fmt:message key="breadcrumb.home"/></a></li>
		<c:choose>
			<c:when test="${not empty selectedPage && not empty categoryPage.childPages}">
				<li><a class="crumb" href="${contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName }/">${categoryPage.name }</a></li>
			</c:when>
			<c:otherwise>
				<li><span class="crumb active">${categoryPage.name }</span></li>
			</c:otherwise>
		</c:choose>
		<c:if test="${not empty categoryPage.childPages }">
			<c:forEach items="${categoryPage.childPages }" var="childPage">
				<c:if test="${selectedPage eq childPage }">
					<li><span class="crumb active">${childPage.name }</span></li>
				</c:if>
			</c:forEach>
		</c:if>
		<c:if test="${not empty topicCategory}">
			<li><span class="crumb active">
				<c:forEach var="topicCat" items="${selectedPage.pageTemplate.topicCategories}">
					<c:if test="${topicCategory eq topicCat.seoName}">
						${topicCat.topicCatName}
					</c:if>
				</c:forEach>
			</span></li>
		</c:if>
	</ul>
</dsp:page>