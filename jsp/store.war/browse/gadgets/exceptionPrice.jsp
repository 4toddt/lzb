<%@ page contentType="application/json" %>

<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
<dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBExceptionPriceDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>



<dsp:page>

	<json:object prettyPrint="true">
	   <dsp:droplet name="LZBExceptionPriceDroplet">
		<dsp:param name="dealerId" bean="ProfileTools.priceListId"  />
		<dsp:param name="itemInfo" param="itemInfo"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="price">
		    <json:property name="hasExceptionPrice" value="true" />
		    <json:property name="exceptionListPrice">
		       <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="exceptionListPrice.price"/>
		       </dsp:include>
		    </json:property>
		    <json:property name="exceptionSalePrice">
		       <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="exceptionSalePrice.price"/>
		       </dsp:include>
		    </json:property>
		    <json:property name="exceptionId">
		       <dsp:valueof param="exceptionListPrice.exceptionId"/>
		    </json:property>
		</dsp:oparam>
		<dsp:oparam name="totalPrice">
			<json:property name="hasExceptionPrice" value="false" />
		    <json:property name="totalAmount">
		       <dsp:include page="/pricing/displayPrice.jsp">
		         	<dsp:param name="currency" param="totalAmount"/>
		       </dsp:include>
		    </json:property>
		
		</dsp:oparam>
	   </dsp:droplet>
	</json:object>
	
	


</dsp:page>