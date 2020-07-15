<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	<%-- Page Variables --%>
	
	<layout:default>
		<jsp:attribute name="pageTitle">OrderStatus</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content</jsp:attribute>
		<jsp:attribute name="analyticsPageType">anonymousOrderStatusPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
	    <jsp:body>      
	     
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a href="${contextPath}/" class="crumb"><fmt:message key="breadcrumb.home"/></a></li>
					<li><span class="crumb active"><fmt:message key="anonymousOrder.Header"/></span></li>
				</ul>
			</section>
			
			<%-- title --%>
			<div class="section-title">
				<h1><fmt:message key="anonymousOrder.Header" /></h1>
			</div>
			
			<%-- content container--%>
			<div class="section-row">
				<div class="section-content">
				    <div>
				       <fmt:message key="anonymousOrder.Ordertext"/></br>
				       <fmt:message key="anonymousOrder.Ordertext2"/></br>
				       <fmt:message key="anonymousOrder.Ordertext3"/></br>
				       <fmt:message key="anonymousOrder.Ordertext4"/></br>
				       <fmt:message key="anonymousOrder.Ordertext5"/></br>			     				  				   			     
					</div>
					<div>
					     <fmt:message key="anonymousOrder.OrderStatusText1"/></br>
					     <fmt:message key="anonymousOrder.OrderStatusText2"/></br>
					     <fmt:message key="anonymousOrder.OrderStatusText3"/></br>&nbsp;<dsp:a href="${contextPath}/content/CustomerCare/contactus">Contact Us</dsp:a>
					</div>

			        <dsp:form action="#" method="post" name="anonymous_order" id="anonymous_orders" formid="anonymous_orders" data-validate>
						<p><fmt:message key="profile.required"/></p>
						<div class="field-group">
							<fmt:message var="orderNumber" key="anonymousOrder.OrderNumber"/>
							<label for="account_Order_Number"><<fmt:message key="anonymousOrder.OrderNumber"/>&nbsp;*<span class="sr-only"><fmt:message key="anonymousOrder.OrderNumber"/></span></label>
							<dsp:input id="account_Order_Number" type="text" name="account_Order_Number" bean="ProfileFormHandler.orderNumber" maxlength="255" data-validation="required" aria-required="true" autocomplete="off" placeholder="${orderNumber}"/>
						</div>
						<div class="field-group">
							<fmt:message var="postalCode" key="anonymousOrder.postalCode"/>
							<label for="account_Zip_Code"><<fmt:message key="anonymousOrder.postalCode"/>&nbsp;*<span class="sr-only"><fmt:message key="anonymousOrder.postalCode"/></span></label>
							<dsp:input id="account_Zip_Code" type="text" name="account_Postal_Code" bean="ProfileFormHandler.zipCode" maxlength="255" data-validation="required zipCode" autocomplete="off" placeholder="${postalCode}" aria-required="true"/>
						</div>
		               	<dsp:input type="hidden" bean="ProfileFormHandler.anonymousOrderSuccessUrl" value="${contextPath}/order/json/anonymousOrderSuccess.jsp?orderId="/>
		               	<dsp:input type="hidden" bean="ProfileFormHandler.anonymousOrderErrorUrl" value="${contextPath}/account/json/profileError.jsp" />
		               	<dsp:input type="hidden" bean="ProfileFormHandler.mobileRequest" value="true"/>
		               	<dsp:input type="submit" value="SUBMIT" name="anonymous_order" id="anonymous_order" iclass="button primary" bean="ProfileFormHandler.searchAnonymousOrder" />
			        </dsp:form>

			        <div>
			            <h2><fmt:message key="anonymousOrder.register"/></h2>
		                <fmt:message key="anonymousOrder.registerText1"/></br>
		                <fmt:message key="anonymousOrder.registerText2"/></br>
		                <fmt:message key="anonymousOrder.registerText3"/></br>
			        </div>
			        <div>
			            <h2><fmt:message key="anonymousOrder.signIn"/></h2>
		                <fmt:message key="anonymousOrder.signInText1"/></br>
		                <fmt:message key="anonymousOrder.signInText2"/>
			        </div>
				</div>
			</div>
			
		 </jsp:body>
	 </layout:default>
</dsp:page>