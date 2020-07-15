<dsp:page>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler" />
<dsp:getvalueof param="entriesId" var="entriesId"/>
<dsp:getvalueof param="navurl" var="navurl"/>

<dsp:form id="removeItem${entriesId}" action="${navurl}" name="removeItem${entriesId}">
		<input type="hidden" value="${entriesId}" name="entryIds"/>
		<dsp:input bean="ProductListHandler.removeProductSuccessURL" type="hidden" value="${navurl}" />
		<dsp:input bean="ProductListHandler.removeProductErrorURL" type="hidden" value="${navurl}" />
		<dsp:input bean="ProductListHandler.removeEntries" type="submit" value="X" />
</dsp:form>
</dsp:page>