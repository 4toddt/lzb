<dsp:page>

<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:getvalueof var="transient" bean="Profile.transient" />

<lzb:pageContainer>
			<jsp:attribute name="bodyClass">npc</jsp:attribute>
			<lzb:breadCrumb pageKey="breadcrumb.dashboard" divClass="breadcrumb" />
			<main role="main">
				<dsp:include page="/includes/leftnavigation.jsp"/>

				<section role="region" class="my-account-content">

					<h1>My Account</h1>

					<div class="account-content standard-border">

						<dsp:getvalueof var="firstName" bean="Profile.firstName" />

						<c:choose>

							<c:when test="${firstName != null }">
							<h2>Hello, ${firstName}</h2>
							</c:when>

							<c:otherwise></c:otherwise>

						</c:choose>

						<p class="account-heading">Use the available options below or the left navigation to manage your account with us.</p>

						<div class="content-options">

							<div class="options-wrapper">

								<a href="/account/profile.jsp">Profile</a>

								<p>Modify your name, your account login and password. Manage your &ldquo;subscription&rdquo; preferences.</p>

							</div>

							<div class="options-wrapper">
								<a href="/account/orderHistory.jsp">Order History</a>
								<p>View your order history.</p>
							</div>
							<div class="options-wrapper">
								<a href="/account/preferredStore.jsp">My preferred store</a>
								<p>Set your local store to ensure accurate pricing, delivery estimates, store hours and more.</p>
							</div>
							<%-- JIRA DMI-1763 Hide Wishlist UI
							<div class="options-wrapper">
								<a href="/account/wish_list_items.jsp">My wishlist</a>
								<p>Create a list of your favorite items to share with family and friends or send it to your local store to check availability.</p>
							</div>
							--%>
						</div>
					</div>

				</section>
				</main>

	</lzb:pageContainer>

</dsp:page>
