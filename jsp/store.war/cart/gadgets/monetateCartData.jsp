<dsp:page>
<%-- This JSP generates cart details for monetate --%>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="commerceItemsVarForMonetateLocal" param="commerceItemsVarForMonetate" />
			<c:forEach items="${commerceItemsVarForMonetateLocal}" var="commerceItem" varStatus="status">
					<c:if test="${ status.first }" >
					   	<script type="text/javascript"> window.monetateQ.push(["addCartRows", [
					</c:if>
			
   						<c:set var="SKU_ID" value ="${ commerceItem.commerceItem.catalogRefId }"/>
   						<c:set var="quantity" value ="${ commerceItem.commerceItem.quantity }"/>
   						<c:set var="listPrice" value ="${ commerceItem.listPrice }"/>
   						<c:set var="salePrice" value ="${ commerceItem.salePrice }"/>
						<c:choose>
						<c:when test="${not empty salePrice and salePrice gt 0 and salePrice lt listPrice }">
							<fmt:parseNumber  type="number" var="unitPrice"   pattern="#.##" value="${salePrice}" />
						</c:when> 
						<c:otherwise>
						 	<fmt:parseNumber  type="number" var="unitPrice"   pattern="#.##" value="${listPrice}" />
						 </c:otherwise>
					</c:choose>   						
   						{ "productId": "${SKU_ID}","quantity": "${quantity}", "unitPrice": "${unitPrice}", "currency": "${currencyCode}"},
   					<c:if test="${ status.last }" >
   						]]);</script>
					</c:if>   						
			</c:forEach>
					
</dsp:page>