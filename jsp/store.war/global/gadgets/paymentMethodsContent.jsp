<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="paymentGroups" param="order.paymentGroups"/>
	<dsp:droplet name="ForEach">
		<dsp:param name="array" value="${paymentGroups}"/>
		<dsp:param name="elementName" value="paymentGroup"/>
            <dsp:getvalueof var="ccnum" param="paymentGroup.creditCardNumber"/>
            <c:set var="cclength" value="${fn:length(ccnum)}" />
			<c:set var="cc" value="${fn:substring(ccnum,cclength-4, cclength)}" />
			<dsp:oparam name="output">          
				<dsp:getvalueof var="ccType" param="paymentGroup.creditCardType"/>
				
				<c:choose>
					<c:when test="${ccType == 'MasterCard'}">
						<dsp:getvalueof var="ccType" value="MC" />
					</c:when>
					<c:when test="${ccType == 'Discover'}">
						<dsp:getvalueof var="ccType" value="DISC" />
					</c:when>
					<c:when test="${ccType == 'AmericanExpress'}">
						<dsp:getvalueof var="ccType" value="AMEX" />
					</c:when>
					<c:when test="${ccType == 'digitalBuy'}">
						<dsp:getvalueof var="ccType" value="LZB" />
					</c:when>
				</c:choose>                          
				<dsp:getvalueof var="amount" param="paymentGroup.amount"/>
				<div class="order-paymentcard"><strong class="style-upercase">${ccType}</strong> <span>${cc} &nbsp;&nbsp;&nbsp;<dsp:valueof value="${amount}" converter="currency" /></span></div>
			</dsp:oparam>
	</dsp:droplet>
</dsp:page>