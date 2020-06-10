<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>	
	<dsp:getvalueof var="dealerId" param="dealerId" />

		<%-- 	<div style="-webkit-column-count: 2; -moz-column-count: 2; column-count: 2;">

				<img src="${storeConfig.hostName}/Images/promo/LaborDaySale_homepageleft_485x210_2.jpg" alt="Labor Day Sale"/>
				
				<img src="${storeConfig.hostName}/Images/promo/promo-in-home-consult.jpg" alt="Free In-Home Design Assistant"/>

			</div> --%>

<%-- 		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="Banner" />
			<dsp:param name="bannerName" value="HomeLeftPromoSlot" />
			<dsp:param name="dealerId" value="${dealerId }" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="imageUrl" vartype="String" param="response" />

	          	<img src="${imageUrl}" />
			</dsp:oparam>
			<dsp:oparam name="error">
				 Error out Umbraco Content
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty out Umbraco Content
			</dsp:oparam>
		</dsp:droplet> --%>


 
</dsp:page>
