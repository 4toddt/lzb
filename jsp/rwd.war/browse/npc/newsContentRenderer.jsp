<dsp:page>
	<dsp:getvalueof var="itemId" param="itemId" />

	<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
		<dsp:param name="queryRQL" value="id EQUALS IGNORECASE :itemId" />
		<dsp:param name="repository"
			bean="/com/lzb/repository/content/LZBContentRepository" />
		<dsp:param name="itemDescriptor" value="news" />
		<dsp:param name="elementName" value="newsItem" />
		<dsp:oparam name="output">
				<c:if test="${not empty itemId}">
					News Headline - <dsp:valueof param="newsItem.newsHeadline"/><br/>
					News Date - <dsp:valueof param="newsItem.newsTimestamp" date="MM/dd/yy" /><br/>
					Category - <dsp:valueof param="newsItem.category.name"/><br/>
					News Content - <dsp:valueof param="newsItem.newsContent"/>
				</c:if>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>