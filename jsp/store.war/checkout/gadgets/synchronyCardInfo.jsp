<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="payGrpCount" bean="ShoppingCart.current.paymentGroupCount"/>
	
	<p>paymentInfo.jsp ver: 1.2</p>
	 <p>OrderId: <dsp:valueof bean="ShoppingCart.current.id"/>
	 Session: ${originatingRequest.session.id} <br/>

	<fmt:message var="edit" key="checkout.review.edit"/>
	<table>
		<tr>
	    	<td><dt><fmt:message key="checkout.review.paymentInfo"/></dt></td>
	    	<td>
	    		<dsp:a href="/work/checkout/deliveryAndPayment.jsp"><dsp:param name="page" value="orderReview"/><input type="button" value="${edit}"/></dsp:a>
   			</td>
    	</tr>
    	<tr>
    		<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.PaymentGroups"/>
					<dsp:param name="elementName" value="PGroup"/>
					<dsp:oparam name="output">
	    			<td>
						<dsp:getvalueof var="pay" param="PGroup"/>
						<dsp:valueof value="${pay.billingAddress.firstName}"/>  <dsp:valueof value="${pay.billingAddress.lastName}"/> </br> 
				 		<dsp:valueof value="${pay.billingAddress.address1}"/>    <dsp:valueof value="${pay.billingAddress.address2}"/> </br>
				 		<dsp:valueof value="${pay.billingAddress.city}"/>,<dsp:valueof value="${pay.billingAddress.state}"/>   </br>
				 		<dsp:valueof value="${pay.billingAddress.country}"/>  </br>
				 		<dsp:valueof value="${pay.billingAddress.postalCode}"/>   </br>
				 		<dsp:valueof value="${pay.billingAddress.email}"/></br>
				 		<dsp:valueof value="${pay.billingAddress.phoneNumber}"/>   </br>				 		
			    	</td>
	    		</dsp:oparam>
			</dsp:droplet>
	  	</tr>
	</table>
</dsp:page>
