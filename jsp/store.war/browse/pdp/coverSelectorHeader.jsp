<dsp:page>
	<dsp:getvalueof var="defaultCover" param="defaultCover" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<c:set value="${fn:split(defaultCover,'~')}" var="defaultCoverAttr"/>
	<fmt:message var="seeCoverDetail" key="pdp.seeCoverDetail"/>
	
	<div id="materialDetails" class="material-details new-ui" data-default-cover-id="${defaultCoverAttr[0]}">
		<c:choose>
			<c:when test="${not empty defaultCover && fn:contains(defaultCover,'~') eq 'true'}">
				<div class="large-swatch-sample">
					<img src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${defaultCoverAttr[0]}.jpg"/>
				</div>
				<c:set var="length" value="${fn:length(defaultCoverAttr)}"/>
				<div class="swatchDetails swatch-sample-details">
                    <div class="top-part">
                        <h4>Select Your Cover</h4>
                    </div>
                    <div class="swatch-color-container">
	                	<div class="color">
		                    <span>${defaultCoverAttr[length-4]}&nbsp;${defaultCoverAttr[0]}</span>
		       			</div>
		       			
		       			<c:if test="${storeConfig.showCoverDetails}">
		       				<a id="view-cover-details-link" href="${contextPath}/modals/viewCoverDetailsModal.jsp?coverId=${defaultCoverAttr[0]}&coverColor=${defaultCoverAttr[length-4]}" class="view-cover-details-link" data-module="view-cover-details" aria-label="${viewCoverDetails}" tabindex="0">${seeCoverDetail}</a>
	      				</c:if>
	      			</div>
                    <span class="price swatch-price selected-cover-price"></span>
					<%--
					<div class="cover-id">
						<span>${fn:split(defaultCover,'~')[0]}</span>
					</div>
					--%>
				</div>
				<c:if test="${isDealerRMS eq true}">
					<div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
				</c:if>
			</c:when>
			<c:otherwise>
				<div class="swatchDetails swatch-sample-details">
					<div class="large-swatch-sample">
						<img src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${defaultCoverAttr[0]}.jpg"/>
					</div>
                    <div class="top-part">
                        <h4>Select Your Cover</h4>
                    </div>
					<div class="color">
						<span>no default cover set</span>
					</div>
                    <span class="price selected-cover-price"></span>
					<%--
					<div class="cover-id">
						<span>${fn:split(defaultCover,'~')[0]}</span>
					</div>
					--%>
				</div>
				<c:if test="${isDealerRMS eq true}">
					<div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
				</c:if>
				<!-- selectedSkuDisplay.jsp otherwise -->
				<!-- ${devaultCover} -->
				<!-- ${fn:contains(defaultCover,'~') eq 'true'} -->
				<%-- <label id="selecteditemsid"> - -</label> --%>
			</c:otherwise>
		</c:choose>
	</div><%-- .material-details --%>
	<span class="accordion-state icon-arrow-down"></span>
</dsp:page>
