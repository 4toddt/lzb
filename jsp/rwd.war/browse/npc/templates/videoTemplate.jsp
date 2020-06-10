<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="videos" value="${templateItem.videos}" />
	Hero Images : <img src="${templateItem.heroImage.url}" /> <br/>
	Hero Image Title : ${templateItem.imageTitle}<br/>
	Hero Image Content : ${templateItem.heroImageContent}<br />
	<c:if test="${not empty videos}">
		<c:forEach items="${videos}" var="video">
				Video Title : ${video.videoTitle} <br />
				<dsp:getvalueof var="tags" value="${video.tags}" />
				<c:if test="${not empty tags}">
					<c:forEach items="${tags}" var="tag">
							Video Tag : ${tag}&nbsp;
					</c:forEach>
				</c:if>
		</c:forEach>
	</c:if>
</dsp:page>