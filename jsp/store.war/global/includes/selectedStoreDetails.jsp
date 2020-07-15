<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="anonymousStore" bean="SessionBean.changeStoreForCheckout"/>

	<c:choose>
		<c:when test="${not empty preferredStore}">
			<dsp:getvalueof var="store" value="${preferredStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}" scope="request" />
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="store" value="${currentStore}"/>
			<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}" scope="request" />
		</c:otherwise>
	</c:choose>


	<c:choose>
	<c:when test="${ store != null }">
	<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>

		<div class="npc-store-details">
			
				<div class="store-address">
					<p>${store.name}</p>
					<address>
						${store.address1} ${store.address2}
						${store.address3}<br> ${store.city},
						${store.stateAddress} ${store.postalCode}<br>
						<c:if test="${not empty store.phoneNumber and fn:length(store.phoneNumber)>= 10 }">
						<span class="preferred-store-phone"><c:out value="${fn:substring(store.phoneNumber, 0, 3)}-${fn:substring(store.phoneNumber, 3, 6)}-${fn:substring(store.phoneNumber,6,fn:length(store.phoneNumber))}"/></span> 
						</c:if>

						<input type="hidden" value="${store.address1} ${store.address2} ${store.address3}" 	id="mapsAddress1">
						<input type="hidden" value="${store.city}, ${store.stateAddress}  ${store.postalCode}" id="mapsAddress2">
					</address>
				
				</div>

				<div class="store-website-url">
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
					<c:if test="${not empty storeURL}">
					<a href="${storeURL}" id="visit-preffered-store" class="triangle-forwards"><fmt:message key="preferdStore.visitYourStore"/></a>
					</c:if>
				</div>

	                  <div class="store-direction-link">
	                     	<dsp:getvalueof var="directionURL" value="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp"/>
		                    <input type="hidden" value="${store.latitude}"/> 
					<input type="hidden" value="${store.longitude}"/>
		                     <a href="${directionURL}?storeId=${store.locationId}" id="directions-preffered-store" class="triangle-forwards"><fmt:message key="preferdStore.getDirection"/></a>
	                   </div>

		</div>
	</c:when>
	</c:choose>
</dsp:page>