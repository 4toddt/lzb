<%--
	- File Name: pagination.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page lays out the pagination for the product listing pages
	- Required Parameters:
	- Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="pagination" value="${endecahelpers:pagination(contentItem,false)}" scope="request"/>

	<%-- START: Pagination --%>
	<div class="pagination-container">
		<div class="pagination">
			<c:forEach items="${pagination.paginationMap}" var="entry" varStatus="loop">
				<c:set var="poffset" value="${entry.value}" />
				<c:set var="linkAction" value="${fn:replace(fn:replace(pageTemplate, '%7Boffset%7D', poffset ), '%7BrecordsPerPage%7D',  contentItem.recsPerPage)}" />
				<c:set var="url" value="${contextPath}${fn:replace(fn:escapeXml(linkAction),'//','/')}" />
				<c:set var="pOptionName" value="${entry.key}" />
				<c:set var="currPage" value="${pagination.currentPageNo}" />

				<c:choose>
					<c:when test="${pOptionName eq '....' || pOptionName eq '...'}">
						<%-- render more pages link --%>
						<a class="more-pages" href="javascript:void(0);" aria-disabled="true">
							<span class="sr-only"><fmt:message key="pagination.more"/></span> <fmt:message key="pagination.ellipsis"/>
						</a>
					</c:when>
					<c:when test="${pOptionName eq currPage && !loop.first && !loop.last}">
						<%-- render active middle page number link --%>
						<a class="page-num active" href="javascript:void(0);" aria-disabled="true">${entry.key}</a>
					</c:when>
					<c:when test="${pOptionName eq currPage && loop.first}">
						<%-- render disabled previous link --%>
						<a class="pagination-prev disabled" href="${url}" aria-disabled="true">
							<span class="sr-only"><fmt:message key="pagination.previous"/></span>
							<span class="icon icon-arrow-left" aria-hidden="true"></span>
						</a>
						<%-- render active first page number link --%>
						<a class="page-num active" href="javascript:void(0);" aria-disabled="true">${entry.key}</a>
					</c:when>
					<c:when test="${pOptionName eq currPage && loop.last}">
						<%-- render active last page number link --%>
						<a class="page-num active" href="javascript:void(0);" aria-disabled="true">${entry.key}</a>
						<%-- render disabled next link --%>
						<a class="pagination-next disabled" href="${url}" aria-disabled="true">
							<span class="sr-only"><fmt:message key="pagination.next"/></span>
							<span class="icon icon-arrow-right" aria-hidden="true"></span>
						</a>
					</c:when>
					<c:when test="${pOptionName eq 'Next'}">
						<%-- render selectable next link --%>
						<a class="pagination-next" href="${url}">
							<span class="sr-only"><fmt:message key="pagination.next"/></span>
							<span class="icon icon-arrow-right" aria-hidden="true"></span>
						</a>
					</c:when>
					<c:when test="${pOptionName eq 'Prev'}">
						<%-- render selectable previous link --%>
						<a class="pagination-prev" href="${url}">
							<span class="sr-only"><fmt:message key="pagination.previous"/></span>
							<span class="icon icon-arrow-left" aria-hidden="true"></span>
						</a>
					</c:when>
					<c:otherwise>
						<%-- render selectable middle page number link --%>
						<a class="page-num" href="${url}">${entry.key}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
	</div>
	<%-- END: Pagination --%>
</dsp:page>