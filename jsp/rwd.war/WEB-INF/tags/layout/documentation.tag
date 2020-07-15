<%--
  Tag for documentation page wrapper. Responsible for wrapping contents of page with html, head, header and footer.
--%>
<%@ include file="/sitewide/fragments/tags.jspf" %>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="pageTitle"%>
<%@ attribute name="metaDescription"%>
<%@ attribute name="metaKeywords"%>
<%@ attribute name="pageSpecificMETA"%>
<%@ attribute name="seoCanonicalURL"%>
<%@ attribute name="seoRobots"%>
<%@ attribute name="lastModified"%>
<%@ attribute name="doSessionTimeout"%>
<%@ attribute name="section"%>
<%@ attribute name="pageType"%>
<%@ attribute name="bodyClass"%>
<%@ attribute name="analyticsPageType"%>
<%@ attribute name="pageSpecificCSS"%>
<%@ attribute name="pageSpecificJS"%>

<%-- Set page vars --%>
<c:set var="siteDisplayName" value="DMI" scope="request"/>
<c:set var="encodedSeoCanonicalURL" value="${seoCanonicalURL}" scope="request"/>
<c:set var="jsController" value="${section}" scope="request"/>
<c:set var="jsAction" value="${pageType}" scope="request"/>


<!doctype html>
<%-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ --%>
<!--[if lt IE 7 ]> <html class="no-js ie6 ${deviceClass}" lang="en"> <![endif]-->
<!--[if IE 7 ]>    <html class="no-js ie7 ${deviceClass}" lang="en"> <![endif]-->
<!--[if IE 8 ]>    <html class="no-js ie8 ${deviceClass}" lang="en"> <![endif]-->
<!--[if IE 9 ]>    <html class="no-js ie9 ${deviceClass}" lang="en"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html class="no-js ${deviceClass}" lang="en"><!--<![endif]-->
<head>
	<title>${pageTitle} | ${siteDisplayName}</title>

	<%-- Meta stuff --%>
	<jsp:include page="/sitewide/head.jsp" />

	<%-- CSS Imports --%>
	<!--[if lt IE 9]><link rel="stylesheet" href="${assetPath}/css/main-ie8.css?ver=${assetVersion}" type="text/css" charset="utf-8"/><![endif]-->
	<!--[if gt IE 8]><!--><link rel="stylesheet" href="${assetPath}/css/main.css?ver=${assetVersion}" type="text/css"/><!--<![endif]-->
	<link rel="stylesheet" type="text/css" href="${assetPath}/css/documentation.css?ver=${assetVersion}"/>

	<%-- Modernizr: included in head so we don't render without it --%>
	<script type="text/javascript" src="${assetPath}/js/modernizr.min.js?ver=${assetVersion}"></script>
	<%-- Javascript --%>
	<script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>
	<script	type="text/javascript" src="${contextPath}/sitewide/jsConstants.jsp?ver=${assetVersion}"></script>
	<script	type="text/javascript" src="${assetPath}/js/lib.lzb.js?ver=${assetVersion}"></script>

	<jsp:include page="/sitewide/analytics/analytics.jsp">
		<jsp:param name="analyticsPageType" value="${analyticsPageType}" />
		<jsp:param name="analyticsPageTitle" value="${pageTitle}" />
	</jsp:include>
	<%-- Fragment for Google Tag Manager --%>
	<%@ include file="/sitewide/fragments/googleTagManager.jspf" %>
</head>

<body class="${bodyClass}" data-controller="${section}" data-action="${pageType}">
	<%-- Fragment for Google Tag Manager (noscript) --%>
	<%@ include file="/sitewide/fragments/googleTagManagerNoScript.jspf" %>

	<%-- Contents here --%>
	<jsp:doBody />

		<%-- Back to top link --%>
		<div class="back-to-top" data-backtotop>
			<div aria-hidden="true" class="icon icon-arrow-up"></div>
			<div class="text">top</div>
		</div>


</body>
</html>
