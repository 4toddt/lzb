<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<%@ taglib prefix="endecahelpers" uri="/WEB-INF/tld/endecahelpers.tld" %> 
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBFAQURLDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/NPCSearchUrlDroplet"/>
	<dsp:importbean bean="/com/lzb/droplet/NewsRoomUrlDroplet"/>
	<dsp:getvalueof var="selectedFacet" param="selectedFacet" />
	<c:set var="pageTemplate" value="${contentItem.pagingActionTemplate.contentPath}${contentItem.pagingActionTemplate.navigationState}" />
	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<dsp:getvalueof var="term" param="Ntt" scope="page" />	
	<fmt:message var="productPagePath" key="pdp.storePath"/>
	<c:choose>
		<c:when test="${contentItem.totalNumRecs > 0}">
		<c:if test="${not empty term}">
			<h2>Search Results for ${fn:escapeXml(term)}</h2>
		</c:if>
			<div class="cdp-selections" data-module="cdpCompare" data-module="cdp-sort-functionality">
					<p class="cdp-item-count">items ${contentItem.firstRecNum} - ${contentItem.lastRecNum} of ${contentItem.totalNumRecs} total</p>
					
					<c:if test="${not empty selectedFacet && selectedFacet ne 'ProductLiteratures'}">
						<fieldset>
						<!-- Display Sort Options Start-->
						
							<label for="sort-by" ><fmt:message key="sort.by.label"/></label>
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
						</fieldset>
					</c:if>					
					<fieldset class="cdp-display-count">
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
					</fieldset>
					
					<!-- Display Pagination Options Start -->
				 	
					<div class="cdp-pagination-pages">
						<p>
							<c:set var="pagination" value="${endecahelpers:pagination(contentItem,false)}" scope="request"/>
							
							<fmt:message key="pagination.label"/>&nbsp;
							<c:forEach items="${pagination.paginationMap}" var="entry">
								<c:set var="poffset" value="${entry.value}" />
								<c:set var="poffsetUrl" value="${fn:replace(pageTemplate,'%7Boffset%7D', poffset)}" />
								<c:set var="precordsUrl" value="${fn:replace(poffsetUrl,'%7BrecordsPerPage%7D', contentItem.recsPerPage)}" />
								<c:set var="linkAction" value="${fn:replace(fn:replace(pageTemplate, '%7Boffset%7D', poffset ), '%7BrecordsPerPage%7D',  contentItem.recsPerPage)}" />
								<c:url var="url" value="${fn:escapeXml(linkAction)}"></c:url>
								<c:set var="pOptionName" value="${entry.key}" />
								<c:set var="currPage" value="${pagination.currentPageNo}" />
								<c:set var="numberPages" value="${pagination.numberPages}" />
								<c:choose>
									<c:when
										test="${pOptionName eq '...'|| pOptionName eq '....' || pOptionName eq currPage}">
										<c:choose>
											<c:when test="${pOptionName eq '....' || pOptionName eq '...'}">
												...
											</c:when>
											<c:otherwise>
												${entry.key}
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when
												test="${pOptionName eq 'next' || pOptionName eq 'prev' }">
												<c:choose>
													<c:when test="${pOptionName eq 'next'}">
														<dsp:a href="${contextPath}${url}">${entry.key}</dsp:a>
													</c:when>
													<c:otherwise>
														<dsp:a href="${contextPath}${url}">${entry.key}</dsp:a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<dsp:a href="${contextPath}${url}">${entry.key}</dsp:a>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<!-- Display Pagination Options End -->
						</p>
				</div><%-- .cdp-pagination-pages --%>
		</div><%-- .cdp-selections --%>
		<div class="search-product-info">					
				
				<!-- Display Records in Results List  Start-->			
				 <c:forEach var="element" items="${contentItem.records}">				 
					<div class="product-literature">
					<!-- Display Records in Results List  for ProductLiterature Start-->
						<h2><a href="${element.attributes['product.productDownloadLink']}">${element.attributes['product.productDownloadHeading']}</a></h2>
					
					<c:if test="${not empty element.attributes['product.productDownloadDescription']}">
						 ${element.attributes['product.productDownloadDescription']}
					</c:if>
						</br>
					<c:if test="${not empty element.attributes['product.productDownloadImage']}">
						 ${element.attributes['product.productDownloadImage']}
					</c:if>
					<!-- Display Records in Results List  for ProductLiterature End-->
					
					<!-- Display Records in Results List  for FAQ -->
					 
					<dsp:droplet name="LZBFAQURLDroplet">
	     				<dsp:param name="productItem" value="${element}" />
	     				<dsp:param name="searchTerm" value="${term}" />
	     					
							<dsp:oparam name="output">
								<dsp:getvalueof var="faqUrl" param="faqUrl"/>
							</dsp:oparam>
	     			 </dsp:droplet>	
	     			<c:if test="${not empty faqUrl}">
						<a href="${contextPath}${faqUrl}">${element.attributes['question']}</a>
					</c:if>
					<c:choose>
						<c:when test="${not empty element.attributes['answer.Snippet']}">
				 			<c:out value="${element.attributes['answer.Snippet']}" escapeXml="false"/>
						 </c:when>
						 <c:otherwise>
						 <c:if test="${not empty element.attributes['answer']}">
						 	  ${fn:substring(element.attributes['answer'],50)} 
						 </c:if>
						 </c:otherwise>
					</c:choose>
					
						 <!-- Display Records in Results List  for Investor relations from NewsRoom-->
				 	<dsp:droplet name="NewsRoomUrlDroplet">
	     				<dsp:param name="productItem" value="${element}" />
		     				<dsp:oparam name="output">
								<dsp:getvalueof var="newRoomUrl" param="newRoomUrl"/>
							</dsp:oparam>
	     			 </dsp:droplet>
	     			
					<c:if test="${not empty element.attributes['NewsCaptionTitle']}">
				 	
				 		${element.attributes['NewsCaptionTitle']}
				 	</c:if>
				 	<br/>
				 	<c:if test="${not empty element.attributes['NewsHeadLine']}">
				 	
				 		<a href="${contextPath}${newRoomUrl}"> ${element.attributes['NewsHeadLine']}</a>
				 	</c:if>
				 	<br/>
				 	
				 	
				 	<c:choose>
						<c:when test="${not empty element.attributes['NewsCaptionContent.Snippet']}">
				 			<c:out value="${element.attributes['NewsCaptionContent.Snippet']}" escapeXml="false"/>
						 </c:when>
						 <c:otherwise>
						 <c:if test="${not empty element.attributes['NewsCaptionContent']}">
						 	  ${fn:substring(element.attributes['NewsCaptionContent'],50)} 
						 </c:if>
						 </c:otherwise>
					</c:choose>
				 	
				 	
				 
				 	 <!-- Display Records in Results List  for Investor relations from NewsRoom END-->
						 
					<!-- Display Records in Results List  for Investor relations from crawl-->
					<c:choose>
					<c:when test="${not empty element.attributes['Endeca.Web.LinkedFromUrl.LinkText']}">
						 <a href="${element.attributes['Endeca.Web.URL']}"> ${element.attributes['Endeca.Web.LinkedFromUrl.LinkText']}</a>
						</br>
							<c:choose>
								 <c:when test="${not empty element.attributes['Endeca.Document.Text.Snippet']}">
									<c:out value="${element.attributes['Endeca.Document.Text.Snippet']}" escapeXml="false"/>
								</c:when>
								 <c:otherwise>
									 <c:if test="${not empty element.attributes['Endeca.Document.Text']}">
									 	 ${fn:substring(element.attributes['Endeca.Document.Text'],0,50)} 
									 </c:if>
								 </c:otherwise>
							</c:choose>						
					</c:when>
					<c:otherwise>
						 <a href="${element.attributes['Endeca.Web.URL']}"> ${element.attributes['Endeca.Web.Title']}</a>
							<c:choose>
								 <c:when test="${not empty element.attributes['Endeca.Document.Text.Snippet']}">
									<c:out value="${element.attributes['Endeca.Document.Text.Snippet']}" escapeXml="false"/>
								</c:when>
								 <c:otherwise>
									 <c:if test="${not empty element.attributes['Endeca.Document.Text']}">
									 	 ${fn:substring(element.attributes['Endeca.Document.Text'],0,50)} 
									 </c:if>
								 </c:otherwise>
							</c:choose>
					</c:otherwise>
					</c:choose>					
					<!-- Display Records in Results List  for Investor relations from crawl end-->
					
					<!-- Display Records in Results List  for NPC -->
					<dsp:droplet name="NPCSearchUrlDroplet">
	     				<dsp:param name="productItem" value="${element}" />
		     				<dsp:oparam name="output">
								<dsp:getvalueof var="npcUrl" param="npcUrl"/>
							</dsp:oparam>
	     			 </dsp:droplet>
	     			 
	     			 <c:if test="${not empty element.attributes['title']}">
						  <a href="${element.attributes['url']}"> ${element.attributes['title']}</a>DDD
					</c:if>
					<br/>
					
	     			
	     			 <c:if test="${not empty element.attributes['pagekeywords']}">
						  ${element.attributes['pagekeywords']} 
					</c:if>
					
					
					<!-- Display Records in Results List  for NPC END-->
					</div><%-- .product-literature --%>
				 </c:forEach>
				 <!-- Display Records in Results List  End-->
				 <div class="cdp-pagination-wrapper">
				
					<p>items ${contentItem.firstRecNum} - ${contentItem.lastRecNum} of ${contentItem.totalNumRecs} results </p>
					
					<c:if test="${not empty pagination.paginationMap && not empty pagination.paginationMap['Next']}">
						<div>Show the <a href="${fn:replace((fn:replace(pageTemplate,'%7BrecordsPerPage%7D', contentItem.recsPerPage)),'%7Boffset%7D',  pagination.paginationMap['Next'])}">next ${contentItem.recsPerPage} results</a></div>
					</c:if>
					<fmt:message var="viewAllRecords" key="display.view.all"/>
					<c:set var="viewAllUrl" value="${contextPath}${fn:replace((fn:replace(pageTemplate,'%7BrecordsPerPage%7D', contentItem.totalNumRecs)),'%7Boffset%7D',  '0')}" />
					<p><a href="${viewAllUrl}"><fmt:message key="display.view.all.label"/></a></p>
				</div><%-- .cdp-pagination-wrapper --%>
		</c:when>
		<c:otherwise>
		<div class="cdp-pagination-wrapper">
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
				
					<c:forEach var="element" items="${content.mainContent}" varStatus="status">
							<dsp:renderContentItem contentItem="${element}" />
					</c:forEach>
				
			</c:if> 
		</div><%-- .cdp-pagination-wrapper --%>
		</c:otherwise>
	</c:choose>
	</div><%-- .search-product-info --%>
</dsp:page>