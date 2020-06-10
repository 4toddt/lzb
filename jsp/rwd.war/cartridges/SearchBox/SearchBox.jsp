<%--
  - Cartridge: SearchBox
  - File Name: SearchBox.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: Renders a search box which allows the user to query for search results.
  - Required Parameters:
        - contentItem,
        - headerType: display header type is a request scope variable (desktop or mobile)
  - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
    <dsp:importbean bean="/atg/endeca/assembler/SearchFormHandler"/>
    <dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

    <c:if test="${not empty contentItem.topSearch1Link }">
        <dsp:droplet name="ActionURLDroplet">
            <dsp:param name="action" value="${contentItem.topSearch1Link}" />
            <dsp:oparam name="output">
                <dsp:getvalueof var="topSearch1Link" param="actionURL" />
            </dsp:oparam>
            <dsp:oparam name="empty">
            </dsp:oparam>
        </dsp:droplet>
    </c:if>

    <c:if test="${not empty contentItem.topSearch2Link }">
        <dsp:droplet name="ActionURLDroplet">
            <dsp:param name="action" value="${contentItem.topSearch2Link}" />
            <dsp:oparam name="output">
                <dsp:getvalueof var="topSearch2Link" param="actionURL" />
            </dsp:oparam>
            <dsp:oparam name="empty">
            </dsp:oparam>
        </dsp:droplet>
    </c:if>

    <c:if test="${not empty contentItem.topSearch3Link }">
        <dsp:droplet name="ActionURLDroplet">
            <dsp:param name="action" value="${contentItem.topSearch3Link}" />
            <dsp:oparam name="output">
                <dsp:getvalueof var="topSearch3Link" param="actionURL" />
            </dsp:oparam>
            <dsp:oparam name="empty">
            </dsp:oparam>
        </dsp:droplet>
    </c:if>

    <c:if test="${not empty contentItem.topSearch4Link }">
        <dsp:droplet name="ActionURLDroplet">
            <dsp:param name="action" value="${contentItem.topSearch4Link}" />
            <dsp:oparam name="output">
                <dsp:getvalueof var="topSearch4Link" param="actionURL" />
            </dsp:oparam>
            <dsp:oparam name="empty">
            </dsp:oparam>
        </dsp:droplet>
    </c:if>


    <c:choose>
		<c:when test="${headerType eq 'mobile'}">
            <div class="keyword-search-${headerType} keyword-search" role="search">
                <%-- Render Search Form --%>
                <dsp:form action="${contextPath}${storeConfig.mobileSearchUrl}" id="searchForm-${headerType}" formid="searchForm-${headerType}" requiresSessionConfirmation="false" name="searchForm-${headerType}">
                    <input type="hidden" id="contextPath-${headerType}" value="${contextPath}" />
                    <dsp:input bean="SearchFormHandler.searchSuccessURL" type="hidden" value="${contextPath}${storeConfig.mobileSearchUrl}"/>
                    <dsp:input bean="SearchFormHandler.searchErrorURL" type="hidden" value="${contextPath}${storeConfig.mobileSearchUrl}"/>
                    <input type="hidden" name="Dy" value="1"/>
                    <input type="hidden" name="Nty" value="1"/>
                    <input type="hidden" name="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
                    <div class="field-group inline-form">
                        <div class="field search-field">
                            <label class="sr-only" for="keyword-${headerType}">keyword search</label>
                            <dsp:input bean="SearchFormHandler.searchTerm" type="text" value="" name="Ntt" id="keyword-${headerType}">
                                <dsp:tagAttribute name="class" value="keyword-field"/>
                                  <dsp:tagAttribute name="autocomplete" value="off"/>
                                  <dsp:tagAttribute name="autocorrect" value="off"/>
                                  <dsp:tagAttribute name="placeholder" value="What are you looking for?"/>
                                  <dsp:tagAttribute name="data-typeahead" value=""/>
                                  <dsp:tagAttribute name="data-content-type" value="${headerType}"/>
                            </dsp:input>
                            <!--[if IE]><input type="text" style="display: none;" title="Ignore field. IE bug fix" disabled="disabled" size="1" /><![endif]-->
                        </div>
                        <div class="action-field">
                            <button type="submit" class="button keyword-search-button" aria-label="search">
                                <span class="icon icon-search" aria-hidden="true"></span>
                            </button>
                            <dsp:input type="hidden" bean="SearchFormHandler.search" name="search" value="Search" id="atg_store_searchSubmit-${headerType}"/>
                        </div>
                    </div>
                </dsp:form>

                <%-- Render Typeahead Search Suggestions --%>
                <div class="search-results-${headerType} hide"></div>

                <%-- Render Search Top Searches --%>
                <div class="top-searches-${headerType}">
                    <h4 class="search-title">${contentItem.name}</h4>
                    <ul class="link-list">
                        <c:if test="${not empty topSearch1Link }">
                      	    <li><a href="${contextPath}${topSearch1Link}" aria-label="${contentItem.topSearch1Text}" tabindex="0">${contentItem.topSearch1Text}</a></li>
                        </c:if>
                        <c:if test="${not empty topSearch2Link }">
                      	    <li><a href="${contextPath}${topSearch2Link}" aria-label="${contentItem.topSearch2Text}" tabindex="0">${contentItem.topSearch2Text}</a></li>
                        </c:if>
                        <c:if test="${not empty topSearch3Link }">
                      	    <li><a href="${contextPath}${topSearch3Link}" aria-label="${contentItem.topSearch3Text}" tabindex="0">${contentItem.topSearch3Text}</a></li>
                        </c:if>
                        <c:if test="${not empty topSearch4Link }">
                      	    <li><a href="${contextPath}${topSearch4Link}" aria-label="${contentItem.topSearch4Text}" tabindex="0">${contentItem.topSearch4Text}</a></li>
                        </c:if>
                    </ul>
                </div>

                <%-- Render Typeahead Product Suggestions --%>
                <div class="typeahead-products-${headerType}"></div>
                <%-- Render Typeahead No Suggestions --%>
                <div class="typeahead-no-suggestions-${headerType}">
                    <p><fmt:message key="search.noSuggestions" /></p>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <%-- The search form --%>
          <header>
              <div class="keyword-search-${headerType}" role="search">
                  <dsp:form action="${contextLinkPath}${storeConfig.storeSearchUrl}" id="searchForm-${headerType}" formid="searchForm-${headerType}" requiresSessionConfirmation="false" name="searchForm">
                      <input type="hidden" id="contextPath-${headerType}" value="${contextLinkPath}" />
                      <dsp:input bean="SearchFormHandler.searchSuccessURL" type="hidden" value="${contextLinkPath}${storeConfig.storeSearchUrl}"/>
                      <dsp:input bean="SearchFormHandler.searchErrorURL" type="hidden" value="${contextLinkPath}${storeConfig.storeSearchUrl}"/>
                      <input type="hidden" name="Dy" value="1"/>
                      <input type="hidden" name="Nty" value="1"/>
                      <input type="hidden" name="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
                      <label class="sr-only" for="keyword-${headerType}">keyword search</label>
                      <dsp:input bean="SearchFormHandler.searchTerm" type="text" value="" name="Ntt" id="keyword-${headerType}">
                          <dsp:tagAttribute name="class" value="keyword-field"/>
                            <dsp:tagAttribute name="autocomplete" value="off"/>
                            <dsp:tagAttribute name="autocorrect" value="off"/>
                            <dsp:tagAttribute name="placeholder" value="What are you looking for?"/>
                            <dsp:tagAttribute name="data-typeahead" value=""/>
                            <dsp:tagAttribute name="data-content-type" value="${headerType}"/>
                      </dsp:input>
                      <!--[if IE]><input type="text" style="display: none;" title="Ignore field. IE bug fix" disabled="disabled" size="1" /><![endif]-->
                      <button type="submit" class="button keyword-search-button" aria-label="search">
                          <span class="icon icon-search" aria-hidden="true"></span>
                      </button>
                      <dsp:input type="hidden" bean="SearchFormHandler.search" name="search" value="Search" id="atg_store_searchSubmit-${headerType}"/>
          </dsp:form>
                </div>
          </header>
          <div class="content typeahead" id="typeahead">
            <div class="top-searches-${headerType} typeahead-links">
              <h4>${contentItem.name}</h4>
              <ul>
              	<c:if test="${not empty topSearch1Link }">
                	<li><a href="${topSearch1Link}" aria-label="${contentItem.topSearch1Text}" tabindex="0">${contentItem.topSearch1Text}</a></li>
                </c:if>
                <c:if test="${not empty topSearch2Link }">
                	<li><a href="${topSearch2Link}" aria-label="${contentItem.topSearch2Text}" tabindex="0">${contentItem.topSearch2Text}</a></li>
                </c:if>
                <c:if test="${not empty topSearch3Link }">
                	<li><a href="${topSearch3Link}" aria-label="${contentItem.topSearch3Text}" tabindex="0">${contentItem.topSearch3Text}</a></li>
                </c:if>
                <c:if test="${not empty topSearch4Link }">
                	<li><a href="${topSearch4Link}" aria-label="${contentItem.topSearch4Text}" tabindex="0">${contentItem.topSearch4Text}</a></li>
                </c:if>
              </ul>
            </div>
            <%-- Render Typeahead Search Suggestions --%>
            <div class="search-results-${headerType} hide"></div>

            <div class="typeahead-promos">
              <ul class="row col-2 clearfix">
        					<c:if test="${not empty contentItem.leftPromo}">
        			 			<dsp:renderContentItem contentItem="${contentItem.leftPromo}"/>
        					</c:if>
         					<c:if test="${not empty contentItem.rightPromo}">
        			 			<dsp:renderContentItem contentItem="${contentItem.rightPromo}"/>
        					</c:if>
              </ul>
            </div>
            <div class="typeahead-products-${headerType}"></div>
            <div class="typeahead-no-suggestions-${headerType}">
              <p><fmt:message key="search.noSuggestions" /></p>
            </div>
        </div>
        </c:otherwise>
    </c:choose>
</dsp:page>
