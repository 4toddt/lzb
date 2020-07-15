<dsp:getvalueof var="canonicalRequestUri" param="canonicalRequestUri" />

<c:if test="${empty canonicalUrl}">

<c:choose>
	<c:when test="${not empty canonicalRequestUri}">
		<c:set var="requestUrl" value="${canonicalRequestUri}" scope="request"/>
	</c:when>
	<c:otherwise>
		<c:set var="requestUrl" value="${requestScope['javax.servlet.forward.servlet_path']}" scope="request"/>
	</c:otherwise>
</c:choose>

	<c:choose>
		<c:when test="${fn:startsWith(requestUrl, '/mobile')}">
			
					<c:set var="canonicalUrl" value="${'https://'}${pageContext.request.serverName}${fn:substringAfter(requestUrl, '/mobile')}${canonicalQueryStringVar}" scope="request"/>
				
		</c:when>
		<c:otherwise>
			
				
					
					<c:set var="canonicalUrl" value="${'https://'}${pageContext.request.serverName}${requestUrl}${canonicalQueryStringVar}" scope="request"/>
					<c:set var="alternateUrl" value="${'https://'}${pageContext.request.serverName}${'/mobile'}${requestUrl}${canonicalQueryStringVar}" scope="request"/>

		</c:otherwise>
	</c:choose>
</c:if>