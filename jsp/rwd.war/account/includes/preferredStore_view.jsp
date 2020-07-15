<%--
	- File Name: preferredStore_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is selected store for Profile
	- Parameters:
	-
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	
	<%-- Page Variables --%>
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
	
	<section role="region" class="preferred-store-container">
	
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="store.msg"/></h1>
		</div> --%>
		
		<div class="account-content standard-border">
			<div id="storeInfoContainer">
				<div class="preferred-store-address">
					<h2><fmt:message key="store.storeAddressCaps"/></h2>
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
							<p>${preferredStore.address1}&nbsp;${preferredStore.address2}</p>
							<p>${preferredStore.city},&nbsp;${preferredStore.stateAddress}&nbsp;${preferredStore.postalCode}</p>
							<p class="preferred-store-phone phone">${preferredStore.phoneNumber}</p>
							<input type="hidden" value="${preferredStore.address1} ${preferredStore.address2} ${preferredStore.address3}" id="mapsAddress1">
							<input type="hidden" value="${preferredStore.city}, ${preferredStore.stateAddress}  ${preferredStore.postalCode}" id="mapsAddress2">

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

							<a href="${url}" target="_blank">
								<button class="btn preferred-store-website button primary"><fmt:message key="store.visit"/><!-- Store Website --></button>
							</a>
						</c:when>
						<c:otherwise>
							<p><fmt:message key="store.noStores" /></p>
						</c:otherwise>
					</c:choose>
				</div>
				<c:if test="${not empty preferredStore}">
					<div class="preferred-store-hours">
						<h3><fmt:message key="store.storeHours"/></h3>
						<ul>${preferredStore.storeHourUrl}</ul>
					</div>
				</c:if>
				<div class="find-more-stores">
					<h3><fmt:message key="store.findStores"/></h3>

					<dsp:form id="storeLocator" formid="storeLocator" name="storeLocator" action="#" method="post" data-validate>
						<div class="field-group">
							<fmt:message var="zipCode" key="store.label"/>
							<label for="zipcode"><fmt:message key="store.label"/><span class="sr-only"><fmt:message key="store.label"/></span></label>
							<dsp:input type="text" name="locator" id="zipcode" iclass="zipcode" bean="LZBStoreLocatorFormHandler.valueMap.state" beanvalue="LZBStoreLocatorFormHandler.valueMap.state" maxlength="25" autocapitalize="off" data-validation="required alphanumericspacecomma" aria-required="true" data-fieldname="Locator" placeholder="${zipCode}"/>
							<dsp:input type="hidden" name="La-Z-Boy Home Furnishings & D�cor" bean="LZBStoreLocatorFormHandler.valueMap.homeFurnishings" value="false" />
							<dsp:input type="hidden" name="La-Z-Boy Furniture Galleries" bean="LZBStoreLocatorFormHandler.valueMap.furnitureGalleries" value="false" />
							<dsp:input type="hidden" name="La-Z-Boy Comfort Studio"  bean="LZBStoreLocatorFormHandler.valueMap.comfortStudio" value="false" />
							<dsp:input type="hidden" name="Other La-Z-Boy Retailers" id="locator" bean="LZBStoreLocatorFormHandler.valueMap.retailers" value="false" />
							<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${contextPath}/storeLocator/json/storeLocatorSuccess.jsp" />
							<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${contextPath}/account/json/storeError.jsp"/>
							<dsp:input type="submit" value="Find" name="findStore"	id="findStore" bean="LZBStoreLocatorFormHandler.locate" iclass="button primary" required="true"/>
						</div>
					</dsp:form>
				</div>
			</div>
			<div class="fa-map-marker">
				<c:if test="${not empty preferredStore}">
					<!-- Here need to get the user current location latitude and longitude -->
					<!-- <div id="map-canvas" class="map-canvas"></div> -->
					<dsp:a href="${contextPath}/storeLocator/storeLocator.jsp?storeId=${preferredStore.locationId}" iclass="locator"><span class="icon icon-locator"></span><fmt:message key="store.currentLocation"/></dsp:a>
				</c:if>
			</div>
			<!-- show store locator search results after submit the form -->
			<div class="store-location-results"></div>
			
			<dsp:form id="preferredStore" formid="preferredStore" name="preferredStore" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
				<dsp:input type="hidden" bean="ProfileFormHandler.storeId" id="prefer-store-id" value="" />
				<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationErrorURL" value="${contextPath}/storeLocator/json/storeError.jsp" />
				<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationSuccessURL" value="${contextPath}/storeLocator/json/storeSuccess.jsp?type=preferStore" />
				<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocation" value="MAKE THIS MY PREFERRED STORE" iclass="btn-primary show-more" />
			</dsp:form>
			
			<dsp:form id="changeStore" formid="changeStore" name="changeStore" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
				<dsp:input type="hidden" bean="ProfileFormHandler.storeId" id="change-store-id" value="" />
				<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${contextPath}/storeLocator/json/storeSuccess.jsp?type=" />
				<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreErrorURL" value="${contextPath}/storeLocator/json/storeError.jsp" />
				<dsp:input type="hidden" bean="ProfileFormHandler.changeStore" value="MAKE THIS MY PREFERRED STORE" iclass="btn-primary show-more" />
			</dsp:form>
		</div>
		
	</section>
</dsp:page>