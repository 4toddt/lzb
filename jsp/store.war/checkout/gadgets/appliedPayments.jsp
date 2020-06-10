<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />

	<div class="split-payment-applied" style="display:none">
		<h3><fmt:message key="checkout.deliveryAndPayment.appliedPayments"/></h3>
		<a href="gadgets/removeAllPayment.jsp"><fmt:message key="checkout.deliveryAndPayment.removeAll"/></a>
    	
	   		<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.PaymentGroups"/>
					<dsp:param name="elementName" value="PGroup"/>
					<dsp:oparam name="output">
					<ul>
						<dsp:droplet name="Switch">
							<dsp:param name="value" param="PGroup.paymentGroupClassType"/>
							<dsp:oparam name="creditCard">
								<li>
									<dsp:getvalueof var="pay" param="PGroup"/>
						    		<dsp:valueof value="${pay.creditCardType}"/> <dsp:valueof value="${pay.creditCardNumber}"/>
						    	</li>
						    	<li>
						    		$ <dsp:valueof value="${pay.amount}"/>
						    	</li>
						    	<li>
						    		<dsp:a href="removePayment.jsp">
						    			<fmt:message key="checkout.deliveryAndPayment.remove"/>
						    			<dsp:param name="paymentGrpId" value="${pay.id}"/>
						    		</dsp:a>
								</li>
							</dsp:oparam>
						</dsp:droplet>
			    	</ul>
	    		</dsp:oparam>
			</dsp:droplet>	
		</ul>  	
	</div>
</dsp:page>