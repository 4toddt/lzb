<dsp:page>
<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler"/>
	<section role="region" class="cust-support" data-template-name="features">
		<div class="cust-contant">
			<dsp:getvalueof var="templateItem" param="templateItem" />
			<dsp:getvalueof var="pageItem" param="page" />

	<c:choose>
			<c:when test="${pageItem.seoName eq 'ViewOurTVAds'}">
				 <dsp:droplet name="InvokeAssembler">
                 	<dsp:param name="includePath" value="/content/Shared/Static/NowFeaturing/ViewOurTVAds"/>
                        <dsp:oparam name="output">
                                    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem"/>
                        </dsp:oparam>
            	</dsp:droplet>
            
           		 <c:choose>
                        <c:when test="${not empty contentItem}">
                                    <dsp:renderContentItem contentItem="${contentItem}" />
                        </c:when>
                        <c:otherwise>
                                    <b>Content Empty</b>
                        </c:otherwise>
           		 </c:choose>
			
			</c:when>
			<c:when test="${pageItem.seoName eq 'ViewOurPrintAds'}">

				 <dsp:droplet name="InvokeAssembler">
                 <dsp:param name="includePath" value="/content/Shared/Static/NowFeaturing/ViewOurPrintAds"/>
                        <dsp:oparam name="output">
                                    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem"/>
                        </dsp:oparam>
           		 </dsp:droplet>
            
           		 <c:choose>
                        <c:when test="${not empty contentItem}">
                                    <dsp:renderContentItem contentItem="${contentItem}" /> 
                        </c:when>
                        <c:otherwise>
                                    <b>Content Empty</b>
                        </c:otherwise>
            	</c:choose>
			
			
			</c:when>
			
			<c:otherwise>
			
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>	
			<img src="${templateItem.heroImage.url}" alt="${ templateItem.heroImage.description }"/>

			<dsp:getvalueof var="features" value="${templateItem.features}" />

			<c:if test="${not empty features}">

				<c:forEach items="${features}" var="feature">

					<div class="hme-design" data-module="cbox" data-transition="elastic" data-speed="500" data-class="video-modal" data-width="680" data-title="false">

					<c:choose>
					<c:when test="${not empty feature.linkURL and fn:contains(feature.linkURL, 'youtube') or fn:contains(feature.linkURL, 'youtu.be')}">

						<c:url var="url" value="">
							<c:param name="vid" value="${feature.linkURL}" />
							<c:param name="title" value="${feature.linkText}" />
							<c:param name="description" value="${feature.shortDesc}" />
						</c:url>

						<div class="laz-careimg">
							<a href="/modals/video.jsp${url}" aria-label="video link" class="video">
								<div class="play">
									<div class="triangle"></div>
								</div>
								<img src="${feature.image.url}" alt="${feature.image.description }" />
							</a>
						</div>

						<a href="/modals/video.jsp${url}" class="video">${feature.linkText}</a>

					</c:when>
					<c:otherwise>

						<div class="laz-careimg"><img src="${feature.image.url}" alt="${feature.image.description }" /></div>

						<c:if test="${not empty feature.subTitle}">
 						<p class="subtitle">${feature.subTitle}</p>
						</c:if>

						<c:if test="${not empty feature.shortDesc}">
						<p>${feature.shortDesc}</p>
						</c:if>

						<c:if test="${not empty feature.linkURL}">
						<a href="${feature.linkURL}" class="triangle-forwards">${feature.linkText}</a>
						</c:if>

					</c:otherwise>

				</c:choose>

					</div>
		        </c:forEach>
			</c:if>
			</c:otherwise>
			</c:choose>
		</div>
	</section>
</dsp:page>