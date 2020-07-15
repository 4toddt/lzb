<dsp:page>
<dsp:getvalueof var="priceInfo" param="priceInfo"/>
<dsp:getvalueof var="listPrice" param="priceInfo.listPrice"/>
<dsp:getvalueof var="salePrice" param="priceInfo.salePrice"/>

<fmt:message key="minicart.price"/>:
	<strong> 
	<dsp:include page="../../global/includes/formattedPrice.jsp">
	<dsp:param name="price" value="${listPrice}" />
	</dsp:include>
	</strong>
<span>
	<c:if test="${not empty salePrice and salePrice > 0.0}">
		<fmt:message key="minicart.discount"/>: <em><fmt:message key="minicart.onefor"/>
		<dsp:include page="../../global/includes/formattedPrice.jsp">
			<dsp:param name="price" value="${salePrice}" />
		</dsp:include></em>
	</c:if>
</span>
</dsp:page>