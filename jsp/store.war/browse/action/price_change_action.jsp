<%@ page contentType="application/json" %>

<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
<dsp:page>
<json:object prettyPrint="true">
    <dsp:getvalueof var="showStrickedPrice" value="true"  />
    <dsp:droplet name="/com/lzb/commerce/pricing/droplet/LZBProductWithOptionPriceDroplet">
    <dsp:param name="configSkuId" param="configSkuId"  />
	<dsp:param name="skuId" param="skuId"  />
	<dsp:param name="itemInfo" param="jsonString"  />
	<dsp:param name="quantity" value="1"/>
		<dsp:param name="exceptionId" value=""/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:param name="dealerId" bean="ProfileTools.priceListId"/>
		<dsp:getvalueof var="isDealerRMS" bean="Profile.isDealerRMS" />	
		<dsp:oparam name="output">
		  <dsp:getvalueof var="hasSalePrice" param="priceInfo.onSale"/>
			<dsp:getvalueof var="saveAmount" param="saveAmount"/>
			<dsp:getvalueof var="endDate" param="endDate"/> 
			<dsp:getvalueof var="priceListId" param="priceListId"/>
			<dsp:getvalueof var="exceptionId" param="exceptionId"/>  
			<dsp:getvalueof var="inStock" param="inStock"/>
			<dsp:getvalueof var="stockMsg" param="stockMsg"/>
		   <json:property name="hasSalePrice" value="${hasSalePrice}" />
		      <c:choose>
			   <c:when test="${empty hasSalePrice || hasSalePrice eq false}">
			   <dsp:getvalueof param="priceInfo.listPrice" var="listPrice"/>
			   <c:choose>
			   <c:when test="${not empty listPrice && listPrice gt 0}">
			   <json:property name="listPrice">
			     <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" value="${listPrice}"/>
		      	 </dsp:include>
		      	 </json:property>
			   </c:when>
			   <c:otherwise>
			    <dsp:getvalueof param="priceInfo.salePrice" var="salePrice"/>
			   <c:if test="${not empty salePrice && salePrice gt 0}">
			   <json:property name="listPrice">
			     <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" value="${salePrice}"/>
		      	 </dsp:include>
		      	 </json:property>
		      	 </c:if>
			   </c:otherwise>
		      	 </c:choose>
			   </c:when>
			   <c:otherwise>
			    <json:property name="listPrice">
   					  <dsp:include page="/pricing/displayPrice.jsp">
		         		<dsp:param name="currency" param="priceInfo.listPrice"/>
		      	 	  </dsp:include>
				 </json:property>
				   <json:property name="salePrice">
	   				  <dsp:include page="/pricing/displayPrice.jsp">
			         	<dsp:param name="currency"  param="priceInfo.salePrice"/> 
			      	  </dsp:include>
   				 </json:property>	
			   </c:otherwise>
			  </c:choose>
	<json:property name="saveAmount" value="${saveAmount}"/>
	<json:property name="priceListId" value="${priceListId}"/>
	<json:property name="exceptionId" value="${exceptionId}"/>
	<json:property name="onSale" value="${onSale}"/>
	<json:property name="endDate" value="${endDate}"/>
	<json:property name="inStock" value="${inStock}"/>
	<json:property name="stockMsg" value="${stockMsg}"/>
	<json:property name="isDealerRMS" value="${isDealerRMS}"/>
		</dsp:oparam>
	</dsp:droplet>
</json:object>
</dsp:page>