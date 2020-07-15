<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<dsp:importbean bean="/com/lzb/order/LZBEstimatedDeliveryChargeFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>

	<dsp:param name="formhandler" bean="LZBEstimatedDeliveryChargeFormHandler" />

	<json:object>

		<json:property name="success">false</json:property>

		<json:array name="errorMessages">
			<dsp:droplet name="ErrorMessageForEach">
			<dsp:param name="exceptions" param="LZBEstimatedDeliveryChargeFormHandler.formExceptions" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="rawErrorMsg" param="message"/>
				<c:set var="message" value="${fn:split(rawErrorMsg, '|')}" />
				<json:property escapeXml="false">
					${message[0]}
				</json:property>
			</dsp:oparam>
			</dsp:droplet>
		</json:array>
	</json:object>

</dsp:page>
