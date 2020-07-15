<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

	<c:if test="${not empty contentItem.imageLink }">
		<dsp:droplet name="ActionURLDroplet">
			<dsp:param name="action" value="${contentItem.imageLink}" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="actionURLLink" param="actionURL" />
			</dsp:oparam>
			<dsp:oparam name="empty">
			</dsp:oparam>
		</dsp:droplet>
	</c:if>

	    <li class="visual-link-group">
	    <c:choose>
	    	<c:when test="${not empty actionURLLink }">
	    		<a href="${actionURLLink}" class="image-link" aria-label="${contentItem.title}" tabindex="0"><img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" /></a>
	    </c:when>
	    <c:otherwise>
	    		<img src="${contentItem.imageUrl}" alt="${contentItem.imageAltText}" />
	    </c:otherwise>
	    </c:choose>
          <h4>${contentItem.title}</h4>
          	<c:if test="${not empty contentItem.description}">
              <p class="small">${contentItem.description}</p>
            </c:if>
          	<ul>
          	<c:if test="${not empty contentItem.links}">
            	<c:forEach var="element" items="${contentItem.links}">
                	<dsp:renderContentItem contentItem="${element}" />
                </c:forEach>
            </c:if>
          </ul>
        </li>
</dsp:page>