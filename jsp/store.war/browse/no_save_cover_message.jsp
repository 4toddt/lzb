<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration"var="storeConfig" />
	<dsp:getvalueof var="saveCoverXMPageName" value="${storeConfig.coverSearchXMPageName}" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	
	<b><fmt:message key="savecover.notdisplay" /></b></p>
	<fmt:message key="savecover.addsugessition" /></p>
	<fmt:message key="savecover.you.can.use" />
	<dsp:droplet name="/atg/commerce/endeca/cache/DimensionValueCacheDroplet">
			<dsp:param name="repositoryId" value="Covers" />
			<dsp:param name="ancestors" value="view" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="cacheObject" param="dimensionValueCacheEntry" />
				<c:if test="${cacheObject!=null && not empty cacheObject}">
					<c:set var="coverSearchPageUrl" value="${contextPath}${saveCoverXMPageName}${cacheObject.url}" />
				</c:if>
			</dsp:oparam>
	</dsp:droplet>
	<a href="${coverSearchPageUrl}">"<fmt:message key="savecover.cover.search" />"</a>
	<fmt:message key="savecover.cover.tool" /></p>
	<fmt:message key="savecover.having.cover" /></p>
	<fmt:message key="savecover.unchekced" />
</dsp:page>