<%--
	- File Name: viewCoverDetailsModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is a view cover details modal.
	- Required Parameters:
	- Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/commerce/droplet/LZBCoverCareDroplet"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="coverId" param="coverId" />
	<dsp:getvalueof var="coverColor" param="coverColor" />
	
	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">viewCoverDetailsModal</jsp:attribute>

        <jsp:body>
			<div class="view-cover-details-modal" role="dialog" id="viewCoverDetailsModal">
				<div class="modal-header">
					<div class="title-bar">
						<h2 class="title">
                            <fmt:message key="pdp.viewCoverDetailsModal.coverDetails" />
						</h2>
					</div>
				</div>

				<div class="modal-body">
					<c:set var="largeImage" value="//${storeConfig.contentHostName}/Images/Fabrics/Small/${coverId}.jpg" />
					<c:set var="xLargeImage" value="//${storeConfig.contentHostName}/Images/Fabrics/Large/${coverId}.jpg" />
					<c:set var="defaultImage" value="//${storeConfig.contentHostName}/Images/product/additional/image-available-soon.jpg" />
					
					<section id="swatch-image-section">
						<div>
							<img src="${xLargeImage}" class="swatch-image panzoom" onerror="this.src='${defaultImage}'" width="1000" height="1000">
						</div>
						<div class="buttons">
					        <button class="panzoom-out"><span class="icon icon-minus" aria-hidden="true"></span></button>
					        <button class="panzoom-in"><span class="icon icon-plus" aria-hidden="true"></span></button>
					      </div>
					</section>
					
                    <a href="${contextPath}/content/free-swatches" class="free-swatches-link"><fmt:message key="pdp.viewCoverDetailsModal.orderFreeSwatches" /></a>
                    
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
				<div class="modal-footer hide">
      			</div>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>