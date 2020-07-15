<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	
    <dsp:getvalueof var="paymentGroups" vartype="java.lang.Object" bean="ShoppingCart.current.PaymentGroups" />
	<dsp:getvalueof var="payGrpCount" bean="ShoppingCart.current.paymentGroupCount"/> 
		
    <div>
		<span class="icon checkout-title-icon icon-radio"></span>
		<div class="checkout-title">
			<span class="sr-only"><fmt:message key="checkout.step.srDescription" /></span>
			<span class="status-step-num">2</span><fmt:message key="checkout.step.payment" />
			<a href="javascript:void(0);" class="edit-payment edit-link hide-for-medium">
				<fmt:message key="checkout.edit.link" />
				<span class="sr-only"><fmt:message key="checkout.edit.link.srPayment" /></span>
			</a>
		</div>
	</div>
	
	<div class="payment-review js-review-content">
		<c:forEach var="currentPaymentGroup" items="${paymentGroups}" varStatus="status">
			<dsp:getvalueof var="paymentAddress" value="${currentPaymentGroup.billingAddress}" />
			
			<div class="payment-method">
				<c:choose>
					<c:when test="${currentPaymentGroup.paymentGroupClassType == 'creditCard'}">
						<div class="credit-card">
							<span class="credit-card-num"><dsp:valueof value="${currentPaymentGroup.creditCardNumber}" converter="CreditCard" maskcharacter="" numcharsunmasked="4"/></span>
							
							<dsp:include page="/global/includes/creditCardType.jsp">
								<dsp:param name="creditCardType" value="${currentPaymentGroup.creditCardType}" />
							</dsp:include>
						</div>
						
						<c:if test="${payGrpCount == '2'}">
							<div class="charge-amount">
								<c:if test="${currentPaymentGroup.lzbDebitType == 'deposit'}">
									<fmt:message key="financialstack.label.deposit"/>:&nbsp; 
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${currentPaymentGroup.depositAmount}" />
									</dsp:include>
						    	</c:if>
						    	<c:if test="${currentPaymentGroup.lzbDebitType == 'balance'}">
						    		<fmt:message key="financialstack.label.balance"/>:&nbsp;
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${currentPaymentGroup.balanceAmount}" />
									</dsp:include>
						    	</c:if>
							</div>
						</c:if>
					</c:when>
					<c:when test="${currentPaymentGroup.paymentGroupClassType == 'digitalBuyCard'}">
						<div>
							<img src="${contextPath}/resources/images/checkout/lzb_card.jpg" class="lzb-cc" alt="LazyBoy Credit Card" title="LazyBoy Credit Card">
						</div>
					</c:when>
					<c:otherwise>
						<%-- For more payment methods in future --%>
					</c:otherwise>
				</c:choose>
				
				<p>
					${paymentAddress.firstName}&nbsp;${paymentAddress.lastName}<br/>
					${paymentAddress.address1}<br/>
					<c:if test="${not empty paymentAddress.address2}">
						${paymentAddress.address2}<br/>
					</c:if>
					${paymentAddress.city},&nbsp;${paymentAddress.state}&nbsp;${paymentAddress.postalCode}<br/>
					<span class="phone">${paymentAddress.phoneNumber}</span>
				</p>
			</div>
		</c:forEach>
		<a href="javascript:void(0);" class="edit-payment edit-link hide-for-small" data-target="checkout-payment">
			<fmt:message key="checkout.edit.link" />
			<span class="sr-only"><fmt:message key="checkout.edit.link.srPayment" /></span>
		</a>
	</div>
</dsp:page>
