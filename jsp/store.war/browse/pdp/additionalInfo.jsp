<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/droplet/LZBNPCURLDroplet" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
<dsp:getvalueof var="productRecord" param="productRecord" />
<dsp:getvalueof var="categoryImageUrlMap" value="${storeConfig.categoryNameToImageUrlMap}" />

	<div>
		<%-- editable content cartridge goes here --%>
		<c:if test="${ not empty productRecord['styleNumber']}" >
		<c:set var="styleNumberToValidate" value="${productRecord['styleNumber']}" />
			<dsp:droplet name="/com/lzb/droplet/LZBConfigurableSkuLookUpDroplet">
					
			    <c:if test="${fn:length(styleNumberToValidate) < 6}">
								<dsp:param name="id" value="${productRecord['sku.repositoryId']}"/>
							</c:if>
				<c:if test="${fn:length(styleNumberToValidate) == 6}">
								<dsp:param name="id" value="${productRecord['styleNumber']}"/>
							</c:if>
				<dsp:param value="sku" name="elementName"/>
				<dsp:oparam name="output">
					<dsp:valueof param="sku.resources" valueishtml="true"/>
				</dsp:oparam>
				<dsp:oparam name="wrongCatalog">
					<dsp:valueof param="sku.resources" valueishtml="true"/>
				</dsp:oparam>
			</dsp:droplet>
		</c:if>
	</div>

	<div class="product-manual">
		<c:if test="${ not empty productRecord['product.productDownloadImage']}" >
			<img src="${productRecord['product.productDownloadImage']}" alt="${productRecord['product.productDownloadHeading']}"/>
		</c:if>
		<div class="content">
			<c:if test="${not empty productRecord['product.productDownloadHeading']}">
				<p><strong>${productRecord['product.productDownloadHeading']}</strong></p>
			</c:if>
			<p>${productRecord['product.productDownloadDescription']}
				<c:if test="${not empty productRecord['product.productDownloadLink']}">
					<a href="${productRecord['product.productDownloadLink']}">Product Manual</a>
				</c:if>
			</p>
		</div>
	</div>

</dsp:page>