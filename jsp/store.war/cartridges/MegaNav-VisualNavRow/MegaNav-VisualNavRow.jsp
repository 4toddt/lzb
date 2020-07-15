<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<!-- START OF THE ROW -->
	
		<ul class="row col-5 clearfix">
		<c:if test="${not empty contentItem.tiles}">
			<c:forEach var="tile" items="${contentItem.tiles}">
				<dsp:renderContentItem contentItem="${tile}"/>
			</c:forEach>
		</c:if>
		</ul>
	<!-- END OF THE ROW -->

</dsp:page>