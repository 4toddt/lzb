<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:getvalueof var="storeId" param="storeId"/>
	
	<!-- for displaying current store -->
	<div class="store-content store-pref-address">
		<c:choose>
			<c:when test="${not empty preferredStore}">
				<dsp:getvalueof var="store" value="${preferredStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}"/>
			</c:when>
			<c:otherwise>
				<dsp:getvalueof var="store" value="${currentStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}"/>
			</c:otherwise>
		</c:choose>
			
		<dsp:droplet name="LZBDealerStoreDroplet">
			<dsp:param name="parentDealerId" value="${parentDealerId}"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="parentDealer" param="parentDealer" scope="session"/>
				<dsp:getvalueof var="webUrl" param="parentDealer.websiteURL" scope="session"/>
				<dsp:getvalueof var="storePhoneNum" param="parentDealer.phone" scope="session"/>
			</dsp:oparam>
		</dsp:droplet>
		
		<c:if test="${not empty store }">
			<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>
			<h2><fmt:message key="store.msg"/></h2>
			<p class="pref-head"><strong>${store.name}</strong></p>
			<div class="store-address">
				<p>${store.address1} ${store.address2} ${store.address3} </p>
				<p>${store.city}, ${store.stateAddress} , ${store.postalCode}</p>
				<%-- ${store.phoneNumber} --%>
				<p class="distance"></p>
				<input type="hidden" id="latitude" value="${store.latitude}" name="latitude"/>
				<input type="hidden" id="longitude" value="${store.longitude}" name="longitude"/>
			</div>
			
			<dsp:getvalueof var="phoneNum" value="${store.phoneNumber}"/>
			<!-- for FEI use to get directions -->
			<input type="hidden" value="${store.address1} ${store.address2} ${store.address3}" id="mapsAddress1">
			<input type="hidden" value="${store.city}, ${store.stateAddress} , ${store.postalCode}" id="mapsAddress2">
			<dsp:getvalueof var="preferStoreName" value="${preferredStore.name}" scope="request"/>
			
			<div class="actions">
				<c:if test="${not empty phoneNum }">
					<%-- remove special characters from phone number --%>
					<c:set var="formattedPhoneValue" value="${fn:replace(fn:replace(fn:replace(fn:replace(phoneNum,'(',''),')',''),'-',''),' ','')}"/>
					<c:set var="phoneNum1" value="${fn:substring(formattedPhoneValue,0,3)}" />
					<c:set var="phoneNum2" value="${fn:substring(formattedPhoneValue,3,6)}" />
					<c:set var="phoneNum3" value="${fn:substring(formattedPhoneValue,6,10)}" />
					<a href="tel:${phoneNum1}-${phoneNum2}-${phoneNum3}" class="button secondary"><span class="icon icon-phone"></span>${phoneNum1}-${phoneNum2}-${phoneNum3}</a>
				</c:if>
				<dsp:a href="//www.google.com/maps/place/${store.address1}+${store.city}+${store.stateAddress}+${store.postalCode}" iclass="button primary get-direct">Get Directions</dsp:a>
				<c:if test="${not empty store.storeApptUrl}">
	    			<fmt:message key="preferdStore.prvtAppt" var="prvtAppt"/>
       				<dsp:a href="${store.storeApptUrl}" target="_blank" iclass="button primary make-appt" aria-label="${prvtAppt}" tabindex="0">${prvtAppt}</dsp:a>
                </c:if>
				
				<%-- <dsp:a href="${url}" style="width:50%;" iclass="button secondary" id="view-store-website"><fmt:message key="storeLocator.visit"/></dsp:a>
				<a href="#" id="getStoreDirections" class="button primary directions" data-store-id="${store.locationId}" data-store-address="${store.address1} ${store.address2} ${store.address3},${store.city}, ${store.stateAddress} , ${store.postalCode}"><fmt:message key="preferdStore.getDirectionCaps"/></a> --%>
			</div>
		</c:if>
	</div>
</dsp:page>
