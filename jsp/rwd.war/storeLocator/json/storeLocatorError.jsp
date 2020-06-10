<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>
	
 	<dsp:param name="formHandler" bean="LZBStoreLocatorFormHandler" />
 	
  	<json:object>
    	<json:property name="success">false</json:property>
    	<dsp:droplet name="Switch">
			<dsp:param name="value" param="formhandler.formError" />
			<dsp:oparam name="true">
				<json:property name="InlineFormErrorSupport">
					false
				</json:property>
				<%-- <h3><fmt:message key="error.msg"/></h3> --%>
				<json:array name="errorMessages">
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" param="formHandler.formExceptions" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="errorMessage" param="message" />
	                        <dsp:getvalueof var="errorField" param="propertyName" />
							<json:property escapeXml="false">
								<c:out value="${errorMessage}" escapeXml="false"/>
							</json:property>
						</dsp:oparam>
					</dsp:droplet>
				</json:array>
			</dsp:oparam>
		</dsp:droplet>
  	</json:object>
</dsp:page>