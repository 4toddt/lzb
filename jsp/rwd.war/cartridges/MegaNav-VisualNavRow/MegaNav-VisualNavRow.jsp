<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<!-- START OF THE ROW -->
	<c:choose>
		<c:when test="${headerType eq 'mobile'}">
			<li>
			<c:if test="${not empty contentItemTitle}">
				<a class="view-all" href="${actionURLTitleLink}">View All ${contentItemTitle}</a>
			</c:if>
			<c:if test="${not empty contentItem.tiles}">
				<c:forEach var="tile" items="${contentItem.tiles}">
					<dsp:renderContentItem contentItem="${tile}"/>
				</c:forEach>
			</c:if>
			</li>
		</c:when>
	<%-- END OF THE ROW--%>
		<c:otherwise>
			<ul class="row col-5 clearfix">
			<c:if test="${not empty contentItem.tiles}">
				<c:forEach var="tile" items="${contentItem.tiles}">
					<dsp:renderContentItem contentItem="${tile}"/>
				</c:forEach>
			</c:if>
			</ul>
		</c:otherwise>
	</c:choose>	

</dsp:page>
