<dsp:page>
		<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof value="${storeConfig.endecaMediaURL}" var="mediaURL"/>
	
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:if test="${not empty content}">
		<c:if test="${not empty content.link}">
				<%-- Get the URL for the action passed within content item --%>
			<dsp:droplet name="ActionURLDroplet">
				<dsp:param name="action" value="${content.link}" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="actionURL" param="actionURL" />
				</dsp:oparam>
				<dsp:oparam name="empty">
				</dsp:oparam>
			</dsp:droplet>
		</c:if>

		<c:if test ="${not empty content.imageUrl}">

			<c:choose>
				<c:when test="${not empty actionURL and fn:contains(actionURL, 'youtube') or fn:contains(actionURL, 'youtu.be')}">

				<c:url var="url" value="">
					<c:param name="vid" value="${actionURL}" />
					<c:param name="title" value="${content.text}" />
					<c:param name="description" value="" />
				</c:url>

				<a href="/modals/video.jsp${url}" class="video">

				</c:when>

				<c:otherwise>
				<a href="${actionURL}">
				</c:otherwise>
			</c:choose>

			<c:if test ="${not empty content.text}">
				<small>${content.text} </small>				
			</c:if>

				<div class="play"><div class="triangle"></div></div>

			<c:if test="${empty actionURL}">
				<c:set var="actionURL" value="#" />
			</c:if>

			<c:if test ="${not empty content.imageUrl}">
				<img src="${content.imageUrl}" alt="brook shields" />
			</c:if>

		</a>

	</c:if>
	</c:if>
</dsp:page>