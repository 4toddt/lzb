<%--
	- File Name: orderHistory.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Order history page that contains all a users orders
	- Parameters:
	-
--%>
<dsp:page>
	<%-- SET PAGE PARAMS --%>

	<%-- HEAD stuff--%>
	<layout:default>
		<jsp:attribute name="pageTitle">Order History</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">account</jsp:attribute>
		<jsp:attribute name="pageType">orderHistory</jsp:attribute>
		<jsp:attribute name="bodyClass">account order-history</jsp:attribute>
		<jsp:attribute name="analyticsPageType">accountOrderHistoryPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>

		<jsp:body>
			<!-- breadcrumbs -->
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a class="crumb" href="${contextPath}/account/account.jsp"><fmt:message key="breadcrumb.dashboard"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.orderHistory"/></span></li>
				</ul>
			</section>
			
			<!-- page title -->
			<div class="section-title hide-for-large">
				<h1><fmt:message key="orderHistory.Header"/></h1>
			</div>
			
			<!-- page content-->
			<div class="section-row">
				<div class="account-two-column-container">
					<div class="account-two-column-left hide">
						<dsp:include page="/account/includes/leftnavigation.jsp">
							<dsp:param name="selpage" value="ORDERHISTORY" />
						</dsp:include>
					</div>
					<div class="account-two-column-right">
						<dsp:include page="/account/includes/orderHistory_view.jsp"/>
					</div>
				</div>
			</div>

		</jsp:body>
	</layout:default>
</dsp:page>