<dsp:page>
	<dsp:importbean bean="/atg/repository/seo/ContentItemLink" />
	<dsp:getvalueof var="catId" param="catId" />

	<c:if test="${not empty catId }">
		<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
			<dsp:param name="queryRQL" value="id EQUALS IGNORECASE :catId" />
			<dsp:param name="catId" value="${catId}" />
			<dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository" />
			<dsp:param name="itemDescriptor" value="pageCategory" />
			<dsp:param name="elementName" value="pageCatItem" />
			<dsp:oparam name="output">
				<dsp:getvalueof param="pageCatItem" var="pageCatItem" />
				<dsp:getvalueof param="pageCatItem.categoryPage" var="categoryPage" />
	
				<c:if test="${not empty categoryPage }">
					<li><a href="${contextPath}/content/${empty pageCatItem.seoName?pageCatItem.id:pageCatItem.seoName  }/">${pageCatItem.name } <span class="icon icon-arrow-right"></span></a></li>
				</c:if>
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
</dsp:page>