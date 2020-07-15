<dsp:page>
	<dsp:importbean bean="/com/lzb/content/npc/LZBNPCConfiguration" />

	<dsp:getvalueof var="templateJSPMap" bean="LZBNPCConfiguration.npcPageTemplateMap" />
	<dsp:getvalueof var="pageItem" param="page" />

	<dsp:getvalueof var="templateName" value="${pageItem.pageTemplate.templateName}" />
	<dsp:getvalueof var="templateJSP" value="${templateJSPMap[templateName]}" />

	<c:if test="${pageItem.seoName eq 'CoverSearch'}">
		<c:set var="coverSearch" value="coverSearch" />
	</c:if>

	<section role="region" class="cust-support ${coverSearch}" data-page-title="page-title" data-title="${pageItem.name}">
		<dsp:include page="${templateJSP}">
			<dsp:param name="templateItem" value="${pageItem.pageTemplate}" />
			<dsp:param name="title" value="${pageItem.name}" />
		</dsp:include>
	</section>

</dsp:page>
