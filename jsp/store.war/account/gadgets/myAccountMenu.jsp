<%--
  This page renders 'My Account' menu for navigating to profile information,
  payment settings, addresses, wish lists, gift lists and previous orders.

  Required parameters:
    selpage
      indicates which menu option is currently selected

  Optional parameters
    None
--%>

<dsp:page>

  <dsp:importbean bean="/atg/dynamo/servlet/RequestLocale"/>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>

	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

		<dsp:getvalueof var="activeTab" param="selpage" />
		<div id="lzb_myAccountNav">
			<h2><fmt:message key="myAccount.account"/></h2>
			<ul>
				<%-- Profile information --%>
				<fmt:message var="profile" key="account.profile" />
				<c:choose>
					<c:when test="${activeTab == 'PROFILE'}">
						<li>
							<b>${profile}</b>
					</c:when>
					<c:otherwise>
						<li>
						<dsp:a page="/account/profile.jsp" title="${profile}">
							${profile}
						</dsp:a>
					</c:otherwise>
				</c:choose>

				</li>

				<fmt:message var="prefStore" key="myAccount.preferredStore" />
				<c:choose>
					<c:when test="${activeTab == 'PREFERREDSTORE'}">
						<li>
							<b>${prefStore}</b>
					</c:when>
					<c:otherwise>
						<li>
						<dsp:a page="/account/preferredStore.jsp" title="${prefStore}">
							${prefStore}
						</dsp:a>
					</c:otherwise>
				</c:choose>
				</li>

				<fmt:message var="orderHistory" key="myAccount.orderHistory" />
				<c:choose>
					<c:when test="${activeTab == 'ORDERHISTORY'}">
						<li>
						   <b>${orderHistory}</b>
					</c:when>
					<c:otherwise>
						<li>
						<dsp:a page="/account/orderHistory.jsp" title="${orderHistory}">${orderHistory}</dsp:a>
					</c:otherwise>
				</c:choose>
				</li>

                <%-- JIRA DMI-1763 Hide Wishlist UI
				<fmt:message var="wishList" key="myAccount.wishList" />
				<c:choose>
					<c:when test="${activeTab == 'WISHLIST'}">
						<li>
						   <b>${wishList}</b>
					</c:when>
					<c:otherwise>
						<li>
						<dsp:a page="/account/wish_list_items.jsp" title="${wishList}">${wishList}</dsp:a>
					</c:otherwise>
				</c:choose>
				</li>
                --%>

				<fmt:message var="logout" key="common.logout" />
				<c:choose>
					<c:when test="${activeTab == 'LOGOUT'}">
						<li>
							<b>${logout}</b>
					</c:when>
					<c:otherwise>
						<li>
						<dsp:a id="loggedInUserAnchr" href="${siteBaseUrl}/index.jsp" bean="ProfileFormHandler.logout" value="logout" title="${logout}">
							${logout}
						</dsp:a>
					</c:otherwise>
				</c:choose>
				</li>
			</ul>
		</div>
		<div>
			<h2><fmt:message key="myAccount.myDesign"/></h2>
			<ul>
				<fmt:message var="savedCover" key="myAccount.savedCovers" />
					<c:choose>
						<c:when test="${activeTab == 'SAVEDCOVER'}">
							<li>
								<dsp:a page="#" title="${savedCover}">
									<b>${savedCover}</b>
								</dsp:a>
						</c:when>
						<c:otherwise>
							<li>
							<dsp:a page="#" title="${savedCover}">
								${savedCover}
							</dsp:a>
						</c:otherwise>
					</c:choose>
					</li>

					<fmt:message var="roomPlanner" key="myAccount.roomPlanner" />
					<c:choose>
						<c:when test="${activeTab == 'ROOMPLANNER'}">
							<li>
								<dsp:a page="#" title="${roomPlanner}">
									<b>${roomPlanner}</b>
								</dsp:a>
						</c:when>
						<c:otherwise>
							<li>
								<dsp:a page="#" title="${roomPlanner}">
									${roomPlanner}
								</dsp:a>
						</c:otherwise>
					</c:choose>
					</li>
			</ul>
			</div>
	</dsp:layeredBundle>
</dsp:page>