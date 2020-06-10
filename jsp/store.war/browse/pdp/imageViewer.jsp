<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder" />
	<dsp:getvalueof param="isMarxentImageIntegration" var="isMarxentImageIntegration" />
	<dsp:getvalueof param="xLargeImage" var="xLargeImage" />
	<dsp:getvalueof param="defaultCover" var="defaultCover" />
	<dsp:getvalueof param="standardFinish" var="standardFinish" />
	<dsp:getvalueof param="standardNailhead" var="standardNailhead" />

	<%-- Check if Marxent Imager is enabled --%>
	<c:choose>
		<c:when test="${storeConfig.marxentImagerEnabled}">
			<%-- Droplet used to build Marxent Imager URL --%>
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
		</c:when>
		<c:otherwise>
			<c:set var="isMarxentImageIntegration" value="false" />
		</c:otherwise>
	</c:choose>


	<div id="enlarge-image">
		<div id="enlarge-image-viewer" class="viewer">
			<c:choose>
				<c:when test="${isMarxentImageIntegration eq 'true'}">
					<%-- Load Marxent Imager Large Image --%>
					<img src="${marxentImageURL}&width=1000&height=1000" alt="product image" />
				</c:when>
				<c:otherwise>
					<%-- Load Additional Image Large Image --%>
					<img src="${xLargeImage}" alt="product image" />
				</c:otherwise>
			</c:choose>

		</div>
		<dsp:getvalueof var="thumbnailImages" value="${additionalImage}" />
		<c:if test="${thumbnailImages==null || not empty thumbnailImages }">
			<ul class="swatch-selection">
				<%-- START Marxent Imager Thumbnail --%>
				<c:if test="${isMarxentImageIntegration eq 'true'}">
					<li class="active">
						<a href="${marxentImageURL}&width=1000&height=1000">
							<img id="marxent-image-enlarged-thumb" src="${marxentImageURL}&width=225&height=225" alt="product thumbnail" />
						</a>
					</li>
				</c:if>
				<%-- END Marxent Imager Thumbnail --%>

				<%-- START Additional Thumbnail --%>
				<c:forEach var="thumbnailImg" items="${thumbnailImages}" varStatus="status">
					<li
						<c:if test="${status.index eq 0 && isMarxentImageIntegration ne 'true'}">
							class="active"
						</c:if>
					>
						<a href="${thumbnailImg.XLargeImage}">
							<img src="${thumbnailImg.thumbnailImage}" alt="product thumbnail" />
						</a>
					</li>
				 </c:forEach>
				 <%-- END Additional Thumbnail --%>
			 </ul>
		</c:if>
		<button>Close</button>
	</div>
</dsp:page>