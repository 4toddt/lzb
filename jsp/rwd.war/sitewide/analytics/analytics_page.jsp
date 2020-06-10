<%--
Creates the json for digitalData.page. Populate the following page variables for this:
	analyticPageType  - page type is a string describing the page. Used for triggers in GTM (ex: homePage, productListPage, cartPage)
	searchTerm - if this is a keyword search page, search termis the string the user entered
	searchRedirect - (boolean) if the search was reditected, set this to true
	searchResultCount - number of products returned
	adjustedTerms - if this is a keyword search page and the search was corrected, populate with corrected search term
	searchResultsPerPage - number of products dispayed per page
	categoryNameCrumb - this is the category name in a crumb style. up to 5 entries separated by "/". if this is keywprd search, just use "search" as the value
	locatorResultCount - the number of stores returned by store locator in in-stire availability search
	storeLocatorAddress - the user-entered address used in the store locator search (zip or city,state)
	findInStoreAddress - the user-entered address used in the in-store availability search
	serverName - the server instance
	currency - USD unless this is localized
--%>
<c:set var="currency" value="USD"/>
<json:object>
	<c:if test="${!empty analyticsPageType}">
		<json:property name="pageType" value="${analyticsPageType}"/>
	</c:if>
	<c:if test="${!empty analyticsPageTitle}">
		<json:property name="title" value="${analyticsPageTitle}"/>
	</c:if>
	<c:if test="${!empty searchTerm}">
		<json:property name="searchTerm" value="${searchTerm}"/>
	</c:if>
	<c:if test="${searchRedirect}">
		<json:property name="searchRedirect" value="true"/>
	</c:if>
	<c:if test="${!empty searchResultCount}">
		<json:property name="searchResults" value="${searchResultCount}"/>
	</c:if>
	<c:if test="${!empty adjustedTerms}">
		<json:property name="searchTermCorrected" value="${adjustedTerms}"/>
	</c:if>
	<c:if test="${!empty searchResultsPerPage}">
		<json:property name="itemsPerPage"  value="${searchResultsPerPage}"/>
	</c:if>
	<c:if test="${!empty categoryNameCrumb}">
		<json:property name="categoryName"  value="${categoryNameCrumb}"/>
	</c:if>
	<c:if test="${!empty locatorResultCount}">
		<json:property name="locatorResults" value="${locatorResultCount}"/>
		<c:choose>
			<c:when test="${!empty storeLocatorAddress}">
				<json:property name="locatorSearchTerm" value="${storeLocatorAddress}"/>
			</c:when>
			<c:when test="${!empty findInStoreAddress}">
				<json:property name="locatorSearchTerm" value="${findInStoreAddress}"/>
			</c:when>
		</c:choose>
	</c:if>
	<json:property name="server"  value="${serverName}" />
	<json:property name="currency" value="${currency}"/>
</json:object>