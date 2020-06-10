<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content"
		vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />

		<!-- RichTextMain :  ${content.name } : ${hideCDPSEOContent} -->
		<c:choose>
			<%--
			   Below condition added to display SEO content on the bottom of the browse page if there is no
				filter applied. If there is a filter applied then don't show SEO Content
			 --%>
			<c:when test="${  not empty content.name and fn:startsWith(content.name,'CDP_SEO_CONTENT') }">
				<c:if test="${empty hideCDPSEOContent }" >
					<div class="seo-content">
				 		<c:if test="${not empty content.content}">${content.content}</c:if>
					</div>
			 	</c:if>
			</c:when>
			<c:otherwise>
					<div class="seo-content">
						<c:if test="${not empty content.content}">${content.content}</c:if>
					</div>
			</c:otherwise>
		</c:choose>

</dsp:page>