<dsp:page>
    <dsp:importbean bean="/atg/userprofiling/Profile"/>
    <dsp:getvalueof var="transient" bean="Profile.transient" />
    <dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
    <dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBDealerStoreDroplet" />
    <dsp:importbean bean="/com/lzb/droplet/LZBGoogleMapURLSigner" />
    <dsp:importbean bean="/com/lzb/service/SessionBean"/>
    <dsp:getvalueof var="anonymousStore" bean="SessionBean.changeStoreForCheckout"/>
    <dsp:getvalueof var="storePromo" param="storePromo"/>

    <c:choose>
        <c:when test="${not empty preferredStore}">
            <dsp:getvalueof var="store" value="${preferredStore}"/>
            <dsp:getvalueof var="parentDealerId" value="${preferredStore.parentDealerNumber}" scope="request" />
            <dsp:getvalueof var="storeDealerId" value="${preferredStore.dealerNumber}" scope="request"/>
        </c:when>
        <c:otherwise>
            <dsp:getvalueof var="store" value="${currentStore}"/>
            <dsp:getvalueof var="parentDealerId" value="${currentStore.parentDealerNumber}" scope="request" />
            <dsp:getvalueof var="storeDealerId" value="${currentStore.dealerNumber}" scope="request" />
        </c:otherwise>
    </c:choose>

    <dsp:droplet name="LZBDealerStoreDroplet">
        <dsp:param name="parentDealerId" value="${parentDealerId}"/>
        <dsp:oparam name="output">
            <dsp:getvalueof var="parentDealer" param="parentDealer" />

            <dsp:getvalueof var="storePhoneNum" param="parentDealer.phone"/>
        </dsp:oparam>
        <dsp:oparam name="empty">
        </dsp:oparam>
    </dsp:droplet>

    <div id="off-canvas-locator" class="off-canvas-content off-canvas-locator">
        <%-- offCanvas heading --%>
        <div class="off-canvas-heading">
            <a href="javascript:void(0);" class="close-off-canvas-link">
                <span class="icon icon-close" aria-hidden="true"></span>
                <span class="sr-only">close menu</span>
            </a>
            <span class="storeLocatorHeading">Your Store</span>
        </div>
    	<c:choose>
        	<c:when test="${ store != null }">
        		<dsp:getvalueof var="webUrl" value="${store.storeWebsiteUrl }"/>
        			<c:set var="storeName" value ="${store.name}"/>
        			<c:set var="storeNameNew" value ="${fn:replace(storeName, 'é', '&#233;')}"/>
        			<div class="store-name"><dsp:valueof value="${storeNameNew}" valueishtml="true"/></div>
        			<div class="store-location">${store.city}, ${store.stateAddress}</div>
        		<div class="store-menu">
        			<div class="store-content">
        				<div class="store-actions-container clearfix">
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
                            <div class="store-actions">
        						<fmt:message key="preferdStore.visitYourStore" var="visitYourStore"/>
        						<a href="${contextPath}${storeURL}" id="visit-preffered-store" class="left" aria-label="${visitYourStore}" tabindex="0">${visitYourStore}</a>
                            </div>
                            </c:if>
                            <div class="store-actions">
			                   <fmt:message key="preferdStore.moreStore" var="moreStore"/>
                               <a href="${contextPath}/storeLocator/storeLocator.jsp" class="right" aria-label="${moreStore}" tabindex="0">${moreStore}</a>
                           </div>
        				</div>
        				<div class="map">
        					<dsp:droplet name="LZBGoogleMapURLSigner">
        						<dsp:param name="inputURL" value="https://maps.googleapis.com/maps/api/staticmap?center=${store.latitude},${store.longitude}&zoom=14&size=280x140&markers=icon:https://content.la-z-boy.com/img/icon-store-marker-dropdown.png%7C${store.latitude},${store.longitude}&style=feature:poi%7Cvisibility:off&client=gme-lazboy"/>
        						<dsp:oparam name="output">
        							<dsp:getvalueof var="signedURL" param="signedURL" />
        						</dsp:oparam>
        						<dsp:oparam name="empty">
        						</dsp:oparam>
        					</dsp:droplet>

        					<fmt:message key="preferdStore.getDirection" var="getDirection"/>
        					<a href="https://www.google.com/maps/dir/Current+Location/${store.address1}${store.address2}${store.address3}+${store.city}+${store.stateAddress}+${store.postalCode}" target="_blank" aria-label="${getDirection}" tabindex="0">
        						<img src="${signedURL}" alt="map showing La-Z-Boy store location in ${store.city}, ${store.stateAddress}" />
        					</a>
        				</div>
        				<div class="store-details">
        					<c:if test="${not empty parentDealerId }">
        						<dsp:droplet name="/com/lzb/droplet/UmbracoContentDroplet">
        							<dsp:param name="dealerId" value="${storeDealerId}" />
        							<dsp:param name="contentType" value="storeInfo" />
        							<%--<dsp:param name="bannerName" value="Nav" /> --%>
        							<dsp:oparam name="output">
        								<dsp:getvalueof var="storeHours" vartype="String" param="response" />
        							</dsp:oparam>
        						</dsp:droplet>
        					</c:if>

        					<c:if test="${not empty storeHours }">
        						<c:set var="today" value="<%=new java.util.Date()%>"/>
        						<fmt:message key="preferdStore.hoursOpen" var="hoursOpen"/>
        						<fmt:formatDate var="day" value="${today}" pattern="E"/>
        						<dsp:droplet name="/com/lzb/droplet/LZBParseStoreHoursDroplet">
        							<dsp:param name="hours" value="${storeHours}"/>
        							<dsp:oparam name="output">
        								<dsp:getvalueof var="hoursMap" param="hoursMap" />
        								<c:forEach items="${hoursMap}" var="dayHours">
        									<c:if test="${fn:startsWith(fn:split(dayHours,'@')[0], day)}">
        										<p  tabindex="0">${fn:split(dayHours,'@')[1]}</p>
        									</c:if>
        								</c:forEach>
        							</dsp:oparam>
        						</dsp:droplet>
        					</c:if>
        					<p  tabindex="0">${store.address1}${store.address2}${store.address3}</p>
        					<p  tabindex="0">${store.phoneNumber}</p>
        					<a href="https://www.google.com/maps/dir/Current+Location/${store.address1}${store.address2}${store.address3}+${store.city}+${store.stateAddress}+${store.postalCode}" target="_blank" class="button primary" aria-label="${getDirection}" tabindex="0">${getDirection}</a>
        					<c:if test="${not empty store.storeApptUrl}">
	    						<fmt:message key="preferdStore.prvtAppt" var="prvtAppt"/>
       							<a href="${store.storeApptUrl}" target="_blank" class="button primary" aria-label="${prvtAppt}" tabindex="0">${prvtAppt}</a>
                            </c:if>

                            <a href="${contextPath}/storeLocator/storeLocator.jsp" class="button secondary" tabindex="0">Search All Stores</a>
        				</div>
        			</div>
        		</div>
        	</c:when>
        	<c:otherwise>
            <div class="store-empty">
        	   <a href="${contextPath}/storeLocator/storeLocator.jsp" class="button primary" tabindex="0">Store Locator</a>
            </div>
        	</c:otherwise>
        	</c:choose>
    </div>
</dsp:page>
