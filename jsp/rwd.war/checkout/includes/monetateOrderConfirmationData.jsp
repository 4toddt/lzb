<%--
    - File Name: monetateOrderConfirmationData.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page generates cart details for Monetate.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="orderParam" param="order" />

	<%-- commerceItemsForMenetate variable is set in /account/includes/orderedItemContents.jsp file --%>
	<dsp:droplet name="ForEach">
		<dsp:param name="array" value="${commerceItemsForMenetate}" />
		<dsp:param name="elementName" value="commerceItemVarForMonetate" />
		<dsp:oparam name="outputStart">
			<script type="text/javascript">
				window.monetateQ.push(["addPurchaseRows", [</dsp:oparam><dsp:oparam name="output">
				<dsp:getvalueof var="skuIdVarForMonetate" param="commerceItemVarForMonetate.commerceItem.catalogRefId" />
				<dsp:getvalueof var="quantityVarForMonetate" param="commerceItemVarForMonetate.commerceItem.quantity"/>
				<dsp:getvalueof var="listPriceVarForMonetate" param="commerceItemVarForMonetate.listPrice" />
				<dsp:getvalueof var="salePriceVarForMonetate" param="commerceItemVarForMonetate.salePrice" />
				<c:choose>
					<c:when test="${not empty salePriceVarForMonetate and salePriceVarForMonetate gt 0 and salePriceVarForMonetate lt listPriceVarForMonetate }">
						<fmt:parseNumber  type="number" var="unitPriceVarForMonetate"   pattern="#.##" value="${salePriceVarForMonetate}" />
					</c:when>
					<c:otherwise>
					 	<fmt:parseNumber  type="number" var="unitPriceVarForMonetate"   pattern="#.##" value="${listPriceVarForMonetate}" />
					 </c:otherwise>
				</c:choose>
				{"purchaseId": "${orderParam.id}", "productId": "${skuIdVarForMonetate}","quantity": "${quantityVarForMonetate}", "unitPrice": "${unitPriceVarForMonetate}", "currency": "${currencyCode}"},</dsp:oparam><dsp:oparam name="outputEnd">]]);
			</script>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>