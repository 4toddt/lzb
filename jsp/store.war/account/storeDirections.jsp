<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

		<jsp:attribute name="bodyClass">npc mapping</jsp:attribute>

		<jsp:attribute name="pageSpecificJS">
			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?client=gme-lazboy&sensor=false&v=3.7"></script>
			<script type="text/javascript" src="/js/mapping.js?ver=${assetVersion}"></script>
		</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
			<main role="main">
				<dsp:include page="/includes/leftnavigation.jsp"/>

				<section role="region" class="my-account-content">

		<h1>Directions</h1>
		<div id="preferredStoreContainer">
			<dsp:getvalueof bean="Profile.id" var="profileId" />
			<dsp:getvalueof bean="Profile.preferredStore" var="preferredStore" />

			<h2>test</h2>
			<div class="preferred-store-map">
				 <div id="map-canvas"></div>

				<button class="btn-primary preferred-store-directions-btn">GET
					DIRECTIONS</button>
			</div>
			<div id="storeInfoContainer">
				<div class="preferred-store-address">
					<h3>Direction to Store</h3>

				</div>
			</div>

		</div>

				</section>
				</main>

	</lzb:pageContainer>

</dsp:page>
