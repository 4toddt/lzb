<%--
    - File Name: productImages.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product images section on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - productRecord: product record,
        - productId: product id,
        - productSkuId: product sku id,
        - additionalImage: product images,
        - defaultCoverSkuId: default seclected cover sku
        - productName: name of the product,
        - isMobileiOS: iphone/ipod mobile user agent boolean is a request scope variable
    - Optional Parameters:
        - productVideoUrl: product video url
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder" />
   	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="productRecord" param="productRecord" />
    <dsp:getvalueof var="productId" param="productId" />
    <dsp:getvalueof var="productSkuId" param="productSkuId" />
    <dsp:getvalueof var="additionalImage" param="additionalImage" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
    <dsp:getvalueof var="productVideoUrl" param="productVideoUrl" />
    <dsp:getvalueof var="productName" param="productName" />
    <c:set var="productConfigurableOptionNames" value="${productRecord['sku.configurableOptionNames']}" />
    <c:set var="productNailHeadOptions" value="${productRecord['Nail Head Options']}" />
    <c:set var="standardNailhead" value="" />
    <c:set var="standardFinish" value="" />
    <c:set var="marxentImageURL" value=""/>
    <fmt:message var="videoHeading" key="pdp.videoHeading" />

    <%-- Check if Marxent Composer is enabled --%>
    <c:choose>
		<c:when test="${storeConfig.marxentComposerEnabled}">
            <c:set var="isMarxentComposerEnabled" value="true" />
            <%-- Define Product ID variable for Composer --%>
            <c:choose>
        		<c:when test="${pdpRecordType eq 'sectional'}">
                    <c:set var="composerProductId" value="${productId}" />
                </c:when>
                <c:otherwise>
                    <c:set var="composerProductId" value="${productSkuId}" />
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="isMarxentComposerEnabled" value="false" />
        </c:otherwise>
    </c:choose>
    <%-- Check if Marxent Imager is enabled --%>
    <c:choose>
		<c:when test="${storeConfig.marxentImagerEnabled}">
            <c:set var="isMarxentImagerEnabled" value="true" />
        </c:when>
        <c:otherwise>
            <c:set var="isMarxentImagerEnabled" value="false" />
        </c:otherwise>
    </c:choose>

    <%-- NOTE: Image Composer is only rendered for specific pdpRecordType --%>
	<c:if test="${(isMarxentComposerEnabled) && (pdpRecordType eq 'configurable' || pdpRecordType eq 'sectional' || pdpRecordType eq 'licensed')}">
        <%-- Find the FIRST nailhead option, and if it's not null or NN, use as the default for Marxent to use. --%>
    	<%-- Commenting code for default Nailhead on initial page load as it is not working accurately for products where 'none' is pre-selected.
    	<c:set var="nailheadOption" value="${productNailHeadOptions}" />
    	<c:if test="${not empty nailheadOption}" >
    		<c:set var="nailheadOptionVal" value="${fn:split(nailheadOption,'|')[0]}" />
    		<c:set var="nailheadSku" value="${fn:split(nailheadOptionVal,'~')[0]}" />
    		<c:if test="${fn:contains(nailheadSku,'_') eq true }" >
    			<c:set var="nailheadIndex" value="${fn:indexOf(nailheadSku,'_')}" />
    			<c:set var="standardNailhead" value="${fn:substring(nailheadSku, nailheadIndex+1, nailheadIndex+3)}" />
    		</c:if>
    		<c:if test="${fn:contains(nailheadOptionVal,'_NN') eq true }">
    			<c:set var="standardNailhead" value="" />
    		</c:if>
    	</c:if>
    	--%>

    	<%-- Loop through product options for a finish option and set the var to "default" for Marxent to use. --%>
    	<c:forEach items="${fn:split(productConfigurableOptionNames,'|')}" var="parentOptionName">
    		<c:set var="foption" value="${productRecord[parentOptionName]}" />
    		<c:forEach items="${fn:split(foption,'++')}" var="subOption" varStatus="i">
    			<c:if test="${fn:contains(subOption,'Finish') eq true }">
    				<dsp:getvalueof var="standardFinish" value="Default" />
    			</c:if>
    		</c:forEach>
    	</c:forEach>

        <%-- Check if Marxent Imager is enabled --%>
        <c:if test="${isMarxentImagerEnabled}">
        	<dsp:droplet name="LZBImageURLBuilder">
        		<dsp:param name="skuid" value="${productSkuId}"/>
        		<c:if test="${not empty defaultCoverSkuId}">
        	      <dsp:param name="base" value="${defaultCoverSkuId}"/>
        		</c:if>
        		<c:if test="${not empty standardFinish}">
        	      <dsp:param name="finish" value="${standardFinish}"/>
        		</c:if>
        		<c:if test="${not empty standardNailhead}">
        	      <dsp:param name="nailhead" value="${standardNailhead}"/>
        		</c:if>
        		<dsp:param name="width" value="500"/>
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
	</c:if>

    <%-- Define SKULookup Property Variables --%>
    <dsp:droplet name="SKULookup">
        <dsp:param name="id" value="${productSkuId}" />
        <dsp:setvalue param="sku" paramvalue="element" />
        <dsp:oparam name="output">
            <%-- set video variable --%>
            <dsp:getvalueof var="skuVideos" param="sku.videos"/>
            <%-- set AR enabled variable --%>
            <dsp:getvalueof var="arEnabled" param="sku.ar_enabled"/>
        </dsp:oparam>
        <dsp:oparam name="wrongCatalog">
            <%-- set video variable --%>
            <dsp:getvalueof var="skuVideos" param="sku.videos"/>
            <%-- set AR enabled variable --%>
            <dsp:getvalueof var="arEnabled" param="sku.ar_enabled"/>
        </dsp:oparam>
    </dsp:droplet>

    <%-- Render Product Images --%>
    <div id="productImages" class="product-images" data-composer-enabled="${isMarxentComposerEnabled}" data-imager-enabled="${isMarxentImagerEnabled}">
        <div class="product-images-slider">
            <%-- START Marxent Integration --%>
			<%-- NOTE: Image Composer is only rendered for specific pdpRecordType --%>
            <c:if test="${(isMarxentComposerEnabled) && (pdpRecordType eq 'configurable' || pdpRecordType eq 'sectional')}">
                <div id="divSpins" class="product-composer" data-product-id="${composerProductId}" data-default-cover="${defaultCoverSkuId}" data-default-finish="${standardFinish}" data-default-nailhead="${standardNailhead}" data-image-url="${marxentImageURL}" data-json=""></div>
			</c:if>
            <%-- END Marxent Integration --%>

			<%-- Render Additional Product Images --%>
			 <c:if test="${additionalImage ne null || not empty additionalImage}">
                <c:forEach var="image" items="${additionalImage}" varStatus="status">
                	<c:choose>
						<c:when test="${status.index eq 0}">
                            <%-- Render Product Image --%>
							<div class="product-image"><img data-lazy="${image.largeImage}" alt="${productName}"></div>

                            <%-- Render Product Video --%>
							<c:if test="${not empty skuVideos}">
								<dsp:droplet name="ForEach">
							    	<dsp:param value="${skuVideos}" name="array"/>
							       	<dsp:param name="elementName" value="skuMediaVideo"/>
							       	<dsp:oparam name="output">
                                        <div class="product-video">
                                            <dsp:include page="/sitewide/includes/videoPlayer.jsp">
                                                <dsp:param name="index" param="index"/>
                                                <dsp:param name="url" param="skuMediaVideo.url"/>
                                                <dsp:param name="imagePoster" param="skuMediaVideo.thumbImage"/>
                                                <dsp:param name="audio" param="skuMediaVideo.hasAudio"/>
                                                <dsp:param name="loop" value="true"/>
                                            </dsp:include>
                                        </div>
							      	</dsp:oparam>
							     </dsp:droplet>
							</c:if>
						</c:when>
						<c:otherwise>
							<div class="product-image"><img data-lazy="${image.largeImage}" alt="${productName}"></div>
						</c:otherwise>
					</c:choose>
                </c:forEach>
            </c:if>

            <%-- Render Product Video Action --%>
            <c:if test="${not empty productVideoUrl}">
                <div class="product-video-action">
                    <div class="video-container">
                        <c:url value="/sitewide/ajax/videoModal.jsp" var="modalUrl">
                            <c:param name="videoURL" value="${productVideoUrl}" />
                        </c:url>
                        <a href="${modalUrl}" class="modal-trigger video" data-target="modal-video" data-size="medium" aria-label="${videoHeading}">
                            <h4>${videoHeading}</h4>
                            <span class="icon icon-play-outline" aria-hidden="true"></span>
                        </a>
                    </div>
                </div>
			</c:if>
        </div>

        <%-- Render Augmented Reality(AR) Action --%>
        <%-- NOTE: AR button will only display for iPhone/iPod mobile user agents. --%>

        <c:if test="${arEnabled && ((isMobileiOS && storeConfig.iosArEnabled) || (isMobileAndroid && storeConfig.androidArEnabled))}">
            <div class="ar-action">
                <%-- NOTE: data param is generated by javascript on click event --%>
                <a href="${storeConfig.augmentedRealityBasePath}?sku=${composerProductId}&data=" class="ar-link">
                    <span class="icon icon-recliner-dimension" aria-hidden="true"></span>
                    <span class="text-label"><fmt:message key="pdp.link.arAction" /></span>
                </a>
            </div>
        </c:if>
    </div>

</dsp:page>