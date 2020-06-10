<%@ include file="/sitewide/fragments/content-type-json.jspf" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyTokenDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />

	<dsp:droplet name="GetDigitalBuyTokenDroplet" >
		<dsp:param name="order" bean="ShoppingCart.current" />
		<dsp:oparam name="output" >
			<dsp:getvalueof var="token" param="token" />
			<dsp:getvalueof var="postback" param="postback" />
		</dsp:oparam>	
	</dsp:droplet>
	
	<json:object>
		<json:property name="success">true</json:property>
		<json:property name="token">${token}</json:property>
		<json:property name="postback">${postback}</json:property>
	</json:object>
	
</dsp:page>