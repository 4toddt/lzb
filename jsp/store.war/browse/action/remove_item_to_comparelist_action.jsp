<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
<dsp:setvalue bean="ProductListHandler.removeProductWithSku" value="true"/>
</dsp:page>