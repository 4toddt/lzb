<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/> 
	<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
	
		<c:choose>
			<c:when test="${not empty preferredStore}">
<%--				<fmt:message key="storeLocator.preferredStore"/><br> --%>
				<dsp:getvalueof var="store" value="${preferredStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}"/>				
			</c:when>
			<c:otherwise>
<%--				<fmt:message key="preferdStore.storeNearest"/><br> --%>
				<dsp:getvalueof var="store" value="${currentStore}"/>
				<dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}"/>
			</c:otherwise>
		</c:choose>
		

		
		
	
		<c:if test="${ store != null }">
		
			<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>

			<p class="cdp-subtitle store"><fmt:message key="storeLocator.yourStore"/></p>
			<p class="cdp-store-info"><dsp:a href="${webUrl}">${store.name}</dsp:a></p>
			<p class="cdp-store-info">${store.address1}${store.address2}${store.address3}</p>
			
			<!-- For google Map purpose starts -->
			<input id="mapsAddress1" type="hidden" value="${store.address1}">
			<input id="mapsAddress2" type="hidden" value="${store.address2}">
			<!-- For google Map purpose ends -->
			
			<p class="cdp-store-info">${store.city}&nbsp;${store.country}&nbsp;${store.stateAddress}&nbsp;${store.postalCode}</p>
			<p class="cdp-store-info"><dsp:a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp" iclass="tools"><fmt:message key="storeLocator.changeStore"/></dsp:a></p>
	
			<input type="hidden" value="${store.latitude}"/>
			<input type="hidden" value="${store.longitude}"/>			
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
			
			<p class="cdp-store-info"><dsp:a href="${url}" iclass="tools"><fmt:message key="storeLocator.visitweb"/></dsp:a></p>
			<p class="cdp-store-info"><dsp:a href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp?storeId=${store.locationId}" iclass="tools"><fmt:message key="storeLocator.directions"/></dsp:a></p>
		</c:if>
</dsp:page>
