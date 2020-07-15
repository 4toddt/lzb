<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<!-- This used for to display profile dash board content -->

	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<lzb:breadCrumb pageKey="breadcrumb.dashboard" divClass="breadcrumb" /><br />
		<dsp:getvalueof var="firstName" bean="ProfileFormHandler.value.firstName" />
		<dsp:getvalueof var="lastName" bean="ProfileFormHandler.value.lastName" />
		<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
		
		<%--Bread crumb --%>
		
		<%-- Display left-side menu with selected   --%>
		
	<table>
			<tr>
				<td>
					<dsp:include page="/account/gadgets/myAccountMenu.jsp">
				        <dsp:param name="selpage" value="" />
				    </dsp:include>				
				</td>
				
				<td>
					<h1>My Account</h1>
					<div>
						<c:choose>
							<c:when test="${not empty firstName }">
								<span>Hello,&nbsp;${firstName}&nbsp;${lastName}</span>
							</c:when>
							<c:otherwise>
								<span>Welcome</span>
							</c:otherwise>
						</c:choose>
						<br>
						Want to personalize your experience?<br> Complete your profile
						so we can match your preferences.
					</div>
					<br>
					<div>
						<dsp:a href="/account/profile.jsp">Profile</dsp:a>
						<br> Make changes to your account information, login, password
						and subscription preferences. <br>
						<br>
						<!-- <dsp:a href="/account/myOrders.jsp">Order History</dsp:a> -->
						<dsp:a href="/account/orderHistory.jsp">Order History</dsp:a>
						<br> View order history and status of current and completed
						orders.
					</div>
					<br>
					<div>
						<dsp:a href="/account/preferredStore.jsp">My Preferred Store</dsp:a>
						<br> Set your local store to ensure accurate pricing, delivery
						estimates, store hours and more.<br>
						<%-- JIRA DMI-1763 Hide Wishlist UI
						<br>
						<dsp:a href="/account/wish_list_items.jsp">My Wishlist</dsp:a>
						<br> Create a list of your favorite items to share with family
						and friends or send it to your local store to check availability.
						--%>
					</div>
				</td>
			</tr>
		</table>	
	</dsp:layeredBundle>
</dsp:page>