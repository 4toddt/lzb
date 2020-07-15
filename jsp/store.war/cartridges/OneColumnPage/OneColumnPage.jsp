<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem"
		value="${originatingRequest.contentItem}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	
	<c:if test="${not empty content.headerContent}">
	   <c:forEach var="element" items="${content.headerContent}">
	    <c:if test="${element['@type'] eq 'Breadcrumbs'}">
			<c:set var="selectedBreadcrumbs" value="${element}" scope="request"/>
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
								<c:set var="selectedFacet" value="${colorArr[1]}" scope="request" />
							</c:if>
			      		</c:when>
			      		<c:otherwise>
			      			<c:set var="selectedFacet" value="${dimCrumb.label}" scope="request" />
			      		</c:otherwise>
			      	</c:choose>
			      </c:if>
			     </c:forEach>
			</c:if>
	    </c:if>
	    </c:forEach>
	 </c:if>	

	<c:if test="${not empty selectedBreadcrumbs &&  not empty selectedBreadcrumbs.breadcrumbsMap}">
				<c:forEach items="${selectedBreadcrumbs.breadcrumbsMap}" var="breadCrumb">
					<c:forEach items="${breadCrumb.value}" var="refinement" >
						<c:set var="refinementLabelForSEO" value="${refinement.label}" scope="request" />
					</c:forEach>
				</c:forEach>
	</c:if>

	<c:choose>
		<c:when test="${not empty selectedFacet and not empty refinementLabelForSEO}">
			<dsp:include page="/includes/SEOTagData.jsp">
				<dsp:param name="paramKeyForSEOTagData" value="${refinementLabelForSEO}_${selectedFacet}"/>
			</dsp:include>
		</c:when>
		<c:when test="${not empty selectedFacet}">
			<dsp:include page="/includes/SEOTagData.jsp">
				<dsp:param name="paramKeyForSEOTagData" value="${selectedFacet}"/>
			</dsp:include>
		</c:when>
	</c:choose>

	<%-- Define SEO Alternate URL --%>
	<c:choose>
		<%-- Category Page --%>
		<c:when test="${fn:contains(endecaUrl, storeConfig.storeBrowseUrl)}">
			<c:set var="alternateUriReplacePattern" value="${storeConfig.storeBrowseUrl}/" />
			<c:set var="alternateUriReplaceWith" value="${storeConfig.mobileBrowseUrl}/" />
		</c:when>
		<%-- No Search Results Page --%>
		<c:when test="${fn:contains(endecaUrl, storeConfig.storeNoSearchUrl)}">
			<c:set var="alternateUriReplacePattern" value="${storeConfig.storeNoSearchUrl}" />
			<c:set var="alternateUriReplaceWith" value="${storeConfig.mobileNoSearchUrl}" />
		</c:when>
		<%-- Search Results Page --%>
		<c:when test="${fn:contains(endecaUrl, storeConfig.storeSearchUrl)}">
			<c:set var="alternateUriReplacePattern" value="${storeConfig.storeSearchUrl}" />
			<c:set var="alternateUriReplaceWith" value="${storeConfig.mobileSearchUrl}" />
		</c:when>
	</c:choose>
	<c:if test="${not empty alternateUriReplacePattern && not empty alternateUriReplaceWith}">
		<c:set var="seoAlternateURL" value="${fn:replace(endecaUrl, alternateUriReplacePattern, alternateUriReplaceWith)}" />
	</c:if>


<c:if test="${fn:contains(fn:toLowerCase(endecaUrl),'/p/') }">
	<dsp:getvalueof var="productRecord" value="${content.mainContent[0].record.attributes}" />
	<c:set var="prodName" value="${productRecord['sku.displayName']}"  scope="request"/>
</c:if>
	<lzb:pageContainer>
		<jsp:attribute name="pageSpecificCSS">
			<c:if test="${not empty content.cssIncludes}">
				${content.cssIncludes}
			</c:if>
		</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
			<c:if test="${not empty content.jsIncludes}">
				${content.jsIncludes}
			</c:if>
		</jsp:attribute>
		<jsp:attribute name="bodyClass">home one-column<c:if test="${not empty content.bodyStyle}">${content.bodyStyle} SHA2</c:if></jsp:attribute>

		<jsp:attribute name="title">
			<c:choose>
			<c:when test="${not empty prodName }">
				${prodName }
			</c:when>
			<c:when test="${not empty content.title}">
				${content.title}
			</c:when>
			<c:otherwise>
			</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty content.metaDescription }">
					${content.metaDescription}
				</c:when>
				<c:when test="${not empty sEOMetaTagDescription }">
					${sEOMetaTagDescription}
				</c:when>
				<c:when test="${not empty productRecord['sku.longDescription'] }">
					${productRecord['sku.longDescription']}
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="metaKeywords">
			<c:choose>
				<c:when test="${not empty content.metaKeywords }">
					${content.metaKeywords}
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${seoAlternateURL}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${endecaUrl}</jsp:attribute>

		<jsp:body>
			<section role="region" class="cdp-content" data-module="lzb-filters" data-filters>
			
				<p class="compare-error-msgs-section" style="display:none;" data-module="messaging-close">
           <span class="compare-error-icon"></span>
           <span class="compare-error-msg">This is an error message</span>
           <span class="compare-error-hide close">Hide</span>
           <span class="compare-error-x close">X</span>
        </p>

				<c:if test="${not empty content.mainContent}">
					<c:forEach var="element" items="${content.mainContent}">
					   	<dsp:renderContentItem contentItem="${element}" />
					 </c:forEach>
				</c:if>
			</section>

		</jsp:body>
	</lzb:pageContainer>
</dsp:page>
