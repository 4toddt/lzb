<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/endeca/CoverSearchActionURLDroplet" />
	<c:set var="contentHostName" value="${storeConfig.contentHostName}"/>
	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<dsp:getvalueof var="term" param="Ntt" scope="page" />
	<fmt:message var="productPagePath" key="pdp.storePath"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListContainDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
	<dsp:getvalueof var="dealerId" bean="ProfileTools.priceListId" />

	<c:choose>
		<c:when test="${contentItem.totalNumRecs > 0}">

		<c:if test="${not empty term}">
			<h2>Search Results for ${fn:escapeXml(term)}</h2>
		</c:if>
			<div class="cdp-selections">
				<p class="cdp-item-count">
					items ${contentItem.firstRecNum} - ${contentItem.lastRecNum} of ${contentItem.totalNumRecs} total
				</p>
				<div class="cdp-display-sortby" data-module="cdp-sort-functionality">
					<!-- Display Sort Options Start-->
					<label for="sort-by"><fmt:message key="sort.by.label"/></label>
					<select class="cdp-sort-by" id="sort-by">
						<c:forEach items="${contentItem.sortOptions}" var="sortOption">
								<c:choose>
								<c:when test="${sortOption.selected}">
									<option value="${contextPath}${sortOption.contentPath}${sortOption.navigationState}" selected="selected"><fmt:message key="${sortOption.label}"/></option>
								</c:when>
								<c:otherwise>
									<option value="${contextPath}${sortOption.contentPath}${sortOption.navigationState}"><fmt:message key="${sortOption.label}"/></option>
								</c:otherwise>
						 	 </c:choose>
						</c:forEach>
					</select>
					<!-- Display Sort Options End-->
				</div>
				<div class="cdp-display-count">
					<!-- Display Options Start-->
					<label for="sort-by-items"><fmt:message key="display.options.label" /></label>
					<fmt:message var="displayOptionList" key="display.options.list" />
					<c:set var="displayOptions" value="${fn:split(displayOptionList,'|')}" />
					<select id="sort-by-items">
						<c:forEach var="option" items="${displayOptions}">
							<c:set var="optionsURL" value="${fn:replace(pageTemplate,'%7BrecordsPerPage%7D', option)}" />
							<c:choose>
								<c:when test="${option eq param.Nrpp}">
									<option value="${contextPath}${optionsURL}" selected="selected">${option}</option>
								</c:when>
								<c:otherwise>
									<option value="${contextPath}${optionsURL}" >${option}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
					<!-- Display Options End-->
				</div>
			</div><%-- .cdp-selections --%>
		</div><%-- .cdp-selections --%>
		<ul class="cdp-item-wrapper search-cover">


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
							    <c:choose>
							    	<c:when test="${not empty coverActionURL}">
							    		<c:set var="coverURL" value="${contextPath}${coverActionURL}" />
							    	</c:when>
							    	<c:otherwise>
							    		<fmt:message var="facbricSelectorUrl" key="fabricSelectorPagePath" />
							    		<c:set var="coverURL" value="${contextPath}${facbricSelectorUrl}" />
							    	</c:otherwise>
							    </c:choose>
							    <c:set var="coverImgURL" value="//${contentHostName}${storeConfig.coverThumbnailBaseUrl}${element.attributes['sku.repositoryId']}" />


								<li class="cdp-item">
									<div class="cdp-img-wrapper">
										<%-- XXXXXX SALE IMG XXXXXX
										<img src="/img/sale-overlay.png" class="sale" alt="sale"/>
										--%>
										   <dsp:droplet name="LZBWishListContainDroplet">
	    									 <dsp:param name="configSkuId" value="${element.attributes['sku.repositoryId']}" />
	    									  <dsp:param name="saveCoverRequest" value="${true}" />
	    										 <dsp:param name="profile" bean="/atg/userprofiling/Profile" />
												 <dsp:oparam name="true">
													<dsp:getvalueof var="wishlistid" param="wishListId"/>
													 <a href="#" class='save-cover active-wishlist cdp' data-giftItemId="${wishlistid}" data-wishlist="${true}" data-skuid="${element.attributes['sku.repositoryId']}" data-productid=""  data-dealerid="${dealerId}"><img src="/img/heartred.png" class="heart" alt="heart icon" tabindex="0"/></a>
												</dsp:oparam>
												<dsp:oparam name="false">
												<dsp:getvalueof var="wishlistid" param="wishListId"/>
													 <a href="#" class="save-cover cdp" data-giftItemId="${wishlistid}" data-wishlist="${false}"  data-skuid="${element.attributes['sku.repositoryId']}" data-productid="" data-dealerid="${dealerId}"><img src="/img/heart.png" class="heart" alt="heart icon" tabindex="0"/></a>
												</dsp:oparam>
											</dsp:droplet>

										<a href="${coverUrl}" title="${element.attributes['coverSku.patternName']}" >
											<img src="${coverImgURL}.jpg" alt="${element.attributes['coverSku.colorFamliy']}"/>
										</a>
									</div><%-- .cdp-img-wrapper --%>
									<div class="cdp-item-detail-wrapper">
										<div class="cdp-cover-name">
											<a href="${coverURL}">
												${element.attributes['product.displayName']}
											</a>
										</div>
										<div class="cdp-cover-id">
										<%-- no logic given for this --%>
										<c:if test="${not empty element.attributes['sku.repositoryId']}">
 											${element.attributes['sku.repositoryId']}
										</c:if>

										</div>

									</div><%-- .cdp-item-detail-wrapper --%>
								</li><%-- .cdp-img-wrapper --%>
							</c:if>

				 </c:forEach>
				 <!-- Display Records in Results List  End-->
		</ul>
		<div class="cdp-pagination-wrapper">
			<p>
				items ${contentItem.firstRecNum} - ${contentItem.lastRecNum} of ${contentItem.totalNumRecs} results
			</p>
			<c:if test="${not empty pagination.paginationMap && not empty pagination.paginationMap['Next']}">
				<div class="cdp-pagination-btn">
					<div>
					Show the next
					</div>
					<ul class="cdp-pagination-drop">
						<li>
							<c:forEach var="option" items="${displayOptions}" varStatus="theCount">
								<c:set var="optionsURL" value="${fn:replace(pageTemplate,'%7BrecordsPerPage%7D', option)}" />
								<c:if test="${theCount.index eq 0}">
									<a href="${contextPath}${optionsURL}">${option} Results</a>
								</c:if>
								<c:if test="${theCount.index eq 1}">
									<ul>
								</c:if>
								<c:if test="${theCount.index gt 0}">
									<li><a href="${contextPath}${optionsURL}">${option} Results</a></li>
								</c:if>
							</c:forEach>
						<%--
						<a href="${contextPath}${fn:replace((fn:replace(pageTemplate,'%7BrecordsPerPage%7D', contentItem.recsPerPage)),'%7Boffset%7D',  pagination.paginationMap['Next'])}">next ${contentItem.recsPerPage} results</a>
						--%>
							</ul><%-- as per htmls, after initial result, needs to be subset under another ul --%>
						</li>
					</ul>
				</div><%-- .cdp-pagination-btn --%>
			</c:if>
			<fmt:message var="viewAllRecords" key="display.view.all"/>
			<c:set var="viewAllUrl" value="${contextPath}${fn:replace((fn:replace(pageTemplate,'%7BrecordsPerPage%7D', contentItem.totalNumRecs)),'%7Boffset%7D',  '0')}" />
			<a href="${viewAllUrl}"><fmt:message key="display.view.all.label"/></a>
		</div><%-- .cdp-pagination-wrapper --%>
		<%-- <a href="${fn:replace((fn:replace(pageTemplate,'%7BrecordsPerPage%7D', contentItem.recsPerPage)),'%7Boffset%7D',  pagination.paginationMap['Next'])}">next ${contentItem.recsPerPage} results</a>
		 --%>
	</c:when>
		<c:otherwise>
		 	<p>${contentItem.totalNumRecs} results</p>
		 	<c:if test="${empty contentItem.records}">
				<c:set var="splitArr" value="${fn:split(term, '|')}" />
				<c:set var="length" value="${fn:length(fn:split(term,'|'))}" />

				<dsp:droplet name="InvokeAssembler">
					<dsp:param name="includePath" value="/pages/no-results" />
					<dsp:oparam name="output">
					 <dsp:getvalueof var="content" 	vartype="com.endeca.infront.assembler.ContentItem" 	param="contentItem" />
					</dsp:oparam>
				</dsp:droplet>
				<div class="main">
					<c:forEach var="element" items="${content.mainContent}" varStatus="status">
							<dsp:renderContentItem contentItem="${element}" />
					</c:forEach>
				</div>
			</c:if>
		</c:otherwise>
	</c:choose>
</dsp:page>