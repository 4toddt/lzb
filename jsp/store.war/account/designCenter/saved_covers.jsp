<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<%-- This is used on PDP to display user's saved covers --%>
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL" value="/account/designCenter/saveCover.jsp"  />
	<dsp:setvalue bean="GiftlistFormHandler.updateGiftlistItemsErrorURL" value="/account/designCenter/saveCover.jsp"  />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="saveCoverXMPageName" value="${storeConfig.coverSearchXMPageName}" />
<dsp:droplet name="/com/lzb/droplet/LZBNPCURLDroplet">
 		  <dsp:param name="catPageIdPageId" value="${storeConfig.customizeItCoverSearchId}" />
  		 <dsp:oparam name="output">
    		<dsp:getvalueof var="coverSearchPageUrl" param="npcurl"/>
  		 </dsp:oparam>
  </dsp:droplet>

	<dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
	<dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />

		<dsp:getvalueof var="savedCovers" param="savedCoversItem" />
       	<%--
       	<json:object>
		  <json:array name="covers" var="item" items="${savedCovers}">
		    <json:object>
		      <json:property name="id" value="${item.id}"/>
		      <json:property name="description" value="${item.displayName}"/>
		      <json:property name="skuid" value="${item.catalogRefId}"/>
		      <json:property name="thumbnailimage" value="${storeConfig.hostName}${storeConfig.coverThumbnailBaseUrl}${item.catalogRefId}.jpg"/>
		      <json:property name="largeviewimage" value="${storeConfig.hostName}${storeConfig.coverLargeviewBaseUrl}${item.catalogRefId}.jpg"/>
		    </json:object>
		  </json:array>
		</json:object>
		 --%>
		<div class="design-border">  
			<dsp:droplet name="IsEmpty">
				<dsp:param name="value" param="savedCoversItem" />
				<dsp:oparam name="true">
					You have no items in your Save Cover List.</br>
					<a href="${contextPath}/index.jsp"><fmt:message key="cart.continueShop" /></a>
				</dsp:oparam>
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
			</dsp:droplet>
		</div>

</dsp:page>
