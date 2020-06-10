<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
    <div class="pdp-block-container why-lzb" data-anchor="whyLZB">
      <h3 class="section-heading">${content.title}</h3>
		<div class="pdp-block">
		<div>
		  <div class="carousel">
          <ul>
            <c:forEach var="tile" items="${content.tiles}" varStatus="status">
				<li><dsp:renderContentItem contentItem="${tile}" /></li>
			</c:forEach>
          </ul>
	        </div>
	        <div class="copy">
	            <h3>${content.paragraphHeading}</h3>
	            <p>${content.paragraph}</p>
	        </div>
		</div>
		<c:if test="${not empty content.videoURL || not empty content.imageURL}">
   	  	<c:choose>
			<c:when test="${not empty content.videoURL}">
				<c:url value="/modals/video.jsp" var="modalUrl">
 					<c:param name="vid" value="${content.videoURL}" />
				</c:url>
				<c:choose>
					<c:when test="${content.isModal}">
						<div class="content-right video-link" data-module="cbox" data-transition="elastic" data-speed="500" data-class="video-modal" data-width="680" data-title="false">
							<a href="${modalUrl}" class="video cboxElement" aria-label="${content.title}" tabindex="0">
								<span class="icon-play"></span>
								<img src="${content.videoThumbnailURL}" alt="${content.imageAlt}" />
							</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="content-right video-link">
							<a href="${content.videoURL}" aria-label="${content.title}" tabindex="0">
								<span class="icon-play"></span>
								<img src="${content.videoThumbnailURL}" alt="${content.imageAlt}" />
							</a>
						</div>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<div class="content-right">
					<img src="${content.imageURL}" alt="${content.imageAlt}"/>
				</div>
			</c:otherwise>
		</c:choose>
		</c:if>
		</div>
    </div>
</dsp:page>