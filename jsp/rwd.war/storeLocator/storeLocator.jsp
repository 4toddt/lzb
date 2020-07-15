<%--
	- File Name: storeLocator.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the store locator
	- Parameters:
	-
--%>

<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="preferredStore" param="preferredStore"/>
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	
	<dsp:include page="/sitewide/includes/SEOTagData.jsp">
		<dsp:param name="paramKeyForSEOTagData" value="storeLocator"/>
	</dsp:include>
	
	<layout:default>
		<jsp:attribute name="pageTitle">${sEOTagTitle}</jsp:attribute>
		<jsp:attribute name="metaDescription">${sEOMetaTagDescription}</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">store</jsp:attribute>
		<jsp:attribute name="pageType">storeLocator</jsp:attribute>
		<jsp:attribute name="bodyClass">store-locator</jsp:attribute>
		<jsp:attribute name="analyticsPageType">storeLocatorPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
		<jsp:attribute name="pageSpecificJS"></jsp:attribute>
		
		<jsp:body>
		
			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a href="${contextPath}/" class="crumb"><fmt:message key="breadcrumb.home"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.storeLocator"/></span></li>
				</ul>
			</section>
			
			<%-- title --%>
			<div class="section-title">
				<h1>
					<c:choose>
						<c:when test="${not empty sEODisplayName}">
							${sEODisplayName}
						</c:when>
						<c:otherwise>
							<fmt:message key="home.locator"/>
						</c:otherwise>
					</c:choose>
				</h1>
			</div>
			
			<%-- content container--%>
			<div class="section-row">
				<div class="two-column-container">
					<div class="store-locator-left">
						<!-- current store details -->
						<dsp:include page="/storeLocator/includes/currentStore.jsp"/>
						
						<!-- store locator form -->
						<div class="store-content store-locator-form">
							<dsp:include page="/storeLocator/includes/storeLocatorForm.jsp"/>
						</div>
						
						<!-- show store locator search results after submit the form -->
						<div class="store-location-results"></div>
					</div>
					
					<div class="store-locator-right">
						<div id="map-canvas"></div>
					</div>
					
					<dsp:form id="preferredStore" formid="preferredStore" name="preferredStore" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
						<dsp:input type="hidden" bean="ProfileFormHandler.storeId" id="prefer-store-id" value="" />
						<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationErrorURL" value="${contextPath}/storeLocator/json/storeError.jsp" />
						<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationSuccessURL" value="${contextPath}/storeLocator/json/storeSuccess.jsp?type=preferStore" />
						<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocation" value="MAKE THIS MY PREFERRED STORE" iclass="btn-primary show-more" />
					</dsp:form>
					
					<dsp:form id="changeStore" formid="changeStore" name="changeStore" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
						<dsp:input type="hidden" bean="ProfileFormHandler.storeId" id="change-store-id" value="" />
						<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${contextPath}/storeLocator/json/storeSuccess.jsp?type=" />
						<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreErrorURL" value="${contextPath}/storeLocator/json/storeError.jsp" />
						<dsp:input type="hidden" bean="ProfileFormHandler.changeStore" value="MAKE THIS MY PREFERRED STORE" iclass="btn-primary show-more" />
					</dsp:form>
						
				</div>			
			</div>
			
			<%-- include google maps api --%>
			<script type="text/javascript" async src="https://maps.googleapis.com/maps/api/js?client=gme-lazboy&v=3&libraries=geometry"></script>
		</jsp:body>
	</layout:default>
	
</dsp:page>