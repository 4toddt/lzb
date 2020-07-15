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

				<section role="region" class="cust-support">

					<h1>Free In-Home Design</h1>
					<img src="http://placehold.it/775x400" alt="alt text goes here" />

					<h2>It’s like a personal stylist for your home</h2>
					<p>
						Discover the possibilities! At La-Z-Boy Furniture Galleries,
						our design professionals will come to your home and help turn your
						dreams into reality. From finding the perfect colors and fabrics to
						choosing the right accessories, we’ll work with you to bring your
						room together. The service is free and the results are priceless.
					</p>

					<div class="cust-contant">
						<div class="hme-design">
							<img src="http://placehold.it/175x150" alt="Free In-Home Design" />
							<p>
								<strong>Professional design staff trained and certified
									by La-Z-Boy</strong>
							</p>
							<p>Let our certified designers help you discover the
								possibilities with our Free In-Home Design.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="hme-design">
							<img src="http://placehold.it/175x150" alt="Free In-Home Design" />
							<p>
								<strong>3D Room Planner</strong>
							</p>
							<p>Quickly and easily bring your dream rooms to life in amazing
								3D visual reality with our 3D Room Planner.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="hme-design">
							<img src="http://placehold.it/175x150" alt="Free In-Home Design" />
							<p>
								<strong>Customize It</strong>
							</p>
							<p>Comfort, it’s in the details! Customize your perfect piece
								of La-Z-Boy furniture from power to pillows.</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
						<div class="hme-design">
							<img src="http://placehold.it/175x150" alt="Free In-Home Design" />
							<p>
								<strong>Find a local store</strong>
							</p>
							<p>Find your local store and inquire about our In-Home Design
								services today!</p>
							<a href="#" class="triangle-forwards">Learn more</a>
						</div>
					</div>

				</section>
			</main>

	</lzb:pageContainer>

</dsp:page>
