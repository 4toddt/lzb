<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %> 
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/endeca/CoverSearchActionURLDroplet" />
	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}" />
	<dsp:getvalueof var="term" param="Ntt" scope="page" />
	<fmt:message var="productPagePath" key="pdp.storePath"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />

	  <c:set var="contentHostName" value="//content.la-z-boy.com"/>
      <dsp:getvalueof var="recsPerPage" value="${contentItem.recsPerPage}"/>
      <dsp:getvalueof var="totalNumRecs" value="${contentItem.totalNumRecs}"/>
      <dsp:getvalueof var="lastRecNum" value="${contentItem.lastRecNum}"/>
      <dsp:getvalueof var="firstRecNum" value="${contentItem.firstRecNum}"/>
      <dsp:getvalueof var="contentPath" value="${contentItem.pagingActionTemplate.contentPath}"/>
      <dsp:getvalueof var="coverId" param="coverId"/>

<c:set var="nextPageLink" value="${fn:replace(contentItem.pagingActionTemplate.navigationState, '%7Boffset%7D', contentItem.lastRecNum)}"/>
<c:set var="previousPageLink" value="${fn:replace(contentItem.pagingActionTemplate.navigationState, '%7Boffset%7D', firstRecNum-recsPerPage-1)}"/>

<c:if test="${empty rlistonlyajax}"><div class="search-cover-box"></c:if>
		<c:if test="${firstRecNum eq 1}">
			<c:set var="setPreviousEnabled" value="disabled"/>
		</c:if>

		<c:if test="${lastRecNum eq totalNumRecs}">
			<c:set var="setNextEnabled" value="disabled"/>
		</c:if>

				<div class="cover-pagination">
					<span>${contentItem.totalNumRecs}</span>
					<span class="cover-show">
						items ${contentItem.firstRecNum} - ${contentItem.lastRecNum} of ${contentItem.totalNumRecs} total
					</span>
				</div>
				
				 <div class="color-box-nav">
				 	  <c:if test="${setPreviousEnabled ne 'disabled'}">
                      <span class="color-box-left-nav color-box-nav-link" a-disabled="${setPreviousEnabled}" a-val="${contextPath}${contentPath}${previousPageLink}" tabindex="0"></span>
                       <span class="offscreen">Go to Previous Page</span>
                      </c:if>
                 </div>
				
				<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
				<div class="color-box">
				<!-- Display Records in Results List  Start-->			
				<c:forEach var="element" items="${contentItem.records}">
						<c:if test ="${not empty element.attributes['sku.repositoryId']}">
							<dsp:droplet name="CoverSearchActionURLDroplet">
								<dsp:param name="repoID" value="${element.attributes['sku.repositoryId']}" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="coverActionURL" param="actionURL" />
								</dsp:oparam>
								<dsp:oparam name="empty">
								</dsp:oparam>
					    	</dsp:droplet>
							<c:if test="${not empty  coverActionURL}">
								<c:set var ="coverUrl" value ="${coverActionURL}"/>
							</c:if>				
						</c:if>
						<c:if test ="${not empty element.attributes['product.displayName']}">
							<%-- ${element.attributes['product.displayName']} --%>
						</c:if>
						<input type="hidden" id="storeConfigHostName" value="${contentHostName}" />
						<c:set var="storeConfigHostName" value="${contentHostName}" />
						<c:if test="${empty storeConfigHostName}">
							<c:set var="storeConfigHostName" value="http://${storeConfigHostName}" />
						</c:if>
						<c:choose>
							<c:when test ="${not empty coverUrl}">
								<div class="color-box-a">
									<a href="${contextPath}${coverUrl}" title="${element.attributes['sku.displayName']}" aria-label="${element.attributes['sku.displayName']}-link"  >
										<img src="${storeConfigHostName}${storeConfig.coverThumbnailBaseUrl}${element.attributes['sku.repositoryId']}.jpg" alt="${element.attributes['sku.displayName']}" class="color-box-img" />
									</a>
									<div class="cover-tooltip slideIn top" style="display:none" data-module="social-share">
                                         <figure>
                                             <img src="${storeConfigHostName}${storeConfig.coverThumbnailBaseUrl}${element.attributes['sku.repositoryId']}.jpg" class="cover-tt-img" alt="${element.attributes['coverType']} ${element.attributes['sku.displayName']} Cover Image">
                                             <figcaption>
                                                 <h4>Cover details</h4>
                                                 <div><span>Type:</span> ${element.attributes['coverType']}</div>
                                                 <div><span>Color:</span> ${element.attributes['colorFamliy']} (${element.attributes['sku.repositoryId'] })</div>
                                                 <div><span>Pattern:</span> ${element.attributes['patternName']}  (${element.attributes['sku.repositoryId'] })</div>
                                                
                                                 <span class="save-cover" data-skuid="${element.attributes['sku.repositoryId']}" data-productid="${element.attributes['product.repositoryId']}" data-coverid="${element.attributes['defaultCoverSku']}" data-dealerid="${dealerId}" data-wishlistid="${wishlistid}">
                                                 	<img src="/img/heart.png" class="heart" alt="heart icon" tabindex="-1" />Save Cover
                                                 </span>
                                                 <span class="pin-it"><span class="tt-img"></span>
                                                 	<a href="https://www.pinterest.com/lazboy/" rel="external" title="Connect with us on Pinterest" data-service="pinterest">Pin It</a>
                                                 </span>
                                                 <a href="=${contextPath}${coverUrl}"><button class="btn-primary tool-tip-btn" type="button" tabindex="-1">View products in this cover</button></a>
                                             </figcaption>
                                         </figure>
                                     </div>
								</div>
								<%-- <a href="https://www.pinterest.com/lazboy/" rel="external" title="Connect with us on Pinterest">Pin It</a> --%>
							</c:when>
							<c:otherwise>
								<fmt:message var="facbricSelectorUrl" key="fabricSelectorPagePath" />
								<a href="${contextPath}${facbricSelectorUrl}">${element.attributes['product.displayName']}</a>
							</c:otherwise>
						</c:choose>
				 </c:forEach>
				 <!-- Display Records in Results List  End-->
				</div><%-- .color-box --%>
				<div class="color-box-nav">
					  <c:if test="${setNextEnabled ne 'disabled'}">
                     <span class="color-box-right-nav color-box-nav-link" a-disabled="${setNextEnabled}" a-val="${contextPath}${contentPath}${nextPageLink}" tabindex="0"></span>
                     <span class="offscreen">Go to Next Page</span>
                     </c:if>
                </div>
</div><%-- .search-cover-box --%>
</dsp:page>