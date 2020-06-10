<dsp:page>
	<dsp:getvalueof var="record" param="record"/>
	<dsp:getvalueof var="pdpURL" param="pdpURL"/>
	<fmt:message var="productPagePath" key="pdp.storePath"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<c:set var="recordAttributeMap" value="${record.attributes}"/>
	<c:choose>
		<c:when test="${not empty pdpURL}">
			<c:set var="recordURL" value="${pdpURL}"/>
		</c:when>
		<c:otherwise>
			<c:set var="recordURL" value="${contextPath}${productPagePath}${element.detailsAction.recordState}"/>
		</c:otherwise>
	</c:choose>
	
	<table>
		<tr><td>Quick Look</td></tr>
		<tr><td>
				<a href="${recordURL}">
					<img src="${recordAttributeMap['configurableSku.imagePath']}" alt="${recordAttributeMap['sku.displayName']}" />
				</a> 
			</td></tr>
			<tr><td>
				${recordAttributeMap['styleNumber']}
			</td></tr>
			<tr><td>${recordAttributeMap['product.rating']} (${recordAttributeMap['product.reviewCount']})</td></tr> 
			<tr><td>
				<c:choose>
					<c:when test="${not empty element.attributes['P_LowestSalePrice'] && not empty element.attributes['P_LowestPrice']}">
						<fmt:message key="price.asLow.label"/><strike> $${element.attributes['P_LowestPrice']}</strike> $${element.attributes['P_LowestSalePrice']}
					</c:when>
					<c:when test="${not empty element.attributes['P_LowestPrice']}">
						<fmt:message key="price.asLow.label"/>  $${element.attributes['P_LowestPrice']}
					</c:when>
				</c:choose>
			</td></tr>
			<tr><td>
			<c:if test="${not empty recordAttributeMap['sku.exteriorHeight'] || not empty recordAttributeMap['sku.exteriorHeight'] || not empty recordAttributeMap['sku.exteriorDepth']}">
				<fmt:message key="quick.look.overall.label"/> ${recordAttributeMap['sku.exteriorHeight']}" H × ${recordAttributeMap['sku.exteriorHeight']}" W × ${recordAttributeMap['sku.exteriorDepth']}" D<br/>
			</c:if>
			</td></tr>
			<tr><td>
			<c:if test="${not empty recordAttributeMap['sku.interiorHeight'] || not empty recordAttributeMap['sku.interiorWidth'] || not empty recordAttributeMap['sku.interiorDepth']}">
				<fmt:message key="quick.look.seat.label"/> ${recordAttributeMap['sku.interiorHeight']}" H × ${recordAttributeMap['sku.interiorWidth']}" W × ${recordAttributeMap['sku.interiorDepth']}" D<br/>
			</c:if>
			</td></tr>		
			<c:if test="${not empty recordAttributeMap['sku.cover']}">
				<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
					<dsp:param name="skuCoverList" value="${recordAttributeMap['sku.cover']}" />
					<dsp:param name="isQuickLook" value="true" />
					<dsp:oparam name="output">
						<dsp:getvalueof param="coverOptionList" var="coverOptionList" />
							<tr><td>
							<c:forEach items="${coverOptionList}" var="colorSwatch">
										<c:set var="coverArr" value="${fn:split(colorSwatch,'~')}"/>
											<a id="coverskuid"  href="#" title="${coverArr[1]}" ><img src="${storeConfig.hostName }${storeConfig.coverThumbnailBaseUrl}${coverArr[0]}.jpg" height="50" width="50" alt="${coverArr[1]}"/></a>
							</c:forEach>
							</td> </tr>
					</dsp:oparam>
				</dsp:droplet>
				<tr><td>
				<a href="${recordURL}">
					<fmt:message key="quick.look.see.all.covers"/> (${recordAttributeMap['sku.noOfCovers']} Total)
				</a>
				</td></tr>
			</c:if>
			<tr><td>
			<a href="${recordURL}">
					<fmt:message key="quick.look.customise.it"/>
			</a>
			</td></tr>
			<tr><td>
			<a href="${recordURL}">
					<fmt:message key="quick.look.view.product"/>
			</a>
			</td></tr>
	</table>
</dsp:page>