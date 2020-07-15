<dsp:page>

    <dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="title" param="title" />
	<dsp:getvalueof var="metadesc" param="metadesc" />
	<dsp:getvalueof var="metakywd" param="metakywd" />
	<dsp:getvalueof var="geoCountry" bean="SessionBean.geoLocatedCountry" scope="request" />
	<dsp:getvalueof var="geoZipcode" bean="SessionBean.geoLocatedZipcode" scope="request" />
    <fmt:message var="siteDisplayName" key="meta.siteDisplayName"/>

	<%-- Page's title --%>
	<c:choose>
		<c:when test="${not empty title}">
			<title>${title} | ${siteDisplayName}</title>
		</c:when>
		<c:otherwise>
			<title><fmt:message key="header.title" /> | ${siteDisplayName}</title>
		</c:otherwise>
	</c:choose>
	<%-- Page's meta description --%>
	<c:if test="${not empty metadesc}">
		<c:set var="metadesc"
			value="${fn:replace(metadesc, '\"', '')}" />
		<meta name="description" content="${metadesc}" />
	</c:if>

	<%-- Page's meta keywords --%>
	<c:if test="${not empty metakywd}">
		<c:set var="metakywd" value="${fn:replace(metakywd, '\"', '')}" />
		<meta name="keywords" content="${metakywd}" />
	</c:if>

	<meta name="DCSext.w_country_of_visitor" content="${geoCountry }">
	<meta name="WT.z_zip" content="${geoZipcode }">

</dsp:page>
