<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount" />
	<dsp:getvalueof var="siteHostName" value="${storeConfig.hostName}"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/atg/multisite/Site"/>
	<dsp:importbean bean="/atg/registry/RepositoryTargeters/GlobalHomePageTopLeftPromoBlock"/>
<dsp:importbean bean="/atg/registry/RepositoryTargeters/GlobalHomePageTopMiddlePromoBlock"/>
<dsp:importbean bean="/atg/registry/RepositoryTargeters/GlobalHomePageTopRightPromoBlock"/>

	<dsp:getvalueof var="contextRoot" bean="Site.contextRoot"/>
	<c:set var="contextRoot" scope="request" value="${contextRoot}"/>
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

<dsp:getvalueof var="currDealerId" bean="Profile.currentDealerId"/>

<%--Testing purpose later need to delete this style --%>

<div class="above-header-targeters">
	<div class="above-header-targeters-inner">
	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="GlobalHomePageTopLeftPromoBlock"/>
		<dsp:oparam name="output">
			<div class="secondary-promo">
			<dsp:getvalueof param="element" var="element" />
	 	 		<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}" >
					<c:if test="${not empty element.linkURL}">
						${element.title}
						<a href="${element.linkURL}">${element.linkText }</a>
		  			</c:if>
				</c:if>
			</div>
		</dsp:oparam>
	</dsp:droplet>
	<dsp:droplet name="/atg/targeting/TargetingFirst">
    	<dsp:param name="targeter" bean="GlobalHomePageTopMiddlePromoBlock"/>
  		<dsp:oparam name="output">
			<div class="secondary-promo">
				<dsp:getvalueof param="element" var="element" />
				<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}" >
					<c:if test="${not empty element.linkURL}">
						${element.title}
						<a href="${element.linkURL}">${element.linkText } </a>
					</c:if>
				</c:if>
			</div>
		</dsp:oparam>
	</dsp:droplet>
	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="GlobalHomePageTopRightPromoBlock"/>
		<dsp:oparam name="output">
			<div class="secondary-promo">
				<dsp:getvalueof param="element" var="element" />
				<c:if test="${fn:contains(element.itemDescriptor,'promoSlotItem')}" >
					<c:if test="${not empty element.linkURL}">
						${element.title}
						<a href="${element.linkURL}">${element.linkText }</a>
					</c:if>
				</c:if>
			</div>
		</dsp:oparam>
	</dsp:droplet>
	</div><%-- .above-header-targeters-inner --%>
</div><%-- .above-header-targeters --%>
<div class="util-nav">
	<nav role="navigation" data-module="nav-hover-intent" data-hovertarget=".nav-list > li">
		<ul class="nav-list left">
			<li>			
	       	<dsp:include src="${pageContext.request.contextPath}/global/includes/displayPreferredStoreHeader.jsp">
	       		<c:if test="${not empty content.storePromo}">
					<dsp:param name="storePromo" value="${content.storePromo}"/>
				</c:if>
	       	</dsp:include>
	    	</li>
		</ul>
		<ul class="nav-list right">
			<li><a href="${siteHostName}" class="utility menu-pointer" id="currLang" tabindex="0">English <span class="icon-arrow-down"></span></a>
				<div class="lang-menu" id="langMenu" data-module="lang-select">
					<ul class="lang-list">
					<dsp:include page="${pageContext.request.contextPath}/global/includes/language.jsp">
						<dsp:param name="siteHostName" value="${siteHostName}"/>
					</dsp:include>
					</ul>
				</div>
			</li>
			<%-- START Account or Sign-in Menu --%>
			<c:choose>
				<%-- START Account Menu --%>
				<c:when test="${ transient eq 'false' }">
					<li>
						<dsp:include src="${pageContext.request.contextPath}/global/includes/headerAccountDropdown.jsp" />
					</li>
				</c:when>
				<%-- END Account Menu --%>
				<%-- START Sign-in Menu --%>
				<c:otherwise>
					<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
	          <dsp:param name="inUrl" value="/"/>
	          <dsp:oparam name="output">
	                <dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
	          </dsp:oparam>
	        </dsp:droplet>

					<li data-module="signin-modal-redirect" data-className="sign-in-modal" data-transition="elastic" data-speed="500" data-domain="${updatedProtocolURL}" data-destination="">
	          <fmt:message key="header.signIn" var="signIn"/>
            <a href="${updatedProtocolURL}modals/signin.jsp" class="utility sign-in-click menu-pointer" data-form="signInForm" aria-label="${signIn}">${signIn} <span class="icon-arrow-down"></span></a>
						<dsp:include src="${pageContext.request.contextPath}/global/includes/headerSigninDropdown.jsp" />
	        </li>

				</c:otherwise>
				<%-- END Sign-in Menu --%>
			</c:choose>
			<%-- END Account or Sign-in Menu --%>
			<li>
				<a href="/rwd/checkout/cart.jsp" class="utility cart-link"><fmt:message key="header.myCart" /> (<span class="cart-item-count">${commerceItemCount}</span>)<span class="icon-cart"></span></a>
				<%-- This include for Adobe Analytics in DTM script Mini-Cart-Details.js --%>
				<dsp:include page="${pageContext.request.contextPath}/global/includes/microcart.jsp" />
			</li>
		</ul>
	</nav>

