<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBDisplayPreferredStoreDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<jsp:attribute name="bodyClass">npc mapping</jsp:attribute>

		<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc1fmsu5Hj0aGte7S7llCO7KTgEgZ0BJg"></script>
		<script type="text/javascript" src="/js/mapping.js?ver=${assetVersion}"></script>

		<dsp:getvalueof var="preferredStore" var="preferredStore" />

<main role="main">

		<section role="region" class="profile-account-content">

			<h1>Get Directions</h1>
			<div id="preferredStoreContainer">


				<h2>My Preferred Store - <p>${preferredStore.name}</p></h2>
				<div class="preferred-store-map">

					<div class="inline">
						<div id="map-canvas"></div>
					</div>
				</div>
				<div class="inline">
					<div id="directions-panel"></div>
				</div>
				<h2>Starting Address:</h2>
				<div>
					<input type="text" id="startLocation"></br>
					<button class="btn-primary btn-directions" id="startLocationBtn">GET
						DIRECTIONS</button>
				</div>
				<div class="preferred-store-address">

					<h3>Store Address</h3>
					<p>${preferredStore.name}</p>
					<address>
						${preferredStore.address1} ${preferredStore.address2}
						${preferredStore.address3}<br> ${preferredStore.city},
						${preferredStore.stateAddress} ${preferredStore.postalCode}<br>


						<span class="preferred-store-phone">todo- add in phone
							number bean</span> <input type="hidden"
							value="${preferredStore.address1} ${preferredStore.address2} ${preferredStore.address3}"
							id="mapsAddress1"> <input type="hidden"
							value="${preferredStore.city}, ${preferredStore.stateAddress}  ${preferredStore.postalCode}"
							id="mapsAddress2">
					</address>
					<a href="#" target="_blank"></a>
					<button class="btn preferred-store-website btn-primary">Store
						Website</button>
					</a>
				</div>
			</div>

			</div>
			<script>
		$( "#startLocationBtn" ).click(function() {
			calcRoute()
			});
		</script>

		</section>
		</main>
	</lzb:pageContainer>

</dsp:page>
