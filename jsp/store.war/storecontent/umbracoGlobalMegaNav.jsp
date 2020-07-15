<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:getvalueof var="dealerId" param="dealerId" />

	<div>
		<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="Banner" />
			<dsp:param name="bannerName" value="GlobalMegaNav" />
			<dsp:param name="dealerId" value="${dealerId }" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="imageUrl" vartype="String" param="response" />
<dsp:getvalueof var="bannerMap" vartype="String" param="bannerMap" />
	          	<a href="${bannerMap.bannerURL}">
			          			<img src="${bannerMap.bannerImage}" width="280" height="415"/>
			          		</a>
	          	<%-- <img src="${imageUrl}" width="280" height="415"/> --%>
			</dsp:oparam>
			<dsp:oparam name="error">
				Error out <!-- Do something here -->
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty empty <!-- Do something here -->
			</dsp:oparam>
		</dsp:droplet>
	</div>

</dsp:page>
