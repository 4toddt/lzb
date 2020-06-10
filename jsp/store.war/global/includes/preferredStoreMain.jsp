<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBDisplayPreferredStoreDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<jsp:attribute name="bodyClass">npc mapping</jsp:attribute>

		<script type="text/javascript"
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAc1fmsu5Hj0aGte7S7llCO7KTgEgZ0BJg"></script>
		<script type="text/javascript" src="/js/mapping.js?ver=${assetVersion}"></script>

		<dsp:getvalueof var="preferredStore" param="preferredStore" />

		<main role="main">


		<section role="region" class="profile-account-content">

			<h1>My Preferred Store-<p>${preferredStore.name}</p></h1>
			<div id="preferredStoreContainer">


				<div id="storeInfoContainer">
					<div class="preferred-store-address">

						<h3>Store Address</h3>
						<c:choose>
							<c:when test="${not empty preferredStore}">
								<p>${preferredStore.name}</p>
								<address>
									${preferredStore.address1} ${preferredStore.address2}
									${preferredStore.address3}<br> ${preferredStore.city},
									${preferredStore.stateAddress} ${preferredStore.postalCode}<br>



									<span class="preferred-store-phone">xxx-xxx-xxx</span> <input
										type="hidden"
										value="${preferredStore.address1} ${preferredStore.address2} ${preferredStore.address3}"
										id="mapsAddress1"> <input type="hidden"
										value="${preferredStore.city}, ${preferredStore.stateAddress}  ${preferredStore.postalCode}"
										id="mapsAddress2">
								</address>
								<a href="${preferredStore.storeWebsiteUrl}" target="_blank"></a>
								<button class="btn preferred-store-website btn-primary">Store
									Website</button>
								</a>
							</c:when>
							<c:otherwise>
								<p>
									<fmt:message key="preferred.noStores" />
								</p>
							</c:otherwise>
						</c:choose>
					</div>

					<div class="preferred-store-hours">

						<h3>Store Hours</h3>
						<ul>${preferredStore.storeHourUrl}
						</ul>

					</div>
					<div class="find-more-stores">
						<div>
							<h3>Find more stores near you</h3>
							<dsp:include
								src="${originatingRequest.siteBaseUrl}/storeLocator/storeLocator.jsp">
								<dsp:param value="true" name="preferredStore" />
							</dsp:include>
						</div>
						<div >
							<h3>Store Results</h3>
							<div class="storeResultContainer">
								<dsp:include
									src="${originatingRequest.siteBaseUrl}/storeLocator/storeResults.jsp">
									<dsp:param value="true" name="preferredStore" />
								</dsp:include>
							</div>
						</div>

					</div>
				</div>
				<div class="preferred-store-map">
					<c:choose>
						<c:when test="${not empty preferredStore}">
							<div id="map-canvas"></div>

							<a href="${pageContext.request.contextPath}/storeLocator/getDirections.jsp"><button
									class="btn-primary preferred-store-directions-btn">GET
									DIRECTIONS</button></a>
						</c:when>
					</c:choose>
				</div>
			</div>

		</section>
		</main>

	</lzb:pageContainer>

</dsp:page>
