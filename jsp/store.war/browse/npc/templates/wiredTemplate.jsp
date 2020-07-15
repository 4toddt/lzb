<dsp:page>

	<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:getvalueof var="selectedCover" param="selectedCover" /> 
	<dsp:getvalueof var="showLeftNav" param="showLeftNav" />

	<c:if test="${pageItem.seoName eq 'CoverSearch'}">
		<dsp:droplet name="/atg/endeca/assembler/droplet/InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/Shared/CoverSearch/CoverSearch" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<dsp:renderContentItem contentItem="${element}" />
			</dsp:oparam>
			<dsp:oparam name="error">
				failed
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	
	<c:if test="${not empty showLeftNav && showLeftNav eq false}">
		<c:set var="noLeftNavClass" value="no-left-nav" />
	</c:if>
	
	<span data-module="favorite-cover"></span>
	<span data-module="search-cover"></span>
	<section role="region" class="cust-support ${noLeftNavClass}" data-template-name="utilitiesWayFinding">

		<c:choose>
			<c:when test="${pageItem.name eq 'Contact Us' or pageItem.seoName eq 'CoverSearch' or pageItem.seoName eq 'catalogs'}"></c:when>
			<c:otherwise>
					<dsp:include page="/browse/npc/pageTitle.jsp">
						<dsp:param name="pageTitle" value="${pageItem.name}"  />
					</dsp:include>		
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${not empty templateItem.url and fn:contains(templateItem.url, '/_/N-')}">
			<dsp:getvalueof var="endecaurl" value="/pages${templateItem.url}" />
			<dsp:droplet name="/atg/endeca/assembler/droplet/InvokeAssembler">
				<dsp:param name="includePath" value="${endecaurl}" />
				<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<c:if test="${not empty element.contents}">
			    <c:forEach var="element1" items="${element.contents}">
			      <section class="cust-support" role="region">
	<%-- 					<h1>${selectedFacet}</h1> --%>
						<%-- <img src="${templateItem.heroImage.url}" />
						${templateItem.contentBlock} --%>
						<c:if test="${not empty element1.mainContent}">
							<c:forEach var="mainContentelement" items="${element1.mainContent}">
							   	<dsp:renderContentItem contentItem="${mainContentelement}">
								   	<dsp:param name="selectedFacet" value="${selectedFacet}"/>
							   	</dsp:renderContentItem>
							 </c:forEach>
						</c:if>
					  </section>
	    </c:forEach>
	   </c:if>
   </section>
	</dsp:oparam>
	<dsp:oparam name="error">
	</dsp:oparam>
</dsp:droplet>
</c:when>
<c:otherwise>
		<dsp:include page="${templateItem.url}" />
</c:otherwise>
</c:choose>


</dsp:page>