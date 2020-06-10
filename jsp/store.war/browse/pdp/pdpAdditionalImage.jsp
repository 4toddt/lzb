<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder" />
 	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof param="isMarxentImageIntegration" var="isMarxentImageIntegration" />
	<dsp:getvalueof param="productRecord" var="productRecord" />
	<dsp:getvalueof param="defaultCover" var="defaultCover" />
	<dsp:getvalueof param="standardFinish" var="standardFinish" />
	<dsp:getvalueof param="standardNailhead" var="standardNailhead" />

<%-- when is grabbing thumbnail img values from pdpImage.jsp --%>
<%-- otherwise is grabbing thumbnail img params from quickviewmodal.jsp --%>
<c:choose>
	<c:when test="${additionalImage ne null || not empty additionalImage}">
		<dsp:getvalueof var="thumbnailImages" value="${additionalImage}" />
	</c:when>
	<c:otherwise>
		<dsp:getvalueof var="thumbnailImages" param="thumbnailImages" />
	</c:otherwise>
</c:choose>

<%-- Droplet used to build Marxent Imager URL --%>
<c:if test="${storeConfig.marxentImagerEnabled}">
	<dsp:getvalueof var="marxentImageURL" value="/"/>
	<dsp:droplet name="LZBImageURLBuilder">
		<dsp:param name="skuid" value="${productRecord['sku.repositoryId']}"/>
		<c:if test="${not empty defaultCover}">
	      <dsp:param name="base" value="${defaultCover}"/>
		</c:if>
		<c:if test="${not empty standardFinish}">
	      <dsp:param name="finish" value="${standardFinish}"/>
		</c:if>
    		<c:if test="${not empty standardNailhead}">
    	      <dsp:param name="nailhead" value="${standardNailhead}"/>
    		</c:if>		
		<dsp:param name="bg" value="white"/>
		<dsp:param name="padding" value="10"/>
		<dsp:param name="trim" value="true"/>
		<dsp:param name="crop" value="false"/>
		<dsp:param name="secureURL" value="true"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="marxentImageURL" param="elements"/>
		</dsp:oparam>
	</dsp:droplet>
</c:if>

<c:if test="${thumbnailImages ne null || not empty thumbnailImages }">
	<div class="wrapper">
		<%-- START Marxent Imager Thumbnail --%>
		<c:if test="${isMarxentImageIntegration eq 'true'}">
			<%-- Check if Marxent Imager is enabled --%>
			<c:choose>
				<c:when test="${storeConfig.marxentImagerEnabled}">
					<%-- If Marxent Imager is enabled use imager droplet to set source --%>
					<div class="alt-img marxent-image marxent-enabled active">
						<a href="${marxentImageURL}&width=500&height=500" data-zoom-image="${marxentImageURL}&width=1000&height=1000" data-addtocart-modal-image="${marxentImageURL}&width=500">
							<img src="${marxentImageURL}&width=225&height=225" alt="product thumbnail" />
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<%-- If Marxent Imager is disabled use a generic thumbnail image --%>
					<div class="alt-img marxent-image active">
						<a href="//content.la-z-boy.com/Images/productIcons/img-360-thumbnail.png" data-zoom-image="//content.la-z-boy.com/Images/productIcons/img-360-thumbnail.png">
							<img src="//content.la-z-boy.com/Images/productIcons/img-360-thumbnail.png" alt="360 product view thumbnail" />
						</a>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
		<%-- END Marxent Imager Thumbnail --%>
         
        <dsp:droplet name="SKULookup">
			<dsp:param name="id" value="${productRecord['sku.repositoryId']}" />
			<dsp:setvalue param="sku" paramvalue="element" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="skuVideos" param="sku.videos"/>
			</dsp:oparam>
			<dsp:oparam name="wrongCatalog">
				<dsp:getvalueof var="skuVideos" param="sku.videos"/>
	    	</dsp:oparam>
		</dsp:droplet>
		
		<%-- START Additional Thumbnail --%>
		<c:forEach var="thumbnailImg" items="${thumbnailImages}" varStatus="status">
			<c:choose>
				<c:when test="${status.index eq 0 && isMarxentImageIntegration ne 'true'}">
					<dsp:getvalueof var="altImgClass" value="alt-img active"/>
				</c:when>
				<c:otherwise>
					<dsp:getvalueof var="altImgClass" value="alt-img"/>
				</c:otherwise>
			</c:choose>
					
			<c:choose>
				<c:when test="${status.index eq 0}">
					<div class="${altImgClass}">
						<a href="${thumbnailImg.largeImage}" data-zoom-image="${thumbnailImg.XLargeImage}">
							<img src="${thumbnailImg.thumbnailImage}" alt="product thumbnail" />
						</a>
					</div>
					
					<%-- Start Product videos Images --%>           
					<c:if test="${not empty skuVideos}">
						<dsp:droplet name="ForEach">
					    	<dsp:param value="${skuVideos}" name="array"/>
					       	<dsp:param name="elementName" value="skuMediaVideo"/>
					       	<dsp:oparam name="output">
					       		<dsp:getvalueof param="index" var="index" />
					       		<dsp:getvalueof var="url" param="skuMediaVideo.url" />
					       		<dsp:getvalueof var="hasAudio" param="skuMediaVideo.hasAudio" />
					       		<dsp:getvalueof var="thubImage" param="skuMediaVideo.thumbImage" />
					       		<div aria-hidden="true" class="alt-img is-video">
									<a href="${url}" data-zoom-image="${thubImage}" data-audio="${hasAudio}">
										<img src="${thubImage}" alt="product thumbnail">
									</a>
									<span class="icon-play"></span>
								</div>
					      	</dsp:oparam>
					     </dsp:droplet>
					</c:if>
					<%-- End Product videos Images --%> 
				</c:when>
				<c:otherwise>
					<div class="${altImgClass}">
						<a href="${thumbnailImg.largeImage}" data-zoom-image="${thumbnailImg.XLargeImage}">
							<img src="${thumbnailImg.thumbnailImage}" alt="product thumbnail" />
						</a>
					</div>
				</c:otherwise>
			</c:choose>
				
		 </c:forEach>
	
		 <%-- END Additional Thumbnail --%>
	 </div>
 </c:if>
</dsp:page>