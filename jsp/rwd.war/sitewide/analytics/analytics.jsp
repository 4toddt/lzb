	<script class="analytics-script">
		(function (digitalData, undefined) {

			function getUrlParameter(sParam) {
				var sPageURL = decodeURIComponent(window.location.search.substring(1)),
								sURLVariables = sPageURL.split('&'),  sParameterName, i;
				for (i = 0; i < sURLVariables.length; i++) {
					sParameterName = sURLVariables[i].split('=');
					if (sParameterName[0] === sParam) {
						return sParameterName[1] === undefined ? "" : sParameterName[1];
					}
				}
				return undefined;
			}

			if (getUrlParameter("utm_campaign")) {
				digitalData.campaign = {};
				digitalData.campaign.name = getUrlParameter("utm_campaign");
				digitalData.campaign.source = getUrlParameter("utm_source");
				digitalData.campaign.medium = getUrlParameter("utm_medium");
				digitalData.campaign.term = getUrlParameter("utm_term");
				digitalData.campaign.content = getUrlParameter("utm_content");
			}

			<%-- tags common to all pages --%>
			digitalData.page = <c:import url="/sitewide/analytics/analytics_page.jsp" />;
			digitalData.user = <c:import url="/sitewide/analytics/analytics_user.jsp" />;
			digitalData.order = <c:import url="/sitewide/analytics/analytics_order.jsp" />;

			<%-- page, user, campaign, and order data go into dataLayer for GTM --%>
			var dataLayer = dataLayer || [];
			dataLayer.push(digitalData);

			<%-- initialize products, events and promotions variables --%>
			digitalData.products = [];
			digitalData.events =[];
			digitalData.promotions = [];

		}(window.digitalData = window.digitalData || {}));
	</script>
