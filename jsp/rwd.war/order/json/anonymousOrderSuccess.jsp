<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<%-- Page Variables --%>
	<dsp:getvalueof var="orderId" param="orderId"/>
	
	<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
		<dsp:param name="inUrl" value="${contextPath}/order/anonymousOrderDetails.jsp?orderId=${orderId}"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="redirectUrl" scope="request" param="secureUrl"/>
		</dsp:oparam>
	</dsp:droplet>

	<json:object>
		<json:property name="success">true</json:property>
		<json:property name="url">${redirectUrl}</json:property>
	</json:object>

</dsp:page>
