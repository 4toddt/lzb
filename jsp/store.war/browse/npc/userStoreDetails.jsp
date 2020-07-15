<dsp:page>

	<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBDisplayPreferredStoreDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	
	<dsp:droplet name="LZBDisplayPreferredStoreDroplet">
		<dsp:param name="profile" bean="/atg/userprofiling/Profile"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="preferredStore" param="preferredStore" />
		</dsp:oparam>
		<dsp:oparam name="empty">
			No stores available for this profile.
		</dsp:oparam>
	</dsp:droplet>

	<c:if test="${ preferredStore != null }">

					<h2 class="nav-heading-title">Your Local Store:</h2>

					<strong>${preferredStore.name}</strong>

					<div class="adr">

						<div class="street-address">${preferredStore.address1}${preferredStore.address2}${preferredStore.address3}</div>

						<span class="locality">${preferredStore.city}</span>,&nbsp;<abbr class="region" title="${preferredStore.stateAddress}">${preferredStore.stateAddress}</abbr>&nbsp;<span class="postal-code">${preferredStore.postalCode}</span>

					</div>
		

		<dsp:a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp">
		Change my store</dsp:a>
		<dsp:getvalueof var="webUrl" value="${preferredStore.storeWebsiteUrl }"/>
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
		 
		<dsp:a href="${url}">

		Visit Store Website</dsp:a>
		<!-- for get directions google map API -->
		<input type="hidden" value="${preferredStore.latitude}"/>
		<input type="hidden" value="${preferredStore.longitude}"/>
		<dsp:a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp?storeId=${preferredStore.locationId}">
		Get Directions</dsp:a>
	</c:if>
</dsp:page>
