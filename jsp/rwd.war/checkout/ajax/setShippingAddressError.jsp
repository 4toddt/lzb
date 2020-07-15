<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/pcr/commerce/order/purchase/PCRShippingGroupFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<json:object>
		<json:property name="success">false</json:property>
		<json:property name="avsAddressChanged"><dsp:valueof bean="PCRShippingGroupFormHandler.avsAddressChanged"/></json:property>
		<json:property name="addressUndeliverable"><dsp:valueof bean="PCRShippingGroupFormHandler.addressUndeliverable"/></json:property>
		<json:property name="hasRestrictedItems"><dsp:valueof bean="PCRShippingGroupFormHandler.hasRestrictedItems"/></json:property>
		<json:array name="errorMessages">
			<dsp:droplet name="ErrorMessageForEach">
			<dsp:param name="exceptions" param="PCRShippingGroupFormHandler.formExceptions" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="rawErrorMsg" param="message"/>
				<c:set var="message" value="${fn:split(rawErrorMsg, '|')}" />
				<json:property escapeXml="false">
					${message[0]}
				</json:property>
			</dsp:oparam>
			</dsp:droplet>
		</json:array>
		<%-- error messages array for utag tracking --%>
		<json:array name="errorMessagesForUtag">
			<dsp:droplet name="ErrorMessageForEach">
			<dsp:param name="exceptions" param="PCRShippingGroupFormHandler.formExceptions" />
			<dsp:oparam name="output">
				<json:property escapeXml="false">
					<dsp:valueof param="message" />
				</json:property>
			</dsp:oparam>
			</dsp:droplet>
		</json:array>
	</json:object>
</dsp:page>