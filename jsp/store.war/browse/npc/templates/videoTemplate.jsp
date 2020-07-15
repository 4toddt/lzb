<dsp:page>
	<dsp:getvalueof var="videoTag" param="videoTag" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
 <script type="text/javascript">
function selectedTag(obj){
	 var tag = $(obj).attr("data-tag");
	 console.log("tag="+tag);
	 $("#videoTag").val(tag);
	$("#sortByCatForm").submit();
	 
	
}
</script>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="videos" value="${templateItem.videos}" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:importbean bean="/com/lzb/droplet/LZBVideoItemSelector" />
<section role="region" class="cust-support" data-template-name="video">

		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<img src="${templateItem.heroImage.url}" alt="${templateItem.imageTitle}" />
		<h2>${templateItem.imageTitle}</h2>
		<p><dsp:valueof value="${templateItem.heroImageContent}" valueishtml="true"/></p>
		<form id="sortByCatForm" class="sort-by-cat-form" name="sortByCatForm" action="${requestScope['javax.servlet.forward.request_uri']}" method="post">
<dsp:droplet name="LZBVideoItemSelector">
	<dsp:param name="videoItems" value="${videos}" />
	<dsp:param name="videoTag" param="videoTag" />
	<dsp:param name="tagDropDownRequest" value="false" />
	<dsp:oparam name="output">
	<dsp:getvalueof var="tags" param="tags" />
	<dsp:getvalueof var="videos" param="filteredVideoItems" />
	</dsp:oparam>
	<dsp:oparam name="empty">
	<dsp:getvalueof var="tags" param="tags" />
	</dsp:oparam>
</dsp:droplet>

	<select id="videoTag" name="videoTag" onchange="this.form.submit()" >
	<option value="">Select Tags</option>
		<c:forEach items="${tags}" var="tag">
		<c:choose>
		<c:when test="${videoTag eq tag}">
			<option value="${tag}" selected="selected">${tag}</option>
		</c:when>
		<c:otherwise>
		<option value="${tag}">${tag}</option>
		</c:otherwise>
		</c:choose>
		</c:forEach>
	</select>	
</form>
		<c:if test="${not empty videos}">
		<div class="cust-contant video-list" data-module="cbox">
				<c:forEach items="${videos}" var="video">
				
					<%-- <img src="${video.image.url}"/> --%>
					<div class="hme-design">
						<div class="laz-careimg">

				<c:choose>

					<c:when test="${fn:contains(video.videoUrl, 'youtube') or fn:contains(video.videoUrl, 'youtu.be')}">
							<a href="${video.videoUrl}" class="youtube" aria-link="video link"><img src="${video.image.url}" alt="${video.image.description}" /></a>
					</c:when>

					<c:otherwise>
							<a href="${video.videoUrl}" aria-link="video link"><img src="${video.image.url}" alt="${video.image.description}" /></a>
					</c:otherwise>

				</c:choose>

						</div>
						<h3>${video.videoTitle}</h3>
						<dsp:getvalueof var="tags" value="${video.tags}" />
						<c:if test="${not empty tags}">
							<ul>
								<c:forEach items="${tags}" var="tag">
									<li><a href="#" onclick="selectedTag(this)" data-tag="${tag}" aria-link="tag link">${tag}</a></li>
								</c:forEach>
							</ul>
						</c:if>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</section>
</dsp:page>