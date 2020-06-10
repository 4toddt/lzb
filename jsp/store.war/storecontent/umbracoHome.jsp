<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/UmbracoContentDroplet" />
	<dsp:getvalueof var="dealerId" param="dealerId" />

	<div>
<dsp:droplet name="UmbracoContentDroplet">
			<dsp:param name="contentType" value="Banner" />
			<dsp:param name="bannerName" value="HomePage" />
			<dsp:param name="dealerId" value="${dealerId}" />
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
		</dsp:droplet>
	</div>

</dsp:page>
