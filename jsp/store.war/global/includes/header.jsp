<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />

<dsp:droplet name="InvokeAssembler">
	<dsp:param name="contentCollection" value="/content/Shared/Header/Desktop" />
	<dsp:param name="includePath" value="" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="element"
			vartype="com.endeca.infront.assembler.ContentItem"
			param="contentItem" />

		<dsp:renderContentItem contentItem="${element}" />
	</dsp:oparam>
	<dsp:oparam name="error">
	</dsp:oparam>
</dsp:droplet>
<%-- <!--  Survey modal NOTE : Need to make POP UP -->
	<div id="showSurvey">
		<dsp:droplet name="/com/lzb/droplet/LZBSurveyDroplet">
		<dsp:oparam name="output">
		<dsp:getvalueof param="showSurveyPopup" var="showSurveyPopup"/>
			<c:if test="${showSurveyPopup eq true}">
				<iframe  width="100%" height="500" src="https://roisurvey.com/la-z-boy" frameborder="0" allowfullscreen></iframe> 
			</c:if>
		</dsp:oparam>
		</dsp:droplet> --%>
</dsp:page>

