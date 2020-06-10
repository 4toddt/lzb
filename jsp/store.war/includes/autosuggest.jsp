<%--
Return content from Endeca Experience Manager using the InvokeAssembler droplet
--%>
<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:importbean bean="/atg/endeca/assembler/AutoSuggestDroplet"/>
	<dsp:getvalueof var="collection" value="${originatingRequest.contentCollection}"/>
	<dsp:droplet name="AutoSuggestDroplet">
		<dsp:param name="collection" value="${collection}"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>