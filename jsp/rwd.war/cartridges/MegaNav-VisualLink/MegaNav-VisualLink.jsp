<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
    <dsp:getvalueof var="dealerCountry" bean="Profile.currentStore.country"/>

	<c:choose>
		<c:when test="${dealerCountry eq 'CA' && contentItem.hideForCanada eq true}" >
		</c:when>
		
		<c:otherwise>

	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	<c:choose>
		<c:when test="${not empty contentItem.videoUrl}">
			<c:url value="/sitewide/ajax/videoModal.jsp" var="modalUrl">
  				<c:param name="videoURL" value="${contentItem.videoUrl}" />
			</c:url>
			<c:choose>
			<c:when test="${contentItem.isModal}">
			<!-- ${contentItem.isModal} -->
			<li class="video-link">
					<a href="${modalUrl}" class="video modal-trigger image-link" data-target="modal-video" data-size="medium" aria-label="${contentItem.title}" tabindex="0"><span class="icon-play"></span>
						<img src="${contentItem.videoImageUrl}" alt="${contentItem.imageAltText}" />
					</a>
				 <a	href="${modalUrl}" class="video modal-trigger" data-target="modal-video" data-size="medium" aria-label="${contentItem.title}" tabindex="0">${contentItem.title}</a>
				<p class="small">${contentItem.description}</p>
			</li>
			</c:when>
			<c:otherwise>
			<li class="visual-link"><a href="${contentItem.videoUrl}" class="image-link" aria-label="${contentItem.title}" tabindex="0"><img src="${contentItem.videoImageUrl}" alt="${contentItem.imageAltText}" /></a>
				<a href="${contentItem.videoUrl}" aria-label="${contentItem.title}" tabindex="0">${contentItem.title}</a>
				<p class="small">${contentItem.description}</p>
			</li>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:when test="${(empty contentItem.title) && (empty contentItem.imageUrl) && (empty contentItem.description)}">
			<li class="visual-link no-content"></li>
		</c:when>
		<c:otherwise>				
			<li class="visual-link"><a href="${actionURLLink}" class="image-link" aria-label="${contentItem.title}" tabindex="0"><img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" /></a>
				<a href="${actionURLLink}" aria-label="${contentItem.title}" tabindex="0">${contentItem.title}</a>
				<p class="small">${contentItem.description}</p>
			</li>
		</c:otherwise>
		</c:choose>

	</c:otherwise>
	</c:choose>
			
</dsp:page>