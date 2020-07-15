<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

        <main role="main">

            <nav role="navigation" class="account secondary-nav">

				<div class="nav-title">My Account<div class="triangle"></div></div>
				<ul>
					<li class="nav-item"><a href="#">Profile</a></li>
					<li class="nav-item"><a href="#">My Preferred Store</a></li>
					<li class="nav-item"><a href="#">Address Book</a></li>
					<li class="nav-item"><a href="#">Order History</a></li>
					<%-- JIRA DMI-1763 Hide Wishlist UI
					<li class="nav-item"><a href="#">My Wishlist</a></li>
					--%>
					<li class="nav-item"><a href="#">Payment Methods</a></li>
					<li><div class="logout">Logout</div></li>
				</ul>
				<div class="nav-title">My Design Center</div>
				<ul>
					<li class="nav-item"><a href="#">Saved Covers</a></li>
					<li class="nav-item"><a href="#">Room Planner</a></li>
				</ul>
            </nav>

            <section role="region" class="my-account-content">
				<h1>My Wishlist</h1>
				<div class="standard-border"><div class="info"><div class="info-mark">i</div></div>You have not items in your Wishlist. Add product to your Wishlist. <a href="#">Continue Shopping</a></div>
				<div>You ahve not itmes in your Wishlist. <a href="#">Get Started</a> &mdash; click on the heart icon next to any product to save it to your list.</div>
            </section>

        </main>

	</lzb:pageContainer>
</dsp:page>