</div>

<header role="banner" class="masthead">

<c:set var="forwardRequestUriValueForHomePageCheck" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:set var="forwardRequestUriValueForSEO_storeLocator" value="${originatingRequest.getRequestURI()}" scope="request"/>

<c:choose>
<c:when test="${not empty forwardRequestUriValueForSEO_storeLocator and  forwardRequestUriValueForSEO_storeLocator eq '/storeLocator/storeLocator.jsp' }" >
	<a href="/">
	  <img src="/img/La-Z-Boy_logo.png" class="brand-mark" alt="La-Z-Boy" />
	  </a>
</c:when>
<c:when test="${ empty forwardRequestUriValueForHomePageCheck or  forwardRequestUriValueForHomePageCheck eq '/'}">
	<h1>
	<a href="/" aria-label="Home page link">
	  <img src="/img/La-Z-Boy_logo.png" class="brand-mark" alt="Home Furniture to Transform Your Living Spaces" />
	  </a>
	</h1>
</c:when>
<c:otherwise>

	<a href="/" aria-label="Home page link">
	  <img src="/img/La-Z-Boy_logo.png" class="brand-mark" alt="La-Z-Boy" />
	  </a>
</c:otherwise>
</c:choose>
<div class="second-nav">
	<nav role="navigation" data-module="nav-hover-intent" data-hovertarget=".nav-list > li">
		<ul class="nav-list">
			<c:if test="${not empty content.secondaryNav}">
				<dsp:renderContentItem contentItem="${content.secondaryNav}" />
				</c:if>
			<li>
				<a href="#" class="search-menu toggle-menu menu-pointer" data-module="toggle">
					<span class="title">Search</span><span class="icon-search"></span>
				</a>
				<div class="mega-nav">
					<c:if test="${not empty content.searchBox}">
						<dsp:renderContentItem contentItem="${content.searchBox}" />
					</c:if>
				</div>
			</li>
		</ul>
	</nav>
</div>
</header>
	<div class="primary-nav sticky" data-module="sticky-header">
		<div class="sticky-logo">
			<a href="/" aria-label="Home page link">
			  <img src="/img/La-Z-Boy_logo-sticky.png" alt="Home Furniture to Transform Your Living Spaces" />
		  </a>
		</div>
		<nav class="clearfix" role="navigation" data-module="nav-hover-intent" data-hovertarget=".nav-list > li">
				<c:if test="${not empty content.pryNavigation}">
					<dsp:renderContentItem contentItem="${content.pryNavigation}" />
				</c:if>
		</nav>
	</div>
</dsp:page>
