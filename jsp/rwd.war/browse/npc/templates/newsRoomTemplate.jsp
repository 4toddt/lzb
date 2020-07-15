<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:getvalueof var="newsCategory" param="newsCategory" />
	<dsp:getvalueof var="year" param="year" />
	<dsp:getvalueof var="howMany" param="howMany" />
	
	<c:if test="${empty howMany}">
		<dsp:getvalueof value="10" var="howMany" />
	</c:if>
	
	<style type="text/css">
		div.atg_store_pagination ul {
			display: inline-flex;
			list-style: none outside none;
		}
	</style>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script>
		$(document).ready(function () {
			var year = new Date().getFullYear();
			while (year >= 2008) {
				$("#year").get(0).options[$("#year").get(0).options.length] = new Option(year, year);
		        year=year-1;
			}
			var selectedCat = $("#hdnNewsCategory").val();
			var selectedYear = $("#hdnYear").val();
			if (selectedCat != "") {
				$("#newsCategory").val(selectedCat);
			}
			if (selectedYear != "") {
				$("#year").val(selectedYear);
			}
		});
	</script>
	<div style="float: left;">
		<form id="sortByYearForm" action="${requestScope['javax.servlet.forward.request_uri']}" method="post">
			<select id="year" name="year" onchange="this.form.submit()">
				<option value="">All Years</option>
			</select>
			<input id="hdnYear" value="${year}" type="hidden" />
			&nbsp;&nbsp;&nbsp;&nbsp;
		</form>
	</div>
	<div style="float: left;">
		<form id="sortByCatForm" action="${requestScope['javax.servlet.forward.request_uri']}" method="post">
		
			<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
			<dsp:param name="queryRQL" value="ALL" />
			<dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository" />
			<dsp:param name="itemDescriptor" value="newsCategory" />
			<dsp:param name="elementName" value="newsCatItem" />
			<dsp:oparam name="outputStart">
				<select id="newsCategory" name="newsCategory" onchange="this.form.submit()">
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
	</div> <br />
	
	<h1>${pageItem.name}</h1>
	<img src="${templateItem.heroImage.url}" alt="${templateItem.captionTitle}" />
	<span>${templateItem.captionContent}</span>
	<dsp:getvalueof var="newss" value="${templateItem.news}" />
	<c:if test="${not empty newss}">
		
		<dsp:droplet name="/com/lzb/droplet/LZBNewsItemSelector">
		<dsp:param name="newsItems" value="${newss}" />
		<dsp:param name="newsCategory" value="${newsCategory}" />
		<dsp:param name="year" value="${year}" />
		<dsp:oparam name="output">
			<br />
			<dsp:getvalueof var="filteredNewsItems" param="filteredNewsItems" />
		 	<dsp:droplet name="/atg/dynamo/droplet/Range">
			<dsp:param name="array" param="filteredNewsItems"/>
			<dsp:param name="howMany" value="${howMany}"/>
			<dsp:param name="start" value="${start}"/>
			<dsp:param name="elementName" value="filteredNewsItem" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="news" param="filteredNewsItem" />
				<dsp:getvalueof var="index" param="index" />
				
				<a href="${pageContext.request.contextPath}/content/About/News/${news.SEOurl}">${news.newsHeadLine}</a> <br />
				News Date : <dsp:valueof value="${news.newsTimestamp}" date="MM/dd/yy" /> <br />
				<dsp:getvalueof var="category" value="${news.category}" />
				News Category : : ${category.name} <br />
							
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
	<dsp:getvalueof var="contacts" value="${templateItem.contacts}" />
	<c:if test="${not empty contacts}">
		<c:forEach items="${contacts}" var="contact">
			<div>
				<p>
					Contact Details  : ${contact.contactDetails} <br />
					Phone Number : ${contact.phoneNumber} <br />
					Email Id : ${contact.emailId}
				</p>
			</div>
        </c:forEach>
	</c:if>
</dsp:page>