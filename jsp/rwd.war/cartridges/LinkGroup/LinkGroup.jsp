<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="groupText" value="${contentItem.title}" />
	<c:set var="colorSwatches" value="" />
	<c:if test="${groupText eq 'Color'}">
		<c:set var="colorSwatches" value="color-swatches" />
	</c:if>
	<li>
		<c:if test="${not empty groupText}">
			<strong>${groupText}</strong>
		</c:if>
		<ul class="sub-cat ${colorSwatches}">
		<%-- Render sublinks of header--%>
			<c:if test="${not empty contentItem.subLinks}">
				<c:forEach var="element" items="${contentItem.subLinks}">
					<li class="li-linkgroup"><dsp:renderContentItem contentItem="${element}" /></li>
				</c:forEach>
			</c:if>
		</ul>
	</li>	
</dsp:page>