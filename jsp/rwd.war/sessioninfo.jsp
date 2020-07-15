<%--
	- File Name: sessioninfo.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page prints out some session information for debugging purposes.
	- Required Parameters:
	- Optional Parameters:
--%>

<dsp:page>

	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/nm/droplet/SessionInfo"/>
			<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
		ServerName: ${ hostName } <br>
		ServerPort: <dsp:valueof bean="/atg/dynamo/Configuration.siteHttpServerPort"></dsp:valueof><br><br>
		
	<dsp:droplet name="SessionInfo">
		<dsp:param name="profile" bean="Profile" />
	</dsp:droplet>
</dsp:page>