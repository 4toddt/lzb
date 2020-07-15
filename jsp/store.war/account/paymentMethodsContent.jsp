<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="paymentGroups" param="orderNo.paymentGroups"/>
	<dsp:getvalueof var="payGrpCount" param="orderNo.paymentGroupCount"/>

	<dsp:droplet name="ForEach">
		<dsp:param name="array" value="${paymentGroups}"/>
		<dsp:param name="elementName" value="paymentGroup"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="pay" param="paymentGroup"/>
				<dsp:valueof value="${pay.creditCardType}"/> <dsp:valueof converter="CreditCard" numcharsunmasked="4" maskcharacter=" " value="${pay.creditCardNumber}"/></br>
			    		<c:choose>
			    			<c:when test="${payGrpCount eq 1}">
			    				<fmt:message key="checkout.review.deposit"/>
			    				<dsp:include page="/global/includes/formattedPrice.jsp">
									<dsp:param name="price" value="${pay.depositAmount}" />
								</dsp:include><br/>
			    				<fmt:message key="checkout.review.balance"/>
			    				<dsp:include page="/global/includes/formattedPrice.jsp">
									<dsp:param name="price" value="${pay.balanceAmount}" />
								</dsp:include><br/>
			    			</c:when>
			    			<c:when test="${payGrpCount eq 2}">
			    				<c:if test="${pay.lzbDebitType eq 'deposit'}">
			    					<fmt:message key="checkout.review.deposit"/>
			    					<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${pay.depositAmount}" />
									</dsp:include><br/>
			    				</c:if>
			    				<c:if test="${pay.lzbDebitType eq 'balance'}">
			    					<fmt:message key="checkout.review.balance"/>
			    					<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${pay.balanceAmount}" />
									</dsp:include><br/>
			    				</c:if>
			    			</c:when>
			    		</c:choose>
			</dsp:oparam>
	</dsp:droplet>
</dsp:page>