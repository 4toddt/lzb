<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:choose>
		<c:when test="${headerType eq 'mobile'}">
			<c:if test="${not empty contentItem.tiles}">
				<c:forEach var="tile" items="${contentItem.tiles}">
					<dsp:renderContentItem contentItem="${tile}"/>
				</c:forEach>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="${not empty contentItem.tiles}">
				<c:forEach var="tile" items="${contentItem.tiles}">
					<dsp:renderContentItem contentItem="${tile}"/>
				</c:forEach>
			</c:if>
		</c:otherwise>
	</c:choose>

</dsp:page>
