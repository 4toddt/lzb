<dsp:page>
		<dsp:getvalueof var="pageTitleValue" param="pageTitle" />
		<c:choose>
				<c:when test="${not empty sEODisplayName}">
					<h1>${sEODisplayName}</h1>
				</c:when>
				<c:otherwise>
						<h1>${pageTitleValue}</h1>			
				</c:otherwise>				
		 </c:choose>
</dsp:page>