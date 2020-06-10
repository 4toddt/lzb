<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	
	<img src="${templateItem.heroImage.url}" alt="${templateItem.heroImage.description}"/> <br />
	
	<dsp:getvalueof var="features" value="${templateItem.features}" />
	<c:if test="${not empty features}">
		<c:forEach items="${features}" var="feature">
			&nbsp;> <img src="${feature.image.url}" /> <br />
			&nbsp;> ${feature.subTitle} <br />
			&nbsp;> ${feature.shortDesc} <br />
			&nbsp;> <a href="${feature.linkURL}">${feature.linkText}</a><br /><br />
        </c:forEach>
	</c:if>
</dsp:page>