<%--
  This page renders 'My Account' menu for navigating to profile information,
  payment settings, addresses, wish lists, gift lists and previous orders.

  Required parameters:
    selpage
      indicates which menu option is currently selected

  Optional parameters
    None
--%>

<dsp:page>

	<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
	<dsp:getvalueof var="hostName" bean="LZBStoreConfiguration.hostName"/>
	<dsp:getvalueof var="subarea" value="My Cart" />

	<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:set var="reqURL" value="${pageContext.request.requestURL}"/>
		<div class="account-menu">
			<ul class="account-list">
			  <li data-subarea="${subarea}"><dsp:a page="${pageContext.request.contextPath}/../account/account.jsp" tabindex="0"><fmt:message key="headerAcntMenu.myAcount"/></dsp:a></li>
			  <li data-subarea="${subarea}"><dsp:a page="${pageContext.request.contextPath}/../designcenter/designhome.jsp?tab=1" tabindex="0"><fmt:message key="headerAcntMenu.myDesigncentr"/></dsp:a></li>
			  <%-- JIRA DMI-1763 Hide Wishlist UI
			  <li data-subarea="${subarea}"><dsp:a page="${pageContext.request.contextPath}/../account/wish_list_items.jsp" tabindex="0"><fmt:message key="headerAcntMenu.myWishlist"/></dsp:a></li>
		  	  --%>
			  <li data-subarea="${subarea}"><dsp:a page="${pageContext.request.contextPath}/../account/orderHistory.jsp" tabindex="0"><fmt:message key="headerAcntMenu.orderHistory"/></dsp:a></li>
			<c:choose>
				<c:when test="${not empty endecaUrl}">
					 <li data-subarea="${subarea}"><dsp:a id="loggedInUserAnchr" href="${hostName}${endecaUrl}" bean="ProfileFormHandler.logout" value="logout" tabindex="0"><fmt:message key="headerAcntMenu.signOut"/></dsp:a></li>
				</c:when>
				<c:when test="${fn:containsIgnoreCase(reqURL,'storeLocator')}">
				   	<li data-subarea="${subarea}"><dsp:a id="loggedInUserAnchr" href="${reqURL}" bean="ProfileFormHandler.logout" value="logout" tabindex="0"><fmt:message key="headerAcntMenu.signOut"/></dsp:a></li>
				</c:when>
				<c:when test="${fn:containsIgnoreCase(reqURL,'content')}">
					 <li data-subarea="${subarea}"><dsp:a id="loggedInUserAnchr" href="${reqURL}" bean="ProfileFormHandler.logout" value="logout" tabindex="0"><fmt:message key="headerAcntMenu.signOut"/></dsp:a></li>
				</c:when>
				<c:when test="${fn:containsIgnoreCase(reqURL,'cart')}">
				 	<li data-subarea="${subarea}"><dsp:a id="loggedInUserAnchr" href="${reqURL}" bean="ProfileFormHandler.logout" value="logout" tabindex="0"><fmt:message key="headerAcntMenu.signOut"/></dsp:a></li>
				</c:when>
				<c:otherwise>
					 <li data-subarea="${subarea}"><dsp:a id="loggedInUserAnchr" href="${pageContext.request.contextPath}/logout.jsp" bean="ProfileFormHandler.logout" value="logout" tabindex="0"><fmt:message key="headerAcntMenu.signOut"/></dsp:a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</dsp:layeredBundle>
</dsp:page>