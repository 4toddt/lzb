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
					<dsp:param name="selpage" value="ROOM_MEASURING" />
				</dsp:include>

				<section role="region" class="cust-support">

					<h1>Room Measuring</h1>
					<img src="http://placehold.it/775x400" alt="alt text goes here" />

					<h2>Remember: measure twice and pick once.</h2>
					<p>
						We want to make sure what you pick out will, in fact, work
						inside your home. Following these steps will help you pick the
						appropriate furniture for the desired space.
					</p>

					<div class="cust-contant style-measure">
						<div class="room-measure">
							<img src="http://placehold.it/100x100" alt="plaholder image">
							<div class="insps-txt">
								<h3>1. Will It Fit In My Space?</h3>
								<p>Check the standard dimensions listed for the piece you are
									considering. Note all the numbers for width x depth x height
									(e.g., 87.5” W x 38” D x 36.5” H). It’s also a good idea to
									consider the diagonal dimensions of the furniture you want. These
									measurements will be helpful when planning your space.</p>
							</div>
						</div>
						<div class="room-measure">
							<img src="http://placehold.it/100x100" alt="plaholder image">
							<div class="insps-txt">
								<h3>2. Will It Work In My Space?</h3>
								<p>
									Now it’s time to consider the measurements and decide if the
									piece you want is going to work. Will it block any entrances?
									Would another piece fill the space better? Designers recommend
									making paper cutouts that matches the width and depth of the
									furniture and place the pieces on the floor. Download our <a
										href="#">Room Grid</a> or use our <a href="#">Room Planner</a>
									as a handy tool that can help you with room arrangements.
								</p>
							</div>
						</div>
						<div class="room-measure">
							<img src="http://placehold.it/100x100" alt="plaholder image">
							<div class="insps-txt">
								<h3>3. Is There Room To Maneuver?</h3>
								<p>
									Be sure to measure the entryways, doors, height clearances and
									stairways to make sure the piece you want can make it into the
									desired location. Also note obstacles such as, lights, railings,
									ceiling fans, etc.. If the numbers look good, you’re ready to
									order. Stop in your local <a href="#">La-Z-Boy dealer</a> and
									we’ll get started.
								</p>
							</div>
						</div>
					</div>

				</section>
			</main>

	</lzb:pageContainer>

</dsp:page>
