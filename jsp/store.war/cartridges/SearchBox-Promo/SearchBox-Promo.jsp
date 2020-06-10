<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

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
			<c:url value="/modals/video.jsp" var="modalUrl">
  				<c:param name="vid" value="${contentItem.videoUrl}" />
			</c:url>
			<c:choose>
			<c:when test="${contentItem.isModal}">
			<!-- ${contentItem.isModal} -->
			<li class="category-promo video-link" data-module="cbox" data-transition="elastic"
				data-speed="500" data-class="video-modal" data-width="680"
				data-title="false">
					<a href="${modalUrl}" class="video cboxElement image-link" aria-label="${contentItem.title}" tabindex="0">
						<span class="icon-play"></span>
						<img src="${contentItem.videoImageUrl}" alt="${contentItem.imageAltText}" />
					</a>
				<div class="content">
            		<h4>${contentItem.title}</h4>
            			<p class="small">${contentItem.description}</p>
            			<a href="${actionURLLink}" aria-label="" tabindex="0">${contentItem.linkText}</a>
          		</div>
			</li>
			</c:when>
			<c:otherwise>
			<li class="category-promo video-link">
				<a href="${contentItem.videoUrl}" class="image-link" aria-label="${contentItem.title}" tabindex="0">
					<img src="${contentItem.videoImageUrl}" alt="${contentItem.imageAltText}" />
				</a>
				<div class="content">
            		<h4>${contentItem.title}</h4>
            			<p class="small">${contentItem.description}</p>
            			<a href="${actionURLLink}" aria-label="" tabindex="0">${contentItem.linkText}</a>
          		</div>
			</li>
			</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<li class="category-promo">
				<a href="${actionURLLink}" class="image-link" aria-label="${contentItem.title}" tabindex="0">
					<img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" />
				</a>
				<div class="content">
            		<h4>${contentItem.title}</h4>
            			<p class="small">${contentItem.description}</p>
            			<a href="${actionURLLink}" aria-label="" tabindex="0">${contentItem.linkText}</a>
          		</div>
			</li>
		</c:otherwise>
		</c:choose>

</dsp:page>