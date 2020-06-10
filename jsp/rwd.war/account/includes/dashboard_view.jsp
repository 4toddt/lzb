<%--
	- File Name: dashboard_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the view page for My Account
	- Parameters:
	-
--%>
<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	
	<!-- This used for to display profile dash board content -->
	<%-- Page Variables --%>
	<dsp:getvalueof var="firstName" bean="ProfileFormHandler.value.firstName" />
	<dsp:getvalueof var="lastName" bean="ProfileFormHandler.value.lastName" />
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	
	<c:choose>
        <c:when test="${not empty firstName }">
            <c:set var="displayProfileName"><fmt:message key="dashboard.hello"/>&nbsp;<span>${firstName}&nbsp;${lastName}</span></c:set>
        </c:when>
        <c:otherwise>
            <c:set var="displayProfileName"><fmt:message key="dashboard.hello"/>&nbsp;<fmt:message key="dashboard.welcome"/></c:set>
        </c:otherwise>
    </c:choose>
		
	<section role="region" class="my-account-content">
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="dashboard.account"/></h1>
		</div> --%>
		
		<div class="account-content standard-border">
			<h2>${displayProfileName}</h2>
			<p class="account-heading"><fmt:message key="dashboard.info"/></p>
	
			<div class="content-options">
				<div class="options-wrapper">
					<dsp:a href="${contextPath}/account/profile.jsp"><fmt:message key="dashboard.profile"/>&nbsp;<span class="icon icon-arrow-right"></span></dsp:a>
					<p><fmt:message key="dashboard.profileInfo"/>&nbsp;<fmt:message key="dashboard.SubscriptionsInfo"/></p>
				</div>
				<div class="options-wrapper">
					<dsp:a href="${contextPath}/account/orderHistory.jsp"><fmt:message key="dashboard.order"/>&nbsp;<span class="icon icon-arrow-right"></span></dsp:a>
					<p><fmt:message key="dashboard.orderInfo"/></p>
				</div>
				<div class="options-wrapper">
					<dsp:a href="${contextPath}/account/preferredStore.jsp"><fmt:message key="dashboard.Store"/>&nbsp;<span class="icon icon-arrow-right"></span></dsp:a>
					<p><fmt:message key="dashboard.StoreInfo"/></p>
				</div>
				<div class="options-wrapper">
					<dsp:a href="${contextPath }/content/DesignInspirations/3DRoomPlanner/"><fmt:message key="dashboard.myDesigncentr"/>&nbsp;<span class="icon icon-arrow-right"></span></dsp:a>
					<p></p>
				</div>
				<fmt:message var="logout" key="headerAcntMenu.signOut" />
				<div class="options-wrapper">
					<dsp:a id="loggedInUserAnchr" href="${contextPath}" bean="ProfileFormHandler.logout" value="logout" title="${logout}"><fmt:message key="headerAcntMenu.signOut" /></dsp:a>
				</div>
			</div>
		</div>
	
	</section>
</dsp:page>