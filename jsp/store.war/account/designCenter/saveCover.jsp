<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/userprofiling/Profile" />
		<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
		<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
		<dsp:importbean bean="/com/lzb/droplet/LZBNPCURLDroplet" />
		<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
		<dsp:importbean bean="/atg/store/LZBStoreConfiguration"var="storeConfig" />
		<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL" value="/account/designCenter/saveCover.jsp"  />
		<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsErrorURL" value="/account/designCenter/saveCover.jsp"  />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
		<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
		<dsp:getvalueof var="saveCoverXMPageName" value="${storeConfig.coverSearchXMPageName}" />
		<dsp:droplet name="LZBNPCURLDroplet">
 		  <dsp:param name="catPageIdPageId" value="${storeConfig.customizeItCoverSearchId}" />
  		 <dsp:oparam name="output">
    		<dsp:getvalueof var="coverSearchPageUrl" param="npcurl"/>
  		 </dsp:oparam>
  		</dsp:droplet>

			<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.profile" divClass="breadcrumb" />
		<main role="main"> <dsp:include
			page="/includes/leftnavigation.jsp">
			<dsp:param name="selpage" value="PROFILE" />
		</dsp:include>

		<section role="region" class="profile-account-content"
			data-module="profile-validate">
			<div class="design-tabs-wrapper">
					<div class="design-tabs">Design Help</div>
					<div class="design-tabs design-tab-active">Saved Covers</div>
					<div class="design-tabs ">Room Planner</div>
				</div>
			<dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
			<dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" param="savedCoversItem" />
				<dsp:oparam name="true">
				You have no items in your Save Cover List.</br>
						<a href="${contextPath}/index.jsp"><fmt:message key="cart.continueShop" /></a>
				</dsp:oparam>

				<div class="design-border">
				<dsp:oparam name="false">
					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="savedCoversItem" />
						<dsp:param name="elementName" value="savedCoverelement" />
						<dsp:oparam name="outputStart">
							<fmt:message key="account.designCenter.favourites.saveCoversMsg" />
							<table class="savedCover">
								<th><fmt:message
										key="account.designCenter.favourites.tableHeading.image" /></th>
								<th><fmt:message
										key="account.designCenter.favourites.tableHeading.description" />
								</th>
								<th><fmt:message
										key="account.designCenter.favourites.tableHeading.fabricNumber" />
								</th>
								<th><fmt:message
										key="account.designCenter.favourites.tableHeading.addedOn" />
								</th>
								<th></th>

								</dsp:oparam>
								<dsp:oparam name="output">
									<dsp:getvalueof var="coverid"
										param="savedCoverelement.catalogRefId" />
									<dsp:getvalueof var="title"
										param="savedCoverelement.displayName" />
									<tr>
										<td><a href="${coverSearchPageUrl}?selectedCover=${coverid}" title="${title}">
												<img
												src="${storeConfig.hostName}${storeConfig.coverThumbnailBaseUrl}${coverid}.jpg"
												height="50" width="50" alt="${title}" /> &nbsp; <img
												src="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${coverid}.jpg"
												height="50" width="50" alt="${title}" style="display: none;" />
										</a></td>
										<td><a href="${coverSearchPageUrl}?selectedCover=${coverid}" title="${title}">
												${title} </a> </br> Color: <dsp:valueof
												param="savedCoverelement.description" /></td>
										<td>${coverid}</td>

										<td><dsp:valueof param="savedCoverelement.creationDate"
												date="yyyy-dd-MM" /></td>
										<td><dsp:getvalueof var="wishlistItemId"
												param="savedCoverelement.id" /> <dsp:getvalueof
												var="giftlistId" param="savedCovers.id" />
											<dsp:a
												href="/account/designCenter/saveCover.jsp"
												bean="GiftlistFormHandler.removeGiftlistItems" value="true">
												<dsp:param name="wishlistItemIdToRemove" value="${wishlistItemId}" />
												<dsp:param name="saveCoverRequest" value="true" />
												<fmt:message key="account.designCenter.favourites.remove" />
											</dsp:a></td>
									</tr>
								</dsp:oparam>
								<dsp:oparam name="outputEnd">
							</table>
						</dsp:oparam>

					</dsp:droplet>
				</dsp:oparam>
				</div>
			</dsp:droplet>
		</section>
		</main>
	</lzb:pageContainer>
</dsp:page>
