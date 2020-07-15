<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<jsp:attribute name="title">Profile</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />


		<main role="main">
			<main role="main">
				<dsp:include page="/includes/designInspirationsNav.jsp">
					<dsp:param name="selpage" value="ROOM_PLANNER" />
				</dsp:include>

				<section role="region" class="cust-support design-inspiration">

					<h1>Design Inspirations</h1>

					<include file="includes/home/carousel.html"></include>

					<div class="cust-contant">
						<div class="teaser-box">
							<img src="http://placehold.it/245x175" alt="plaholder image">
							<h2>Room Inspirations</h2>
							<p>Find the room that inspire you! Add some text copy to have a better info scent for the shopper to click on.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="teaser-box">
							<img src="http://placehold.it/245x175" alt="plaholder image">
							<h2>3D Room Planner</h2>
							<p>Enter your room’s dimensions, then drag-and-drop furniture to see what fits best.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="teaser-box">
							<img src="http://placehold.it/245x175" alt="plaholder image">
							<h2>Style Finder</h2>
							<p>Use our Style Finder and discover the perfect look for you. Add some text copy for better info scent.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="teaser-box">
							<img src="http://placehold.it/245x175" alt="plaholder image">
							<h2>Room Measuring</h2>
							<p>We want to make sure what you pick out will, in fact, work inside your home. Following these steps will help you pick the appropriate furniture.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="teaser-box">
							<img src="http://placehold.it/245x175" alt="plaholder image">
							<h2>Free In Home Design</h2>
							<p>Comfort, style, fabrics, leathers, accessories ... leave it to the pros! The service is free and the results are priceless..</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
					</div>

				</section>
			</main>

	</lzb:pageContainer>

</dsp:page>
