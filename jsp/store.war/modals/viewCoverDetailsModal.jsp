<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/commerce/droplet/LZBCoverCareDroplet"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<dsp:getvalueof var="coverId" param="coverId" />
		<dsp:getvalueof var="coverColor" param="coverColor" />
	
		<main role="main" id="viewCoverDetailsModal">
			<h3 class="section-heading">
				<fmt:message key="pdp.viewCoverDetailsModal.coverDetails"/>
			</h3>
			<div class="content">
				<div class="swatch-info-container">
					<div class="cover-name">${coverColor}</div>
					<div class="cover-id"><fmt:message key="pdp.viewCoverDetailsModal.coverSku" />: ${coverId}</div>
					
					<dsp:droplet name="LZBCoverCareDroplet">
					<dsp:param name="coverId" value="${coverId}" />
					<dsp:oparam name="output">	
						<dsp:getvalueof var="coverDescription" param="coverCareInfo.description" />
						
						<dsp:droplet name="ForEach">
						<dsp:param name="array" param="coverCareInfo.coverCares" />
						<dsp:param name="elementName" value="coverCare" />
						<dsp:oparam name="outputStart">
							<ul class="cover-care-grid">
						</dsp:oparam>
						<dsp:oparam name="output">
							<li>
								<dsp:getvalueof var="coverImage" param="coverCare.imageName" />
								<c:if test="${not empty coverImage}">
									<img src="//${storeConfig.contentHostName}/Images/Covercare/${coverImage}">
								</c:if>
								
								<span class="cover-care-name"><dsp:valueof param="coverCare.careText" /></span>
							</li>
	    				</dsp:oparam>
	    				<dsp:oparam name="outputEnd">
	    					</ul>
	    				</dsp:oparam>
	    				</dsp:droplet>
	    			</dsp:oparam>
	    			</dsp:droplet>
					
					<div class="cover-details">${coverDescription}</div>
				</div>
				<div id="swatch-image-container" class="swatch-image-container" data-imgid="swatch-image" data-position="11" data-offetx="-20">
					<c:set var="largeImage" value="//${storeConfig.contentHostName}/Images/Fabrics/Small/${coverId}.jpg" />
					<c:set var="xLargeImage" value="//${storeConfig.contentHostName}/Images/Fabrics/Large/${coverId}.jpg" />
					<c:set var="defaultImage" value="//${storeConfig.contentHostName}/Images/product/additional/image-available-soon.jpg" />
					<div id="swatch-image">
						<img src="${largeImage}" data-zoom-image="${xLargeImage}"  onerror="this.src='${defaultImage}'">
					</div>
					<a href="${contextPath}/content/free-swatches" class="free-swatches-link"><fmt:message key="pdp.viewCoverDetailsModal.orderFreeSwatches" /></a>
                </div>
			</div>
		</main>
	</dsp:layeredBundle>
</dsp:page>