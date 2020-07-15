<%--
	- File Name: saveCover_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Save covered page that contains all a covers
	- Parameters:
	-
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration"var="storeConfig" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder"/>
	
	<%-- Page Variables --%>
	<dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
	<dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />
	
	<dsp:droplet name="/com/lzb/droplet/LZBNPCURLDroplet">
 		 <dsp:param name="catPageIdPageId" value="${storeConfig.customizeItCoverSearchId}" />
  		 <dsp:oparam name="output">
    		<dsp:getvalueof var="coverSearchPageUrl" param="npcurl"/>
  		 </dsp:oparam>
  	</dsp:droplet>
	
	<section role="region" class="savedcover-container">
	
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="orderHistory.Header"/></h1>
		</div> --%>
	
		<div class="account-content standard-border">
			<%-- save cover header --%>
			<p><fmt:message key="account.designCenter.favourites.saveCoversMsg" /></p>
			<div class="cover-items-header hide">
				<div class="cover-items-header-image"><fmt:message key="account.designCenter.favourites.tableHeading.image" /></div>
				<div class="cover-items-header-description"><fmt:message key="account.designCenter.favourites.tableHeading.description" /></div>
				<div class="cover-items-header-number"><fmt:message key="account.designCenter.favourites.tableHeading.fabricNumber" /></div>
				<div class="cover-items-header-datel"><fmt:message key="account.designCenter.favourites.tableHeading.addedOn" /></div>
				<div class=""></div>
			</div>
			
			<%-- saved cover items list --%>
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="savedCoversItem" />
				<dsp:param name="elementName" value="savedCoverelement" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="coverid" param="savedCoverelement.catalogRefId" />
					<dsp:getvalueof var="title" param="savedCoverelement.displayName" />
					
					<%-- Droplet used to build Marxent Imager URL --%>
					<c:choose>
						<c:when test="${!storeConfig.marxentImagerEnabled}">
							<dsp:getvalueof var="marxentImageURL" value="/"/>
							<dsp:droplet name="LZBImageURLBuilder">
								<dsp:param name="json" param="savedCoverelement.requestJson"/>
								<dsp:param name="width" value="50"/>
								<dsp:param name="height" value="50"/>
								<dsp:param name="bg" value="white"/>
								<dsp:param name="padding" value="0"/>
								<dsp:param name="trim" value="true"/>
								<dsp:param name="crop" value="false"/>
								<dsp:param name="secureURL" value="true"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="marxentImageURL" param="elements"/>
								</dsp:oparam>
							</dsp:droplet>
						</c:when>
						<c:otherwise>
							<c:set var="marxentImageURL" value="${storeConfig.hostName}${storeConfig.coverThumbnailBaseUrl}${coverid}.jpg"/>
						</c:otherwise>
					</c:choose>
					
					<div class="cover-item">
						<div class="item-image cover-item-section">
							<a href="${coverSearchPageUrl}?selectedCover=${coverid}" title="${title}">
								<img src="${marxentImageURL}" height="50" width="50" alt="${title}" />
							</a>
						</div>
						
						<div class="item-details cover-item-section">
							<div class="item-title cover-item-section">
								<a href="${coverSearchPageUrl}?selectedCover=${coverid}" title="${title}"><strong>${title}</strong> </a>
								<br><span>Color: <dsp:valueof param="savedCoverelement.description" /></span>
							</div>
						
							<div class="item-cover-id cover-item-section">
								${coverid}
							</div>
						
							<div class="item-date cover-item-section">
								<dsp:valueof param="savedCoverelement.creationDate" date="yyyy-dd-MM" />
							</div>
						</div>
						
						<dsp:getvalueof var="wishlistItemId" param="savedCoverelement.id" /> 
						<dsp:getvalueof var="giftlistId" param="savedCovers.id" />
						
						<div class="item-action-links cover-item-section">
							<dsp:a href="${contextPath}/account/designCenter/saveCover.jsp" bean="GiftlistFormHandler.removeGiftlistItems" value="true">
								<dsp:param name="wishlistItemIdToRemove" value="${wishlistItemId}" />
								<dsp:param name="saveCoverRequest" value="true" />
								<fmt:message key="account.designCenter.favourites.remove" />
							</dsp:a>
						</div>
					</div>
				</dsp:oparam>
			</dsp:droplet>
		</div>
		
	</section>
</dsp:page>