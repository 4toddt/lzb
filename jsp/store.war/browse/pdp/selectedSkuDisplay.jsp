<dsp:page>
<dsp:getvalueof var="defaultCover" param="defaultCover" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

<c:choose>
	<c:when test="${(isSimple eq 'true') || (isDiscontinuedSectional eq 'true')}">
		<c:set var="materialClass" value="material-simple" />
	</c:when>
	<c:when test="${(isDiscontinuedSimple eq 'true') || (isDiscontinuedConfigurable eq 'true')}">
		<c:set var="materialClass" value="material-discontinued" />
	</c:when>
</c:choose>

	<c:set value="${fn:split(defaultCover,'~')}" var="defaultCoverAttr"/>

	<c:choose>
		<c:when test="${not empty defaultCover && fn:contains(defaultCover,'~') eq 'true'}">
			<div id="materialDetails" class="material-details ${materialClass}" data-default-cover-id="${defaultCoverAttr[0]}">
		
				<div class="large-swatch-sample">
					<c:choose>
						<c:when test="${isDiscontinuedSectional eq 'true'}">
							<img src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${defaultCoverAttr[0]}.jpg" alt="${defaultCoverAttr[1]}" />
						</c:when>
						<c:otherwise>
							<img src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${defaultCoverAttr[0]}.jpg"/>
						</c:otherwise>
					</c:choose>
				</div>
				<c:set var="length" value="${fn:length(defaultCoverAttr)}"/>
				<div class="swatchDetails swatch-sample-details">
					<div class="cover-type">
						<c:choose>
							<c:when test="${isDiscontinuedSectional eq 'true'}">
								<b>Cover Type:</b> <span>${defaultCoverAttr[3]}</span>
							</c:when>
							<c:otherwise>
								<b>Cover Type:</b> <span>${defaultCoverAttr[length-2]}</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="color">
						<c:choose>
							<c:when test="${isDiscontinuedSectional eq 'true'}">
								<b>Color:</b> <span>${defaultCoverAttr[4]}</span>
							</c:when>
							<c:otherwise>
								<b>Color:</b> <span>${defaultCoverAttr[length-4]}&nbsp;${defaultCoverAttr[0]}</span>
							</c:otherwise>
						</c:choose>
					</div>
					<%--
					<div class="cover-id">
						<span>${fn:split(defaultCover,'~')[0]}</span>
					</div>
					 --%>
				</div>
			</div><%-- .material-details --%>
		</c:when>
		<c:otherwise>
			<%-- <label id="selecteditemsid"> - -</label> --%>
		</c:otherwise>
	</c:choose>
	
</dsp:page>
