<%--
	This page is responsible for initializing turnto functionality.  All pages that require any kind of turnto
	items need to include this somewhere.

	Parameters:
		type - not required, but if 'orderComplete', then some special code is rendered for the feed on that page
		productId - required if PDP, used to determine if TT can be shown
--%>

    	
<dsp:page>

	<dsp:getvalueof var="turnToEnabled"	bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
	<dsp:getvalueof var="siteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
	<dsp:getvalueof var="pageType" param="type" />

	<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
		<dsp:param name="inUrl" value="/modals/signin.jsp"/>
		<dsp:oparam name="output">
			<dsp:getvalueof param="secureUrl" var="loginUrl" />
			<dsp:getvalueof param="nonSecureUrl" var="loginUrlNonSecure"/>
		</dsp:oparam>
	</dsp:droplet>

<%-- Hidden login button we use to help triggering an ajax logout --%>
<dsp:a id="logoutHidden" href="/" value="logout" style="display: none;">
	<dsp:property bean="/atg/userprofiling/ProfileFormHandler.logout" value="true"/>
	Logout
</dsp:a>


	<link rel="stylesheet" href="//static.www.turnto.com/tra4_3/tra.css" />
	<c:choose>
		<c:when test="${turnToEnabled}">
			<script type="text/javascript">
				
			<%-- This must be declared before any other TurnTo items --%>
				turnToConfig = {
					siteKey : "${siteKey}",
					setupType : "staticEmbed",
					reviewsSetupType : "staticEmbed",
					questionHeader : "Find answers from other customers, our expert staff and our FAQs.",
					skipCssLoad : true,
					paginationReviewsShownInitially : 5,
					paginationReviewsShownOnExpand : 5,
					paginationQuestionsShownInitially : 5,
					paginationQuestionsShownOnExpand : 5
				
				};
				
				(function() {
					var tt = document.createElement('script');
					tt.type = 'text/javascript';
					tt.async = true;
					tt.src = document.location.protocol + "//static.www.turnto.com/traServer4_3/trajs/"	+ '${siteKey}' + "/tra.js";
					var s = document.getElementsByTagName('script')[0];
					s.parentNode.insertBefore(tt, s);
				})();
			</script>

			<%--         <script type="text/javascript" src="//static.www.turnto.com/traServer4_3/trajs/${siteKey}/tra.js"></script>
 			--%>
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>

</dsp:page>
