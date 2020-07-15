<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:choose>
		<c:when test="${not empty content.contents}">
			<c:forEach items="${content.contents}" var="element">
				<c:choose>
				  <c:when test="${element['@type'] eq 'MainContentResultListPromo'}">
			  		 <c:set var="mainContentResultListPromo" value="${element}" scope="request"/>
	  			  </c:when>
				  <c:otherwise>
					 <dsp:renderContentItem contentItem="${element}" />
				  </c:otherwise>
				 </c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<dsp:droplet name="InvokeAssembler">
				<dsp:param name="contentCollection" value="${content.contentCollection}" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="contentSlot" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				</dsp:oparam>
			</dsp:droplet>
			<c:if test="${not empty contentSlot.contents}">
				<c:forEach items="${contentSlot.contents}" var="element">
					<dsp:renderContentItem contentItem="${element}" />
				</c:forEach>
			</c:if>
		</c:otherwise>
	</c:choose>
</dsp:page>