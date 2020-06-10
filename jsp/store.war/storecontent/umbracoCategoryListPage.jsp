<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="dealerId" param="dealerId" />

<!-- 	<div class="managed-content">
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="Banner" />
			<dsp:param name="bannerName" value="CategoryListPage" />
			<dsp:param name="dealerId" value="${dealerId }" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="imageUrl" vartype="String" param="response" />
				<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
	          	<a href="${bannerMap.bannerURL}">
			          			<img src="${bannerMap.bannerImage}" />
			          		</a>
			</dsp:oparam>
			<dsp:oparam name="error">
				 Error out Umbraco Content
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty out Umbraco Content
			</dsp:oparam>
		</dsp:droplet>  -->

	<!-- img src="${storeConfig.hostName}/Images/promo/LaborDaySale_Category_225x225.jpg" alt=""/-->
	<!-- </div> -->

</dsp:page>
