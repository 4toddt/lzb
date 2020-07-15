<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<c:choose>
		<%-- Check if Marxent Composer is enabled and template matches --%>
		<c:when test="${(storeConfig.marxentComposerEnabled) && (isConfigurable eq 'true' || isSectional eq 'true' || isLicensed eq 'true')}">
				<c:set var="isMarxentImageIntegration" value="true" />
		</c:when>
		<c:otherwise>
			<c:set var="isMarxentImageIntegration" value="false" />
		</c:otherwise>
	</c:choose>

	<%-- Find the FIRST nailhead option, and if it's not null or NN, use as the default for Marxent to use. --%>
	<c:set var="standardNailhead" value="" />
	<%-- Commenting code for default Nailhead on initial page load as it is not working accurately for products where 'none' is pre-selected.
	<c:set var="option" value="${productRecord['Nail Head Options']}" />
	<c:if test="${not empty option}" >
		<c:set var="optionVal" value="${fn:split(option,'|')[0]}" />
		<c:set var="nailheadSku" value="${fn:split(optionVal,'~')[0]}" />
		<c:if test="${fn:contains(nailheadSku,'_') eq true }" >
			<c:set var="index" value="${fn:indexOf(nailheadSku,'_')}" />
			<c:set var="standardNailhead" value="${fn:substring(nailheadSku, index+1, index+3)}" />
		</c:if>
		<c:if test="${fn:contains(optionVal,'_NN') eq true }">
			<c:set var="standardNailhead" value="" />
		</c:if>
	</c:if>
	 --%>
	<c:set var="standardFinish" value="" />
	<%-- Loop through product options for a finish option and set the var to "default" for Marxent to use. --%>
	<c:forEach items="${fn:split(productRecord['sku.configurableOptionNames'],'|')}" var="parentOptionName">
		<c:set var="foption" value="${productRecord[parentOptionName]}" />
		<c:forEach items="${fn:split(foption,'++')}" var="subOption" varStatus="i">
			<c:if test="${fn:contains(subOption,'Finish') eq true }">
				<dsp:getvalueof var="standardFinish" value="Default" />
			</c:if>
		</c:forEach>
	</c:forEach>

	<%-- Set defaultCover --%>
	<dsp:getvalueof var="defaultCover" param="defaultCover" />

	<section role="region">

		<%-- Define large and xLarge default images --%>
		<c:set var="largeImage" value="${additionalImage[0].largeImage}" />
		<c:set var="xLargeImage" value="${additionalImage[0].XLargeImage}" />

		<meta itemprop="image" content="${largeImage}">

		<section data-module="pdpImageSelection pdp-edit-config">
			<div id="pdp-main-image-container" data-module="zoom-image" data-imgid="pdp-main-image">
				<%-- START Marxent Integration --%>
				<c:if test="${isMarxentImageIntegration eq 'true'}">
					<c:set var="hideClass" value="hide" />
					<div id="divSpins" data-default-cover="${defaultCover}" data-default-finish="${standardFinish}" data-default-nailhead="${standardNailhead}"></div>
				</c:if>

				<%-- END Marxent Integration --%>
				<div id="pdp-main-image" class="${hideClass}">
					<img src="${largeImage}" data-zoom-image="${xLargeImage}" />
				</div>

				<%-- Render Product Video --%>
				<div class="product-video hide">
					<dsp:include page="/includes/global/videoPlayer.jsp">
						<dsp:param name="loop" value="true"/>
					</dsp:include>
				</div>

				<div id="imageFunctions" data-module="cbox" data-transition="elastic" data-speed="350">
						<span class="${hideClass}" data-module="enlargeImage" data-transition="elastic">
							<a class="open-viewer inline" href="#enlarge-image" aria-label="Image Zoom">Zoom</a>
						</span>
				</div>
				<div class="hide">
					<dsp:include page="${pageContext.request.contextPath}/browse/pdp/imageViewer.jsp">
							<dsp:param name="isMarxentImageIntegration" value="${isMarxentImageIntegration}" />
							<dsp:param name="xLargeImage" value="${xLargeImage}" />
							<dsp:param name="defaultCover" value="${defaultCover}" />
							<dsp:param name="standardFinish" value="${standardFinish}" />
					</dsp:include>
				</div>
			</div>

			<div id="pdp-thumbs-container" data-module="pdp-carousel" data-slides-to-show="3" data-slides-to-scroll="3">
				<%-- include all thumbnail images  --%>
				<dsp:include page="${pageContext.request.contextPath}/browse/pdp/pdpAdditionalImage.jsp">
					<dsp:param name="isMarxentImageIntegration" value="${isMarxentImageIntegration}" />
					<dsp:param name="productRecord" value="${productRecord}"/>
					<dsp:param name="defaultCover" value="${defaultCover}" />
					<dsp:param name="standardFinish" value="${standardFinish}" />
					<dsp:param name="standardNailhead" value="${standardNailhead}" />
				</dsp:include>
			</div>

			<dsp:getvalueof var="videoUrl" value="${productRecord['product.videoURL'] }" />
			<c:if test ="${not empty videoUrl}">
					<div id="pdpProductVideo">
							<h2>Product Overview Video</h2>
							<iframe src="${videoUrl}?autohide=1&controls=1" frameborder="0"></iframe>
					</div>
			</c:if>

			<c:if test="${pdpPageTargeter!=null && not empty pdpPageTargeter}">
				<div class="pdp-promo-block">
					<dsp:renderContentItem contentItem="${pdpPageTargeter}" />
				</div>
			</c:if>
		</section>

		<dsp:include src="${pageContext.request.contextPath}/global/pageTargeter.jsp">
			<dsp:param name="targeterName" value="PDPPromoBlock"/>
		</dsp:include>
	</section>

</dsp:page>