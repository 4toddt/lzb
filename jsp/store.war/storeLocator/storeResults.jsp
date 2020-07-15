<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:page>

	<div id="storeResultsContainer">

	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		
			<dsp:droplet name="ForEach">
				<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
				<dsp:param name="elementName" value="store" />
				<dsp:oparam name="output" >
					<dsp:getvalueof param="index" var="index" />
					<div class="stores-tab">
						<dsp:getvalueof var="storeId" param="store.locationId" />
						<dsp:getvalueof var="businessType" param="store.businessType" />
						<dsp:getvalueof var="apptURL" param="store.storeApptUrl" />

						<h4><dsp:valueof param="store.name" valueishtml="true" /></h4>

						<p><dsp:valueof param="store.address1" valueishtml="true" />&nbsp;<dsp:valueof param="store.address2" valueishtml="true" />&nbsp;<dsp:valueof param="store.address3" valueishtml="true" /></p>
						<p><dsp:valueof param="store.city" valueishtml="true" />, <dsp:valueof param="store.stateAddress" valueishtml="true" /></p>
						<p><dsp:valueof param="store.postalCode" valueishtml="true" />, <dsp:valueof param="store.country" valueishtml="true" /></p>
						<c:choose>
							<c:when test="${not empty businessType and ( businessType eq '004'  or businessType eq '002') }">
								<c:choose>
									<c:when test="${securityStatus > 2 }">
										<dsp:form id="preferredStore${storeId}" name="preferredStore${storeId}" action="${siteBaseUrl}/storeLocator/storeLocator.jsp" method="post">
											<span class="btn-secondary more_info" data-index="${index}" tabindex="0" role="button" aria-label="more info - open google map dialog window">More Info</span>
											<span class="offscreen">Opens a modal to locate store on map</span>
											<dsp:input type="hidden" bean="ProfileFormHandler.storeId" value="${storeId}" />
											<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationErrorURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
											<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationSuccessURL" value="${siteBaseUrl}/account/preferredStore.jsp" />
											<span class="offscreen sr-only" aria-hidden="true">.</span><dsp:input type="submit" bean="ProfileFormHandler.setPreferredLocation" value="Make This Preferred Store" iclass="btn-primary btn-prefstore  make-preferred-store">
												<dsp:tagAttribute name="data-storeid" value="${storeId}" />
											</dsp:input>
										</dsp:form>
										<c:if test="${not empty apptURL}" >
											<dsp:a href="${apptURL}" iclass="btn-appt"><fmt:message key="storeLocator.prvtAppt"/></dsp:a>		
										</c:if>
										
									</c:when>
									<c:otherwise>
										<dsp:form id="changeStore${storeId}" name="changeStore${storeId}" action="${siteBaseUrl}/storeLocator/storeLocator.jsp" method="post">
											<span class="btn-secondary more_info" data-index="${index}" tabindex="0" role="button" aria-label="more info - open google map dialog window">More Info</span>
											<span class="offscreen">Opens a modal to locate store on map</span>
											<dsp:input type="hidden" bean="ProfileFormHandler.storeId" value="${storeId}" />
											<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
											<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreErrorURL" value="${siteBaseUrl}/storeLocator/storeLocator.jsp" />
											<span class="offscreen sr-only" aria-hidden="true">.</span><dsp:input type="submit" bean="ProfileFormHandler.changeStore" value="Make This Preferred Store" iclass="btn-primary make-preferred-store">
												<dsp:tagAttribute name="data-storeid" value="${storeId}" />
											</dsp:input>
										</dsp:form>
										<c:if test="${not empty apptURL}" >
											<dsp:a href="${apptURL}" iclass="btn-appt" id="view-store-appt"><fmt:message key="storeLocator.prvtAppt"/></dsp:a>		
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<span class="btn-secondary more_info" data-index="${index}" tabindex="0" role="button" aria-label="more info - open google map dialog window">More Info</span>
								<span class="offscreen sr-only" aria-hidden="true">.</span><span class="offscreen sr-only">Opens a modal to locate store on map</span>
							</c:otherwise>
						</c:choose>
					</div>
				</dsp:oparam>
			</dsp:droplet>
		</div>


<c:choose>
<c:when test="${not empty index}">

			<script>
				var __locatorResults = [
					{
						"map" : [
							<dsp:droplet name="ForEach">
								<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
								<dsp:param name="elementName" value="store" />
								<dsp:oparam name="output">
									<dsp:getvalueof param="size" var="size" />
									<dsp:getvalueof param="count" var="count" />
									{
										"storename":"<dsp:valueof param="store.name" valueishtml="true" />",
										"address1": "<dsp:valueof param="store.address1" valueishtml="true" />",
										"address2": "<dsp:valueof param="store.address2" valueishtml="true" />",
										"address3": "<dsp:valueof param="store.address3" valueishtml="true" />",
										"city":"<dsp:valueof param="store.city" valueishtml="true" />",
										"state":"<dsp:valueof param="store.stateAddress" valueishtml="true" />",
										"zip":"<dsp:valueof param="store.postalCode" valueishtml="true" />",
										"country":"<dsp:valueof param="store.country" valueishtml="true" />",
										"storeID":"<dsp:valueof param="store.locationId" valueishtml="true" />",
										"storetype":"<dsp:valueof param="store.businessType" valueishtml="true" />",
										"longi":"<dsp:valueof param="store.longitude" valueishtml="true" />",
										"lat":"<dsp:valueof param="store.latitude" valueishtml="true" />",
										"phone":"<dsp:valueof param="store.phoneNumber" valueishtml="true" />",
										"website":"<dsp:valueof param="store.storeWebsiteUrl" valueishtml="true" />",
										"index":"${count}"
									}<c:if test="${size!=count}">,</c:if>
								</dsp:oparam>
							</dsp:droplet>
						],
						"stores" : [
							<dsp:droplet name="ForEach">
								<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
								<dsp:param name="elementName" value="store" />
								<dsp:oparam name="output">
									<dsp:getvalueof param="size" var="size" />
									<dsp:getvalueof param="count" var="count" />
									{
										"storename":"<dsp:valueof param="store.name" valueishtml="true" />",
										"address1": "<dsp:valueof param="store.address1" valueishtml="true" />",
										"address2": "<dsp:valueof param="store.address2" valueishtml="true" />",
										"address3": "<dsp:valueof param="store.address3" valueishtml="true" />",
										"city":"<dsp:valueof param="store.city" valueishtml="true" />",
										"state":"<dsp:valueof param="store.stateAddress" valueishtml="true" />",
										"zip":"<dsp:valueof param="store.postalCode" valueishtml="true" />",
										"country":"<dsp:valueof param="store.country" valueishtml="true" />",
										"storeID":"<dsp:valueof param="store.locationId" valueishtml="true" />",
										"storetype":"<dsp:valueof param="store.businessType" valueishtml="true" />",
										"longi":"<dsp:valueof param="store.longitude" valueishtml="true" />",
										"lat":"<dsp:valueof param="store.latitude" valueishtml="true" />",
										"phone":"<dsp:valueof param="store.phoneNumber" valueishtml="true" />",
										"website":"<dsp:valueof param="store.storeWebsiteUrl" valueishtml="true" />",
										"index":"${count}"
									}<c:if test="${size!=count}">,</c:if>
								</dsp:oparam>
							</dsp:droplet>
						]
					}
				]
			</script>
		
	</c:when>
		</c:choose>		
	</dsp:layeredBundle>
</dsp:page>
