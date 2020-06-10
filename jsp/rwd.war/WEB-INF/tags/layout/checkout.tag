<%--
  Tag for checkout page wrapper. Responsible for wrapping contents of cart and checkout pages with html, head, header and footer.
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
<c:set var="pageTitle" value="${pageTitle}" scope="request"/>
<c:set var="metaDescription" value="${metaDescription}" scope="request"/>
<c:set var="metaKeywords" value="${metaKeywords}" scope="request"/>
<c:set var="pageSpecificMETA" value="${pageSpecificMETA}" scope="request"/>
<c:set var="encodedSeoCanonicalURL" value="${seoCanonicalURL}" scope="request"/>
<c:set var="seoRobots" value="${seoRobots}" scope="request"/>
<c:set var="lastModified" value="${lastModified}" scope="request"/>
<c:set var="doSessionTimeout" value="${doSessionTimeout}" scope="request"/>
<c:set var="section" value="${section}" scope="request"/>
<c:set var="pageType" value="${pageType}" scope="request"/>
<c:set var="bodyClass" value="${bodyClass}" scope="request"/>
<c:set var="analyticsPageType" value="${analyticsPageType}" scope="request"/>
<c:set var="pageSpecificCSS" value="${pageSpecificCSS}" scope="request"/>
<c:set var="pageSpecificJS" value="${pageSpecificJS}" scope="request"/>
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
		<%-- Sitewide Page Title, Meta, Styles, JS stuff --%>
		<dsp:include page="/sitewide/includes/head.jsp" />
	</head>

	<body class="${bodyClass}" data-controller="${jsController}" data-action="${jsAction}">
		<%-- Facebook Connect App Info --%>
		<dsp:include page="/sitewide/includes/fbConnectAppInfo.jsp" />
		<%-- Fragment for Google Tag Manager (noscript) --%>
		<%@ include file="/sitewide/fragments/googleTagManagerNoScript.jspf" %>

		<%-- This include for Adobe Analytics in DTM script Mini-Cart-Details.js --%>
		<dsp:include page="/sitewide/includes/microcart.jsp" />

		<%-- only show header and include wrapping divs for non ajax and non-iframe requests --%>
		<c:if test="${!isAjax && !isProxy}">
			<div class="off-canvas-wrap" data-offcanvas>
				<div class="inner-wrap">

					<%-- Show either the mobile header or the regular header --%>
					<c:choose>
						<c:when test="${pageType eq 'cart' || pageType eq 'checkout' || pageType eq 'login'}">
							<%-- Header for single Checkout page --%>
							<c:import url="/sitewide/headerCheckout.jsp"/>
						</c:when>
						<c:when test="${isMobile == true}">
							<%-- For mobile we only include the mobile (small) header.
									The rendered file will have a smaller footprint for mobile users. --%>
							<c:import url="/sitewide/headerMobile.jsp"/>
						</c:when>
						<c:otherwise>
							<%-- otheriwse include both the desktop/tablet (large) large header and the mobile (small) header --%>
							<c:choose>
								<c:when test="${pageType eq 'orderConfirmation'}">
									<div class="cart-header">
										<c:import url="/sitewide/headerDesktop.jsp"/>
										<c:import url="/sitewide/headerMobile.jsp"/>
									</div>
								</c:when>
								<c:otherwise>
									<c:import url="/sitewide/headerMobile.jsp"/>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					<%-- Body content --%>
					<main class="site-wrapper" id="site-wrapper">
		</c:if>
						<jsp:doBody />

		<%-- only include wrapping divs for non ajax and non-iframe requests --%>
		<c:if test="${!isAjax && !isProxy}">
					</main>

				<c:if test="${pageType ne 'checkout'}">
					<jsp:include page="/sitewide/footerResponsive.jsp" />
				</c:if>

				<div class="back-to-top" data-backtotop>
					<div aria-hidden="true" class="icon icon-arrow-up"></div>
					<div class="text">top</div>
				</div>

				<!-- START: Page End -->
				<%-- Sitewide JS stuff --%>
				<dsp:include page="/sitewide/includes/pageEnd.jsp" />
				<!-- END: Page End -->

				<a class="exit-off-canvas"></a>
				</div><%-- /inner-wrap --%>
			</div><%-- /off-canvas-wrap --%>
		</c:if>

	</body>
</html>
