<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyTokenDroplet" />
	
    <%-- DigitalBuy variables --%>
    <dsp:getvalueof var="useDigitalBuyPayment" param="useDigitalBuyPayment" />
	<dsp:getvalueof var="orderDBToken" bean="ShoppingCart.current.dbuyToken" />
	<dsp:getvalueof var="orderDBStep" bean="ShoppingCart.current.dbuyStep" />
	
	<%-- Begin: For DigitalBuy purchase additional logic --%>
	<dsp:getvalueof var="paymentGroups" vartype="java.lang.Object" bean="ShoppingCart.current.PaymentGroups" />
	<dsp:getvalueof var="billingAddress" value="${paymentGroups[0].billingAddress}" />
	
	<dsp:droplet name="LZBOrderSummaryDroplet">
	<dsp:param name="order" bean="ShoppingCart.current"/>
	<dsp:param name="profile" bean="Profile" />
	<dsp:param name="page" value="checkout"/>
	<dsp:oparam name="output">
		<dsp:getvalueof var="orderTotal" param="total"/>
	</dsp:oparam>
	</dsp:droplet>
	
	<%-- Set default value of DigitalBuy processInd to Pay with DigitalBuy from Cart scenario --%>
	<dsp:getvalueof var="processInd" value="2" />
	<dsp:getvalueof var="dbToken" bean="ShoppingCart.current.dbuyToken" />
	
	<%-- orderDBStep is "cart" for digitalBuy from Cart page, or else it will be null --%>
	<c:if test="${useDigitalBuyPayment && empty orderDBStep}">
		<dsp:getvalueof var="processInd" value="3" />
		<dsp:getvalueof var="dbToken" value="" />
	</c:if>
	<%-- End: For DigitalBuy purchase additional logic --%>
	
	<div class="review-panel js-info-section">
		<div>
			<span class="icon checkout-title-icon icon-radio"></span>
			<div class="checkout-title">
				<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
				<span class="status-step-num">3</span><fmt:message key="checkout.step.review" />
			</div>
		</div>
		
		<div class="js-info-content">
		  	<c:choose>
		  		<c:when test="${useDigitalBuyPayment}">
		  			<%-- Purchase with "Pay with DigitalBuy" from Cart (processInd=2) or Checkout (processInd=3) --%>
		  			<span class="review-instruction"><fmt:message key="checkout.review.instructionDBPurchase"/></span>
		  			
		  			<dsp:form id="digital-buy-form" method="post" name="digital-buy-form" formid="digital-buy-form">
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.usingDigitalBuy" value="true" />
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderSuccessURL"  value="/rwd/checkout/json/setCommitOrderSuccess.jsp" />
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderErrorURL"  value="/rwd/checkout/json/setCommitOrderError.jsp" />
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrder" value="submit" />
					</dsp:form>
					
		  			<div id="dbuymodel${processInd}"></div> 
					<form name="dbuyform${processInd}" id="dbuyform${processInd}"> 
						<input type="hidden" id="processInd" value="${processInd}" /> 
						<input type="hidden" id="tokenId" value="${dbToken}" /> 
						<input type="hidden" id="merchantID" value="${storeConfig.digitalBuyMerchantID}" /> 
						<input type="hidden" id="clientTransId" value="<dsp:valueof bean="ShoppingCart.current.id"/>" />
						<input type="hidden" id="custFirstName" value="${billingAddress.firstName}" />
						<input type="hidden" id="custLastName" value="${billingAddress.lastName}" />
						<input type="hidden" id="custAddress1" value="${billingAddress.address1}" />
						<input type="hidden" id="custCity" value="${billingAddress.city}" />
						<input type="hidden" id="custState" value="${billingAddress.state}" />
						<input type="hidden" id="custZipCode" value="${billingAddress.postalCode}" />
						<input type="hidden" id="transAmount1" value="${orderTotal}" />
						<input type="hidden" id="transPromo1" value="${storeConfig.digitalBuyFinancePromoCode}" />
						
						<a href="#" class="button tertiary checkout-btn db-btn dbuyProcessInd${processInd}-order-btn" data-toggle="modal" data-target="#digBuyModal"><fmt:message key="checkout.review.completeDBPurchase"/></a> 
					</form>
		  		</c:when>
		  		<c:otherwise>
		  			<%-- Credit Card payment --%>
		  			<span class="review-instruction"><fmt:message key="checkout.review.instruction"/></span>
		  			
				  	<dsp:form id="commit-order-form" method="post" name="commit-order-form" formid="commit-order-form">
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderSuccessURL"  value="/rwd/checkout/json/setCommitOrderSuccess.jsp" />
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderErrorURL"  value="/rwd/checkout/json/setCommitOrderError.jsp" />
					  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrder" value="submit" />
					  	
					  	<a href="#" class="button tertiary review-continue checkout-btn"><fmt:message key="checkout.review.completePurchase"/></a> 
					</dsp:form>
				</c:otherwise>
			</c:choose>	 
	  	</div>	  	
	</div>
</dsp:page>
