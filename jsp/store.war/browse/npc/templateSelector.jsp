<dsp:page>
	<dsp:importbean bean="/com/lzb/content/npc/LZBNPCConfiguration" />

	<dsp:getvalueof var="templateJSPMap" bean="LZBNPCConfiguration.npcPageTemplateMap" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:getvalueof var="showLeftNav" param="showLeftNav" />

	<dsp:getvalueof var="templateName" value="${pageItem.pageTemplate.templateName}" />
	<dsp:getvalueof var="templateJSP" value="${templateJSPMap[templateName]}" />

	<c:if test="${pageItem.seoName eq 'CoverSearch'}">
		<c:set var="coverSearch" value="coverSearch" />
	</c:if>
	
	<div class="mainCoverSearchContainer ${coverSearch}">
		<dsp:include page="${templateJSP}">
			<dsp:param name="templateItem" value="${pageItem.pageTemplate}" />
			<dsp:param name="showLeftNav" value="${showLeftNav}" />
		</dsp:include>
	</div>

</dsp:page>