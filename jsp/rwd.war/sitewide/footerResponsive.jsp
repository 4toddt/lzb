<dsp:page>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="contentCollection"
			value="/content/SharedMobile/LZBResponsiveFooter/LZBResponsiveFooter" />
		<dsp:param name="includePath" value="" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="element"
				vartype="com.endeca.infront.assembler.ContentItem"
				param="contentItem" />
                <!-- Footer Content -->
			<c:forEach var="content" items="${element.contents}">
				<dsp:renderContentItem contentItem="${content}" />
			</c:forEach>
		</dsp:oparam>
		<dsp:oparam name="error">
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>
