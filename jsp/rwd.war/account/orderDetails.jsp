<%--
	- File Name: orderDetails.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the order details page
	- Parameters: orderId
	-
--%>

<dsp:page>

	<%-- Imports --%>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="orderId" param="orderId"/>
	
	<layout:default>
		<jsp:attribute name="pageTitle">Order Details</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">account</jsp:attribute>
		<jsp:attribute name="pageType">orderDetails</jsp:attribute>
		<jsp:attribute name="bodyClass">accounts order-details</jsp:attribute>
		<jsp:attribute name="analyticsPageType">accountOrderDetailsPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
			
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a class="crumb" href="${contextPath}/account/account.jsp"><fmt:message key="breadcrumb.dashboard"/></a></li>
					<li><a class="crumb" href="${contextPath}/account/orderHistory.jsp"><fmt:message key="breadcrumb.orderHistory"/></a></li>
					<li><span class="crumb"><fmt:message key="breadcrumb.orderDetails"/></span></li>
				</ul>
			</section>
			
			<!-- page title -->
			<div class="section-title hide-for-large">
				<h1><fmt:message key="orderSummary.no"/> ${orderId}</h1>
			</div>
			
			<!-- page content-->
			<div class="section-row">
				<div class="account-two-column-container">
					<div class="account-two-column-left hide">
						<dsp:include page="/account/includes/leftnavigation.jsp">
							<dsp:param name="selpage" value="PROFILE" />
						</dsp:include>
					</div>
					<div class="section-content account-two-column-right">
						<dsp:include page="/account/includes/orderDetails_view.jsp">
							<dsp:param name="order" param="orderId"/>
						</dsp:include>
					</div>
				</div>
			</div>
		</jsp:body>
	</layout:default>
</dsp:page>
	
