<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
		<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
		<dsp:importbean bean="/com/lzb/droplet/LZBGoogleMapURLSigner" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.preferredStore" divClass="breadcrumb" />

		<c:if test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
			<dsp:include page="/global/errors.jsp">
				<dsp:param name="formHandler" bean="LZBStoreLocatorFormHandler" />
			</dsp:include>
			</div></div>
		</c:if>

		<main role="main"> <dsp:include page="/includes/leftnavigation.jsp">
			<dsp:param name="selpage" value="PREFERREDSTORE" />
		</dsp:include>

		<%--<section role="region" class="my-account-content" data-module="preferred-store">--%>
		<section role="region" class="my-account-content">

			<h1><fmt:message key="preferred.store"/></h1>

                <div id="preferredStoreContainer" class="preferred-store-container">

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


				<h2><fmt:message key="preferred.store"/></h2>

				<div id="storeInfoContainer">
					<div class="preferred-store-address">

						<h3><fmt:message key="preferred.storeAddress"/></h3>
						<c:choose>
							<c:when test="${not empty preferredStore}">

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

								<p>${preferredStore.name}</p>
								<address>
									${preferredStore.address1} ${preferredStore.address2}
									${preferredStore.address3}<br> ${preferredStore.city},
									${preferredStore.stateAddress} ${preferredStore.postalCode}<br>

									<span class="preferred-store-phone"><dsp:getvalueof var="storePhoneNum" param="parentDealer.phone"/></span>
									<input type="hidden" value="${preferredStore.address1} ${preferredStore.address2} ${preferredStore.address3}" id="mapsAddress1">
									<input type="hidden" value="${preferredStore.city}, ${preferredStore.stateAddress}  ${preferredStore.postalCode}" id="mapsAddress2">
								</address>
								<dsp:getvalueof var="webUrl" value="${preferredStore.storeWebsiteUrl }"/>
								<c:choose>
									<c:when test="${ not empty webUrl}">
										<c:choose>
											<c:when test="${fn:contains(webUrl,'http://') }">
												<dsp:getvalueof var="storeURL" value="${webUrl}"/>
											</c:when>
											<c:otherwise>
												<dsp:getvalueof var="storeURL" value="${webUrl}"/>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<dsp:getvalueof var="storeURL" value="#"/>
									</c:otherwise>
								</c:choose>

								<a href="${storeURL}" target="_blank">
									<button class="btn preferred-store-website btn-primary"><fmt:message key="preferred.visit"/><!-- Store Website --></button>
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

						<h3><fmt:message key="preferred.storeHours"/></h3>
						<ul>${preferredStore.storeHourUrl}
						</ul>

					</div>
					<div class="find-more-stores">
						<div>
							<h3><fmt:message key="preferred.findStores"/></h3>


							<dsp:form id="storeLocator" name="storeLocator" action="#" method="post" >
								<fieldset>
									<div>
										<dsp:input type="text" name="locator" id="locator" bean="LZBStoreLocatorFormHandler.valueMap.state" maxlength="25" />
										<dsp:input type="hidden" name="La-Z-Boy Home Furnishings & D�cor" bean="LZBStoreLocatorFormHandler.valueMap.homeFurnishings" value="false" />
										<dsp:input type="hidden" name="La-Z-Boy Furniture Galleries" bean="LZBStoreLocatorFormHandler.valueMap.furnitureGalleries" value="false" />
										<dsp:input type="hidden" name="La-Z-Boy Comfort Studio"  bean="LZBStoreLocatorFormHandler.valueMap.comfortStudio" value="false" />
										<dsp:input type="hidden" name="Other La-Z-Boy Retailers" id="locator" bean="LZBStoreLocatorFormHandler.valueMap.retailers" value="false" />
										<dsp:input type="submit" value="Find" name="findStore"	id="findStore" bean="LZBStoreLocatorFormHandler.locate" iclass="btn-primary" required="true"/>
									</div>
								</fieldset>
								<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
								<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${siteBaseUrl}/account/preferredStore.jsp"/>
							</dsp:form>
						</div>

<%-- 						<dsp:getvalueof var="storeList" bean="LZBStoreLocatorFormHandler.storeList"/>
						<c:if test="${not empty storeList}">
							<div id="storeResultsContainer">
								<fmt:message key="preferred.storeResult"/>
								<dsp:include
									src="${originatingRequest.siteBaseUrl}/storeLocator/storeResults.jsp">
									<dsp:param value="true" name="preferredStore" />
								</dsp:include>
							</div>
						</c:if>
						 --%>

					</div>
				</div>
				<div class="preferred-store-map">
					<c:choose>
						<c:when test="${not empty preferredStore}">
							<div class="map">
								<dsp:droplet name="LZBGoogleMapURLSigner">
									<dsp:param name="inputURL" value="https://maps.googleapis.com/maps/api/staticmap?center=${preferredStore.latitude},${preferredStore.longitude}&zoom=14&size=308x320&markers=icon:https://content.la-z-boy.com/Images/storelocator/galleries_fg.png%7C${preferredStore.latitude},${preferredStore.longitude}&style=feature:poi%7Cvisibility:off&client=gme-lazboy"/>
									<dsp:oparam name="output">
										<dsp:getvalueof var="signedURL" param="signedURL" />
									</dsp:oparam>
									<dsp:oparam name="empty">
									</dsp:oparam>
								</dsp:droplet>

								<img src="${signedURL}" />
							</div>
							<a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp?storeId=${preferredStore.locationId}"  class="btn-primary preferred-store-directions-btn"><fmt:message key="preferdStore.getDirection"/></a>
						</c:when>
					</c:choose>
				</div>
			</div>

		</section>

    				<c:choose>
						<c:when test="${empty preferredStore}">

<script>

var __latLong = {
		"lat" : "${SessionBeanvar.lattitude}",
		"long" : "${SessionBeanvar.longitude}"
}

var __locatorResults = [

        				{
        					"map" : [
        						{
        							"storename" : "NA"
        						}
        					],
        					"stores" : [
        						{
        							"storename" : "NA"
        						}
        					]
        				}

        			]

</script>

				</c:when>
				<c:when test="${not empty preferredStore}">

<script>

var __latLong = {
		"lat" : "${SessionBeanvar.lattitude}",
		"long" : "${SessionBeanvar.longitude}"
}

var __locatorResults = [

				{
					"map" : [
					 {
						"storename":"${fn:trim(preferredStore.name)}",
						"address1": "${fn:trim(preferredStore.address1)}",
						"address2": "${fn:trim(preferredStore.address2)}",
						"address3": "${fn:trim(preferredStore.address3)}",
						"city":"${preferredStore.city}",
						"state":"${preferredStore.stateAddress}",
						"zip":"${preferredStore.postalCode}",
						"country":"${preferredStore.country}",
						"storeID":"${preferredStore.locationId}",
						"storetype":"${preferredStore.businessType}",
						"longi":"${preferredStore.longitude}",
						"lat":"${preferredStore.latitude}",
						"phone": "${preferredStore.phoneNumber}",
						"website": "${preferredStore.storeWebsiteUrl}"
					}
 					],
					"stores" : [
						{
							"storename" : "NA"
						}
					]
				}

			]


</script>

				</c:when>

			</c:choose>

		</main>

	</lzb:pageContainer>

</dsp:page>
