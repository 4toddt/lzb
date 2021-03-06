<%--
	- File Name: sessionExpired.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the page for session expiration
	- Parameters:
	-
--%>
<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />

	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection" value="/content/Mobile/Mobile Error Pages/Session Expired" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
			<dsp:renderContentItem contentItem="${element}" />
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>
