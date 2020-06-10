<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="linkgroupClass" value="link-group-nh" />
    <li class="link-group">
      <c:if test="${not empty contentItem.title}">
		  <c:set var="linkgroupClass" value="" />
				<h4>${contentItem.title}</h4>
			</c:if>
    	<c:if test="${not empty contentItem.description}">
        <p class="small">${contentItem.description}</p>
      </c:if>
    	<ul class="link-group-list ${linkgroupClass}">
      	<c:if test="${not empty contentItem.links}">
        	<c:forEach var="element" items="${contentItem.links}">
          	<dsp:renderContentItem contentItem="${element}" />
          </c:forEach>
        </c:if>
      </ul>
    </li>
</dsp:page>
