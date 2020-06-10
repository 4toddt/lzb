<%--
  - File Name: storeLocatorSuccess.jsp
  - Author(s): jjensen
  - Copyright Notice:
  - Description: Creates a json success message after successfully searching Nearest Stores
  - Parameters:
  --%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="isAvailable" value="false" vartype="Boolean" />
	<dsp:getvalueof var="securityStatus" bean="Profile.securityStatus" />
	<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
	<dsp:getvalueof var="preferStore" bean="Profile.preferredStore"/>
	
	<c:choose>
		<c:when test="${not empty preferStore}">
			<dsp:getvalueof var="preferredStore" value="${preferStore}"/>
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="preferredStore" value="${currentStore}"/>
		</c:otherwise>
	</c:choose>
	
	<json:object>
		<json:property name="success">true</json:property>
		<dsp:getvalueof var="stores" bean="LZBStoreLocatorFormHandler.storeList" />
		<json:property name="stores">${stores}</json:property>
		<%-- locations --%>
		<json:array name="locations">
			<dsp:droplet name="ForEach">
				<dsp:param name="array" bean="LZBStoreLocatorFormHandler.storeList" />
				<dsp:param name="elementName" value="store"/>
				<dsp:oparam name="output">
					<%-- <dsp:getvalueof var="meters" param="store.distance" />
					<fmt:formatNumber var="miles" value="${(meters / 1609.344)}" maxFractionDigits="2" /> --%>
					<dsp:getvalueof var="storeId" param="store.locationId"/>
					<json:object>
						<json:property name="storeIndex"><dsp:valueof param="count" /></json:property>
						<%-- <json:property name="distance">${miles}</json:property> --%>
						<json:property name="name" escapeXml="false"><dsp:valueof param="store.name" valueishtml="true"/></json:property>
						<json:property name="locationId"><dsp:valueof param="store.locationId" /></json:property>
						<json:property name="address"><dsp:valueof param="store.address1" /></json:property>
						<json:property name="address2"><dsp:valueof param="store.address2" /></json:property>
						<json:property name="address3"><dsp:valueof param="store.address3" /></json:property>					
						<json:property name="city"><dsp:valueof param="store.city" /></json:property>
						<json:property name="state"><dsp:valueof param="store.stateAddress" /></json:property>
						<json:property name="zip"><dsp:valueof param="store.postalCode" /></json:property>
						<json:property name="lat"><dsp:valueof param="store.latitude" /></json:property>
						<json:property name="lng"><dsp:valueof param="store.longitude" /></json:property>
						<json:property name="redirectUrl"><dsp:valueof param="store.storeWebsiteUrl" /></json:property>
						
						<dsp:getvalueof param="store.phoneNumber" var="phoneNum"/>
						<c:if test="${not empty phoneNum }">
							<%-- remove special characters from phone number --%>
							<c:set var="formattedPhoneValue" value="${fn:replace(fn:replace(fn:replace(fn:replace(phoneNum,'(',''),')',''),'-',''),' ','')}"/>
							<c:set var="phoneNum1" value="${fn:substring(formattedPhoneValue,0, 3)}" />
							<c:set var="phoneNum2" value="${fn:substring(formattedPhoneValue,3, 6)}" />
							<c:set var="phoneNum3" value="${fn:substring(formattedPhoneValue,6, 10)}" />
							<json:property name="phoneNum1">${phoneNum1}</json:property>
							<json:property name="phoneNum2">${phoneNum2}</json:property>
							<json:property name="phoneNum3">${phoneNum3}</json:property>
						</c:if>
						
						<dsp:getvalueof var="businessType" param="store.businessType"/>
						<c:if test="${not empty businessType and ( businessType eq '004'  or businessType eq '002') }">
							<c:choose>
								<c:when test="${ securityStatus > 2 }">
									<json:property name="preferredStoreButton" escapeXml="false">
										<button class="button primary large make-this-store" data-change-store-id="${storeId}" data-change-type="preferred"><fmt:message key="preferdStore.makePreferredStore" /></button>
									</json:property>
								</c:when>
								<c:otherwise>
									<json:property name="preferredStoreButton" escapeXml="false">
										<button class="button primary large make-this-store" data-change-store-id="${storeId}" data-change-type="change"><fmt:message key="preferdStore.makePreferredStore" /></button>
									</json:property>
								</c:otherwise>
							</c:choose>
							<c:if test="${preferredStore.repositoryId != storeId}">
								<dsp:getvalueof var="isAvailable" value="true" vartype="Boolean" />
							</c:if>
						</c:if>
						
						<c:if test="${isAvailable}">
							<json:property name="available">${isAvailable}</json:property>
						</c:if>
					</json:object>
				</dsp:oparam>
			</dsp:droplet>
		</json:array>
	</json:object>

</dsp:page>