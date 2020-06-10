<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="orderno" param="orderNo"/>
	<dsp:getvalueof var="shippingGroups" param="orderNo.shippingGroups"/>

	      		<dsp:droplet name="ForEach">
				<dsp:param name="array" value="${shippingGroups}"/>
				<dsp:param name="elementName" value="shippingGroup"/>
					<dsp:oparam name="output">
						<div class="customer-name"><dsp:valueof param="shippingGroup.shippingAddress.firstName"/>&nbsp;
						<dsp:valueof param="shippingGroup.shippingAddress.lastName"/></div>
						<p>
						<dsp:valueof param="shippingGroup.shippingAddress.address1"/>
						<dsp:valueof param="shippingGroup.shippingAddress.city"/>
						<dsp:valueof param="shippingGroup.shippingAddress.state"/><br/>
						<dsp:valueof param="shippingGroup.shippingAddress.country"/>
						<dsp:valueof param="shippingGroup.shippingAddress.postalCode"/></p>
					</dsp:oparam>
			</dsp:droplet>
</dsp:page>