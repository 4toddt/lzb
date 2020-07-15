<dsp:page>

	<dsp:importbean bean="/atg/multisite/Site"/>
	<dsp:importbean bean="/atg/repository/seo/ContentItemLink" />

	<dsp:getvalueof param="selectedPage" var="selectedPage" scope="request" />
	<dsp:getvalueof param="categoryPage" var="categoryPage" />
	<dsp:getvalueof param="topicCategory" var="topicCategory" scope="request" />
	<dsp:getvalueof var="contextPath" bean="Site.contextRoot"/>

	<dsp:include page="/includes/webtrendsContent.jsp">
		<dsp:param name="page" value="${categoryPage.name}"  />
	</dsp:include>

	<nav aria-label="breadcrumb" role="navigation" class="breadcrumb-wrapper">
		<ul>
			<li><a href="${contextPath}">Home</a></li>
			<c:choose>
				<c:when test="${not empty selectedPage && not empty categoryPage.childPages}">
					<li><a href="${pageContext.request.contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName}/">${categoryPage.name}</a></li>
				</c:when>
				<c:otherwise>
					<li>${categoryPage.name}</li>
				</c:otherwise>
			</c:choose>
			<c:if test="${not empty categoryPage.childPages}">
				<c:forEach items="${categoryPage.childPages}" var="childPage">
					<c:if test="${selectedPage eq childPage}">
						<li>${childPage.name}</li>
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${not empty topicCategory}">
				<c:forEach var="topicCat" items="${selectedPage.pageTemplate.topicCategories}">
					<c:if test="${topicCategory eq topicCat.seoName}">
						<li>${topicCat.topicCatName}</li>
					</c:if>
				</c:forEach>
			</c:if>
		</ul>
	</nav>

</dsp:page>
