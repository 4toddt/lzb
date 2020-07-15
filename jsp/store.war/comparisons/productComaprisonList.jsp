<dsp:page>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductList"/>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListContains"/>
<dsp:importbean bean="/atg/commerce/catalog/comparison/ProductListHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />

 <dsp:getvalueof var="categoryId" param="categoryId" />
 <dsp:getvalueof var="productId" param="productId" />
 <dsp:getvalueof var="skuId" param="skuId" />
 <dsp:getvalueof var="productListItems" bean="ProductList.items" />

 <dsp:form name="ItemForm1" id="ItemForm1" action="${endUrl}" method="post">
 
 <dsp:droplet name="ProductListContains">
  <dsp:param  name="productList" bean="ProductList"/>
  <dsp:param  name="productID" value="prod10002"/>
 <dsp:oparam name="true">
		<dsp:input bean="ProductListHandler.productID" type="text" value="prod10002" id="removeproductId" />
		<dsp:input bean="ProductListHandler.skuID" type="text" value="sku10005" id="skuId" />
		<dsp:input bean="ProductListHandler.removeProductSuccessURL" type="hidden" value="${endUrl}" />
		<dsp:input bean="ProductListHandler.removeProductErrorURL" type="hidden" value="${endUrl}" />
		<dsp:input bean="ProductListHandler.removeProduct" type="submit" value="remove" />
  </dsp:oparam>
  <dsp:oparam name="false">
		<dsp:input bean="ProductListHandler.productID" type="hidden" value="prod10002" id="productId" />
		<dsp:input bean="ProductListHandler.skuID" type="text" value="sku10005" id="skuid" />
		<dsp:input bean="ProductListHandler.addProductSuccessURL" type="hidden" value="${endUrl}" />
		<dsp:input bean="ProductListHandler.addProductErrorURL" type="hidden" value=" ${endUrl}" />
		<dsp:input bean="ProductListHandler.addProduct" type="submit" value="addProduct" />

  </dsp:oparam>
  
</dsp:droplet>
</dsp:form>


 <dsp:form name="ItemForm2" id="addItemForm" action=" ${endUrl}" method="post">
 
 <dsp:droplet name="ProductListContains">
  <dsp:param  name="productList" bean="ProductList"/>
  <dsp:param  name="productID" value="prod20002"/>
 <dsp:oparam name="true">
		<dsp:input bean="ProductListHandler.productID" type="text" value="prod20002"/>
		<dsp:input bean="ProductListHandler.skuID" type="text" value="sku30002"/>
		<dsp:input bean="ProductListHandler.removeProductSuccessURL" type="hidden" value=" ${endUrl}" />
		<dsp:input bean="ProductListHandler.removeProductErrorURL" type="hidden" value=" ${endUrl}" />
		<dsp:input bean="ProductListHandler.removeProduct" type="submit" value="remove" />
  </dsp:oparam>
  <dsp:oparam name="false">
		<dsp:input bean="ProductListHandler.productID" type="hidden" value="prod20002"/>
		<dsp:input bean="ProductListHandler.skuID" type="text" value="sku30002" />
		<dsp:input bean="ProductListHandler.addProductSuccessURL" type="hidden" value=" ${endUrl}" />
		<dsp:input bean="ProductListHandler.addProductErrorURL" type="hidden" value=" ${endUrl}" />
		<dsp:input bean="ProductListHandler.addProduct" type="submit" value="addProduct" />

  </dsp:oparam>
  
</dsp:droplet>
</dsp:form>

</dsp:page>