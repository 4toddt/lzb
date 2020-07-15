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
			<c:set var="selectedBreadcrumbs" value="${element}"/>
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

<%-- 	${sEOTagTitle }
	${sEOTagDescription }
	${sEOKeywords }
	${sEODisplayName } --%>

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

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">cdp</jsp:attribute>
		<jsp:attribute name="title">
			<c:choose>
				<c:when test="${not empty sEOTagTitle}">
					${sEOTagTitle}
				</c:when>
				<c:when test="${not empty selectedFacet}">
					<c:if test="${selectedFacet eq 'Sofas' }">
						<c:set var="selectedFacet" value="Sofas and Couches" />
					</c:if>
					${selectedFacet} | La-Z-Boy
				</c:when>
				<c:when test="${empty selectedFacet and endecaUrl ne '/b/_/N-1nto8nl'}">
					Shop All Furniture | La-Z-Boy
				</c:when>
				<%-- <c:when test="${endecaUrl eq '/b/_/N-1nto8nl' }"> --%>
				<c:when test="${fn:contains(endecaUrl, 'N-1nto8nl')}">
					Urban Attitudes | La-Z-Boy
				</c:when>
				<c:when test="${not empty content.title}">
					${content.title}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.title" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>

		<c:choose>
			<c:when test="${not empty sEOTagDescription }">
				<c:set var="metaDesc" value="${sEOTagDescription}" />
			</c:when>
			<c:when test="${selectedFacet eq 'Recliners'}">
				<c:set var="metaDesc"
					value="Explore our stylish and durable reclining chair, power recliner, lift chair and more.
					Available in leather and vibrant fabrics with eco-friendly cushion options" />
			</c:when>
			<c:when test="${selectedFacet eq 'Chairs'}">
				<c:set var="metaDesc"
					value="Explore the La-Z-Boy collection of comfortable and stylish stationary, reclining and swivel chairs in rich leathers,
					stylish fabric patterns and cushion options" />
			</c:when>
			<c:when test="${selectedFacet eq 'Sofas and Couches'}">
				<c:set var="metaDesc"
					value="Choose from different styles and upholstery options for your La-Z-Boy leather sofa,
					sleep sofa or leather couch. View our reclining sofas and stationary sofas." />
			</c:when>
			<c:when test="${selectedFacet eq 'Sectionals'}">
				<c:set var="metaDesc"
					value="Explore the La-Z-Boy collection of motion and stationary sectional sofas.  Available in performance leathers,
					stylish fabrics and eco-friendly cushion options" />
			</c:when>
			<c:when test="${selectedFacet eq 'Ottomans'}">
				<c:set var="metaDesc"
					value="Ottoman footstools not only bring comfort but also add functionality to a living room.
					Choose from storage ottomans, table tray ottomans and more at La-Z-Boy.
					" />
			</c:when>
			<c:when test="${selectedFacet eq 'Loveseats'}">
				<c:set var="metaDesc"
					value="Add modern comfort to your living room with La-Z-Boy's stationary and reclining loveseats.
					Styles range from the sleek leather loveseat and the classic pub back.
					" />
			</c:when>
			<c:when test="${selectedFacet eq 'Tables'}">
				<c:set var="metaDesc"
					value="Complement your La-Z-Boy furniture with accent tables and stylish consoles.
					Shop the La-Z-Boy collection for coffee tables, end tables and more for your home.
					" />
			</c:when>
			<c:when test="${selectedFacet eq 'On Sale'}">
				<c:set var="metaDesc"
					value="Shop on-sale furniture at La-Z-Boy.  Search by category and fabric options to find new sofas,
					recliners, loveseats, sectionals, chairs and other home furniture.
					" />
			</c:when>
			<c:when test="${fn:contains(endecaUrl, 'N-1nto8nl')}"><%-- urban attitudes --%>
				<c:set var="metaDesc"
					value="La-Z-Boy's new collection of premium sofas, chairs and accents is an eclectic mix that's perfectly proportioned for your
					modern living space." />
			</c:when>
			<c:otherwise>
				<%-- <c:set var="metaDesc" value="${content.metaDescription}" /> --%>
				<c:set var="metaDesc"
					value="
					See product details for the full line of La-Z-Boy products and furniture collections.  Search by category to find
					new sofas, recliners and other home furniture.
					" />
			</c:otherwise>
		</c:choose>

		<%--  <c:set var="metaDesc" value="${content.metaDescription}" /> --%>
	<!-- selectedFacet :  ${selectedFacet }  ,  Key : ${refinementLabelForSEO}_${selectedFacet} -->

			<c:choose>
				<c:when test="${ empty sEOMetaTagDescription and not empty metaDesc }">
					<meta name="description" content="${metaDesc}" />
				</c:when>
			</c:choose>

		<%--
		<jsp:attribute name="metaDescription">
			<c:choose>
				<c:when test="${not empty content.metaDescription }">
					f22 ${metaDesc}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.metaDescription" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		--%>
		<jsp:attribute name="metaKeywords">
			<c:choose>
				<c:when test="${not empty sEOKeywords }">
					${sEOKeywords}
				</c:when>
				<c:when test="${not empty content.metaKeywords }">
					${content.metaKeywords}
				</c:when>
				<c:otherwise>
					<fmt:message key="meta.home.metaKeywords" />
				</c:otherwise>
			</c:choose>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${seoAlternateURL}</jsp:attribute>
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
		<p class="compare-error-msgs-section" style="display:none;" data-module="messaging-close">
           <span class="compare-error-icon"></span>
           <span class="compare-error-msg">This is an error message</span>
           <span class="compare-error-hide close">Hide</span>
           <span class="compare-error-x close">X</span>
        </p>
        <%-- JIRA DMI-1763 Hide Wishlist UI
		<p class="wishlist-message" style="display:none;">
        	<span class="wishlist-check-icon"></span>
        	<span class="wishlist-message-text"></span>
        	<span class="wishlist-secondary">
        		<a href="#" class="wishlist-continue-browsing">Continue Browsing</a>
        		or
        		<a href="/account/wish_list_items.jsp">View your Favorites</a>
        	</span>
        	<span class="wishlist-close-tag">X</span>
        </p>
		--%>
		<nav role="navigation" class="cdp-nav">

		  	<c:if test="${not empty content.leftContent}">
				<c:forEach var="element" items="${content.leftContent}">
					<dsp:renderContentItem contentItem="${element}"/>
				</c:forEach>
			</c:if>
		</nav>
		<section role="region" class="cdp-content">

				<h1>
				<c:choose>
					<c:when test="${not empty sEODisplayName}">
						${sEODisplayName}
					</c:when>
					<c:when test="${not empty selectedFacet}">
						${selectedFacet}
					</c:when>
					<c:when test="${fn:contains(endecaUrl, 'N-1nto8nl')}">
						Urban-Attitudes
					</c:when>
					<c:otherwise>
						Shop All Furniture
					</c:otherwise>
				</c:choose>

				</h1>
				<h2 class="cdp-description">
				<%--
					<c:choose>
						<c:when test="${not empty sEOTagDescription}">
							${sEOTagDescription}
						</c:when>
						<c:otherwise>
								<c:if test="${not empty content.mainContent}">
									<c:forEach var="element" items="${content.mainContent}">
									  <c:if test="${element['@type'] eq 'CategoryIntroCopy'}">
									  	  	<dsp:renderContentItem contentItem="${element}"/>
									  </c:if>
									</c:forEach>
								</c:if>
						</c:otherwise>
					</c:choose> --%>

					<c:if test="${not empty content.mainContent}">
						<c:forEach var="element" items="${content.mainContent}">
							<c:choose>
								<c:when test="${not empty sEOTagDescription and element['@type'] eq 'ContentSlotMain' and element['name'] eq 'Main Content Slot Intro Text'}">
									${sEOTagDescription} </h2>
								</c:when>
								<c:when test="${empty sEOTagDescription and element['@type'] eq 'ContentSlotMain' and element['name'] eq 'Main Content Slot Intro Text'}">
									 <dsp:renderContentItem contentItem="${element}">
									  	<dsp:param name="selectedFacet" value="${selectedFacet}"/>
								   	</dsp:renderContentItem>
								   	</h2>
								</c:when>
								<c:otherwise>
									 <dsp:renderContentItem contentItem="${element}">
									  	<dsp:param name="selectedFacet" value="${selectedFacet}"/>
								   	</dsp:renderContentItem>
								   	</h2>
								</c:otherwise>
							</c:choose>
						 </c:forEach>
					</c:if>

		</section>
	</main>
	</jsp:body>
	</lzb:pageContainer>

</dsp:page>
