<dsp:importbean bean="/com/lzb/droplet/LZBCartTaxDroplet" />
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:getvalueof param="callTax" var="callTax"/>

<dsp:page>

	<c:if test="${ callTax eq 'true'}">
		<dsp:droplet name="LZBCartTaxDroplet">
			<dsp:param name="order" bean="ShoppingCart.current" />
			<dsp:param name="profile" bean="Profile" />
				<dsp:oparam name="empty">
				</dsp:oparam>
				<dsp:oparam name="output">
					<dsp:getvalueof var="taxAmount" param="taxAmount"/>
					<dsp:getvalueof var="taxDown" param="taxDown"/>
					<c:set var="cartTaxAmount" scope="request" value="${taxAmount}"/>
					<c:set var="cartTaxDown" scope="request" value="${taxDown}"/>
				</dsp:oparam>
		</dsp:droplet>
	</c:if>
	
</dsp:page>