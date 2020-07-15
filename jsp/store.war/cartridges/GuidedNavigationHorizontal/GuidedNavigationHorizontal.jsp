<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<dsp:getvalueof var="selectedBreadcrumbs" param="selectedBreadcrumbs" />

<!-- Horizontal Guided Nav -->
	<!-- ${selectedBreadcrumbs} -->
	<div class="guided-nav-wrapper sticky">
		<div class="guided-nav-dropdowns">
			<c:forEach var="element" items="${contentItem.navigation}">
				<c:if test="${element['@type'] ne 'PriceSlider' || (element['@type'] eq 'PriceSlider' && element.enabled eq true)}">
					<div class="guided-nav-section guided-nav-${fn:length(contentItem.navigation)}">
						<dsp:renderContentItem contentItem="${element}"/>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<dsp:include page="/cartridges/AppliedFacets/AppliedFacets.jsp" />

		<div class="back-to-top">
			<div aria-hidden="true" class="icon icon-arrow-up"></div>
			<div class="text">top</div>
		</div>
	</div>
</dsp:page>
