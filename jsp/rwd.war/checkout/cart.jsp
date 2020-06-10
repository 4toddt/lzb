<%--
    - File Name: cart.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the shopping cart page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" var="profile" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.commerceItemCount" />
	
	<dsp:getvalueof var="country" bean="Profile.currentStore.country" />
	
	<dsp:include page="/sitewide/includes/webtrendsContent.jsp">
  		<dsp:param name="page" value="Checkout"  />
  		<c:set var="pageTypeForTracking" value="cart" scope="request" />
	</dsp:include>
  
  	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />
  	<dsp:getvalueof var="cartMerged" param="cartMerged" />

<!-- DOUG count ${commerceItemCount} -->

	<%-- HEAD stuff--%>
	<layout:checkout>
		<jsp:attribute name="pageTitle">Shopping Cart</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">checkout</jsp:attribute>
		<jsp:attribute name="pageType">cart</jsp:attribute>
		<jsp:attribute name="bodyClass">checkout cart</jsp:attribute>
		<jsp:attribute name="analyticsPageType">cartPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
	
		<jsp:body>
			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextLinkPath}/"><fmt:message key="breadcrumb.home" /></a></li>
					<li><span class="crumb active"><fmt:message key="cart.header.shoppingCart" /></span></li>
				</ul>
			</section>

			<div class="checkout-help-wrapper">
				<div class="header-help-content-container hide-for-medium">
					<div class="header-help-content help-info-content">
						<div class="icon icon-close" aria-hidden="true"></div>
						<dsp:include page="/sitewide/includes/helpContent.jsp" />
					</div>
				</div>
				<div class="checkout-help-wrapper-desktop hide-for-small">
					<div class="help-bubble" tabindex="0">
						<div class="help-inner-bubble">
							<div class="help-title"><fmt:message key="cart.help.title" /></div>
							<div class="help-icon icon icon-arrow-down">
							</div>
						</div>
					</div>
					<div class="help-info help-info-content hide">
						<dsp:include page="/sitewide/includes/helpContent.jsp"/>
					</div>
				</div>
			</div>
			<%-- Marketing Slot Targeter. Commented/Removed targeter per JIRA DMI-2006 --%>
			<%--
			<div class="page-targeter">
				<dsp:include page="/global/pageTargeter.jsp">
					<dsp:param name="targeterName" value="CartPromoBlock"/>
				</dsp:include>
			</div>
			--%>
			<div class="shopping-cart-content">
				<c:choose>
					<c:when test="${cartEmpty}">
						<%-- page header --%>
						<h1 class="title"><fmt:message key="cart.header.shoppingCart"/></h1>
						
						<dsp:include page="/checkout/includes/emptyCart.jsp" />
						
						<%-- Monetate empty cart --%>
						<script>
							window.monetateQ.push(["addCartRows", []]);
						</script>
					</c:when>
					<c:otherwise>
						<c:if test="${cartMerged}">
							<div class="error-box alert-box error">
								<div class="error-message">
									<span class="icon icon-error"></span>
									<p><fmt:message key="cart.error.merge"/></p>
								</div>
							</div>
						</c:if>
						
						<%-- Check if order has discontinued items --%>
						<dsp:droplet name="LZBDisplayCartItemsDroplet">
						<dsp:param name="order" bean="ShoppingCart.current" />
						<dsp:param name="profile" bean="Profile" />
						<dsp:param name="cart" value="true" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="discontinueditemexistsinorder" param="discontinueditemexists" />
							<dsp:getvalueof var="isOptionDiscontinued" param="isOptionDiscontinued" />
						</dsp:oparam>
						</dsp:droplet>
						
						<c:if test="${discontinueditemexistsinorder}">
							<div class="error-box alert-box error">
								<div class="error-message">
									<span class="icon icon-error"></span>
									<p><fmt:message key="cart.error.discontinueditemexists"/></p>
								</div>
							</div>
						</c:if>
<%--						
						<dsp:include page="/checkout/includes/cartTax.jsp">
							<dsp:param name="callTax" value="true" />
						</dsp:include>
--%>										
						<dsp:include page="/checkout/includes/reprice.jsp">
							<dsp:param name="pageReprice" value="cart"/>
						</dsp:include>
						
						<dsp:include page="/checkout/includes/cartContentItems.jsp"/>
					</c:otherwise>
				</c:choose>
			</div>
	
			<c:if test="${not cartEmpty}">
				<div class="promo-and-totals">
					<dsp:include page="/checkout/includes/orderSummary.jsp?pageType=cart" />
				</div>
				
				<div class="cart-actions">
					<c:if test="${country != 'CA'}">
						<a href="#" class="to-digitalbuy-btn ${isOptionDiscontinued || discontinueditemexistsinorder ? 'disabled' : ''}" data-toggle="modal" data-target="#digBuyModal"><img src="${contextPath}/resources/images/checkout/pay_with_lzb_card.png" alt="Pay with LaZBoy credit card"></a> 
						<span class="or-text">OR</span> 
					</c:if>
					<a href="#" class="button tertiary to-checkout-btn ${isOptionDiscontinued || discontinueditemexistsinorder ? 'disabled' : ''}"><fmt:message key="cart.label.checkout"/></a>
				</div>
				
				<div class="wysk-section">
					<div class="title"><fmt:message key="wysk.title"/></div>
					<a href="${contextLinkPath}/content/policies/return-policy" target="_blank"><fmt:message key="wysk.returnPolicy"/></a>
					<a href="${contextLinkPath}/content/policies/privacy-policy" target="_blank"><fmt:message key="wysk.secureShopping"/></a>
				</div>
			</c:if>
	
		</jsp:body>
	</layout:checkout>
</dsp:page>