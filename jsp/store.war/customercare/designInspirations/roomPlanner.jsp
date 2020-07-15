<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="title">Profile</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />


		<main role="main"> <main role="main"> <dsp:include
			page="/includes/designInspirationsNav.jsp">
			<dsp:param name="selpage" value="ROOM_PLANNER" />
		</dsp:include>

					<section role="region" class="cust-support">

				<h1>3D Room Planner</h1>

				<img class="hero-banner" src="http://placehold.it/775x400" alt="alt text goes here" />

				<figure>

					<img src="http://placehold.it/100x100" alt="plaholder image">

					<figcaption>

						<h2>Create new designs in every dimension.</h2>

						<p>Design the perfect room and bring it to life with the new La-Z-Boy 3D Room Planner. Quickly and
						easily create, redecorate and rearrange your room without any of the usual heavy lifting. Customize
						furniture and fabrics, add windows and doors, select floors... even change the color of walls, without
						lifting a finger. You can even share pictures of your room creations with your family and friends.
						Ready to turn your dreams into reality?</p>

						<a href="#" class="triangle-forwards">Learn About Our New Planner</a>

						<a class="btn-primary">launch 3d Room Planner</a>

					</figcaption>

				</figure>

			</section>
		</main>
	</lzb:pageContainer>
</dsp:page>
