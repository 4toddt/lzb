<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	
	nonproduct way finding Hero Images : <img src="${templateItem.heroImage.url}" /> <br/>
	Hero Caption : ${templateItem.heroCaption}<br/>
	<dsp:getvalueof var="features" value="${templateItem.features}" />
	<c:if test="${not empty features}">
		<c:forEach items="${features}" var="feature">
			Feature Image : <img src="${feature.image.url}" /> <br/>
			Feature Subtitle : ${feature.subTitle} <br/>
			Feature Content : ${feature.contentBlock} 
		</c:forEach>
	</c:if>
</dsp:page>