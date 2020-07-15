<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:getvalueof var="newsCategory" param="newsCategory" />
	<dsp:getvalueof var="year" param="year" />
	<dsp:getvalueof var="howMany" param="howMany" />
	
	<c:if test="${empty howMany}">
		<dsp:getvalueof value="10" var="howMany" />
	</c:if>	

	<section role="region" class="cust-support" data-template-name="newsRoomTemplate" data-module="news-room">

		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>			

		<img src="${templateItem.heroImage.url}" alt="${templateItem.captionTitle}" />

		<c:if test="${not empty templateItem.captionContent}">
		<p><dsp:valueof value="${templateItem.captionContent}" valueishtml="true"/></p>
		</c:if>

		<form id="sortByYearForm" action="${requestScope['javax.servlet.forward.request_uri']}" method="post">
			<select id="year" name="year">
				<option value="">All Years</option>
			</select>
			<input id="hdnYear" value="${year}" type="hidden" />
		</form>

		<form id="sortByCatForm" action="${requestScope['javax.servlet.forward.request_uri']}" method="post">
		
			<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
			<dsp:param name="queryRQL" value="ALL" />
			<dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository" />
			<dsp:param name="itemDescriptor" value="newsCategory" />
			<dsp:param name="elementName" value="newsCatItem" />
			<dsp:oparam name="outputStart">
				<select id="newsCategory" name="newsCategory">
					<option value="">All Categories</option>
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="displayName" param="newsCatItem.name" />
				<option value="${displayName}">${displayName}</option>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				</select>
			</dsp:oparam>
			</dsp:droplet>
			
			<input id="hdnNewsCategory" value="${newsCategory}" type="hidden" />
		</form>

		<div class="news-articles">

			<dsp:getvalueof var="newss" value="${templateItem.news}" />

	<c:if test="${not empty newss}">

		<dsp:droplet name="/com/lzb/droplet/LZBNewsItemSelector">
		<dsp:param name="newsItems" value="${newss}" />
		<dsp:param name="newsCategory" value="${newsCategory}" />
		<dsp:param name="year" value="${year}" />
		<dsp:oparam name="output">

			<dsp:getvalueof var="filteredNewsItems" param="filteredNewsItems" />
		 	<dsp:droplet name="/atg/dynamo/droplet/Range">
			<dsp:param name="array" param="filteredNewsItems"/>
			<dsp:param name="howMany" value="${howMany}"/>
			<dsp:param name="start" value="${start}"/>
			<dsp:param name="elementName" value="filteredNewsItem" />
			<dsp:oparam name="output">

				<dsp:getvalueof var="news" param="filteredNewsItem" />
				<dsp:getvalueof var="index" param="index" />

				<article>
				<h2><a href="${pageContext.request.contextPath}${storeConfig.newsContentPath}${news.contentUrl}">${news.newsHeadLine}</a></h2>
					<p>News Date: <time><dsp:valueof value="${news.newsTimestamp}" date="MM/dd/yy" /></time></p>
					<dsp:getvalueof var="category" value="${news.category}" />
					<p>News Category: ${category.name}</p>

				</article>
 
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				
					<dsp:include page="/includes/global/contentPagination.jsp">
						<dsp:param name="arraySplitSize" value="${howMany}"/>
						<dsp:param name="size" param="size"/>
						<dsp:param name="start" value="${start}"/>
						<dsp:param name="top" value="${true}"/>
						<c:choose>
							<c:when test="${not empty newsCategory}">
								<dsp:param name="paramName" value="newsCategory"/>
								<dsp:param name="paramValue" value="${newsCategory}"/>
							</c:when>
							<c:when test="${not empty year}">
								<dsp:param name="paramName" value="year"/>
								<dsp:param name="paramValue" value="${year}"/>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</dsp:include>
				
			</dsp:oparam>
			</dsp:droplet>
		</dsp:oparam>

			<dsp:oparam name="empty">

				<p>No news found for selected filter.</p>

			</dsp:oparam>

		</dsp:droplet>
		
	</c:if>

		</div>

		<aside class="news-aside">

			<dsp:getvalueof var="contacts" value="${templateItem.contacts}" />

			<c:if test="${not empty contacts}">

				<c:forEach items="${contacts}" var="contact">

				<div class="vcard">

					<span class="fn n"><dsp:valueof value="${contact.contactDetails}" valueishtml="true"/></span>
					
					<a class="email" href="mailto:${contact.emailId}">${contact.emailId}</a>

					<a href="tel:${contact.phoneNumber}">${contact.phoneNumber}</a>

				</div>

		        </c:forEach>

			</c:if>

			</aside>

	</section>

</dsp:page>
