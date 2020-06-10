<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
		<dsp:setvalue bean="GiftlistFormHandler.removeGiftlistItems" value="true"/>
</dsp:page>