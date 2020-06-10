
<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
	<dsp:getvalueof var="activeTab" param="selpage" />

	<nav role="navigation" class="account secondary-nav">
		<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		
 <dsp:include page="/includes/webtrendsContent.jsp">
  <dsp:param name="page" value="Accounts"  />
  </dsp:include>
  
		<div class="nav-title"><a href="/account/account.jsp"><fmt:message key="myAccount.account"/></a></div>
		<ul>
			<c:choose>
				<c:when test="${activeTab == 'PROFILE'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/account/profile.jsp"><fmt:message key="account.profile" /></a>
			</li>
			<c:choose>
				<c:when test="${activeTab == 'PREFERREDSTORE'}">
					<li class="nav-item current"><b>${prefStore}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/account/preferredStore.jsp"><fmt:message key="myAccount.preferredStore" /></a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'ORDERHISTORY'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>


			<a href="/account/orderHistory.jsp"><fmt:message key="myAccount.orderHistory" /></a>
			</li>

			<%-- JIRA DMI-1763 Hide Wishlist UI
			<c:choose>
				<c:when test="${activeTab == 'WISHLIST'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/account/wish_list_items.jsp"><fmt:message key="myAccount.wishList" /></a>
			</li>
			--%>

			<li class="logout"><dsp:a id="loggedInUserAnchr"
					href="${siteBaseUrl}/index.jsp" bean="ProfileFormHandler.logout"
					value="logout" title="${logout}"><fmt:message key="common.logout" /></dsp:a></li>
		</ul>
		<div class="nav-title">
			<a href="/designcenter/designhome.jsp?tab=1">
				<fmt:message key="myAccount.myDesign"/>
			</a>
			<div class="triangle"></div>
		</div>
		<ul>
			<c:choose>
				<c:when test="${activeTab == 'SAVEDCOVER'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/designcenter/designhome.jsp?tab=2">
			<%-- <a href="/account/designCenter/saveCover.jsp"> --%>
				<fmt:message key="myAccount.savedCovers" />
			</a>
			</li>
			<c:choose>
				<c:when test="${activeTab == 'ROOMPLANNER'}">
					<li class="nav-item current"><dsp:a page="#"
							title="${roomPlanner}">
							<b>${roomPlanner}</b>
						</dsp:a>
				</c:when>
				<c:otherwise>
					<li class="nav-item"><dsp:a page="#" title="${roomPlanner}">
									${roomPlanner}
								</dsp:a>
				</c:otherwise>
			</c:choose>
			<a href="/designcenter/designhome.jsp?tab=3">
			<%--<a href="/designcenter/roomPlanner.jsp"> --%>
				<fmt:message key="myAccount.roomPlanner" />
			</a>
			</li>
		</ul>
	</nav>

</dsp:layeredBundle>