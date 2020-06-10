<%--
    - File Name: productPrice.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page returns a json data response for a product with options configured.
    - Required Parameters:
    - Optional Parameters:
--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/userprofiling/ProfileTools"/>
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager"/>

	<json:object prettyPrint="true" escapeXml="false">
		<dsp:droplet name="/com/lzb/commerce/pricing/droplet/LZBProductWithOptionPriceDroplet">
			<dsp:param name="itemInfo" param="jsonString"/>
			<dsp:param name="quantity" value="1"/>
			<dsp:param name="exceptionId" value=""/>
			<dsp:param name="profile" bean="Profile"/>
			<dsp:param name="dealerId" bean="ProfileTools.priceListId"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="listPrice" param="priceInfo.listPrice"/>
				<dsp:getvalueof var="salePrice" param="priceInfo.salePrice"/>
				<dsp:getvalueof var="onSale" param="priceInfo.onSale"/>
				<dsp:getvalueof var="saveAmount" param="saveAmount"/>
				<dsp:getvalueof var="endDate" param="endDate"/>
				<dsp:getvalueof var="priceListId" param="priceListId"/>
				<dsp:getvalueof var="exceptionId" param="exceptionId"/>
				<dsp:getvalueof var="isSelectPrice" param="isSelectPrice"/>
				<dsp:getvalueof var="selectExceptionOptions" param="defaultSelectOptionSkuIds"/>
				<dsp:getvalueof var="inStock" param="inStock"/>
				<dsp:getvalueof var="stockMsg" param="stockMsg"/>
				<dsp:getvalueof var="isDealerRMS" param="isDealerRMS"/>
				<json:property name="success" value="true" />
				<json:property name="onSale" value="${onSale}"/>
				<c:choose>
					<c:when test="${empty onSale || onSale eq false}">
						<json:property name="listPrice">
							<c:if test="${listPrice gt 0}">
								<dsp:include page="/global/includes/displayPrice.jsp">
									<dsp:param name="currency" value="${listPrice}"/>
								</dsp:include>
							</c:if>
						</json:property>
					</c:when>
					<c:otherwise>
						<json:property name="listPrice">
							<c:if test="${listPrice gt 0}">
								<dsp:include page="/global/includes/displayPrice.jsp">
									<dsp:param name="currency" value="${listPrice}"/>
								</dsp:include>
							</c:if>
						</json:property>
						<json:property name="salePrice">
							<c:if test="${salePrice gt 0}">
								<dsp:include page="/global/includes/displayPrice.jsp">
									<dsp:param name="currency" value="${salePrice}"/>
								</dsp:include>
							</c:if>
						</json:property>
					</c:otherwise>
				</c:choose>

				<json:property name="saveAmount" value="${saveAmount}"/>
				<json:property name="priceListId" value="${priceListId}"/>
				<json:property name="exceptionId" value="${exceptionId}"/>
				<json:property name="onSale" value="${onSale}"/>
				<json:property name="endDate" value="${endDate}"/>
				<json:property name="isSelectPrice" value="${isSelectPrice}"/>
				<json:property name="selectExceptionOptions" value="${selectExceptionOptions}"/>
				<json:property name="inStock" value="${inStock}"/>
				<json:property name="stockMsg" value="${stockMsg}"/>
				<json:property name="isDealerRMS" value="${isDealerRMS}"/>
			</dsp:oparam>
			<dsp:oparam name="error">
				<json:property name="success" value="false" />
				<dsp:getvalueof var="errorMessage" param="errorMessage"/>
				<fmt:message var="displayError" key="productConfiguration.error.productPrice" />
				<json:array name="errorMessages">
					<json:property escapeXml="false">
						<c:out value="${displayError}" escapeXml="false"/>
						<%-- <c:out value="${errorMessage}" escapeXml="false"/> --%>
					</json:property>
				</json:array>
			</dsp:oparam>
		</dsp:droplet>
	</json:object>
</dsp:page>