<%--
    - File Name: mobileTurnTo.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the mobile TurnTo landing page.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>

	<%-- Page Variables --%>
    <dsp:getvalueof var="turnToEnabled"	bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
    <dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
    <dsp:getvalueof var="pageType" param="type" />

    <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
		<dsp:param name="inUrl" value="/account/login.jsp" />
		<dsp:oparam name="output">
			<dsp:getvalueof param="secureUrl" var="loginUrl" />
			<dsp:getvalueof param="nonSecureUrl" var="loginUrlNonSecure" />
		</dsp:oparam>
	</dsp:droplet>

	<layout:default>
		<jsp:attribute name="pageTitle">mobile item page</jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="doSessionTimeout">false</jsp:attribute>
		<jsp:attribute name="section">browse</jsp:attribute>
		<jsp:attribute name="pageType">TTmobileLandingPage</jsp:attribute>
		<jsp:attribute name="bodyClass">TTmobileLandingPage</jsp:attribute>
		<jsp:attribute name="analyticsPageType">TTmobileLandingPage</jsp:attribute>
		<jsp:attribute name="pageSpecificCSS">
            <%-- Stylesheet Reference for TurnTo Reviews --%>
            <link rel="stylesheet" href="//static.www.turnto.com/tra4_3/tra.css" type="text/css" />
        </jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
            <script type="text/javascript">
                // Declare TurnTo Configuration
                var turnToConfig = {
                    siteKey: "${turnToSiteKey}",
                    setupType: "mobileTT"
                };
            </script>
            <%-- TurnTo Mobile Landing JavaScript Include for TurnTo Reviews --%>
            <script type="text/javascript" src="//static.www.turnto.com/tra4_3/mobile-landing.js"></script>
        </jsp:attribute>

		<jsp:body>
			<div id="mobileTT-content"></div>
		</jsp:body>
	</layout:default>
</dsp:page>