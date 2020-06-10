
<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
	<dsp:getvalueof var="activeTab" param="selpage" />

	<nav role="navigation" class="account secondary-nav">
		<dsp:importbean bean="/atg/dynamo/servlet/RequestLocale" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

		<div class="nav-title">My Account</div>
		<ul>
			<c:choose>
				<c:when test="${activeTab == 'PREFERREDSTORE'}">
					<li class="nav-item current"><b>${prefStore}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/contactUs.jsp">Contact Us</a>
			</li>
			<c:choose>
				<c:when test="${activeTab == 'ADDRESSBOOK'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>
			<a href="/customercare/FAQ.jsp">FAQ</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'ORDERHISTORY'}">
					<li class="nav-item current">
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>


			<a href="/customercare/customerCareVideo.jsp">Customer Care
				Videos</a>
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
			--%>

			<a href="/customercare/productRegContent.jsp">Product
				Registration</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'PAYMENTMETHODS'}">
					<li class="nav-item current"><b>${paymentMethods}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>

			<a href="/customercare/warrantyInfo.jsp">Warranty Information</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'PAYMENTMETHODS'}">
					<li class="nav-item current"><b>${paymentMethods}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>

			<a href="/customercare/warrantyClaims.jsp">Warranty Claims</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'PAYMENTMETHODS'}">
					<li class="nav-item current"><b>${paymentMethods}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>

			<a href="/customercare/returnPolicy.jsp">Return Polciy</a>
			</li>

			<c:choose>
				<c:when test="${activeTab == 'PAYMENTMETHODS'}">
					<li class="nav-item current"><b>${paymentMethods}</b>
				</c:when>
				<c:otherwise>
					<li class="nav-item">
				</c:otherwise>
			</c:choose>

			<a href="/customercare/securityPrivacy.jsp">Security&nbsp;&amp;&nbsp;Privacy</a>
			</li>
		</ul>
		<div class="vcard">

			<strong>Your Local Store</strong> <strong>Plano La-Z-Boy
				Furniture Galleries</strong>

			<div class="adr">

				<div class="street-address">1708 N. Central Expwy</div>

				<span class="locality">Plano</span>,&nbsp;<abbr class="region"
					title="Texas">TX</abbr>&nbsp;<span class="postal-code">75074</span>
				<a href="tel:+19725163208" class="tel">972-516-3208</a>

			</div>

			<a href="#" class="triangle-forwards">Change my store</a> <a href="#"
				class="triangle-forwards">View Store Directions</a> <a href="#"
				class="triangle-forwards">Get Directions</a>

		</div>
	</nav>


</dsp:layeredBundle>