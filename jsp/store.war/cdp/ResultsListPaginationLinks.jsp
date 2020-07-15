<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %>

<dsp:page>

	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>

	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}"/>
	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:set var="pagination" value="${endecahelpers:pagination(contentItem,false)}" scope="request"/>
	
	<c:forEach items="${pagination.paginationMap}" var="entry" varStatus="loop">
		<c:set var="poffset" value="${entry.value}" />
		<c:set var="linkAction" value="${fn:replace(fn:replace(pageTemplate, '%7Boffset%7D', poffset ), '%7BrecordsPerPage%7D',  contentItem.recsPerPage)}" />
		<c:set var="url" value="${fn:replace(fn:escapeXml(linkAction),'//','/')}" />
		<c:set var="pOptionName" value="${entry.key}" />
		<c:set var="currPage" value="${pagination.currentPageNo}" />
		
		<c:choose>
			<c:when test="${pOptionName eq '....' || pOptionName eq '...'}">
				...
			</c:when>
			<c:when test="${pOptionName eq currPage && !loop.first && !loop.last}">
				<span class="aj-pagination active-page">${entry.key}</span>
			</c:when>
			<c:when test="${pOptionName eq currPage && loop.first}">
				<span class="icon-arrow-left inactive"></span>
				<span class="aj-pagination active-page">${entry.key}</span>
			</c:when>
			<c:when test="${pOptionName eq currPage && loop.last}">
				<span class="aj-pagination active-page">${entry.key}</span>
				<span class="icon-arrow-right inactive"></span>
			</c:when>
			<c:when test="${pOptionName eq 'Next'}">
				<span class="aj-pagination" data-nstate="${url}">
					<span class="next-div"><span class="icon-arrow-right"></span></span>
				</span>
			</c:when>
			<c:when test="${pOptionName eq 'Prev'}">
				<span class="aj-pagination" data-nstate="${url}">
					<span class="prev-div"><span class="icon-arrow-left"></span></span>
				</span>
			</c:when>
			<c:otherwise>
				<span class="aj-pagination" data-nstate="${url}">${entry.key}</span>
			</c:otherwise>
		</c:choose>
	</c:forEach>

</dsp:page>
