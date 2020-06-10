<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder" />

	<dsp:getvalueof param="isEmail" var="isEmail"/>
	<dsp:getvalueof param="cartItem" var="cartItem"/>
	<dsp:getvalueof param="asLink" var="asLink"/>
	<dsp:getvalueof param="productName" var="productName"/>
	
	<%-- Droplet used to build Marxent Imager URL --%>
	<c:choose>
		<c:when test="${storeConfig.marxentImagerEnabled && not cartItem.licensedProduct } ">
			<dsp:getvalueof var="marxentImageURL" value="/"/>
			
			<dsp:droplet name="LZBImageURLBuilder">
			<dsp:param name="json" value="${cartItem.commerceItem.requestString}"/>
			<dsp:param name="width" value="231"/>
			<dsp:param name="height" value="231"/>
			<dsp:param name="bg" value="white"/>
			<dsp:param name="padding" value="0"/>
			<dsp:param name="trim" value="true"/>
			<dsp:param name="crop" value="false"/>
			<dsp:param name="secureURL" value="true"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="marxentImageURL" param="elements"/>
			</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:otherwise>
			<%-- when Marxent Imager is disabled use a fallback image --%>
			<c:set var="contentHostName" value="${pageContext.request.scheme}://${storeConfig.contentHostName}"/>
			<c:set var="storeConfigHostName" value="${contentHostName}" />
			<c:set var="imagePath" value="${storeConfig.imagePath}"/>
			<dsp:tomap var="product" value="${cartItem.commerceItem.auxiliaryData.productRef}"/>
			<dsp:tomap var="sku" value="${cartItem.commerceItem.auxiliaryData.catalogRef}"/>
			<c:choose>
				<c:when test="${not empty product.type && product.type eq 'sectional'}">
					<c:set var="cdpImage" value="${product.cdpImage}"/>
				</c:when>
				<c:otherwise>
					<c:set var="cdpImage" value="${sku.cdpDefaultImage}"/>
				</c:otherwise>
			</c:choose>
			<c:set var="marxentImageURL" value="${storeConfigHostName}${imagePath}${cdpImage}"/>
		</c:otherwise>
	</c:choose>

	<c:choose>
		<c:when test="${not empty asLink}">
			<c:choose>
				<c:when test="${isEmail eq true}">
					<a href="${asLink}" aria-label="product-link" title="Click to ${productName} product page"><img src="${marxentImageURL}" alt="${productName}" width="75" /></a>
					<meta property="og:image" content="${marxentImageURL}" />
				</c:when>
				<c:otherwise>
					<a href="${asLink}" aria-label="product-link" title="Click to ${productName} product page"><img src="${marxentImageURL}" alt="${productName}" /></a>
					<meta property="og:image" content="${marxentImageURL}" />
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${isEmail eq true}">
					<img src="${marxentImageURL}" alt="${productName}" width="75" />
					<meta property="og:image" content="${marxentImageURL}" />
				</c:when>
				<c:otherwise>
					<img src="${marxentImageURL}" alt="${productName}" />
					<meta property="og:image" content="${marxentImageURL}" />
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
</dsp:page>
