<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:getvalueof var="storeId" param="storeId"/>
	<!-- for displaying current store -->
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

		<c:choose>
			<c:when test="${not empty preferredStore}">

				<h2><fmt:message key="storeLocator.preferredStore"/></h2>

				<dsp:getvalueof var="store" value="${preferredStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}"/>

			</c:when>

			<c:otherwise>

 				<h2><fmt:message key="preferdStore.storeNearest"/></h2>

				<dsp:getvalueof var="store" value="${currentStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}"/>

			</c:otherwise>

		</c:choose>
		
		<c:choose>
			<c:when test="${not empty store}">
				<input type="hidden" id="storeAvailable" value="storeAvailable" />
			</c:when>
			<c:otherwise>
				<input type="hidden" id="storeAvailable" value="" />
			</c:otherwise>
		</c:choose>
		<c:if test="${not empty store }">
			<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>
			<h3 class="pref-head">${store.name}</h3>
			<p>${store.address1} ${store.address2} ${store.address3}</p>
			<p>${store.city}, ${store.stateAddress} , ${store.postalCode}</p>
			<p> <%-- ${currentStore.phoneNumber} --%>${store.phoneNumber}</p>
			<!-- for FEI use to get directions -->
			<input type="hidden" id="latitude" value="${store.latitude}"/>
			<input type="hidden" id="longitude" value="${store.longitude}"/>
			<input type="hidden" value="${store.address1} ${store.address2} ${store.address3}" id="mapsAddress1">
			<input type="hidden" value="${store.city}, ${store.stateAddress} , ${store.postalCode}" id="mapsAddress2">

			<c:choose>
				<c:when test="${ not empty webUrl}">
					<c:choose>
						<c:when test="${fn:contains(webUrl,'http://') }">
							<dsp:getvalueof var="url" value="${webUrl}"/>
						</c:when>
						<c:otherwise>
							<dsp:getvalueof var="url" value="${webUrl}"/>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise>
					<dsp:getvalueof var="url" value="#"/>
				</c:otherwise>
			</c:choose>
			
			<dsp:a href="${url}" iclass="btn-secondary" id="view-store-website"><fmt:message key="storeLocator.visit"/></dsp:a>

			<a href="#" id="getStoreDirections" class="btn-primary directions" data-store-id="${store.locationId}" data-store-address="${store.address1} ${store.address2} ${store.address3},${store.city}, ${store.stateAddress} , ${store.postalCode}"><fmt:message key="preferdStore.getDirectionCaps"/></a>

			<c:if test="${not empty store.storeApptUrl}" >
				<dsp:a href="${store.storeApptUrl}" target="_blank" iclass="btn-appt"><fmt:message key="storeLocator.prvtAppt"/></dsp:a>		
			</c:if>
		</c:if>

				<form id="directionsForm" action="#" method="post">

					<a id="closeSearch">Close [X]</a>

					<fieldset>

						<legend>Get Directions</legend>

						<fieldset>

							<legend>Starting Address</legend>

							<label data-label="A" for="directionsStart" title="Start Address">A</label>
							<input type="text" id="directionsStart" value="" placeholder="Start Address" />

						</fieldset>

						<fieldset>

							<legend>Destination Address</legend>

							<label data-label="B" for="directionsDestination" title="Destination Address">B</label>

							<c:choose>
								<c:when test="${not empty storeId}">

								<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBStoreLocatorByCoordinatesDroplet"/>	
								<dsp:droplet name="LZBStoreLocatorByCoordinatesDroplet">

									<dsp:oparam name="output">
										<dsp:getvalueof var="store" param="store" />

							<c:choose>
								<c:when test="${not empty store}">

							<%-- ${store.address1} ${store.address2} ${store.address3}, ${store.city}, ${store.stateAddress} , ${store.postalCode} --%>
							<input type="text" id="directionsDestination" value="${fn:trim(store.address1)} ${fn:trim(store.address2)} ${fn:trim(store.address3)}, ${fn:trim(store.city)}, ${fn:trim(store.stateAddress)} ${fn:trim(store.postalCode)}" placeholder="Destination Address" />

								</c:when>
								<c:otherwise>

							<input type="text" id="directionsDestination" value="" placeholder="Destination Address" />

								</c:otherwise>
							</c:choose>

									</dsp:oparam>

								</dsp:droplet>

								</c:when>
								<c:otherwise>
							<input type="text" id="directionsDestination" value="" placeholder="Destination Address" />
								</c:otherwise>
							</c:choose>

							<a href="#" class="btn-secondary get-directions">Get Directions</a>

						</fieldset>

					</fieldset>

				</form>

				<div id="directions-panel"></div>

	</dsp:layeredBundle>

</dsp:page>
