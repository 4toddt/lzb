<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
<dsp:setvalue bean="ProductListHandler.removeProductWithEntryId" value="true"/>
</dsp:page>