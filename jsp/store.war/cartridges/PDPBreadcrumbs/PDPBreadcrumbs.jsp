<%--
  Breadcrumbs

  Renders refinement that have been selected. Selected refinements can consist
  of search refinements, dimension refinements or range filter refinements.

  There are a number of different types of breadcrumb that can be returned
  inside this content item:
    refinementCrumbs - As a result of selecting a dimension
    searchCrumbs - As a result of performing a search
    rangeFilterCrumbs - As a result of applying a range filter
--%>
<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/atg/multisite/Site"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/common/droplet/LZBWebTrendContentDroplet"/>

	<dsp:getvalueof var="contextPath" bean="Site.contextRoot"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
	<dsp:getvalueof var="prodName" param="prodName" />

	<nav aria-label="breadcrumb" role="navigation" class="breadcrumb-wrapper pdp-breadcrumbs">
		<ul>
			<c:if test="${not empty content.refinementCrumbs}">

				<li>
					<span itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
						<a href="${storeConfig.hostName}" title="" itemprop="url">
							<span itemprop="title"><fmt:message key="breadcrumb.home"/></span>
						</a>
					</span>
				</li>

				<%-- Display searched terms if there are any --%>
				<c:if test="${not empty content.searchCrumbs}">
					<fmt:message var="searchTextQuotes" key="common.breadcrumbs.searchTextQuote"/>
					<c:forEach var="searchCrumb" items="${content.searchCrumbs}">
						<%-- Dimension refinement value e.g "Red" --%>
						<dsp:include page="/global/productDetailRenderNavLink.jsp">
							<dsp:param name="navAction" value="${searchCrumb.removeAction}"/>
							<dsp:param name="text" value="${searchTextQuotes}${searchCrumb.terms}${searchTextQuotes}"/>
							<dsp:param name="showRemoveLink" value="true"/>
						</dsp:include>
					</c:forEach>
				</c:if>

				<%-- Display currently selected refinements if there are any --%>
				<c:forEach var="dimCrumb" items="${content.refinementCrumbs}">

					<%-- Get dimension name for refinement --%>
					<c:set var="dimensionName" value="${dimCrumb.dimensionName}" />

					<c:if test="${not empty dimCrumb.ancestors}">
						<c:set var="showRemoveButton" value="true"/>
						<c:forEach var="ancestor" items="${dimCrumb.ancestors}">
							<%-- Check whether it's product.category dimension and if so enable editing of corresponding category in preview. --%>
							<c:if test="${dimensionName eq 'product.category'}">
								<dsp:include page="/includes/webtrendsContent.jsp">
									<dsp:param name="page" value="Products"  />
									<dsp:param name="label" value="${ancestor.label}"/>
								</dsp:include>
								<c:set var="categoryId" value="${ancestor.properties['category.repositoryId'] }"/>
								<dsp:include page="/global/productDetailRenderNavLink.jsp">
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
						<dsp:include page="/includes/webtrendsContent.jsp">
							<dsp:param name="page" value="Products"  />
							<dsp:param name="label" value="${dimCrumb.label}"/>
						</dsp:include>
						<li>
							<span itemscope itemtype="http://data-vocabulary.org/Breadcrumb">
								<c:set var="continueShopping" value="${storeConfig.hostName}${endecaCatId.url}" scope="request" />
								<a href="${storeConfig.hostName}${endecaCatId.url}" title="${dimCrumb.label}" itemprop="url">
									<span itemprop="title">${dimCrumb.label}</span>
								</a>
							</span>
						</li>
					</c:if>

					<li>${prodName}</li>

				</c:forEach>

			</c:if>
		</ul>
  </nav>

</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/10.2/Storefront/j2ee/store.war/cartridges/Breadcrumbs/Breadcrumbs.jsp#5 $$Change: 796430 $--%>
