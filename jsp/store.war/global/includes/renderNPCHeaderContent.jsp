<dsp:page>
	<dsp:importbean bean="/atg/repository/seo/ContentItemLink" />
	<dsp:getvalueof var="catId" param="catId" />
	<dsp:getvalueof var="ulClass" param="ulClass" />
	<dsp:getvalueof var="subarea" param="subarea" />
	<dsp:getvalueof var="listClass" param="listClass" />
	
	<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
		<dsp:param name="queryRQL" value="id EQUALS IGNORECASE :catId" />
		<dsp:param name="catId" value="${catId}" />
		<dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository" />
		<dsp:param name="itemDescriptor" value="pageCategory" />
		<dsp:param name="elementName" value="pageCatItem" />

		<dsp:oparam name="output">

			<c:if test="${not empty catId}">
				<dsp:getvalueof param="pageCatItem" var="pageCatItem" />
				<dsp:getvalueof param="pageCatItem.categoryPage" var="categoryPage" />
				<dsp:getvalueof param="pageCatItem.childPages" var="childPages" />

				<c:if test="${not empty categoryPage }">

				<ul class="${listClass}">
					<li data-subarea="${subarea}">
						<a href="/content/${empty pageCatItem.seoName?pageCatItem.id:pageCatItem.seoName  }" tabindex="0">${pageCatItem.name }</a>
					</li>
					<c:if test="${not empty childPages}">
					<c:forEach items="${childPages}" var="childPage">
					<li data-subarea="${subarea}">
					<c:if test="${selectedPage eq childPage }">
					<strong>
					</c:if>
						<a href="/content/${empty categoryPage.seoName?categoryPage.id:categoryPage.seoName  }/${empty childPage.seoName?childPage.id:childPage.seoName }" class="triangle-forwards" tabindex="0">${childPage.name }</a>
					<c:if test="${selectedPage eq childPage }">
					</strong>
					</c:if>
					</li>
					</c:forEach>
					</c:if>
				</ul>
				</c:if>
			</c:if>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>