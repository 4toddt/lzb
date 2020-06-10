<%--
    - File Name: checkout.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the checkout page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" var="profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />

	<%-- HEAD stuff--%>
	<layout:checkout>
		<jsp:attribute name="pageTitle">Checkout</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">checkout</jsp:attribute>
		<jsp:attribute name="pageType">checkout</jsp:attribute>
		<jsp:attribute name="bodyClass">checkout checkout</jsp:attribute>
		<jsp:attribute name="analyticsPageType">checkoutPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
	
		<jsp:body>
			<%-- SET PAGE PARAMS --%>
			<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.commerceItemCount" />
			<dsp:getvalueof var="order" bean="ShoppingCart.current" />
			
			<dsp:include page="/sitewide/includes/webtrendsContent.jsp">
		  		<dsp:param name="page" value="Checkout"  />
		  		<c:set var="pageTypeForTracking" value="cart" scope="request" />
			</dsp:include>
		  
		  	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />
  	
			<span class="hide" id="orderId"><dsp:valueof bean="ShoppingCart.current.id" /></span>
			
			<%--  Checkout progress stage indicator --%>
			<div class="checkout-breadcrumbs row">
				<a href="javascript:void(0);" class="checkout-progress checkout-progress-shipping edit-shipping">
					<fmt:message key="checkout.step.delivery" />
					<div class="status-step">
						<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
						<hr aria-hidden="true"><div class="status-step-num">1</div><hr aria-hidden="true">
					</div>
				</a>
				<a href="javascript:void(0);" class="checkout-progress checkout-progress-payment edit-payment isDisabled">
					<fmt:message key="checkout.step.payment" />
					<div class="status-step">
						<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
						<hr aria-hidden="true"><div class="status-step-num">2</div><hr aria-hidden="true">
					</div>
				</a>
				<a href="javascript:void(0);" class="checkout-progress checkout-progress-review isDisabled">
					<fmt:message key="checkout.step.review" />
					<div class="status-step">
						<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
						<hr aria-hidden="true"><div class="status-step-num">3</div><hr aria-hidden="true">
					</div>
				</a>

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

			</div>
			
			<div class="checkout-two-column">
				<%--
				<c:if test='${commerceItemCount > 0}'>
					<dsp:include page="/checkout/includes/cartTax.jsp">
						<dsp:param name="callTax" value="true" />
					</dsp:include>
				</c:if>
				
				<dsp:include page="/checkout/includes/reprice.jsp">
					<dsp:param name="pageReprice" value="checkout"/>
				</dsp:include>
				--%>
				
				<%-- Droplet: Order Summary --%>
				<dsp:droplet name="LZBOrderSummaryDroplet">
					<dsp:param name="order" value="${order}" />
					<dsp:param name="profile" bean="Profile" />
					<dsp:param name="page" value="checkout" />
					<dsp:oparam name="output">
						<dsp:getvalueof var="total" param="total"/>
						<dsp:getvalueof var="totalNumberOfItems" param="totalNumberOfItems"/>
						<dsp:getvalueof var="orderCombination" param="orderCombination"/>
					</dsp:oparam>
				</dsp:droplet>

				<%--
					For Debugging
					total: ${total} and totalNumberOfItems: ${totalNumberOfItems}
				--%>

				<div class="checkout-two-column-right">
					<div class="accordion" data-accordion aria-multiselectable="false" role="tablist">
		 				<div class="accordion-container">
			    			<div class="accordion-title checkout-order-summary-accordion hide-for-medium" role="tab" aria-controls="checkoutOrderSummaryTotalContent" id="checkoutOrderSummaryTotal">
			    				<span class="icon icon-arrow-down" aria-hidden="true"></span>
								<div class="num-of-items">Your Items (<span class="number-of-items">${commerceItemCount}</span>)</div>
								<div class="order-total">Total: <span class="order-total-amount"><dsp:valueof value="${total}" converter="currency"/></span></div>
			    			</div>
		    				<div class="accordion-body checkout-order-summary-accordion-body" aria-labeledby="checkoutOrderSummaryTotal" role="tabpanel" id="checkoutOrderSummaryTotalContent">
		      					<div class="accordion-body-content">
		      						<div class="order-summary-title">Order Summary</div>
									<a class="order-edit-link" href="/rwd/checkout/cart.jsp">
										<fmt:message key="checkout.edit.link" />
										<span class="sr-only"><fmt:message key="checkout.edit.link.srCart" /></span>
									</a>
									
									<div class="order-items">
										<dsp:include page="/checkout/includes/checkoutOrderItems.jsp" />
									</div>
									
									<div class="promo-and-totals">
										<dsp:include page="/checkout/includes/orderSummary.jsp?pageType=checkout" />
									</div>
		      					</div>
		    				</div>
		  				</div>
		  			</div>
					
					<div class="wysk-section hide-for-small">
						<div class="title"><fmt:message key="wysk.title"/></div>
						<a href="${contextLinkPath}/content/policies/return-policy" target="_blank"><fmt:message key="wysk.returnPolicy"/></a>
						<a href="${contextLinkPath}/content/policies/privacy-policy" target="_blank"><fmt:message key="wysk.secureShopping"/></a>
					</div>
				</div>
				<div class="checkout-two-column-left">
					<%-- 1. shipping step --%>
					<div class="checkout-shipping in-progress js-checkout-step" id="checkout-shipping">
						<%-- shipping address form --%>
						<dsp:include page="/checkout/includes/shippingAddress.jsp" />

						<%-- shipping review panel--%>
						<div class="shipping-address-review-panel js-review-panel">
							<dsp:include page="/checkout/includes/shippingAddressReview.jsp" /> 
						</div>
					</div>
					
					<%-- 2. payment step --%>
					<div class="checkout-payment not-started js-checkout-step" id="checkout-payment">
						<%-- payment form--%>
						<div class="payment-form-panel js-info-section">
							<dsp:include page="/checkout/includes/billing.jsp">
								<dsp:param name="orderCombination" value="${orderCombination}" />
							</dsp:include>
						</div>
						
						<%-- Payment review panel --%>
						<div class="payment-review-panel js-review-panel">
							<dsp:include page="/checkout/includes/billingReview.jsp" />
						</div>
					</div>
					
					<%-- 3. review step --%>
					<div class="checkout-review not-started js-checkout-step" id="checkout-review">
						<jsp:include page="/checkout/includes/orderReview.jsp" />
					</div>
				</div>
			</div>
			<div class="wysk-section hide-for-medium">
				<div class="title"><fmt:message key="wysk.title"/></div>
				<a href="${contextLinkPath}/content/policies/return-policy" target="_blank"><fmt:message key="wysk.returnPolicy"/></a>
				<a href="${contextLinkPath}/content/policies/privacy-policy" target="_blank"><fmt:message key="wysk.secureShopping"/></a>
			</div>
		</jsp:body>
	</layout:checkout>
</dsp:page>