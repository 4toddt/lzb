<dsp:page>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<!--form to remove item -->
	
	<dsp:getvalueof var="endecaUrl" param="url" />
	<dsp:getvalueof var="successUrl" param="successUrl" />
	<dsp:form name="addCompareItem" id="addCompareItem" action="${endecaUrl}" method="post">
		<dsp:input bean="ProductListHandler.productID" type="hidden" id="addproductId" />
		<dsp:input bean="ProductListHandler.skuID" type="hidden"  id="addskuId" />
		 <input type="hidden" value="" id="jsonString" name="itemInfo" />
		<dsp:input bean="ProductListHandler.addProductSuccessURL" type="hidden" value="${endecaUrl}" />
		<dsp:input bean="ProductListHandler.addProductErrorURL" type="hidden" value="${endecaUrl}" />
		<dsp:input bean="ProductListHandler.addProduct" type="hidden" value="true" />
	</dsp:form>
	<dsp:form name="removeCompareItem" id="removeCompareItem" action="${endecaUrl}" method="post">
		<input type="hidden" value="" id="entryIds" name="entryIds" />
		<dsp:input bean="ProductListHandler.removeProductSuccessURL" type="hidden" value="${endecaUrl}"/>
		<dsp:input bean="ProductListHandler.removeProductErrorURL" type="hidden" value="${endecaUrl}" />
		<dsp:input bean="ProductListHandler.removeEntries" type="hidden" value="true" />
	</dsp:form>
	<dsp:form name="addItemToWishList" id="addItemToWishList" method="post">
		<dsp:input type="text" bean="GiftlistFormHandler.catalogRefIds" type="hidden" value="" id="addcatalogRefId" />
		<input type="hidden" value="" id="addIdItemInfo" name="iteminfo" />
		<dsp:input type="text" bean="GiftlistFormHandler.productId" type="hidden" value="" id="addIdproductIdwishList" />
		<dsp:input type="submit" bean="GiftlistFormHandler.addItemToWishlist" type="hidden" value="true" />
		<input type="hidden" value="true" id="compare" name="compare" />
	</dsp:form>
</dsp:page>