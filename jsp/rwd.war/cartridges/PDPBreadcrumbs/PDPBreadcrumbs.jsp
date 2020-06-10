<%--
  - Cartridge: PDPBreadcrumbs
  - File Name: PDPBreadcrumbs.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description:
  		Renders refinement that have been selected. Selected refinements can consist
  		of search refinements, dimension refinements or range filter refinements.

  		There are a number of different types of breadcrumb that can be returned
  		inside this content item:
			refinementCrumbs - As a result of selecting a dimension
			searchCrumbs - As a result of performing a search
			rangeFilterCrumbs - As a result of applying a range filter
  - Required Parameters:
  	- contentItem,
	- productName: name of the product defined as a request scope variable in ProductDetailsPage,
	- canShip: product can ship boolean defined as request scope variable in ProductDetailsPage
  - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/atg/multisite/Site"/>
	<dsp:importbean bean="/com/lzb/common/droplet/LZBWebTrendContentDroplet"/>
  	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<section class="breadcrumbs">
		<ul aria-label="breadcrumbs" role="navigation">
			<c:if test="${not empty contentItem.refinementCrumbs}">
				<li>
					<span itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
                        <a class="crumb" href="${contextPath}" title="" itemprop="url">
							<span itemprop="title"><fmt:message key="breadcrumb.home"/></span>
						</a>
					</span>
				</li>

				<%-- Display searched terms if there are any --%>
				<c:if test="${not empty contentItem.searchCrumbs}">
					<fmt:message var="searchTextQuotes" key="common.breadcrumbs.searchTextQuote"/>
					<c:forEach var="searchCrumb" items="${contentItem.searchCrumbs}">
						<%-- Dimension refinement value e.g "Red" --%>
                        <%-- TODO: I don't think this include file is needed as it is not rendering. please confirm. copied from store.war --%>
						<dsp:include page="/browse/includes/pdp/productDetailRenderNavLink.jsp">
							<dsp:param name="navAction" value="${searchCrumb.removeAction}"/>
							<dsp:param name="text" value="${searchTextQuotes}${searchCrumb.terms}${searchTextQuotes}"/>
							<dsp:param name="showRemoveLink" value="true"/>
						</dsp:include>
					</c:forEach>
				</c:if>

				<%-- Display currently selected refinements if there are any --%>
				<c:forEach var="dimCrumb" items="${contentItem.refinementCrumbs}">
					<%-- Get dimension name for refinement --%>
					<c:set var="dimensionName" value="${dimCrumb.dimensionName}" />

					<c:if test="${not empty dimCrumb.ancestors}">
						<c:set var="showRemoveButton" value="true"/>

						<c:forEach var="ancestor" items="${dimCrumb.ancestors}">
							<%-- Check whether it's product.category dimension and if so enable editing of corresponding category in preview. --%>
							<c:if test="${dimensionName eq 'product.category'}">

                                <dsp:include page="/sitewide/includes/webtrendsContent.jsp">
									<dsp:param name="page" value="Products"  />
									<dsp:param name="label" value="${ancestor.label}"/>
								</dsp:include>

								<c:set var="categoryId" value="${ancestor.properties['category.repositoryId'] }"/>

                                <%-- TODO: I don't think this include file is needed as it is not rendering. please confirm. copied from store.war --%>
								<dsp:include page="/browse/includes/pdp/productDetailRenderNavLink.jsp">
									<dsp:param name="navAction" value="${ancestor}"/>
									<dsp:param name="text" value="${ancestor.label}"/>
								</dsp:include>
							</c:if>
						</c:forEach>
					</c:if>

					<c:if test="${dimensionName eq 'product.category'}">
						<c:set var="categoryId" value="${dimCrumb.properties['category.repositoryId'] }"/>
						<dsp:droplet name="/atg/commerce/endeca/cache/DimensionValueCacheDroplet">
							<dsp:param name="repositoryId" value="${categoryId}"/>
							<dsp:oparam name="output">
								<dsp:getvalueof var="endecaCatId" param="dimensionValueCacheEntry" />
							</dsp:oparam>
						</dsp:droplet>

						<dsp:include page="/sitewide/includes/webtrendsContent.jsp">
							<dsp:param name="page" value="Products"  />
							<dsp:param name="label" value="${dimCrumb.label}"/>
						</dsp:include>

                        <li>
							<span itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
								<a class="crumb" href="${contextPath}${fn:replace(endecaCatId.url,storeConfig.storeBrowseUrl, storeConfig.mobileBrowseUrl)}" title="${dimCrumb.label}" itemprop="url"><span itemprop="title">${dimCrumb.label}</span></a>
							</span>
						</li>
					</c:if>

					<li>
                        <span class="crumb active">${productName}</span>
                    </li>
				</c:forEach>
			</c:if>
		</ul>

        <c:if test="${canShip eq 'true'}">
            <div class="social-share-container">
                <%-- NOTE: Commenting out this link as Wishlist functionality was removed from mobile redesign until it can be re-written in a future project --%>
                <%-- <a href="javascript:void(0);" aria-label="Add this product to your wishlist"><span class="icon icon-heart-empty" aria-role="button"></span></a> --%>
                <a href="${contextPath}/browse/ajax/socialShareModal.jsp" class="modal-trigger" data-target="social-share-modal" data-size="small" aria-label="Opens modal with social sharing links">
                    <span class="icon icon-share" aria-hidden="true"></span>
                </a>
            </div>
        </c:if>
    </section>
	</dsp:page>