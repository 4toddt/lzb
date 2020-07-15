<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<section role="region" class="cust-support" data-template-name="iframe">
		<dsp:include page="/browse/npc/pageTitle.jsp">
			<dsp:param name="pageTitle" value="${pageItem.name}"  />
		</dsp:include>		
		<iframe src="${templateItem.iFrameURL}" frameborder="0" class="style-finder"></iframe>
	</section>
</dsp:page>