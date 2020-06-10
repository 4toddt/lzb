<dsp:importbean bean="/com/lzb/commerce/droplet/LZBItemDetailsDroplet"/>

<dsp:getvalueof var="skuItem" param="skuItem" />
<dsp:getvalueof var="coverId" param="coverId" />
<dsp:getvalueof var="skuId" param="skuId" />
<dsp:getvalueof var="page" param="page" /> 

<dsp:droplet name="LZBItemDetailsDroplet">
	<dsp:param name="skuItem" value="${skuItem}" />
	<dsp:param name="skuId" value="${skuId}" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="stylesCollection" param="stylesCollection" />
		<dsp:getvalueof var="categoryName" param="categoryName"/>
		<!-- ${stylesCollection} and ${categoryName} -->
		<c:if test="${empty stylesCollection}">
		<c:set var="stylesCollection" value=" "/>
		</c:if>
		<c:choose>
		<c:when test="${not empty page and page eq 'pdp'}">
		<input type="hidden" name="styleCollection" value="${stylesCollection}"/>
		<input type="hidden" name="categoryName" value="${categoryName}"/>
		</c:when>
		<c:otherwise>
		<input type="hidden" name="styleCollection_${skuId}-${coverId}" value="${stylesCollection}"/>
		<input type="hidden" name="categoryName_${skuId}-${coverId}" value="${categoryName}"/>
		</c:otherwise>
		</c:choose>
	</dsp:oparam>
</dsp:droplet>