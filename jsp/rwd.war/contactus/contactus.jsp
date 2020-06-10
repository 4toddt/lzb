<%--
	- File Name: contactus.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the contact page
	- Parameters:
	-
--%>

<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:getvalueof var="callCustomerServiceUrl"value="${storeConfig.callCustomerServiceUrl}"/>
	
	<layout:default>
		<jsp:attribute name="pageTitle">Contact Us</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content</jsp:attribute>
		<jsp:attribute name="analyticsPageType">contactUsPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
		
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a href="${contextPath}/" class="crumb"><fmt:message key="breadcrumb.home"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.contactus"/></span></li>
				</ul>
			</section>
			
			<%-- title --%>
			<div class="section-title">
				<h1><fmt:message key="contactus.header"/></h1>
			</div>
			
			<c:choose>
				<c:when test="${not empty preferredStore}">
					<dsp:getvalueof var="store" value="${preferredStore}"/>
					<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}"/>
					<c:if test="${not empty preferredStore.phoneNumber }">
						<dsp:getvalueof var="storePhoneNum"  value="${fn:substring(preferredStore.phoneNumber, 0, 3)}-${fn:substring(preferredStore.phoneNumber,3,6)}-${fn:substring(preferredStore.phoneNumber,6,10)}"/>
					</c:if>
				</c:when>
				<c:otherwise>
					<dsp:getvalueof var="store" value="${currentStore}"/>
					<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}"/>
				</c:otherwise>
			</c:choose>

			<c:if test="${not empty parentDealerId }">
				<dsp:droplet name="LZBDealerStoreDroplet">
					<dsp:param name="parentDealerId" value="${parentDealerId}"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="parentDealer" param="parentDealer" />
					</dsp:oparam>
				</dsp:droplet>
			</c:if>
			
			<%-- content container--%>
			<div class="section-row">
				<div class="section-content">
					<p>
						<fmt:message key="contactus.introText"/>&nbsp;
						<fmt:message key="contactus.introText2"/>&nbsp;
						<fmt:message key="contactus.introText3"/>&nbsp;
						<fmt:message key="contactus.introText4"/>&nbsp;
						<fmt:message key="contactus.introText5"/>
					</p>
					<div class="contact-container">
						<ul class="contact-tabs">
							<li>
								<a href="tel:<fmt:message key="orderDetail.contactNumber"/>">
									<span class="contact-method"><fmt:message key="contactus.callCustomerService"/>${callCustomerServiceUrl}</span>
									<span class="contact-detail"><fmt:message key="orderDetail.contactNumber"/></span>
									<span class="icon icon-arrow-right"></span>
								</a>
							</li>
							<li>
								<a href="mailto:<fmt:message key="contactus.comfortCareEmailId"/>">
									<span class="contact-method"><fmt:message key="contactus.emailCustomerService"/>
									</span><span class="contact-detail"><fmt:message key="contactus.comfortCareEmailId"/></span>
									<span class="icon icon-arrow-right"></span>
								</a>
							</li>
							
							<dsp:getvalueof var="phoneNum" value="${store.phoneNumber}"/>
							<c:if test="${not empty phoneNum }">
								<li>
									<a href="tel:${phoneNum}">
										<span class="contact-method"><fmt:message key="contactus.callLocalStore"/></span>
										<span class="contact-detail">${phoneNum}</span>
										<span class="icon icon-arrow-right"></span>
									</a>
								</li>
							</c:if>
							
							<li>
								<a href="http://jobs.jobvite.com/la-z-boy-review">
									<span class="contact-method"><fmt:message key="contactus.intrestedInCareer"/></span>
									<span class="icon icon-arrow-right"></span>
								</a>
							</li>
						</ul>
					</div>			
				</div>
			</div>
		</jsp:body>
	</layout:default>
	
</dsp:page>