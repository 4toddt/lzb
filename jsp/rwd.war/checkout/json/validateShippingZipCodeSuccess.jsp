<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	
	<json:object>
		<json:property name="success">true</json:property>
		
		<json:property name="zipCode"><dsp:valueof bean="ProfileFormHandler.zipCode" /></json:property>
	</json:object>
</dsp:page>