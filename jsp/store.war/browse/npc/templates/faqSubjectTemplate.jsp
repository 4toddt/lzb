<dsp:page>
	<dsp:getvalueof param="page" var="childPage" />
	<dsp:getvalueof param="categoryPage" var="categoryPage" />
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />

	<section role="region" class="cust-support" data-template-name="faqSubject">
		<c:choose>
			<c:when test="${not empty topicCategory}">
				<c:forEach var="topicCat" items="${selectedPage.pageTemplate.topicCategories}">
					<c:if test="${topicCategory eq topicCat.seoName}">
						<h1>${topicCat.topicCatName}</h1>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<dsp:include page="/browse/npc/pageTitle.jsp">
					<dsp:param name="pageTitle" value="${pageItem.name}"  />
				</dsp:include>	
			</c:otherwise>
		</c:choose>

		<c:if test="${not empty topicCategory}">
			<c:forEach var="topicCat" items="${selectedPage.pageTemplate.topicCategories}">
				<c:if test="${topicCategory eq topicCat.seoName}">
					<dsp:getvalueof var="seoName" value="${topicCat.seoName}" />
				</c:if>
			</c:forEach>

			<!--  This page needs to be revisited after UI integration Breadcrumbs also needs to be updated -->
			<dsp:getvalueof var="topicCategories" value="${templateItem.topicCategories}" />

			<a href="${pageContext.request.contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName  }/${empty childPage.seoName?childPage.id:childPage.seoName }">Back to FAQs Topics</a>

			<c:if test="${not empty topicCategories}">
				<c:forEach items="${topicCategories}" var="qaTopicCategory">

					<dsp:getvalueof var="topicSubCategories" value="${qaTopicCategory.topicSubCategories}" />
					<c:if test="${not empty topicSubCategories}">
						<c:if test="${seoName eq qaTopicCategory.seoName }">
							<c:forEach items="${topicSubCategories}" var="topicSubCategory">
								<dsp:getvalueof var="questionAnswers" value="${topicSubCategory.questionAnswers}" />
								<c:if test="${not empty questionAnswers}">
									<c:forEach items="${questionAnswers}" var="questionAnswer">
										<div class="prodt-info">
											<p class="prd-qust toggle" data-module="toggle"><a href="#"><dsp:valueof value="${questionAnswer.question}" valueishtml="true"/></a></p>
											<div class="prd-anws">
											<dsp:valueof value="${questionAnswer.answer}" valueishtml="true"/>
											</div>
										</div>
									</c:forEach>
								</c:if>
							</c:forEach>
						</c:if>
					</c:if>
				</c:forEach>
			</c:if>

		</c:if>

		<c:if test="${not empty categoryPage.childPages  && empty topicCategory }">
			<dsp:getvalueof var="topicCategories" value="${templateItem.topicCategories}" />
			<p><dsp:valueof value="${templateItem.introductionText}" valueishtml="true"/></p>
			<div class="faq-list">
				<div class="col">
					<dsp:getvalueof var="topicSubCategories" value="${topicCategory.topicSubCategories}" />
					<c:if test="${not empty topicCategories}">
						<c:forEach items="${topicCategories}" var="topicCategory">
						<ul>
							<li class="faq-category">${topicCategory.topicCatName}</li>
							<dsp:getvalueof var="topicSubCategories" value="${topicCategory.topicSubCategories}" />
							<c:if test="${not empty topicSubCategories}">
								<c:forEach items="${topicSubCategories}" var="topicSubCategory">
									<li>
										<a href="${pageContext.request.contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName  }/${empty childPage.seoName?childPage.id:childPage.seoName }/${topicCategory.seoName}">
											${topicSubCategory.topicSubCatName}
										</a>
									</li>
									<dsp:getvalueof var="questionAnswers" value="${topicSubCategory.questionAnswers}" />
								</c:forEach>
							</c:if>
						</ul>
						</c:forEach>
					</c:if>
				</div>
			</div>
		</c:if>

	</section>
</dsp:page>