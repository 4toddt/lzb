<dsp:page>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />

	<section role="region" class="cust-support" data-template-name="article">
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<div><dsp:valueof value="${templateItem.contentBlock}" valueishtml="true"/></div>
	</section>

</dsp:page>