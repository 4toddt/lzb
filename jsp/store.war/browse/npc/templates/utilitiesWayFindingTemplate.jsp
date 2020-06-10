<dsp:page>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />

	<c:if test="${pageItem.seoName eq 'CoverSearch'}">
		<dsp:droplet name="/atg/endeca/assembler/droplet/InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/Shared/CoverSearch/CoverSearch" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<dsp:renderContentItem contentItem="${element}" />
			</dsp:oparam>
			<dsp:oparam name="error">
				failed
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	<span data-module="favorite-cover"></span>
	<span data-module="search-cover"></span>
	<section role="region" class="cust-support" data-template-name="utilitiesWayFinding">

		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<img src="${templateItem.heroImage.url}" alt="${templateItem.heroImage.description}" />
		<dsp:valueof value="${templateItem.contentBlock}" valueishtml="true"/>

	</section>

	<%-- <dsp:include src="/cartridges/CoverSearchPage/CoverSearchPage.jsp"/> --%>

</dsp:page>