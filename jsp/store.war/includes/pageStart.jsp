<%--
	This page included by page container tag
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

<dsp:page>

	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<c:set var="hostName" value="https:${storeConfig.hostName}"/>
	<c:set var="mobileSiteURL" value="https:${storeConfig.mobileHostName}/mobile" />
	<c:set var="spanishSiteURL" value="https://es.la-z-boy.com" />
	<c:set var="frenchSiteURL" value="https://fr.la-z-boy.com" />

	<!doctype html>
	<html class="no-js" lang="en-US">

		<c:choose>
			<%-- Value for head prefix is set in /cartridges/ProductDetailsPage/ProductDetailsPage.jsp --%>
			<c:when test="${not empty rPDPNameSpaceForOGTag}" >
			 <head prefix="${rPDPNameSpaceForOGTag}">
			</c:when>
			<c:otherwise>
				<head>
			</c:otherwise>
		</c:choose>

		<dsp:getvalueof bean="LZBStoreConfiguration.adobeTagMgrScriptPath" var="adobeTagMgrScriptPath"/>
		<dsp:getvalueof bean="LZBStoreConfiguration.domainNameForCSS" var="domainNameForCSS" scope="request"/>
		<dsp:getvalueof bean="LZBStoreConfiguration.domainNameForJS" var="domainNameForJS"  scope="request"/>
		<dsp:setvalue bean="SessionBean.desktopBrowse" value="true" />
		
		<meta http-equiv="X-UA-Compatible" content="IE=100">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

		<dsp:getvalueof var="title" param="title"/>
		<dsp:getvalueof var="metadesc" param="metaDescription" />
		<dsp:getvalueof var="metakywd" param="metaKeywords" />
		<dsp:getvalueof var="encodedSeoAlternateURL" param="encodedSeoAlternateURL" />
		<dsp:getvalueof var="encodedSeoCanonicalURL" param="encodedSeoCanonicalURL" />
		<dsp:droplet name="/com/lzb/droplet/LZBPreviousPageVisitedDroplet">
			<dsp:param name="referrer" value="${originatingRequest.Referer}" />
			<dsp:oparam name="output">
			</dsp:oparam>
		</dsp:droplet>
		<dsp:getvalueof var="pageSpecificMETA" param="pageSpecificMETA"/>
		<c:choose>
			<c:when test="${not empty pageSpecificMETA}">
				<c:out value="${pageSpecificMETA}" escapeXml="false"/>
			</c:when>
		</c:choose>

		<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

		<%-- global stylesheet --%>
		<link rel="stylesheet" href="/css/min/desktop.css?ver=${assetVersion}" type="text/css" />

		<%-- Marxent Image Composer CSS --%>
		<dsp:getvalueof bean="LZBStoreConfiguration.marxentComposerCSSPath" var="marxentComposerCSSPath"/>
		<dsp:getvalueof bean="LZBStoreConfiguration.marxentComposerEnabled" var="marxentComposerEnabled"/>
		<dsp:getvalueof bean="LZBStoreConfiguration.marxentImagerEnabled" var="marxentImagerEnabled"/>
		<dsp:getvalueof bean="LZBStoreConfiguration.marxentComposerScriptPath" var="marxentComposerScriptPath"/>
		
	    <c:if test="${(not empty marxentComposerCSSPath) && (marxentComposerEnabled || marxentImagerEnabled)}">
	        <link rel="stylesheet" href="${marxentComposerCSSPath}" type="text/css" />
	    </c:if>
	     <c:if test="${(not empty marxentComposerScriptPath) && (marxentComposerEnabled || marxentImagerEnabled)}">
	     	<script>
	     		var marxentComposerScriptPath = '${marxentComposerScriptPath}';
	     	</script>
	     </c:if>

		<%-- Monetate tag header include --%>
		<c:if test="${storeConfig.monetateEnabled eq true }" >
		<dsp:include page="/includes/monetateHeader.jsp" flush="true"></dsp:include>
		<%-- Monetate tag Initialization --%>
		<script>
			window.monetateQ = window.monetateQ || [];
		</script>
		<script>
			var globalJSDomain = '${domainNameForJS}';
		</script>
		</c:if>
		
		<%-- Include content from pageSpecificCSS tag renderer --%>
		<dsp:getvalueof var="pageSpecificCSS" param="pageSpecificCSS"/>
		<c:choose>
			<c:when test="${not empty pageSpecificCSS}">
				<c:out value="${pageSpecificCSS}" escapeXml="false"/>
			</c:when>
		</c:choose>

		<%-- global JavaScript --%>
		<script src="/js/amp.js?ver=${assetVersion}"></script>

		<%-- Include content from pageSpecificJS tag renderer --%>
		<dsp:getvalueof var="pageSpecificJS" param="pageSpecificJS"/>
		<c:choose>
			<c:when test="${not empty pageSpecificJS}">
				<c:out value="${pageSpecificJS}" escapeXml="false"/>
			</c:when>
		</c:choose>

		<%-- Adobe tag manager script include --%>
		<c:if test="${not empty adobeTagMgrScriptPath}">
			<script src="//${adobeTagMgrScriptPath}"></script>
		</c:if>

		<%-- Robots meta tag --%>
		<c:set var="index" value="${contentItem.index}"/>
		<c:set var="follow" value="${contentItem.follow}"/>
		<c:set var="indexValue" value="${(index eq 'false') ? 'noindex' : 'index'}"/>
		<c:set var="followValue" value="${(follow eq 'false') ? 'nofollow' : 'follow'}"/>
		<meta name="robots" content="${indexValue},${followValue}"/>
		<meta name="viewport">

		<%-- Use default SEO tag renderer --%>
		<dsp:include page="/includes/metaDetails.jsp" flush="true">
			<c:choose>
				<c:when test="${not empty sEOTagTitle}">
					<dsp:param name="title" value="${sEOTagTitle}"/>
				</c:when>
				<c:otherwise>
					<dsp:param name="title" value="${title}"/>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${not empty sEOMetaTagDescription}">
					<dsp:param name="metadesc" value="${sEOMetaTagDescription}"/>
				</c:when>
				<c:otherwise>
					<dsp:param name="metadesc" value="${metadesc}"/>
				</c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${not empty sEOKeywords}">
					<dsp:param name="metakywd" value="${sEOKeywords}"/>
				</c:when>
				<c:otherwise>
					<dsp:param name="metakywd" value="${metakywd}"/>
				</c:otherwise>
			</c:choose>
		</dsp:include>

		<%-- SEO Alternate (Mobile)--%>
		<c:choose>
			<c:when test="${isHomePage}">
				<link rel="alternate" href="${mobileSiteURL}" />
			</c:when>
			<c:when test="${!empty encodedSeoAlternateURL}">
				<link rel="alternate" href="${mobileSiteURL}${encodedSeoAlternateURL}" />
			</c:when>
		</c:choose>

		<%-- SEO Canonical & Language Alternate (Desktop) --%>
		<c:choose>
			<c:when test="${isHomePage}">
				<link rel="alternate" href="${hostName}" hreflang="en-us" />
				<link rel="alternate" href="${spanishSiteURL}" hreflang="es" />
				<link rel="alternate" href="${frenchSiteURL}" hreflang="fr-ca" />
				<link rel="canonical" href="${hostName}" />
			</c:when>
			<c:when test="${!empty encodedSeoCanonicalURL}">
				<link rel="alternate" href="${hostName}${encodedSeoCanonicalURL}" hreflang="en-us" />
				<link rel="alternate" href="${spanishSiteURL}${encodedSeoCanonicalURL}" hreflang="es" />
				<link rel="alternate" href="${frenchSiteURL}${encodedSeoCanonicalURL}" hreflang="fr-ca" />
				<link rel="canonical" href="${hostName}${encodedSeoCanonicalURL}" />
			</c:when>
		</c:choose>

		<c:if test="${isHomePage}">
			<script type="application/ld+json">
				{
					"@context": "http://schema.org",
					"@type": "WebSite",
					"url": "${hostName}/",
					"potentialAction": {
						"@type": "SearchAction",
						"target": "${hostName}${storeConfig.storeSearchUrl}?Ntt={search_term_string}",
						"query-input": "required name=search_term_string"
					}
				}
			</script>
		</c:if>

		<script>
		<%-- moving this here, some of the eloqua analytics code that is injected from them
		seems to break on loading by not defining _elqQ properly.  This should either let it be
		defined as is or else as an empty array   --%>
		var _elqQ = _elqQ || [];
		</script>
	</head>

	<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
		<dsp:param name="inUrl" value="/"/>
		<dsp:oparam name="output">
			<dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
		</dsp:oparam>
	</dsp:droplet>

	<dsp:getvalueof var="bodyClass" param="bodyClass"/>

	<body class="${bodyClass}" dir="ltr" data-module="sign-in-listener" data-domain="${updatedProtocolURL}">

	<%--
		<ul class="skip-links">
			<li><a href="#utilityNavigation">Utility Navigation</a></li>
			<li><a href="#siteNavigation">Main Navigation</a></li>
			<li><a href="#mainContent">Main Content</a></li>
			<li><a href="#footerContent">Footer Content</a></li>
		</ul>
	--%>

	<%-- Used to display Survey modal --%>
	<!-- <dsp:getvalueof var="pageVisitCount" bean="SessionBean.count"/> -->
	<c:set var="showSurvey" value="${requestScope['showSurveyDialog']}" />
	<dsp:getvalueof bean="LZBStoreConfiguration.enableSurvey" var="enableSurvey"/>
	<dsp:getvalueof bean="LZBStoreConfiguration.surveyURL" var="surveyURL"/>
	<c:if test="${enableSurvey eq true}">
		<c:if test="${showSurvey eq true}">
			<div data-module="show-survey" data-href="${surveyURL}" id="survey"></div>
		</c:if>
	</c:if>

	<dsp:include page="/includes/global/fbConnectAppInfo.jsp" />

	<dsp:include page="/includes/analytics.jsp"/>

	<c:choose>
		<c:when test="${not empty contentItem.headerContent}">
			<c:forEach var="element" items="${contentItem.headerContent}">
				<dsp:renderContentItem contentItem="${element}"/>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<dsp:include src="/global/includes/header.jsp" />
		</c:otherwise>
	</c:choose>

</dsp:page>
