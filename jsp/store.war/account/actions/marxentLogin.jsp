<%@ page contentType="application/json" %>
<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBRemoteLoginDroplet" />

	<json:object prettyPrint="true" escapeXml="false">

		<dsp:droplet name="LZBRemoteLoginDroplet">
		<dsp:param name="login" param="login"/>
		<dsp:param name="password" param="password"/>
		<dsp:param name="marxentKey" param="marxentKey"/>
		<dsp:oparam name="false">
			<json:property name="success" value="${false}" />
		</dsp:oparam>
		<dsp:oparam name="true">
			<dsp:getvalueof var="customerID" param="customerID" />
			<json:property name="success" value="${true}" />
			<json:property name="customerID" value="${customerID}" />		
		</dsp:oparam>
		</dsp:droplet>
		
	</json:object>
</dsp:page>