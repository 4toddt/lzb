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
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>

	<dsp:getvalueof var="contextRoot" bean="Site.contextRoot"/>
	<c:set var="contextRoot" scope="request" value="${contextRoot}"/>
	<c:set var="headerType" scope="request" value="mobile"/>

	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<dsp:getvalueof var="currDealerId" bean="Profile.currentDealerId"/>

	<c:choose>
        <c:when test="${commerceItemCount gt 0}">
			<dsp:getvalueof var="cartCount" value="(${commerceItemCount})"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="cartCount" value=""/>
		</c:otherwise>
	</c:choose>

	<dsp:getvalueof var="homePageLink" value="${contextPath}/index.jsp"/>

	<!-- mobile header -->
	<header id="mobile-header-container" class="mobile-header">
		<div class="masthead-mobile-content">
			<%-- START: Masthead and logo --%>
			<div class="masthead-mobile">
				<%-- menu --%>
				<a href="javascript:void(0);" class="masthead-mobile-link masthead-mobile-link-menu off-canvas-toggle" id="mobile-menu-icon" data-menu-type="main" data-target="off-canvas-menu">
					<span class="icon icon-menu" aria-hidden="true"></span>
					<span class="masthead-link-title title-menu">Menu</span>
				</a>
				<%-- search --%>
				<a href="javascript:void(0);" class="left masthead-mobile-link masthead-mobile-link-search off-canvas-toggle" id="mobile-search-icon" data-menu-type="search" data-target="off-canvas-search">
					<span class="icon icon-search" aria-hidden="true"></span>
					<span class="masthead-link-title title-search">Search</span>
				</a>
				<%-- logo --%>
				<div class="masthead-logo">
					<a href="${homePageLink}">
						<img src="${assetPath}/images/logo-mobile.png" alt="La-Z-Boy logo">
					</a>
				</div>
				<%-- stores --%>
				<a href="javascript:void(0);" class="right masthead-mobile-link masthead-mobile-link-locator off-canvas-toggle" id="mobile-locator-icon" data-menu-type="locator" data-target="off-canvas-locator">
					<span class="icon icon-locator" aria-hidden="true"></span>
					<span class="masthead-link-title title-stores">Stores</span>
				</a>
				<%-- cart --%>
				<a href="/rwd/checkout/cart.jsp" class="right masthead-mobile-link masthead-mobile-link-cart js-cart-link">
					<span class="icon icon-cart" aria-hidden="true"></span>
					<span class="masthead-link-title title-cart">Cart <span class="cart-count">${cartCount}</span></span>
				</a>
				<div class="menu-indicator">
			        <div class="menu-indicator menu-indicator-inner"></div>
			    </div>
			</div>
			<div class="clearfix"></div>
			<%-- END: Masthead and logo --%>
		</div>

		<%-- END: dropdowns for search and store locator --%>
	</header>

	<nav id="off-canvas-menu" class="off-canvas-menu">
		<dsp:renderContentItem contentItem="${contentItem.pryNavigation}" />
		<div class="mobile-top-nav drilldown-menu mobile-secondary-nav" data-drilldown>
			<ul class="off-canvas-list drilldown-list">
				<dsp:renderContentItem contentItem="${contentItem.secondaryNav}" />
			</ul>
		</div>

		<dsp:renderContentItem contentItem="${contentItem.utilityNavigation}" />
	</nav>


	<%-- START: Search Menu --%>
    <div id="off-canvas-search" class="off-canvas-content off-canvas-search">
        <%-- offCanvas heading --%>
        <div class="off-canvas-heading">
            <a href="javascript:void(0);" class="close-off-canvas-link">
                <span class="icon icon-close" aria-hidden="true"></span>
                <span class="sr-only">close menu</span>
            </a>
        </div>
        <div class="section-content">
        	<dsp:renderContentItem contentItem="${contentItem.searchBox}" />
        </div>
	</div>
    <%-- END: Search Menu --%>



    <c:import url="/sitewide/nav/offCanvas/storeLocator.jsp" />

	<!-- /mobile header -->


</dsp:page>
