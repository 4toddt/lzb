<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<dsp:getvalueof var="rootContentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.rootContentItem}" />

	<dsp:include page="/includes/seo-canonical.jsp">
		<dsp:param name="canonicalRequestUri" value="${rootContentItem.canonicalRequestUri}"/>
	</dsp:include>

	<c:if test="${not empty content.headerContent}">
	   <c:forEach var="element" items="${content.headerContent}">
	    <c:if test="${element['@type'] eq 'Breadcrumbs'}">

	     <c:forEach var="dimCrumb" items="${element.refinementCrumbs}">
	      <c:if test="${dimCrumb.dimensionName eq 'product.category'}">
		<c:set var="selectedFacet" value="${dimCrumb.label}"/>
	      </c:if>
	     </c:forEach>
		<c:if test="${empty selectedFacet}">
		     <c:forEach var="dimCrumb" items="${element.refinementCrumbs}" end="1">
		      <c:if test="${dimCrumb.dimensionName ne 'product.category'}">
		      	<c:choose>
		      		<c:when test="${dimCrumb.dimensionName eq 'sku.color'}">
		      			<c:set var="colorArr" value="${fn:split(refinement.label,'~')}" />
		      			<c:if test="${fn:length(colorArr) > 1}">
							<c:set var="selectedFacet" value="${colorArr[1]}"/>
						</c:if>
		      		</c:when>
		      		<c:otherwise>
		      			<c:set var="selectedFacet" value="${dimCrumb.label}"/>
		      		</c:otherwise>
		      	</c:choose>
		      </c:if>
		     </c:forEach>
		</c:if>
	    </c:if>
	    </c:forEach>
	 </c:if>

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">cdp</jsp:attribute>
		<jsp:attribute name="title">
				<c:choose>
				<c:when test="${not empty selectedFacet}">
					${selectedFacet}
				</c:when>
				<c:when test="${not empty content.title }">
					${content.title}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.title" />
				</c:otherwise>
				</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty content.metaDescription }">
					${content.metaDescription}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.metaDescription" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaKeywords">
			<c:choose>
				<c:when test="${not empty content.metaKeywords }">
					${content.metaKeywords}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.metaKeywords" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${endecaUrl}</jsp:attribute>
		<jsp:body>

			<c:if test="${not empty content.headerContent}">
			      <c:forEach var="element" items="${content.headerContent}">
				      	<c:if test="${element['@type'] eq 'Breadcrumbs'}">
							<c:set var="selectedBreadcrumbs" value="${element}"/>
							<dsp:renderContentItem contentItem="${element}">
								<dsp:param name="selectedBreadcrumbs" value="${selectedBreadcrumbs}"/>
							</dsp:renderContentItem>
						</c:if>
			       </c:forEach>
	  		 	</c:if>

		<main role="main">
			<nav role="navigation" class="cdp-nav">

		  	<c:if test="${not empty content.leftContent}">
				<c:forEach var="element" items="${content.leftContent}">
					<c:if test="${element['@type'] eq 'Breadcrumbs'}">
						<c:set var="selectedBreadcrumbs" value="${element}"/>
					</c:if>
				   	<dsp:renderContentItem contentItem="${element}">
						<dsp:param name="selectedBreadcrumbs" value="${selectedBreadcrumbs}"/>
					</dsp:renderContentItem>
				 </c:forEach>
			</c:if>
			</nav>
			<section role="region" class="cdp-content search-content">
				<%-- ${selectedFacet} --%>
			<c:if test="${not empty content.mainContent}">
				<c:forEach var="element" items="${content.mainContent}">
			 		<c:forEach var="mainContent" items="${element.contents}">
			 			<c:if test ="${mainContent['@type'] eq 'CoverResultsList'}">
			 				<c:set var ="results" value ="${mainContent.totalNumRecs}" scope ="request"/>
			 			</c:if>
			 		</c:forEach>
			 	</c:forEach>
				<c:forEach var="element" items="${content.mainContent}">
	 				<c:choose>
	 					<c:when test="${ element['@type'] eq 'SearchAdjustments'}">
		 				  	<dsp:renderContentItem contentItem="${element}">
						   	 <dsp:param name="resultCount" value="${results}"/>
					   	    </dsp:renderContentItem>
					  </c:when>
					  <c:otherwise>
					  	<dsp:renderContentItem contentItem="${element}">
					   	    <dsp:param name="selectedFacet" value="${selectedFacet}"/>
					   	</dsp:renderContentItem>
					  </c:otherwise>
	 				</c:choose>
				 </c:forEach>
			</c:if>
			</section><%-- .cdp-content search-content --%>
	</jsp:body>
	</lzb:pageContainer>
</dsp:page>
