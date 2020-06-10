<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	
	<dsp:getvalueof param="pageReprice" var="pageName"/>
	
	<c:choose>
		<c:when test="${pageName eq 'cart'}">
			<dsp:droplet name="RepriceOrderDroplet">
		  	<dsp:param name="pricingOp" value="ORDER_SUBTOTAL" />
		  	<dsp:oparam name="successWithErrors">
		   		<dsp:getvalueof param="pipelineResult.errors" var="errors"/>	
				
				<dsp:droplet name="ForEach">
			 	<dsp:param name="array" param="pipelineResult.errors" />
			 	<dsp:param name="elementName" value="error" />
				<dsp:oparam name="output">
					<p style="color:red;"><dsp:valueof param="error" valueishtml="true"/>,&nbsp;Please select different dealer to place an order.</p>
				</dsp:oparam>
				</dsp:droplet>	
		 	</dsp:oparam>
		 	<dsp:oparam name="failure">
		   		<p style="color:red;"><dsp:valueof param="exception" valueishtml="true"/></p>
		 	</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:when test="${pageName eq 'checkout'}">
			<dsp:droplet name="RepriceOrderDroplet">
			<dsp:param name="pricingOp" value="ORDER_TOTAL" />
			<dsp:oparam name="successWithErrors">
		   		<dsp:getvalueof param="pipelineResult.errors" var="errors"/>	
				
				<dsp:droplet name="ForEach">
			 	<dsp:param name="array" param="pipelineResult.errors" />
			 	<dsp:param name="elementName" value="error" />
				<dsp:oparam name="output">
					<p style="color:red;"><dsp:valueof param="error" valueishtml="true"/>,&nbsp;Please select different dealer to place an order.</p>
				</dsp:oparam>
				</dsp:droplet>	
		 	</dsp:oparam>
		 	<dsp:oparam name="failure">
		   		<p style="color:red;"><dsp:valueof param="exception" valueishtml="true"/></p>
		 	</dsp:oparam>
			</dsp:droplet>
		</c:when>
	</c:choose>
</dsp:page>