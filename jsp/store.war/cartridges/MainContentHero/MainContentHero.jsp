<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof value="${storeConfig.endecaMediaURL}" var="mediaURL"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<c:if test="${content.useLightText}">
		<c:set var="textColorLightClass" value="light"/>
	</c:if>

	<div class="plp-hero-wrapper">
		<c:if test="${(not empty content.title) or (not empty content.body)}">
			<div class="plp-hero-banner-text ${textColorLightClass}">
				<c:if test="${not empty content.title}">
					<h1>${content.title}</h1>
				</c:if>
				<c:if test="${(not empty content.title) and (not empty content.body)}">
					<hr>
				</c:if>
				<c:if test="${not empty content.body}">
					<h2>${content.body}</h2>
				</c:if>
			</div>
		</c:if>
		<img src="${content.mediaUrl}" alt="${content.imageAlt}"/>
	</div>
</dsp:page>