<dsp:page>
	<dsp:getvalueof param="page" var="childPage" />
	<dsp:getvalueof param="categoryPage" var="categoryPage" />
	<dsp:getvalueof var="templateItem" param="templateItem" />
	
	${templateItem.introductionText} <br />

	<!--  This page needs to be revisited after UI integration
		Breadcrumbs also needs to be updated -->

	<dsp:getvalueof var="topicCategories"
		value="${templateItem.topicCategories}" />
	<c:if test="${not empty topicCategories}">
		<c:forEach items="${topicCategories}" var="topicCategory">
			&nbsp;> <a
				href="${contextPath}/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName  }/${empty childPage.seoName?childPage.id:childPage.seoName }/${topicCategory.seoName}">${topicCategory.topicCatName}
			</a>
			<br />
			<dsp:getvalueof var="topicSubCategories"
				value="${topicCategory.topicSubCategories}" />

			<c:if test="${not empty topicSubCategories}">
				<c:forEach items="${topicSubCategories}" var="topicSubCategory">
					&nbsp;&nbsp;&nbsp;- ${topicSubCategory.topicSubCatName} <br />
					<dsp:getvalueof var="questionAnswers"
						value="${topicSubCategory.questionAnswers}" />
					<c:if test="${not empty questionAnswers}">
						<c:forEach items="${questionAnswers}" var="questionAnswer">
							<b>Q.</b>&nbsp;${questionAnswer.question} <br />
							<b>A.</b>&nbsp;${questionAnswer.answer} <br />
						</c:forEach>
					</c:if>
				</c:forEach>
			</c:if>
		</c:forEach>
	</c:if>
</dsp:page>