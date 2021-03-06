<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<json:object>
		<json:property name="success">false</json:property>
		<json:array name="errorMessages">
			<dsp:droplet name="ErrorMessageForEach">
			<dsp:param name="exceptions" param="PaymentGroupFormHandler.formExceptions" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="errorMessage" param="message"/>
				<json:property escapeXml="false">
					<c:out value="${errorMessage}" escapeXml="false"/>
				</json:property>
			</dsp:oparam>
			</dsp:droplet>
		</json:array>
	</json:object>
</dsp:page>
