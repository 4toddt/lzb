<%--
	- File Name: careers.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the carrier page
	- Parameters:
	-
--%>

<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="worldHeadquartersUrl"value="${storeConfig.worldHeadquartersUrl}"/>
	<dsp:getvalueof var="retailUrl"value="${storeConfig.retailUrl}"/>
	<dsp:getvalueof var="manufacturingUrl" value="${storeConfig.manufacturingUrl}"/>
	<dsp:getvalueof var="careersImgurl" value="${storeConfig.careersImgurl}"/>
	
	<layout:default>
		<jsp:attribute name="pageTitle">Careers</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">content</jsp:attribute>
		<jsp:attribute name="pageType">staticContent</jsp:attribute>
		<jsp:attribute name="bodyClass">static-content</jsp:attribute>
		<jsp:attribute name="analyticsPageType">careersPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
		
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a href="${contextPath}/" class="crumb"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a href="${contextPath}/content/CustomerCare/contactus" class="crumb"><fmt:message key="breadcrumb.contactus"/></a></li>
					<li><span class="crumb active"><fmt:message key="mobile.careers"/></span></li>
				</ul>
			</section>
			
			<%-- title --%>
			<div class="section-title">
				<h1><fmt:message key="mobile.careers" /></h1>
			</div>
			
			<%-- content container--%>
			<div class="section-row">
				<div class="section-content">
					<div class="career_img image-slot" style="height: auto;">
						<img src="${careersImgurl}" />
					</div>
					<p>
						<fmt:message key="mobile.careersIntroText"/>&nbsp;
						<fmt:message key="mobile.careersIntroText2"/>&nbsp;
						<fmt:message key="mobile.careersIntroText3"/>
					</p>
					
					<ul class="contact-tabs career-tabs">
						<li>
							<a href="${worldHeadquartersUrl}"> World Headquarters <span class="icon icon-arrow-right"></span></a>
						</li>
						<li>
							<a href="${retailUrl}">Retail <span class="icon icon-arrow-right"></span></a>
						</li>
						<li>
							<a href="${manufacturingUrl}">Manufacturing & Other <span class="icon icon-arrow-right"></span></a>
						</li>
					</ul>
					
				</div>
			</div>
			
		</jsp:body>
	</layout:default>
	
</dsp:page>