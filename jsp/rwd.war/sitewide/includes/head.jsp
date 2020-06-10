<%--
	- File Name: head.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Outputs the contents of the <head>. Includes the meta tags, js and css includes.
	- Required Parameters: (these are request scoped)
		- section: string for section the page falls in (ex browse),
		- pageType: string for the page type (ex product)
	- Optional Parameters: (these are request scoped)
		- pageTitle: Page title that appears in the title bar of your browser,
		- metaKeywords: Page keywords,
		- lastModified: Page last modified,
		- doSessionTimeout: session timeout (ex true),
		- metaDescription: Page Description,
		- seoRobots: Page robots instructions,
		- encodedSeoCanonicalURL: has fallback support if value is empty,
		- pageSpecificCSS: pageSpecificCSS tag renderer
	- Facebook Open Graph Notes:
		- Tags appear in several sections of this file, search for og: and fb: to find them.
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="geoCountry" bean="SessionBean.geoLocatedCountry" />
	<dsp:getvalueof var="geoZipcode" bean="SessionBean.geoLocatedZipcode" />
	<fmt:message var="siteDisplayName" key="meta.siteDisplayName"/>
	<fmt:message var="defaultPageTitle" key="meta.title"/>
	<c:set var="hostName" value="https:${storeConfig.hostName}"/>
	<c:set var="mobileHostName" value="https:${storeConfig.mobileHostName}"/>
	<c:if test="${!empty encodedSeoCanonicalURL}">
		<%-- Defines canonical URL by removing '/mobile' from orginal value so url points to desktop variant. Note c:url was moved here to prevent contextPath being appended twice. --%>
		<c:set var="encodedSeoCanonicalURL" scope="request"><c:url value="${hostName}${fn:substringAfter(encodedSeoCanonicalURL, contextPath)}"/></c:set>
	</c:if>

	<%-- Page Title --%>
	<c:if test="${empty pageTitle}">
		<c:set var="pageTitle" value="${defaultPageTitle}" scope="request"/>
	</c:if>
	<title>${pageTitle} | ${siteDisplayName}</title>

	<%-- Meta Tag: Static Tags --%>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta charset="utf-8" />
	<c:choose>
		<c:when test="${!isMobile && pageType eq 'orderConfirmation'}">
			<%-- viewport size for non-responsive (Desktop/Tablet). Scaling needed due to old header/footer not being a responsive design. Remove once full responsive. --%>
			<meta name="viewport">
		</c:when>
		<c:otherwise>
			<%-- viewport size for responsive --%>
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
		</c:otherwise>
	</c:choose>

	<%-- Meta Tag: Session Time Out Refresh. --%>
	<c:if test="${doSessionTimeout}">
		<c:set var="errorTimeout" value="${contextLinkPath}/global/sessionExpired.jsp"/>
		<c:set var="refreshSecs" value="1800"/>
		<meta http-equiv="refresh" content="${refreshSecs};url=${errorTimeout}">
	</c:if>

	<%-- Meta Tag: robots --%>
	<c:if test="${!empty seoRobots}">
		<meta name="robots" content="${seoRobots}" />
	</c:if>

	<%-- Meta Tag: last modified --%>
	<c:if test="${!empty lastModified}">
		<meta http-equiv="last-modified" content="${lastModified}" />
	</c:if>

	<%-- Meta Tag: description --%>
	<c:if test="${!empty metaDescription}">
		<meta name="description" content="${metaDescription}" />
	</c:if>

	<%-- Meta Tag: keywords --%>
	<c:if test="${!empty metaKeywords}">
		<meta name="keywords" content="${metaKeywords}" />
	</c:if>

	<%-- Meta Tag: Country of Visitor --%>
	<c:if test="${!empty geoCountry}">
		<meta name="DCSext.w_country_of_visitor" content="${geoCountry}">
	</c:if>

	<%-- Meta Tag: Zip Code --%>
	<c:if test="${!empty geoZipcode}">
		<meta name="WT.z_zip" content="${geoZipcode}">
	</c:if>

	<%-- START: FACEBOOK OPEN GRAPH TAGS --%>
	<%-- Meta Tag: Open Graph Common Tags --%>
	<meta property="og:site_name" content="${siteDisplayName}" />
	<c:choose>
		<c:when test="${pageType eq 'product'}">
			<meta property="og:type" content="product"/>
		</c:when>
		<c:otherwise>
			<meta property="og:type" content="website">
		</c:otherwise>
	</c:choose>
	<meta property="fb:app_id" content="${storeConfig.fbAppId}"/>

	<%-- Meta Tag: Open Graph Common URL Tags --%>
	<c:if test="${!empty encodedSeoCanonicalURL}">
		<meta property="og:url" content="${encodedSeoCanonicalURL}">
	</c:if>
	<%-- END: FACEBOOK OPEN GRAPH TAGS --%>

	<%-- Meta Tag: Include content from pageSpecificMETA tag renderer --%>
	<c:if test="${!empty pageSpecificMETA}">
		<c:out value="${pageSpecificMETA}" escapeXml="false"/>
	</c:if>

	<%--ICONS --%>
	<%-- For Windows 8 & Windows 10 Pinned Site Tiles --%>
	<meta name="msapplication-config" content="${assetPath}/images/favicons/browserconfig.xml" />
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="theme-color" content="#ffffff">
	<%-- For Favicon --%>
	<link rel="shortcut icon" href="${assetPath}/images/favicons/favicon.ico" />
	<link rel="icon" type="image/png" sizes="32x32" href="${assetPath}/images/favicons/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${assetPath}/images/favicons/favicon-16x16.png">
	<%-- For first- and second-generation iPad: --%>
	<link rel="apple-touch-icon" sizes="72x72" href="${assetPath}/images/favicons/apple-touch-icon-72x72.png">
	<%-- For iPad and iPad mini @1x --%>
	<link rel="apple-touch-icon" sizes="76x76" href="${assetPath}/images/favicons/apple-touch-icon-76x76.png">
	<%-- For iPhone 4, iPhone 4s, iPhone 5, iPhone 5c, iPhone 5s, iPhone 6, iPhone 6s, iPhone 7, iPhone 7s, iPhone8 --%>
	<link rel="apple-touch-icon" sizes="120x120" href="${assetPath}/images/favicons/apple-touch-icon-120x120.png">
	<%-- For third-generation iPad with high-resolution Retina display: --%>
	<link rel="apple-touch-icon" sizes="144x144" href="${assetPath}/images/favicons/apple-touch-icon-144x144.png">
	<%-- For iPad and iPad mini @2x --%>
	<link rel="apple-touch-icon" sizes="152x152" href="${assetPath}/images/favicons/apple-touch-icon-152x152.png">
	<%-- For iPhone X, iPhone 8 Plus, iPhone 7 Plus, iPhone 6s Plus, iPhone 6 Plus --%>
	<link rel="apple-touch-icon" sizes="180x180" href="${assetPath}/images/favicons/apple-touch-icon-180x180.png">
	<%-- For non-Retina iPhone, iPod Touch, and Android 2.1+ devices: --%>
	<link rel="apple-touch-icon" href="${assetPath}/images/favicons/apple-touch-icon.png">
	<link rel="manifest" href="${assetPath}/images/favicons/site.webmanifest">
	<%-- END ICONS --%>

	<%-- SEO Canonical --%>
	<c:if test="${!empty encodedSeoCanonicalURL}">
		<link rel="canonical" href="${encodedSeoCanonicalURL}" />
	</c:if>

	<%-- Base Site CSS & Scripts --%>
	<%-- don't include css and js for ajax requests --%>
	<c:if test="${!isAjax}">
		<%-- CSS Imports --%>
		<!--[if lt IE 9]><link rel="stylesheet" href="${assetPath}/css/main-ie8.css?ver=${assetVersion}" type="text/css" charset="utf-8"/><![endif]-->
		<!--[if gt IE 8]><!--><link rel="stylesheet" href="${assetPath}/css/main.css?ver=${assetVersion}" type="text/css"/><!--<![endif]-->

		<%-- Modernizr: included in head so we don't render without it --%>
		<script type="text/javascript" src="${assetPath}/js/modernizr.min.js?ver=${assetVersion}"></script>

		<%-- NOTE: This came from DMI UX Framework. LZB doesn't seem to use this kind of thing for analytics today --%>
		<%-- <jsp:include page="/sitewide/analytics/analytics.jsp">
			<jsp:param name="analyticsPageType" value="${analyticsPageType}" />
			<jsp:param name="analyticsPageTitle" value="${pageTitle}" />
		</jsp:include> --%>

		<%-- Fragment for Google Tag Manager --%>
        <%@ include file="/sitewide/fragments/googleTagManager.jspf" %>

		<%-- Marxent Image Composer CSS --%>
		<c:if test="${(pageType == 'product') && (not empty storeConfig.marxentComposerCSSPath && storeConfig.marxentComposerEnabled)}">
			<link rel="stylesheet" href="${storeConfig.marxentComposerCSSPath}" type="text/css" />
		</c:if>

		<%-- Include content from pageSpecificCSS tag renderer --%>
		<c:if test="${!empty pageSpecificCSS}">
			<c:out value="${pageSpecificCSS}" escapeXml="false"/>
		</c:if>
	</c:if>

	<%-- Monetate tag header include --%>
	<c:if test="${storeConfig.monetateEnabled eq true }" >
	<dsp:include page="/sitewide/includes/monetateHeader.jsp" flush="true"></dsp:include>
	<%-- Monetate tag Initialization --%>
	<script>
		window.monetateQ = window.monetateQ || [];
	</script>
	</c:if>
	
	<%-- Adobe tag include start. Keep this script always before other scripts in this section --%>
	<%-- Adobe tag manager script include --%>
	<c:choose>
		<c:when test="${!isMobile && section eq 'checkout'}">
			<%-- render for desktop --%>
			<c:if test="${!empty storeConfig.adobeTagMgrScriptPath}">
				<script src="//${storeConfig.adobeTagMgrScriptPath}"></script>
			</c:if>
		</c:when>
		<c:otherwise>
			<%-- render for mobile --%>
			<c:if test="${!empty storeConfig.mobileAdobeTagMgrScriptPath}">
				<script src="//${storeConfig.mobileAdobeTagMgrScriptPath}"></script>
			</c:if>
		</c:otherwise>
	</c:choose>
	<%-- Adobe tag include end --%>

	<%-- Structured Data Schema for home page --%>
	<c:if test="${section eq 'home' && pageType eq 'home'}">
		<script type="application/ld+json">
			{
				"@context": "http://schema.org",
				"@type": "WebSite",
				"url": "${mobileHostName}${contextPath}",
				"potentialAction": {
					"@type": "SearchAction",
					"target": "${mobileHostName}${contextPath}${storeConfig.mobileSearchUrl}?Ntt={search_term_string}",
					"query-input": "required name=search_term_string"
				}
			}
		</script>
	</c:if>
</dsp:page>