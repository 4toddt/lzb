<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

		<jsp:attribute name="bodyClass">npc mapping</jsp:attribute>

		<jsp:attribute name="pageSpecificJS">
			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc1fmsu5Hj0aGte7S7llCO7KTgEgZ0BJg"></script>
			<script type="text/javascript" src="/js/mapping.js?ver=${assetVersion}"></script>
		</jsp:attribute>


		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
			<main role="main">
				<dsp:include page="/includes/leftnavigation.jsp"/>

				<section role="region" class="my-account-content">

		<h1>Store Locator</h1>
		<div id="preferredStoreContainer">
			<dsp:getvalueof bean="Profile.id" var="profileId" />
			<dsp:getvalueof bean="Profile.preferredStore" var="preferredStore" />

			<h2>My Store Locator</h2>
			<div class="preferred-store-map">
				 <div id="map-canvas"></div>

				<a href="/account/storeDirections.jsp"></a><button class="btn-primary preferred-store-directions-btn">GET
					DIRECTIONS</button></a>
			</div>
			<div id="storeInfoContainer">
				<div class="preferred-store-address">

					<h3>Store Address</h3>
					<address>
						${preferredStore.address1} ${preferredStore.address2} ${preferredStore.address3}<br> ${preferredStore.city}, ${preferredStore.stateAddress}  ${preferredStore.postalCode}<br> <span
							class="preferred-store-phone">972-516-3208</span>
					</address>
					<button class="btn preferred-store-website btn-primary">Visit
						Store Website</button>
				</div>

				<div class="preferred-store-hours">

					<h3>Store Hours</h3>
					<ul>
						<fmt:message key="preferred.storeHours"/>
					</ul>

				</div>

			</div>

		</div>

				</section>
				</main>

	</lzb:pageContainer>

</dsp:page>
