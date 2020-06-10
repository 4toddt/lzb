<dsp:page>
	<dsp:getvalueof var="templateItem" param="templateItem" />
	<img src="${templateItem.heroImage.url}" alt="${templateItem.heroImage.description}" />
	<dsp:valueof value="${templateItem.contentBlock}" valueishtml="true"/>
</dsp:page>