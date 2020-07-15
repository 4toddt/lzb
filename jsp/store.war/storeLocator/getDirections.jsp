<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
		<dsp:getvalueof var="transient" bean="Profile.transient" />
		<jsp:attribute name="bodyClass">npc mapping</jsp:attribute>
		<jsp:attribute name="pageSpecificJS">
			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?client=gme-lazboy&sensor=false&v=3.7"></script>
			<script type="text/javascript" src="/js/mapping.js?ver=${assetVersion}"></script>
		</jsp:attribute>
		<jsp:attribute name="seoAlternateURL"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

		<c:choose>
			<c:when test="${ transient eq 'false' }">
				<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
			</c:when>
			<c:otherwise>
				<lzb:breadCrumb pageKey="breadcrumb.storeLocator" divClass="breadcrumb" />
			</c:otherwise>
		</c:choose>

			<main role="main">

				<c:if test="${ transient eq 'false' }">
					<%--If user logged in show the account laft navigation --%>
					<dsp:include page="/includes/leftnavigation.jsp">
						<dsp:param name="selpage" value="PREFERREDSTORE" />
					</dsp:include>
				</c:if>

				<section role="region" class="my-account-content">
					<h1><fmt:message key="preferdStore.getDirection"/></h1>
					<div id="preferredStoreContainer">
						<dsp:getvalueof bean="Profile.id" var="profileId" />
						<dsp:getvalueof bean="Profile.preferredStore" var="preferredStore" />

						<c:choose>
							<c:when test="${not empty preferredStore}">
								<dsp:getvalueof value="${preferredStore}" var="preferredStore" />
							</c:when>
							<c:otherwise>
								<dsp:getvalueof bean="Profile.currentStore" var="preferredStore" />
							</c:otherwise>
						</c:choose>

						<h2><fmt:message key="preferred.store"/> - ${preferredStore.name}</h2>
						<div class="preferred-store-map">

							<div class="inline">
								<div id="map-canvas"></div>
							</div>
						</div>
						<div class="inline">
							<div id="directions-panel"></div>
						</div>
						<h2><fmt:message key="preferred.storeAddress"/><%-- Starting Address --%>:</h2>
						<div>
							<input type="text" id="startLocation"></br>
							<button class="btn-primary btn-directions" id="startLocationBtn"><fmt:message key="preferdStore.getDirectionCaps"/></button>
						</div>
						<div class="preferred-store-address">

							<h3><fmt:message key="preferred.storeAddress"/></h3>
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

							<c:if test="${not empty preferredStore.parentDealerNumber}">
								<dsp:droplet name="LZBDealerStoreDroplet">
									<dsp:param name="parentDealerId" value="${preferredStore.parentDealerNumber}"/>
									<dsp:oparam name="output">
										<dsp:getvalueof var="parentDealer" param="parentDealer" />
										<dsp:getvalueof var="webUrl" param="parentDealer.websiteURL"/>
										<dsp:getvalueof var="storePhoneNum" param="parentDealer.phone"/>
									</dsp:oparam>
									<dsp:oparam name="empty">
									</dsp:oparam>
								</dsp:droplet>
							</c:if>
							<c:choose>
								<c:when test="${ not empty webUrl}">
									<c:choose>
										<c:when test="${fn:contains(webUrl,'http://') }">
											<dsp:getvalueof var="url" value="${webUrl}"/>
										</c:when>
										<c:otherwise>
											<dsp:getvalueof var="url" value="http://${webUrl}"/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<dsp:getvalueof var="url" value="#"/>
								</c:otherwise>
							</c:choose>

							<button class="btn preferred-store-website btn-primary"><fmt:message key="storePopUp.storeWebsite"/></button>
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
