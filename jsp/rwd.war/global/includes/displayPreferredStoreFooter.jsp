<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferStore" bean="Profile.preferredStore"/>

	<c:choose>
		<c:when test="${not empty preferStore}">
			<dsp:getvalueof var="preferredStore" value="${preferStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}" scope="request" />
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="preferredStore" value="${currentStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}" scope="request" />
		</c:otherwise>
	</c:choose>

	
	<meta name="DCSext.w_locstore_parent_of_visitor" content="${parentDealerId }" />

	<c:if test="${ preferredStore != null }">
		<dsp:getvalueof var="webUrl" value="${preferredStore.storeWebsiteUrl }"/>

		<c:choose>
			<c:when test="${ not empty webUrl}">
				<c:choose>
					<c:when test="${fn:contains(webUrl,'http://') }">
						<dsp:getvalueof var="url" value="${webUrl}"/>
					</c:when>
					<c:otherwise>
						<dsp:getvalueof var="url" value="${contextPath}${webUrl}"/>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<dsp:getvalueof var="url" value="#"/>
			</c:otherwise>
		</c:choose>
	
		<div class="your-store vcard">
			<a href="${url}" class="your-store-link">
				<div class="address">
					<span class="icon icon-locator"></span>					
					<div class="title">
						<c:choose>
							<c:when test="${ transient eq 'false' }">
								<fmt:message key="store.msg"/>
							</c:when>
							<c:otherwise>
								<fmt:message key="store.yourStore"/>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="name">${preferredStore.name}</div>
					<div class="street-address">${preferredStore.address1}${preferredStore.address2}${preferredStore.address3}</div>
					<div class="state">${preferredStore.city}, ${preferredStore.stateAddress}, ${preferredStore.postalCode}</div>	
					<span class="icon icon-arrow-right"></span>				
				</div>
			</a>
			<div class="distance"></div>
			<input type="hidden" value="${preferredStore.latitude}" name="latitude"/>
			<input type="hidden" value="${preferredStore.longitude}" name="longitude"/>
			<dsp:getvalueof var="phoneNum" value="${preferredStore.phoneNumber}"/>
			<c:choose>
				<c:when test="${not empty phoneNum }">
					<%-- remove special characters from phone number --%>
					<c:set var="formattedPhoneValue" value="${fn:replace(fn:replace(fn:replace(fn:replace(phoneNum,'(',''),')',''),'-',''),' ','')}"/>

					<c:set var="phoneNum1" value="${fn:substring(formattedPhoneValue,0, 3)}" />
					<c:set var="phoneNum2" value="${fn:substring(formattedPhoneValue,3, 6)}" />
					<c:set var="phoneNum3" value="${fn:substring(formattedPhoneValue,6, 10)}" />
					<a href="tel:${phoneNum1}-${phoneNum2}-${phoneNum3}" class="btn-tel button secondary"><span class="icon icon-phone"></span>${phoneNum1}-${phoneNum2}-${phoneNum3}</a>
				</c:when>
				<c:otherwise />
			</c:choose>
			<!-- for FEI use to get directions -->
			<%--<a href="//www.google.com/maps/@${preferredStore.latitude},${preferredStore.longitude},16z?WT.si_n=Find a Store&WT.si_x=2" target="_blank" class="btn-primary get-directions"><fmt:message key="store.directions"/></a> --%>
			<dsp:a href="//www.google.com/maps/place/${preferredStore.address1}+${preferredStore.city}+${preferredStore.stateAddress}+${preferredStore.postalCode}" iclass="button tertiary right get-direct">Get Directions</dsp:a>
			
			<dsp:a href="${contextPath}/storeLocator/storeLocator.jsp" iclass="more"><span>More Stores</span></dsp:a>
			<dsp:getvalueof var="preferStoreName" value="${preferredStore.name}" scope="request"/>
		</div>
	</c:if>
</dsp:page>