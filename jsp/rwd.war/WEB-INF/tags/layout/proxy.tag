<%--
  Tag for default page wrapper. Responsible for wrapping contents of page with html, head, header and footer.
--%>
<%@ include file="/sitewide/fragments/tags.jspf" %>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="section"%>
<%@ attribute name="pageType"%>
<%@ attribute name="bodyClass"%>

<%-- Set page vars --%>
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
		<%-- Modernizr: included in head so we don't render without it --%>
		<script type="text/javascript" src="${assetPath}/js/modernizr.min.js?ver=${assetVersion}"></script>
	</head>

	<body class="${bodyClass}" data-controller="proxy" data-action="${jsAction}">

		<%-- Body content --%>
		<div id="proxyContent" class="site-wrapper">
			<jsp:doBody />
		</div>

		<%-- Javascript --%>
		<script	type="text/javascript" src="${contextPath}/sitewide/jsConstants.jsp?ver=${assetVersion}"></script>
		<script	type="text/javascript" src="${assetPath}/js/lib.lzb.js?ver=${assetVersion}"></script>

	</body>
</html>
