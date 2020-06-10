<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" bean="/OriginatingRequest.contextPath" />
	
	<c:if test="${not empty content.originalTerms}">
			<c:forEach var="originalTerm" items="${content.originalTerms}" varStatus="status">
				<c:if test="${not empty content.adjustedSearches[originalTerm]|| not empty content.suggestedSearches[originalTerm]}">
					<img class="response-icon" src="${assetsBasePath}/img/error-icon.png" alt="" />
					<c:if test="${not empty content.adjustedSearches[originalTerm]}">
						<p>Your search for <strong>"${originalTerm}"</strong> was adjusted to
							<c:forEach var="adjustment" items="${content.adjustedSearches[originalTerm]}" varStatus="status">
								${adjustment.adjustedTerms}
								<c:if test="${!status.last}">, </c:if>
								<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm ne null ? adjustedTerm : ''}${adjustment.adjustedTerms}" scope="request" />
								<c:if test="${!status.last}">
									<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm}," scope="request" />
								</c:if>
							</c:forEach>
						</p>
					</c:if>
					<c:if test="${not empty content.suggestedSearches[originalTerm]}">
						<p>Did you mean
							<c:forEach var="suggestion" items="${content.suggestedSearches[originalTerm]}" varStatus="status">
								&quot;<a href="${contextPath}/s${suggestion.navigationState}">${suggestion.label}</a>&quot;
								<c:if test="${!status.last}">, </c:if>

								<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm ne null ? adjustedTerm : ''}${content.suggestedSearches[originalTerm]}" scope="page" />
								<c:if test="${!status.last}">
									<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm}," scope="page" />
								</c:if>
							</c:forEach>?
						</p>
					</c:if>
				</c:if>
			</c:forEach>
	</c:if>

</dsp:page>