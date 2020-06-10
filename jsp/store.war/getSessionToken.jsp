<dsp:page>
	<dsp:getvalueof param="jsonpcallback" var="jsonpcallback"/>
	<c:catch var="Exc">
	${jsonpcallback}({"pipelinesessionid":"${pageContext.session.id}", "jsessionid":"${pageContext.session.id}"});
	</c:catch>
	<c:if test="${not empty Exc}">
	${jsonpcallback}({"pipelinesessionid" : "", "jsessionid":""});
	</c:if>
</dsp:page>