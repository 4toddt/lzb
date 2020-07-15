<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="paymentGroups" param="orderNo.paymentGroups"/>
	<dsp:getvalueof var="payGrpCount" param="orderNo.paymentGroupCount"/>
			
			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${paymentGroups}"/>
				<dsp:param name="elementName" value="paymentGroup"/>
					<dsp:oparam name="output">
						<dsp:valueof param="paymentGroup.creditCardType"/> 
						  <dsp:valueof param="paymentGroup.creditCardNumber"/>
						<dsp:getvalueof var="pay" param="paymentGroup"/>
						<c:choose>
			    			<c:when test="${payGrpCount eq 1}">
			    				First Billing     $${pay.depositAmount}    Deposit<br/>
			    				Second Billing    $${pay.balanceAmount}    Balance<br/>
			    			</c:when>
			    			<c:when test="${payGrpCount eq 2}">
			    				<c:if test="${pay.lzbDebitType eq 'deposit'}">
			    					Deposit       $${pay.depositAmount}<br/>
			    				</c:if>
			    				<c:if test="${pay.lzbDebitType eq 'balance'}">
			    					Balance       $${pay.balanceAmount}<br/>
			    				</c:if>
			    			</c:when>
			    		</c:choose>
					</dsp:oparam>
			</dsp:droplet>
	
</dsp:page>