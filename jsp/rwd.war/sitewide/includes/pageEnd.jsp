<%--
	- File Name: pageEnd.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Outputs the contents of the <head>. Includes the meta tags, js and css includes.
	- Required Parameters: (these are request scoped)
		- section: string for section the page falls in (ex browse)
		- pageType: string for the page type (ex product)
		- cg_n: request scoped from webtrendsContent.jsp,
		- cg_s: request scoped from webtrendsContent.jsp,
		- parentDealerId: request scoped from displayPreferredStoreFooter.jsp,
		- storePhoneNum: request scoped from displayPreferredStoreFooter.jsp,
		- preferStoreName: request scoped from displayPreferredStoreFooter.jsp,
		- pageTypeForTracking: request scoped from many page files
	- Optional Parameters: (these are request scoped)
		- pageSpecificJS: pageSpecificJS tag renderer
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Base Site Scripts --%>
	<c:choose>
		<c:when test="${!isAjax && !isProxy}">
			<%-- Javascript --%>
			<script	type="text/javascript" src="${contextPath}/sitewide/jsConstants.jsp?ver=${assetVersion}"></script>
			<script	type="text/javascript" src="${assetPath}/js/lib.lzb.js?ver=${assetVersion}"></script>
		</c:when>
		<%-- proxy iframe may have additional javascript libraries --%>
		<c:when test="${isProxy}">
			<%-- Javascript --%>
			<script	type="text/javascript" src="${contextPath}/sitewide/jsConstants.jsp?ver=${assetVersion}"></script>
			<script	type="text/javascript" src="${assetPath}/js/lib.lzb.js?ver=${assetVersion}"></script>
		</c:when>
	</c:choose>

	<%-- Include content from pageSpecificJS tag renderer --%>
	<c:if test="${not empty pageSpecificJS}">
		<c:out value="${pageSpecificJS}" escapeXml="false"/>
	</c:if>
	
	<%-- Include Synchrony library only on cart and checkout pages --%>
	<c:if test="${pageType eq 'cart' || pageType eq 'checkout' || pageType eq 'orderConfirmation'}">
		<script	type="text/javascript" src="${storeConfig.digitalBuyLibURL}"></script>
	</c:if>
	
	<%-- Web Trends: Analytics group_name | event_name --%>
	<meta name="WT.cg_n" content="${cg_n}" />
	<meta name="WT.cg_s" content="${cg_s}" />
	<section data-groupname="${cg_n}" data-prodname="${cg_s}" data-dealerid="${parentDealerId}" data-dealerphone="${storePhoneNum}" data-dealername="${preferStoreName}"></section>

	<%-- Marxent Image Composer API script --%>
	<c:if test="${(pageType == 'product') && (not empty storeConfig.marxentComposerScriptPath && storeConfig.marxentComposerEnabled)}">
		<script src="${storeConfig.marxentComposerScriptPath}"></script>
	</c:if>

	<%-- Adobe tag manager script end tag --%>
	<c:if test="${not empty storeConfig.adobeTagMgrScriptPath}">
		<script type="text/javascript">_satellite.pageBottom();</script>
	</c:if>

	<!-- START: Facebook Connect API script -->
	<dsp:include src="/sitewide/includes/fbConnect.jsp" />
	<!-- END: Facebook Connect API script -->

	<%-- START: Monetate related data update --%>
	<c:if test="${storeConfig.monetateEnabled eq true }" >
	
	<%-- Monetate include to push CDP or PDP data to monetate queue --%>
	<dsp:include page="/sitewide/includes/monetateCDPAndPDPPageData.jsp" flush="true"></dsp:include>

	<%-- Monetate include to push page type to monetate queue --%>
	<dsp:include page="/sitewide/includes/monetatePageType.jsp" flush="true">
		<dsp:param name="pageType" value="${pageTypeForTracking}"/>
	</dsp:include>

	<%-- Monetate tag data submit --%>
	<script>
		window.monetateQ.push(["trackData"]);
	</script>
	<%-- END: Monetate related data update --%>
	</c:if>
	
	<%-- START: Foresee --%>
	<%-- Foresee Environment Variable --%>
	<c:choose>
        <c:when test="${storeConfig.staging eq true}">
            <c:set var="foreseeEnvironment" value="staging"/>
        </c:when>
        <c:otherwise>
            <c:set var="foreseeEnvironment" value="production"/>
        </c:otherwise>
    </c:choose>

	<%-- Foresee tag start --%>
    <script>
    	// DO NOT MODIFY BELOW THIS LINE *****************************************
    	;(function (g) {
	    	var d = document, am = d.createElement('script'), h = d.head || d.getElementsByTagName("head")[0], fsr = 'fsReady',
		    	aex = {
					"src": "//gateway.foresee.com/sites/lazboy/<c:out value="${foreseeEnvironment}"/>/gateway.min.js",
					"type": "text/javascript",
					"async": "true",
					"data-vendor": "fs",
					"data-role": "gateway"
				};
			for (var attr in aex) { am.setAttribute(attr, aex[attr]); } h.appendChild(am); g[fsr] || (g[fsr] = function () { var aT = '__' + fsr + '_stk__'; g[aT] = g[aT] || []; g[aT].push(arguments); });
		})(window);
    	// DO NOT MODIFY ABOVE THIS LINE *****************************************
    </script>
    <%-- Foresee tag end --%>
	<%-- END: Foresee --%>

</dsp:page>