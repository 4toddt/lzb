<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
<!-- Home Page targeter -->
	<dsp:droplet name="/atg/targeting/TargetingFirst">
	<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/HomePageMarketingPromo" />
		<dsp:oparam name="output">
			<dsp:getvalueof param="element" var="element" />
			<c:if test="${fn:contains(element.itemDescriptor,'media-external')}" >
				<img src="${element.url}" alt="${element.name}" />
			</c:if>
			<c:if test="${fn:contains(element.itemDescriptor,'media-internal-text')}" >
				<dsp:valueof param="element.data" valueishtml="true" />
			</c:if>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>