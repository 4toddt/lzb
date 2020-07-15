<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="term" param="Ntt" scope="page" />
	<dsp:getvalueof var="selectedFacet" param="selectedFacet" />
	<fmt:message var="productPagePath" key="pdp.storePath"/>
	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="${contentItem.navurl}"  />
	<dsp:setvalue bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="${contentItem.navurl}"  />
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL" value="${contentItem.navurl}"  />
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsErrorURL" value="${contentItem.navurl}"  />
	<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>
	<dsp:setvalue bean="ProductList.prevPageURl" value="${contentItem.navurl}"/>
	<dsp:include page="/global/giftlisterrors.jsp">
		<dsp:param name="formHandler" bean="GiftlistFormHandler" />
	</dsp:include>
	<dsp:include page="/includes/global/errors.jsp">
			<dsp:param name="formHandler" bean="ProfileFormHandler"/>
	</dsp:include>
	<c:set var="pageTypeForTracking" value="index" scope="request" />
	<dsp:getvalueof var="catName" param="${catName}" />
	<c:choose>
		<c:when test="${contentItem.totalNumRecs > 0}">

			<c:set var="firstRecNum" value="${contentItem.firstRecNum}" />
			<c:set var="lastRecNum" value="${contentItem.lastRecNum}" />
			<c:set var="totalRecs" value="${contentItem.totalNumRecs}" scope="request" />


			<%-- compare bar --%>
			<%@include file="/comparisons/gadgets/compareBar.jsp"%>

			<div class="cdp-selections" data-module="cdp-sort-functionality">
				<div id="search-results" class="cdp-item-count" data-results="${contentItem.totalNumRecs}">
					<span class="prod-count">${contentItem.totalNumRecs}</span> items
				</div>

				<div class="cdp-pagination-pages pagination-top hide">
					<jsp:include page="${originatingRequest.contextPath}/cdp/ResultsListPaginationLinks.jsp" />
				</div>

				<c:forEach items="${contentItem.sortOptions}" var="sortOption">
					<c:if test="${sortOption.selected}">
						<fmt:message var="selectedSortOption" key="${sortOption.label}"/>
					</c:if>
				</c:forEach>


				<div class="cdp-sort-by-label toggle-menu" tabindex="0">
					<fmt:message key="sort.by.label"/> | <span class="sort-label-value">${selectedSortOption}</span> <span aria-hidden="true" class="icon-arrow-down"></span>
				</div>

				<!-- display Sort Options drawer Start-->
				<c:set var="count" value="0"/>
				<div class="cdp-sort-drawer">
					<fieldset>
						<div class="cdp-sort-by" data-searchname="Sort">
							<c:forEach items="${contentItem.sortOptions}" var="sortOption">
								<c:set var="count" value="${count + 1}"/>
								<c:set var="cPath" value="${fn:replace(sortOption.contentPath ,'//', '/')}" />
								<c:choose>
									<c:when test="${sortOption.selected}">
										<div class="custom-radio">
											<input type="radio" id="sortby-radio${count}" data-sortvalue="${cPath}${sortOption.navigationState}" value="${cPath}${sortOption.navigationState}" name="cdp-sort-radio" checked="checked" tabindex="0"/>
											<label for="sortby-radio${count}"><fmt:message key="${sortOption.label}"/></label>
										</div>
									</c:when>
									<c:otherwise>
										<div class="custom-radio">
											<input type="radio" id="sortby-radio${count}" data-sortvalue="${cPath}${sortOption.navigationState}" value="${cPath}${sortOption.navigationState}" name="cdp-sort-radio" tabindex="0"/>
											<label for="sortby-radio${count}"><fmt:message key="${sortOption.label}"/></label>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</fieldset>
				</div>
				<!-- Display Sort Options drawer End-->

			</div><%-- .cdp-selections --%>

			<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
			<ul class="cdp-item-wrapper aj-pagination-data sort-by-data refinement-data" data-module="cdpCompare rollover-img detail-resize social-share-icons">
				<jsp:include page="${originatingRequest.contextPath}/cdp/ResultsListRecordsLoop.jsp" />
			</ul><%-- .cdp-item-wrapper --%>

			<div class="cdp-selections pagination-bottom">
				<div class="cdp-pagination-pages">
					<jsp:include page="${originatingRequest.contextPath}/cdp/ResultsListPaginationLinks.jsp" />
				</div>
			</div>

		</c:when>
		<c:otherwise>
			<fmt:message var="noResultsMsg" key="display.noresults.msg"/>
			<fmt:message var="noResultsMsgExt" key="display.noresults.msgExt"/>
			<div class="search-no-result">
				<c:if test="${not empty term}">
					<strong>Search Results for ${fn:escapeXml(term)}:</strong>
				</c:if>
			 	<p>${noResultsMsg} <q>${fn:escapeXml(term)}</q> ${noResultsMsgExt}</p>
			 	<c:if test="${empty contentItem.records}">
					<c:set var="splitArr" value="${fn:split(term, '|')}" />
					<c:set var="length" value="${fn:length(fn:split(term,'|'))}" />

					<dsp:droplet name="InvokeAssembler">
						<dsp:param name="includePath" value="/pages/no-results" />
						<dsp:oparam name="output">
						 <dsp:getvalueof var="content" 	vartype="com.endeca.infront.assembler.ContentItem" 	param="contentItem" />
						</dsp:oparam>
					</dsp:droplet>
				</div><%-- .search-no-result --%>
				<div class="search-tips">
						<c:forEach var="element" items="${content.mainContent}" varStatus="status">
								<dsp:renderContentItem contentItem="${element}" />
						</c:forEach>
				</div><%-- .search-tips --%>

				</c:if>
		</c:otherwise>
	</c:choose><%-- total number of records test --%>

	<%-- including jsp for form comarison form submittion --%>
	<c:set var="queryString" value="${requestScope['javax.servlet.forward.query_string']}"/>
	<c:if test="${fn:contains(queryString, '&_requestid')}">
		<c:set var="queryString" value='${fn:substringBefore(queryString, "&_requestid")}'/>
	</c:if>
	<c:choose>
		<c:when test="${not empty queryString}">
			<c:set var="endecaUrlforCategory" value="${requestScope['javax.servlet.forward.request_uri']}?${queryString}" />
		</c:when>
		<c:otherwise>
			<c:set var="endecaUrlforCategory" value="${requestScope['javax.servlet.forward.request_uri']}" />
		</c:otherwise>
	</c:choose>
	<c:if test="${contentItem.categoryPage eq true}">
		<dsp:include page="/comparisons/gadgets/formCompare.jsp">
		<dsp:param name="url" value="${contentItem.navurl}"/>
		</dsp:include>
	</c:if>
</dsp:page>
