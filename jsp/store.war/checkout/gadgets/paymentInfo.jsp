<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="payGrpCount" bean="ShoppingCart.current.paymentGroupCount"/>

	<div class="payment-delivery">

		<h2><fmt:message key="checkout.review.paymentInfo" /></h2>

		<dsp:a href="/checkout/deliveryAndPayment.jsp"><input class="edit btn-primary" type="button" value="EDIT"/></dsp:a>
		<div>
    		<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.PaymentGroups"/>
					<dsp:param name="elementName" value="PGroup"/>
					<dsp:oparam name="output">
		    			<div class="saved-address">
		    				<dsp:getvalueof var="pay" param="PGroup"/>
		    				<ul>
								<li><dsp:valueof value="${pay.billingAddress.firstName}"/>  <dsp:valueof value="${pay.billingAddress.lastName}"/> </li>
						 		<li><dsp:valueof value="${pay.billingAddress.address1}"/>    <dsp:valueof value="${pay.billingAddress.address2}"/></li>
						 		<li><dsp:valueof value="${pay.billingAddress.city}"/>,<dsp:valueof value="${pay.billingAddress.state}"/></li>
						 		<li><dsp:valueof value="${pay.billingAddress.country}"/></li>
						 		<li><dsp:valueof value="${pay.billingAddress.postalCode}"/></li>
						 		<li><dsp:valueof value="${pay.billingAddress.email}"/></li>
						 		<li><dsp:valueof value="${pay.billingAddress.phoneNumber}"/></li>
					 		</ul>
				    	</div>
				    	<div class="saved-address special-delivery">
				    		<ul>
				    			<li><fmt:message key="checkout.review.paymentMethod"/></li>
				    		</ul>
							<dsp:droplet name="Switch">
								<dsp:param name="value" param="PGroup.paymentGroupClassType" />
								<dsp:oparam name="creditCard">
						    		<p>
										<dsp:valueof value="${pay.creditCardType}"/> 
										<dsp:valueof converter="CreditCard" numcharsunmasked="4" maskcharacter=" " value="${pay.creditCardNumber}" />
									</p>
						    		<c:choose>
						    			<c:when test="${payGrpCount eq 1}">
						    				<ul>
							    				<li><fmt:message key="checkout.review.firstBilling"/></li>   
							    				<li>
							    					<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${pay.depositAmount}" />
													</dsp:include>
												</li>   
							    				<li><fmt:message key="checkout.review.deposit"/></li>
						    				</ul>
						    				<ul>
							    				<li><fmt:message key="checkout.review.secondBilling"/></li>
							    				<li>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${pay.balanceAmount}" />
													</dsp:include>
												</li>
							    				<li><fmt:message key="checkout.review.balance"/></li>
						    				</ul>
						    			</c:when>
						    			<c:when test="${payGrpCount eq 2}">
						    				<c:if test="${pay.lzbDebitType eq 'deposit'}">
						    					<ul>
							    					<li><fmt:message key="checkout.review.firstBilling" /></li>
							    					<li>
														<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.depositAmount}" />
														</dsp:include>
													</li>
													<li><fmt:message key="checkout.review.deposit"/></li>			    					
						    					</ul>
						    				</c:if>
						    				<c:if test="${pay.lzbDebitType eq 'balance'}">
						    					<ul>
							    					<li><fmt:message key="checkout.review.secondBilling" /></li>
							    					<li>
														<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${pay.balanceAmount}" />
														</dsp:include>
													</li>
													<li><fmt:message key="checkout.review.balance"/></li>
						    					</ul>
						    				</c:if>
						    			</c:when>
						    		</c:choose>
								</dsp:oparam>
							</dsp:droplet>
				    	</div>
	    		</dsp:oparam>
			</dsp:droplet>
	</div>
</dsp:page>