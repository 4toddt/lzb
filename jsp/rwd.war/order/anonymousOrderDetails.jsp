<%--
	- File Name: anonymousOrderDetails.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the order details page
	- Parameters:
	-
--%>

<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="orderId" param="orderId"/>
	
	<layout:default>
		<jsp:attribute name="pageTitle">Order Details</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content order-details</jsp:attribute>
		<jsp:attribute name="analyticsPageType">anonymousOrderDetailsPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
			
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a href="${contextPath}/" class="crumb"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a href="${contextPath}/order/anonymousOrders.jsp" class="crumb">Online Order Status</a></li>
					<li><span class="crumb active">Your Order Details</span></li>
				</ul>
			</section>
			
			<%-- title --%>
			<div class="section-title">
				<h1><fmt:message key="orderSummary.no"/> ${orderId}</h1>
			</div>
			
			<%--  content container --%>
			<div class="section-row">
				<div class="section-content">
					<dsp:include page="/account/includes/orderDetails_view.jsp">
						<dsp:param name="order" param="orderId"/>
					</dsp:include>
				</div>
			</div>
			
		</jsp:body>
	</layout:default>
</dsp:page>
	
