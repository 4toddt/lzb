<%--
  - Cartridge: SearchAdjustments
  - File Name: SearchAdjustments.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the search adjustments.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<c:if test="${not empty contentItem.originalTerms}">
		<div class="search-adjustments">
			<c:forEach var="originalTerm" items="${contentItem.originalTerms}" varStatus="status">
				<c:if test="${not empty contentItem.adjustedSearches[originalTerm]|| not empty contentItem.suggestedSearches[originalTerm]}">
					<%-- Render Adjusted Search Terms --%>
					<c:if test="${not empty contentItem.adjustedSearches[originalTerm]}">
						<p class="adjusted-terms">Your search for <strong class="original-term">"${originalTerm}"</strong> was adjusted to
							<c:forEach var="adjustment" items="${contentItem.adjustedSearches[originalTerm]}" varStatus="status">
								<strong class="adjusted-term"><q>${adjustment.adjustedTerms}</q></strong>
								<c:if test="${!status.last}">, </c:if>
								<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm ne null ? adjustedTerm : ''}${adjustment.adjustedTerms}" scope="request" />
								<c:if test="${!status.last}">
									<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm}," scope="request" />
								</c:if>
							</c:forEach>
						</p>
					</c:if>
					<%-- Render Suggested Search Terms --%>
					<c:if test="${not empty contentItem.suggestedSearches[originalTerm]}">
						<p class="suggested-terms">Did you mean
							<c:forEach var="suggestion" items="${contentItem.suggestedSearches[originalTerm]}" varStatus="status">
								<q><a href="${contextPath}${storeConfig.mobileSearchUrl}${suggestion.navigationState}">${suggestion.label}</a></q>
								<c:if test="${!status.last}">, </c:if>

								<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm ne null ? adjustedTerm : ''}${contentItem.suggestedSearches[originalTerm]}" scope="page" />
								<c:if test="${!status.last}">
									<dsp:getvalueof var="adjustedTerm" value="${adjustedTerm}," scope="page" />
								</c:if>
							</c:forEach>?
						</p>
					</c:if>
				</c:if>
			</c:forEach>
		</div>
	</c:if>

</dsp:page>