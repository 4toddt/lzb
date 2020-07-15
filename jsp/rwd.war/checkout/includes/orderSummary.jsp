<%--
    - File Name: orderSummary.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the order summary section on the cart and checkout pages.
    - Required Parameters:
        - pageType
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBCalcOrderDepositBalanceAmountDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyFinanceEstimate" />
	<dsp:importbean var="storeConfig" bean="/atg/store/LZBStoreConfiguration"/>

    <%-- Page Variables --%>
	<dsp:getvalueof var="pageType" param="pageType" />
	<dsp:getvalueof var="relOrder" param="relOrder" />
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode" />
	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />
	
	<dsp:getvalueof var="country" bean="Profile.currentStore.country" />

	<c:if test="${pageType == 'checkout'}">
		<dsp:include page="/checkout/includes/cartTax.jsp">
			<dsp:param name="callTax" value="true" />
		</dsp:include>
	</c:if>

	<c:choose>
		<c:when test="${pageType == 'cart' || pageType == 'checkout'}">
			<dsp:getvalueof var="order" bean="ShoppingCart.current" />
			<dsp:getvalueof var="reviewPage" value="" />
		</c:when>
		<c:when test="${pageType == 'orderConfirmation'}">
			<dsp:getvalueof var="order" bean="ShoppingCart.last" />
			<c:if test="${not empty relOrder}" >
				<dsp:getvalueof var="order" value="${relOrder}" />			
			</c:if>
			<dsp:getvalueof var="reviewPage" value="true" />
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>

    <%-- Droplet: Order Summary --%>
	<dsp:droplet name="LZBOrderSummaryDroplet">
	    <dsp:param name="order" value="${order}" />
	    <dsp:param name="profile" bean="Profile" />
	    <dsp:param name="page" value="${pageType}"/>
	    <dsp:oparam name="output">
		    <dsp:getvalueof var="total" param="total"/>
			<dsp:getvalueof var="totalRecycleFee" param="totalRecycleFee"/>
            <dsp:getvalueof var="orderCombination" param="orderCombination"/>
		    <dsp:getvalueof var="taxDown" value="${order.taxPriceInfo.taxDown}"/>

            <c:choose>
                <c:when test="${pageType == 'cart'}">
                    <dsp:getvalueof var="orderTotal" value="${total+cartTaxAmount}" />
                    <c:set var="deliveryLabel"><fmt:message key="financialstack.label.estimatedDelivery"/></c:set>
                    <c:set var="taxLabel"><fmt:message key="financialstack.label.estimatedTax"/></c:set>
                    <dsp:getvalueof var="tax" value="${cartTaxAmount}" />
                </c:when>
                <c:when test="${pageType == 'checkout'}">
                    <dsp:getvalueof var="orderTotal" value="${total}" />
                    <c:set var="deliveryLabel"><fmt:message key="financialstack.label.delivery"/></c:set>
                    <c:set var="taxLabel"><fmt:message key="financialstack.label.estimatedTax"/></c:set>
                    <dsp:getvalueof var="tax" value="---" />
                </c:when>
                <c:when test="${pageType == 'orderConfirmation'}">
                    <dsp:getvalueof var="orderTotal" value="${total}" />
                    <c:set var="deliveryLabel"><fmt:message key="financialstack.label.delivery"/></c:set>
                    <c:set var="taxLabel"><fmt:message key="financialstack.label.tax"/></c:set>
                    <dsp:getvalueof var="tax" param="tax" />
                    <dsp:getvalueof var="totalItemCost" param="totalItemCost"/>
                    <dsp:getvalueof var="itemsList" param="itemsList"/>
                    <%-- #orderItemCost and #itemsList for Bluecore analytics tracking --%>
                    <input type="hidden" id="orderItemCost" value="${totalItemCost}" />
                    <input type="hidden" id="itemsList" value="${itemsList}" />
                </c:when>
                <c:otherwise>
                </c:otherwise>
            </c:choose>
		
		<div class="totals-and-deposits-container">
			<div class="totals-container">
				<div class="totals">
					<div class="total-row subtotal">
						<div class="total-label"><fmt:message key="financialstack.label.subtotal"/></div>
						<div class="total-amount"><dsp:valueof param="totalItemCost" converter="currency"/></div>
					</div>
					<div class="total-row shipping">
						<div class="total-label">${deliveryLabel}</div>
						<div class="total-amount"><dsp:valueof param="shippingCharge" converter="currency"/></div>
					</div>
				    <c:if test="${pageType == 'orderConfirmation'}">
					<div class="total-row tax">
						<c:choose>
							<c:when test="${taxDown == 'true'}">
								<c:set var="taxdownTooltip"><fmt:message key="order.taxdown.tooltip"/></c:set>
								<span class="tax-down-msg">
									<p>
										<fmt:message key="order.taxdown.title"/>
										<span data-tooltip class="has-tip tip-right radius icon icon-info" title="${taxdownTooltip}"><span class="sr-only">${taxdownTooltip}</span></span>
									</p>
									<fmt:message key="order.taxdown.details"/>
								</span>
							</c:when>
							<c:otherwise>
								<div class="total-label">${taxLabel}</div>
								<div class="total-amount"><dsp:valueof value="${tax}" converter="currency"/></div>
							</c:otherwise>
						</c:choose>
					</div>
						<c:if test="${not empty totalRecycleFee}">
							<div class="total-row recycling-fee">
								<div class="total-label">
									<fmt:message var="recyclingFeeTooltipTitle" key="recyclingFee.tooltip.title"/>
									<fmt:message var="recyclingFeeTooltipContent" key="recyclingFee.tooltip.content"/>
									<fmt:message key="financialstack.label.recyclingFee"/>
									<span data-tooltip class="has-tip tip-left radius icon icon-info" title="<p>${recyclingFeeTooltipTitle}</p>${recyclingFeeTooltipContent}"><span class="sr-only">${recyclingFeeTooltipTitle}. ${recyclingFeeTooltipContent}</span></span>
									<a href="${contextPath}/checkout/ajax/financialStackModal.jsp?type=recyclingFee" class="modal-trigger" data-dismiss="modal" data-target="financial-stack-modal" tabindex="0" aria-label="Click to open details about Recycling Fee"><span class="icon icon-info"></span></a>
								</div>
								<div class="total-amount"><dsp:valueof value="${totalRecycleFee}" converter="currency"/></div>
							</div>
						</c:if>
					</c:if>
					<div class="total-row">&nbsp;</div>
					<div class="total-row total">
						<div class="total-label"><fmt:message key="financialstack.label.total"/></div>
						<div class="total-amount"><dsp:valueof value="${orderTotal}" converter="currency"/></div>
					</div>
				</div>
			</div>
	
			<c:if test="${pageType != 'orderConfirmation' && orderCombination != 'onlyLicensed'}">
				<dsp:include page="/checkout/includes/depositSection.jsp" >
					<dsp:param name="deliveryCost" param="shippingCharge"/>
					<dsp:param name="taxCost" value="${cartTaxAmount}"/>
				</dsp:include>
			</c:if>
		</div>
		
		<c:if test="${pageType == 'cart'}">
			<dsp:droplet name="GetDigitalBuyFinanceEstimate">
	    	<dsp:param name="order" value="${order}" />
			<%-- DMI-2921: Passing orderTotal to use it for calculation, this would include delivery fees if any --%> 	    	
	    	<dsp:param name="orderTotal" value="${orderTotal}" />
	    	<dsp:oparam name="output">
	    		<dsp:getvalueof var="estimate" param="estimate"/>
	    		<dsp:getvalueof var="financingMonths" param="financingMonths"/>
	    		<fmt:formatNumber value="${estimate+0.5-((estimate+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
			</dsp:oparam>
	    	</dsp:droplet>
	    	
	    	<c:if test="${country != 'CA'}">
				<div class="lzb-cc-financing">
					<div class="lzb-cc-container">
						<img src="${contextPath}/resources/images/checkout/lzb_card.jpg" align="left" alt="LazyBoy Credit Card" title="LazyBoy Credit Card">
						<div class="lzb-cc-details">
							<p><fmt:message key="cart.financing.LZBcc"/></p>
							<fmt:message key="cart.financing.text"/>
							<a href="#" class="to-digitalbuy-btn" data-toggle="modal" data-target="#digBuyModal"><fmt:message key="cart.financing.applynow"/></a> 
						</div>
					</div>
					<div class="lzb-financing-container">
						<div class="lzb-financing-cost">
							<div class="payment-amount">$<dsp:valueof value="${monthlyPrice}" converter="currency"/></div> 
							${storeConfig.digitalBuyCartMessage}
						</div>
						<div class="lzb-financing-details">
							<p>With <span class="financing-months">${financingMonths}</span> Month Financing</p>
							<fmt:message key="cart.financing.details"/>
							<a href="/content/financing-disclosures" target="_blank"><fmt:message key="cart.financing.info"/></a>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>