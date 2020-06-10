<nav role="navigation" class="account secondary-nav hide-for-small">
	<div class="nav-title"><a href="/account/account.jsp">My Account</a></div>
	<ul>
		<li class="nav-item">
			<a href="${contextPath}/account/profile.jsp">Profile <span class="icon icon-arrow-right"></span></a>
		</li>
		<li class="nav-item">
			<a href="${contextPath}/account/preferredStore.jsp">My Preferred Store <span class="icon icon-arrow-right"></span></a>
		</li>
		<li class="nav-item">
			<a href="${contextPath}/account/orderHistory.jsp">Order History <span class="icon icon-arrow-right"></span></a>
		</li>
		<li class="nav-item">
			<a href="${contextPath}/account/wish_list_items.jsp">My Wishlist <span class="icon icon-arrow-right"></span></a>
		</li>
		<li class="logout"><a id="loggedInUseranchor" href="${contextPath}/index.jsp" title="logout">Sign Out</a></li>
	</ul>
	<div class="nav-title">
		<a href="${contextPath}/designcenter/designhome.jsp?tab=1">
			My Design Center
		</a>
		<div class="triangle"></div>
	</div>
	<ul>
		<li class="nav-item">
			<a href="${contextPath}/designcenter/designhome.jsp?tab=2">Saved Covers <span class="icon icon-arrow-right"></span></a>
		</li>
		<li class="nav-item">
			<a href="${contextPath}/designcenter/designhome.jsp?tab=3">Room Planner</a>
		</li>
	</ul>
</nav>