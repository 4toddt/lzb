<%--
  - Cartridge: ResultsList
  - File Name: ResultsList.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up product results.
  - Required Parameters: contentItem - results list type
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/com/lzb/content/record/LZBEndecaRecord" />
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="pageTypeForTracking" value="index" scope="request" />
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<%-- Display Records in Results List Start--%>
	<c:set var="cdpProductListForTracking" value="" scope="request" />
	<c:set var="cdpProductListSeparator" value="" />
	<%-- PromoSlots --%>
	<c:set var="promoslots" value="${contentItem.promoSlots}"/>

	<dsp:setvalue bean="ProductList.prevPageURl" value="${contentItem.navurl}"/>

	<c:choose>
		<%-- Render Results --%>
		<c:when test="${contentItem.totalNumRecs > 0}">
			<%-- Define ResultsList Variables --%>
			<c:set var="firstRecNum" value="${contentItem.firstRecNum}" />
			<c:set var="lastRecNum" value="${contentItem.lastRecNum}" />
			<c:set var="totalNumRecs" value="${contentItem.totalNumRecs}" />

			<%-- START: Sort Sidebar --%>
		    <dsp:include page="/browse/includes/sort.jsp">
				<dsp:param name="totalNumRecs" value="${totalNumRecs}"/>
				<dsp:param name="sortOptions" value="${contentItem.sortOptions}"/>
		   </dsp:include>
			<%-- END: Sort Sidebar --%>

			<%-- START: Category Navigation Bar --%>
		     <dsp:include page="/browse/includes/categoryNavBar.jsp">
				 <dsp:param name="totalNumRecs" value="${totalNumRecs}"/>
			</dsp:include>
			<%-- END: Category Navigation Bar --%>

			<%-- START: Applied Facets --%>
		    <dsp:include page="/browse/includes/appliedFacets.jsp" />
			<%-- END: Applied Facets --%>

			<%-- START: Product Grid --%>
		 	<div class="category-product-grid">
		 		<ul class="product-grid">
		 			<c:forEach var="record" items="${contentItem.records}" varStatus="loopStatus">
						<dsp:getvalueof var="recIndex" value="${loopStatus.index}"/>
						<dsp:getvalueof var="lastRec" value="${loopStatus.last}"/>
						<dsp:getvalueof var="recType" value="${record.attributes['type']}"/>
						<c:set var="cdpProductListForTracking" value='${cdpProductListForTracking}${cdpProductListSeparator}"${repositoryId}"' scope="request" />
						<c:set var="cdpCategoryNameForTracking"	value="${element.attributes['parentCategory.displayName']}"	scope="request" />

						<c:if test="${loopStatus.index != contentItem.recsPerPage || not empty param.viewAll }">
							<c:choose>
								<c:when test="${recType eq 'promo'}">
									<%-- Render Promo Tile --%>
									<c:forEach var="slot" items="${promoslots}">
										<dsp:getvalueof var="index" value="${slot.index}"/>
										<c:if test="${index == recIndex}">
											<li>
												<dsp:renderContentItem contentItem="${slot}"/>
											</li>
										</c:if>
									</c:forEach>
								</c:when>
								<c:when test="${recType eq 'promoext'}">
									<li></li>
								</c:when>
								<c:otherwise>
									<%-- Render Product Tile --%>
									<li>
										<dsp:include page="/browse/includes/productTile.jsp">
											<dsp:param name="record" value="${record}"/>
										</dsp:include>
									</li>
									<c:set var="cdpProductListSeparator" value="," />
								</c:otherwise>
							</c:choose>
						</c:if>
		 			</c:forEach>
		 		</ul>
		 	</div>
			<%-- END: Product Grid --%>

		 	<%-- START: Pagination --%>
		 	<dsp:include page="/browse/includes/pagination.jsp" />
			<%-- END: Pagination --%>

			<%-- Empty Results Message AJAX Placeholder --%>
			<div id="null-filters-message"></div>
		</c:when>
		<%-- Render No Results --%>
		<c:otherwise>
			<%-- No Results Message for AJAX Filtering --%>
			<div id="null-filters-message">Sorry, no products found.</div>
		</c:otherwise>
	</c:choose>
</dsp:page>
