<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
     <img src="${content.imageURL}"  alt="${content.imageAlt}"/>
     <h4>${content.heading}</h4>
     <p class="small">${content.description}<p>
</dsp:page>

