<%--
  SearchBox

  Renders a search box which allows the user to query for search results.
--%>
<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:importbean bean="/atg/dynamo/droplet/multisite/CartSharingSitesDroplet" />
  <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
  <dsp:importbean bean="/atg/multisite/Site" var="currentSite"/>
  <dsp:importbean bean="/atg/endeca/assembler/SearchFormHandler"/>
  <dsp:importbean bean="/atg/endeca/assembler/cartridge/manager/DefaultActionPathProvider"/>


  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
  <dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}"/>
  <dsp:getvalueof var="actionPath" bean="DefaultActionPathProvider.defaultExperienceManagerNavigationActionPath"/>
  <c:set var="forwardRequestUri" value=""/>
  	<dsp:importbean bean="/com/lzb/endeca/ActionURLDroplet" />

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


	<%-- The search form --%>
  <header data-module="typeahead">
    <dsp:form action="${contextPath}/s" id="searchForm" requiresSessionConfirmation="false" name="searchForm">
      <input type="hidden" id="contextPath" value="${contextPath}" />
      <dsp:input bean="SearchFormHandler.searchSuccessURL" type="hidden" value="${contextPath}/s"/>
	  <dsp:input bean="SearchFormHandler.searchErrorURL" type="hidden" value="${contextPath}/s"/>
	  <input type="hidden" name="Dy" value="1"/>
      <input type="hidden" name="Nty" value="1"/>
      <input type="hidden" name="forwardRequestUri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
      <fieldset>
    		<legend><fmt:message key="search.legend" /></legend>
        <label for="searchBar" style="display:none"><fmt:message key="search.label" /></label>
    		<dsp:input bean="SearchFormHandler.searchTerm" id="searchBar" iclass="search" type="text" name="Ntt">
  				<fmt:message key="search.placeholder" var="placeholder" />
          <dsp:tagAttribute name="placeholder" value="${placeholder}"/>
  				<dsp:tagAttribute name="autocomplete" value="off"/>
          <fmt:message key="search.ariaLabel" var="ariaLabel" />
  				<dsp:tagAttribute name="aria-label" value="${ariaLabel}"/>
          <dsp:tagAttribute name="data-typeahead" value=""/>
    		</dsp:input>
    		<button type="submit" class="btn-search"><span class="sr-only"><fmt:message key="search.button" /></span><span class="icon-search"></span></button>
    		<dsp:input type="hidden" bean="SearchFormHandler.search" name="search" value="Search" id="atg_store_searchSubmit"/>
      </fieldset>
    </dsp:form>
  </header>
  <div class="content typeahead" id="typeahead">
    <div class="typeahead-top-searches typeahead-links">
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
    <div class="typeahead-suggestions typeahead-links"></div>
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
    <div class="typeahead-products"></div>
    <div class="typeahead-no-suggestions">
      <p><fmt:message key="search.noSuggestions" /></p>
    </div>
  </div>
</dsp:page>
