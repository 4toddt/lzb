<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />

	<%-- Page Variables --%>
	<dsp:getvalueof  var="catalogRefId" param="skuId"/>
	<dsp:getvalueof var="prodName" param="productName"/>

	<%-- Define SEO Canonical URL --%>
	<c:set var="seoCanonicalURL" value="${originatingRequest.getRequestURI()}" />

<layout:default>
	<jsp:attribute name="pageTitle"><fmt:message key="shareProd.shareProdText"/></jsp:attribute>
	<jsp:attribute name="metaDescription"></jsp:attribute>
	<jsp:attribute name="metaKeywords"></jsp:attribute>
	<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
	<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
	<jsp:attribute name="lastModified"></jsp:attribute>
	<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
	<jsp:attribute name="section">account</jsp:attribute>
	<jsp:attribute name="pageType">sharing</jsp:attribute>
	<jsp:attribute name="bodyClass">account</jsp:attribute>
	<jsp:attribute name="analyticsPageType">shareProductSuccessPage</jsp:attribute>
	<jsp:attribute name="pageSpecificCSS"></jsp:attribute>
	<jsp:attribute name="pageSpecificJS"></jsp:attribute>

	<jsp:body>
		<!-- breadcrumbs -->
		<section class="breadcrumbs">
			<ul aria-label="breadcrumbs" role="navigation">
				<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
				<li><span class="crumb active"><fmt:message key="shareProd.shareProdText"/></span></li>
			</ul>
		</section>
		
		<!-- page title -->
		<div class="section-title hide-for-large">
			<h1><fmt:message key="shareProd.shareProdText"/></h1>
		</div>

		<main role="main" class="shareby">
			<p><fmt:message key="shareProd.successPDP"/></p>
			<dsp:droplet name="LZBPDPURLDroplet">
				<dsp:param name="productId" value="${catalogRefId}"/>
				<dsp:param name="prodName" value="${prodName}"/>
				<dsp:param name="fromCDP" value="true"/>
				<dsp:param name="isMobile" value="true"/>
				<dsp:param name="elementName" value="url"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="URL" param="url"/>
				</dsp:oparam>
			</dsp:droplet>
			<c:if test="${ not empty URL}">
				<c:set var="PDPURL" value="${URL}"/>
			</c:if>
			<div>
				<dsp:a href="${pageContext.request.contextPath}${PDPURL}" class="button primary small">Return</dsp:a>
			</div>
		</main>
	</jsp:body>
</layout:default>
</dsp:page>