<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<c:if test="${not empty contentItem.link }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	    <li class="category-promo colspan-2">
    		<a href="${actionURLLink}" class="image-link" aria-label="${contentItem.linkText}" tabindex="0"><img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" /></a>
	    	<div class="content">
          		<h4>${contentItem.title}</h4>
          			<c:if test="${not empty contentItem.description}">
              		<p class="small">${contentItem.description}</p>
            		</c:if>
            	 <a href="${actionURLLink}" aria-label="${contentItem.linkText}" tabindex="0">${contentItem.linkText}</a>
            </div>
        </li>
</dsp:page>