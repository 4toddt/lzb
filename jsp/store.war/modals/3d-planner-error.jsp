<%--
  This page renders login form for returned customers.
  Required parameters:
    None
  Optional parameters:
    None
--%>
<dsp:page>

  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
	<dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
  <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
  <dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="guestCheckout" param="guestCheckout"/>
	<c:set var="pageTypeForTracking" value="login" scope="request" />
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

		<!doctype html>
		<html class="no-js">
			<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<title>Sign-in</title>
				<meta name="description" content="">
				<meta name="viewport" content="width=device-width, initial-scale=1">

				<link rel="stylesheet" href="/css/min/desktop.css?ver=${assetVersion}" type="text/css" />
				<script src="/js/amp.js?ver=${assetVersion}"></script>

				<%-- Adobe tag manager script include --%>
				<c:if test="${not empty storeConfig.adobeTagMgrScriptPath}">
					<script src="//${storeConfig.adobeTagMgrScriptPath}"></script>
				</c:if>

				<dsp:include page="/includes/monetateHeader.jsp" flush="true"></dsp:include>
				<%-- Monetate tag Initialization --%>
				<script>
					window.monetateQ = window.monetateQ || [];
				</script>

			</head>
			<body role="document" dir="ltr">

				<main role="main" class="planner-signin" data-module="cbox">

								<h2>Sorry, this page is currently unavailable.<br/>Please try again later or return to our homepage.</h2>

				</main>
				

				<%-- Adobe tag manager script end tag  start --%>
				<c:if test="${not empty storeConfig.adobeTagMgrScriptPath}">
					<script type="text/javascript">_satellite.pageBottom();</script>
				</c:if>
				<%-- Adobe tag manager script end tag end --%>
					<%-- Monetate script page type update  --%>
				<dsp:include page="/includes/monetatePageType.jsp" flush="true">
					<dsp:param name="pageType" value="${pageTypeForTracking}"/>
				</dsp:include>
				<%-- Monetate tag data submit --%>
				<script>
					window.monetateQ.push(["trackData"]);
				</script>

			</body>
		</html>

	</dsp:layeredBundle>

</dsp:page>

