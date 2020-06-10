<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:getvalueof var="preferredStore" param="preferredStore"/>
	<dsp:getvalueof var="preferStore" bean="Profile.preferredStore"/>
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/> 
	
	<c:choose>
		<c:when test="${not empty preferStore}">
		<dsp:getvalueof var="preferredStore" value="${preferStore}"/>
		</c:when>
		<c:otherwise>
		<dsp:getvalueof var="preferredStore" value="${currentStore}"/>
		</c:otherwise>
	</c:choose>
	
	<ul class="store-results-list">
		<dsp:droplet name="ForEach">
			<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
			<dsp:param name="elementName" value="store"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="storeId" param="store.locationId"/>
				<li>
					<div class="address">
						<p class="name"><dsp:valueof param="store.name" valueishtml="true"/></p>
						<p class="street-address"><dsp:valueof param="store.address1" valueishtml="true"/> <dsp:valueof param="store.address2" valueishtml="true"/> <dsp:valueof param="store.address3" valueishtml="true"/></p>
						<p class="state"><dsp:valueof param="store.city" valueishtml="true"/>, <dsp:valueof param="store.stateAddress" valueishtml="true"/>, <dsp:valueof param="store.postalCode" valueishtml="true"/></p>
						<p class="distance"></p>
					</div>
					<dsp:getvalueof param="store.phoneNumber" var="phoneNum"/>
					<c:choose>
						<c:when test="${not empty phoneNum }">
							<%-- remove special characters from phone number --%>
							<c:set var="formattedPhoneValue" value="${fn:replace(fn:replace(fn:replace(fn:replace(phoneNum,'(',''),')',''),'-',''),' ','')}"/>

							<c:set var="phoneNum1" value="${fn:substring(formattedPhoneValue,0, 3)}" />
							<c:set var="phoneNum2" value="${fn:substring(formattedPhoneValue,3, 6)}" />
							<c:set var="phoneNum3" value="${fn:substring(formattedPhoneValue,6, 10)}" />
						</c:when>
						<c:otherwise />
					</c:choose>
					<input type="hidden" name="latitude" value='<dsp:valueof param="store.latitude"/>'/>
					<input type="hidden" name="longitude" value='<dsp:valueof param="store.longitude"/>'/>
					<div class="actions">
						<a href="tel:${phoneNum1}-${phoneNum2}-${phoneNum3}" class="button secondary btn-tel"><span class="icon icon-phone"></span>${phoneNum1}-${phoneNum2}-${phoneNum3}</a>
						<%-- <a href="//www.google.com/maps/@<dsp:valueof param="store.latitude"/>,<dsp:valueof param="store.longitude"/>,16z?WT.si_n=Find a Store&WT.si_x=2" target="_blank" class="btn-primary get-direct"><fmt:message key="store.directions"/></a>--%>
						<a href="//www.google.com/maps/place/<dsp:valueof param="store.address1" valueishtml="true"/>+<dsp:valueof param="store.city" valueishtml="true"/>,+<dsp:valueof param="store.stateAddress" valueishtml="true"/>,+<dsp:valueof param="store.postalCode" valueishtml="true"/>" target="_blank" class="button primary get-direct"><fmt:message key="store.directions"/></a>
					</div>
					<dsp:getvalueof var="businessType" param="store.businessType"/>
					
					<c:if test="${not empty businessType and ( businessType eq '004'  or businessType eq '002') }">
						<c:choose>
							<c:when test="${ securityStatus > 2 }">
								<dsp:form id="preferredStore${storeId}" formid="preferredStore${storeId}" name="preferredStore${storeId}" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
									<dsp:input type="hidden" bean="ProfileFormHandler.storeId" value="${storeId}" />
									<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationErrorURL" value="${contextPath}/storeLocator/storeLocator.jsp" />
									<dsp:input type="hidden" bean="ProfileFormHandler.setPreferredLocationSuccessURL" value="${contextPath}/account/preferredStore.jsp?WT.si_n=Find a Store&WT.si_x=3" />
									<c:if test="${preferredStore.repositoryId != storeId}">
										<dsp:input type="submit" bean="ProfileFormHandler.setPreferredLocation" value="MAKE THIS MY PREFERRED STORE" iclass="button primary make-this-store show-more" />
									</c:if>
								</dsp:form>
							</c:when>
							<c:otherwise>
								<dsp:form id="changeStore${storeId}" formid="changeStore${storeId}" name="changeStore${storeId}" action="${contextPath}/storeLocator/storeLocator.jsp" method="post">
									<dsp:input type="hidden" bean="ProfileFormHandler.storeId" value="${storeId}" />
									<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${contextPath}/storeLocator/storeLocator.jsp?WT.si_n=Find a Store&WT.si_x=3" />
									<dsp:input type="hidden" bean="ProfileFormHandler.setChangeStoreErrorURL" value="${contextPath}/storeLocator/storeLocator.jsp" />
									<c:if test="${preferredStore.repositoryId != storeId}">
										<dsp:input type="submit" bean="ProfileFormHandler.changeStore" value="MAKE THIS MY PREFERRED STORE" iclass="button primary make-this-store show-more" />
									</c:if>
								</dsp:form>
							</c:otherwise>
						</c:choose>
					</c:if>
				</li>
			</dsp:oparam>
		</dsp:droplet>
	</ul>
</dsp:page>