<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>	
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
	<c:if test="${not empty contentItem.link}">
		<dsp:droplet name="/com/lzb/endeca/ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.link}"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURL" param="actionURL"/>
			</dsp:oparam>
		</dsp:droplet>
		<c:if test="${!empty contentItem.queryString && !empty actionURL}">
			<dsp:getvalueof var="actionURL" value="${actionURL}${fn:contains(actionURL, '?') ? '&': '?' }"/>
		</c:if>
	</c:if>
	
	<dsp:getvalueof var="stepNum" param="stepNum"/>
     <div class="image">
			<c:choose>
 				<c:when test="${not empty actionURL}">
        	<a href="${actionURL}" aria-label="${contentItem.linkText}" tabindex="0">
						<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}"/>
					</a>
				</c:when>
				<c:otherwise>
					<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}"/>
				</c:otherwise>
			</c:choose>
     </div>
     <h4>
         <span class="item-num">${stepNum}</span>
         <span class="item-title">${contentItem.heading}</span>
     </h4>
     <p>
			 ${contentItem.description}
			 <c:if test="${not empty actionURL}">
				 <br />
				 <a href="${actionURL}" aria-label="${contentItem.linkText}" tabindex="0">${contentItem.linkText}</a>
			 </c:if>
		 </p>
</dsp:page>

