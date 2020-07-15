<%--
	- File Name: pageNotFound.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the page for 404 error
	- Parameters:
	-
--%>
<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />

	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection" value="/content/Mobile/Mobile Error Pages/Page Not Found" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
			<dsp:renderContentItem contentItem="${element}" />
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>