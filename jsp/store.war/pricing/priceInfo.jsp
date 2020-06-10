<dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBProductPriceBasedOnDealer"/>
<dsp:importbean bean="/atg/userprofiling/Profile" />

<dsp:page>
    <dsp:getvalueof var="showStrickedPrice" param="showStrickedPrice"  />
    
	<dsp:droplet name="LZBProductPriceBasedOnDealer">
	<dsp:param name="configSkuId" param="configSkuId"  />
	<dsp:param name="skuId" param="skuId"  />
	<dsp:param name="grade" param="grade"  />
	<dsp:param name="dealerId" param="dealerId"/>
	<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="itemPrice">
		  <dsp:getvalueof var="hasSalePrice" param="hasSalePrice"  />

		  <c:choose>
		   <c:when test="${not empty showStrickedPrice && showStrickedPrice eq 'false'}">
		     <span> 
		       <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="finalPrice"/>
		       </dsp:include>
		       
		     </span>
		   </c:when>
		   <c:otherwise>
		      <c:choose>
			   <c:when test="${empty hasSalePrice || hasSalePrice eq false}">
			     <span> 
			     <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="finalPrice"/>
		      	 </dsp:include>
			   </c:when>
			   <c:otherwise>
   					<span> 
   					 <font style="text-decoration: line-through;">
   					  <dsp:include page="/pricing/displayPrice.jsp">
		         		<dsp:param name="currency" param="listPrice"/>
		      	 	  </dsp:include>
   					 </font> 
	   				  <dsp:include page="/pricing/displayPrice.jsp">
			         	<dsp:param name="currency" param="finalPrice"/>
			      	  </dsp:include>
   					 </span>
			   </c:otherwise>
			  </c:choose>
		   </c:otherwise>
		  </c:choose>
			
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>

