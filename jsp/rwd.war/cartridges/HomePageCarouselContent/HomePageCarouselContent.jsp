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

		<%-- <li class="gallery-cell">
			<figure>
				<img src="//www.la-z-boy.com/Images/homepage_main/MainImage_Bijou.jpg">
			</figure>
		</li>
		<li class="gallery-cell">
			<figure>
				<img src="//www.la-z-boy.com/Images/homepage_main/MainImage_Bijou.jpg">
			</figure>
		</li>
		<li class="gallery-cell">
			<figure>
				<img src="//www.la-z-boy.com/Images/homepage_main/MainImage_Bijou.jpg">
			</figure>
		</li>
			
		<c:if test ="${not empty content.text}">
			<li class="gallery-cell">
				<figure>
					<small>${content.text}</small>
				</figure>
			</li>
		</c:if>
 --%>
 		<div class="hero-slide">
	 		<c:if test ="${not empty content.imageUrl}">
				<c:if test="${empty actionURL}">
					<c:set var="actionURL" value="#" />
				</c:if>
				<c:choose>
					<c:when test="${not empty content.imageUrl}">
						<a href="${actionURL}" title="${content.text}"><img src="${content.imageUrl}" alt="${content.text}"/></a>
						<%-- <c:if test ="${not empty content.text}">
							<div class="hero-slider-content">
								<a href="${actionURL}" class="promo" title="${content.text}">${content.text}</a>
							</div>
						</c:if>  --%>
					</c:when>
					<c:otherwise>
						<c:if test ="${not empty content.text}">
							<a href="${actionURL}" class="promo" title="${content.text}">${content.text}</a>
						</c:if> 
					</c:otherwise>
				</c:choose>
			</c:if>
		</div>
	</c:if>
</dsp:page>