<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="templateItem" param="templateItem" />
	<dsp:getvalueof var="pageItem" param="page" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
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
		      		<c:when test="${dimCrumb.dimensionName eq 'sku.covers'}">

		      			<c:set var="colorArr" value="${fn:split(dimCrumb.label,'~')}" />
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
<c:choose>
<c:when test="${empty navajax}">
	<layout:default>
		<jsp:attribute name="bodyClass">
			two-column-first npc
		</jsp:attribute>
		<jsp:attribute name="pageTitle">
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
		<jsp:attribute name="seoCanonicalURL">${endecaUrl}</jsp:attribute>
		<jsp:body>
		<main role="main" data-module="search-cover">
				<nav class="account secondary-nav" role="navigation">
				  	<c:if test="${not empty contentItem.headerContent}">
			      <c:forEach var="element" items="${contentItem.headerContent}">
				      	<c:if test="${element['@type'] eq 'Breadcrumbs'}">
							<c:set var="selectedBreadcrumbs" value="${element}"/>
						</c:if>
			       </c:forEach>
	  		 	</c:if>

			  	<c:if test="${not empty content.leftContent}">
					<c:forEach var="element" items="${content.leftContent}">
						<c:if test="${element['@type'] ne 'Breadcrumbs'}">
							<dsp:renderContentItem contentItem="${element}" />
						</c:if>
					 </c:forEach>
				 </c:if>
				 </nav><%-- .account secondary-nav --%>
				 <section class="cust-support" role="region">

					<c:if test="${not empty selectedFacet}">
						<h1>${selectedFacet}</h1>
					</c:if>

					<img src="${templateItem.heroImage.url}" />
					${templateItem.contentBlock}

					<c:if test="${not empty content.mainContent}">
						<c:forEach var="element" items="${content.mainContent}">
						   	<dsp:renderContentItem contentItem="${element}">
							   	<dsp:param name="selectedFacet" value="${selectedFacet}"/>
						   	</dsp:renderContentItem>
						 </c:forEach>
					</c:if>
				  </section>
		</main>
	</jsp:body>
	</layout:default>
</c:when>
<c:otherwise>
<%--
		<main role="main">
				<nav class="account secondary-nav" role="navigation">

	  	<c:if test="${not empty content.leftContent}">--%>
			<c:forEach var="element" items="${content.headerContent}">
				<c:if test="${element['@type'] eq 'Breadcrumbs'}">
					<c:set var="selectedBreadcrumbs" value="${element}"/>
				</c:if>
			 </c:forEach>
		<%--</c:if>

		 </nav>
		  --%>
	 <%--<section class="cust-support" role="region"> 
		<c:if test="${empty rlistonlyajax and not empty selectedFacet }"><h1>${selectedFacet}</h1></c:if>--%>

		<c:if test="${not empty content.mainContent}">
			<c:forEach var="element" items="${content.mainContent}">
			   	<c:choose>
					<c:when test="${empty rlistonlyajax}">
			   			<dsp:renderContentItem contentItem="${element}">
				   			<dsp:param name="selectedFacet" value="${selectedFacet}"/>
				   			<dsp:param name="selectedBreadcrumbs" value="${selectedBreadcrumbs}"/>
			   			</dsp:renderContentItem>
				   	 </c:when>
					<c:otherwise>
			   			<c:if test="${(element['@type'] eq 'CoverSearchResultsList') ||
			   						(element['@type'] eq 'ResultsList') || (element['@type'] eq 'CoverSearchRefinementContainer')||
			   						(element['@type'] eq 'FabricSelectorResultsList')}">
			   				<dsp:renderContentItem contentItem="${element}">
				   				<dsp:param name="selectedFacet" value="${selectedFacet}"/>
				   				<dsp:param name="selectedBreadcrumbs" value="${selectedBreadcrumbs}"/>
			   				</dsp:renderContentItem>
						</c:if>
					</c:otherwise>
				</c:choose>
			 </c:forEach>
		</c:if>

	 	<%-- </section>
	</main> --%>


</c:otherwise>
</c:choose>

</dsp:page>
