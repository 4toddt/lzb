<%@ page contentType="application/json" %>

<dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
<dsp:page>
<json:object prettyPrint="true">
   <dsp:getvalueof var="showStrickedPrice" value="true"  />
	<dsp:droplet name="LZBSectionalPDPPriceDroplet">
	<dsp:param name="subSkuId" param="configSkuId"  />
	<dsp:param name="coverId" param="coverId"  />
	<dsp:param name="dealerId"  param="dealerId"  />
	<dsp:param name="jsonString" param="json"/>
		<dsp:oparam name="output">
		  <dsp:getvalueof var="hasSalePrice" param="hasSalePrice"  />
			<dsp:getvalueof var="exceptionId" param="exceptionId"/>
			<dsp:getvalueof var="selectExceptionOptions"  param="defaultSelectOptionSkuIds"/>
		   <json:property name="hasSalePrice" value="${hasSalePrice}" />
		      <c:choose>
			   <c:when test="${empty hasSalePrice || hasSalePrice eq false}">
			     <json:property name="listPrice">
			     <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="listPrice"/>
		      	 </dsp:include>
		      	 </json:property>
			   </c:when>
			   <c:otherwise>
			    <json:property name="listPrice">
   					  <dsp:include page="/pricing/displayPrice.jsp">
		         		<dsp:param name="currency" param="listPrice"/>
		      	 	  </dsp:include>
				 </json:property>
				   <json:property name="salePrice">
	   				  <dsp:include page="/pricing/displayPrice.jsp">
			         	<dsp:param name="currency" param="salePrice"/>
			      	  </dsp:include>
   				 </json:property>
   				  <json:property name="longDescription">
			         	<dsp:valueof param="defaultStyleSkuLongDesc"/>
   				 </json:property>
   				   <json:property name="shortDescription">
			         	<dsp:valueof param="defaultStyleSkuShortDesc"/>
   				 </json:property>			
			   </c:otherwise>
			  </c:choose>
	<json:property name="exceptionId" value="${exceptionId}"/>
	<json:property name="onSale" value="${hasSalePrice}"/>
	<json:property name="selectExceptionOptions" value="${selectExceptionOptions}"/>
		</dsp:oparam>
	</dsp:droplet>
</json:object>
</dsp:page>