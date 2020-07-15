<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="orderno" param="orderNo"/>
	<dsp:getvalueof var="paymentGroups" param="order.paymentGroups"/>
      			
			<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${paymentGroups}"/>
				<dsp:param name="elementName" value="paymentGroup"/>
					<dsp:oparam name="output">
						<div class="customer-name"><dsp:valueof param="paymentGroup.billingAddress.firstName"/>&nbsp; 
						<dsp:valueof param="paymentGroup.billingAddress.lastName"/></div>
						<p>
							<dsp:valueof param="paymentGroup.billingAddress.address1"/><br/>
							<dsp:valueof param="paymentGroup.billingAddress.city"/>,&nbsp;<dsp:valueof param="paymentGroup.billingAddress.state"/>&nbsp;<dsp:valueof param="paymentGroup.billingAddress.country"/>&nbsp;<dsp:valueof param="paymentGroup.billingAddress.postalCode"/>
						</p>
					</dsp:oparam>
			</dsp:droplet>

</dsp:page>