<dsp:page>

	<dsp:importbean
		bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean
		bean="/atg/commerce/pricing/priceLists/PriceListManager" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/com/lzb/droplet/LZBWishListItemDroplet" />
	<dsp:getvalueof param="skuId" var="giftListId" />

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc</jsp:attribute>

		<dsp:getvalueof param="success" var="successMsg" />
		<div class="message-wrapper">
			<c:if test="${successMsg eq 'true' }">
				<fmt:message key="wishlist.successMsgs" />
			</c:if>
		</div>
		<main role="main"> <dsp:include
			page="/includes/leftnavigation.jsp">
			<dsp:param name="selpage" value="PROFILE" />
		</dsp:include>

		<section role="region" class="wishlist-share-store">
			<h3>
				<fmt:message key="wishList.contactText" />
			</h3>
			<div>
				<h5>
					<fmt:message key="wishList.infoText" />
					<br />
					<fmt:message key="wishList.localStoreInfo" />
				</h5>
			</div>
			<p>
				<sup><sup>&#42;</sup> </sup> Required fields
			</p>
			<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError" />

			<c:if test="${formError eq 'true'}">
				<div class="message-container">
					<div class="message-wrapper">
						<dsp:include page="/includes/global/errors.jsp">
							<dsp:param name="formHandler" bean="GiftlistFormHandler" />
						</dsp:include>
					</div>
				</div>
			</c:if>
			<div>
				<div>
					<fmt:message key="wishList.storeContact" />
				</div>

				<div>
					<fmt:message key="wishList.storeInfo" />
					<br />
					<dsp:getvalueof var="Store" bean="Profile.currentStore" />
					<c:set var="storeEmail" value="${Store.email}" />
					${Store.name}<br /> ${Store.address1},${Store.city},<br />
					${Store.stateAddress},${Store.country},${Store.postalCode}<br />
				</div>

				<div>
					<!-- need to add logic for store to display store to contact detail -->
					<dsp:getvalueof var="prefStoreUrl" value="${Store.storeWebsiteUrl}" />
					<c:choose>
						<c:when test="${not empty prefStoreUrl}">
							<dsp:getvalueof var="storeUrl" value="${prefStoreUrl}" />
						</c:when>
						<c:otherwise>
							<dsp:getvalueof var="storeUrl" value="#" />
						</c:otherwise>
					</c:choose>
					<dsp:a href="${storeUrl}">
						<fmt:message key="wishList.visitWebsite" />
					</dsp:a>
					|
					<dsp:a href="#">
						<fmt:message key="wishList.getDirections" />
						<input type="hidden" name="longitude" value="${Store.longitude}" />
						<input type="hidden" name="latitude" value="${Store.latitude}" />
					</dsp:a>
					|
					<dsp:a href="${sitebaseurl}/work/storeLocator/storeLocator.jsp">
						<fmt:message key="wishList.changeStore" />
					</dsp:a>
				</div>
			</div>
			<div>

				<dsp:form name="wishlistStore" method="post">

					<fieldset>
						<labeL><fmt:message key="wishList.yourName" /></labeL>
						<dsp:input type="text" name="yourName"
							bean="GiftlistFormHandler.profileValueMap.fullName"
							maxlength="50" value="" />
					</fieldset>
					<fieldset>
						<labeL> <fmt:message key="wishList.yourEmail" /></labeL>

						<dsp:input type="text" name="yourEmail"
							bean="GiftlistFormHandler.profileValueMap.email" maxlength="50"
							value="" />
					</fieldset>

					<fieldset>
						<labeL> <fmt:message key="wishList.address" /></labeL>

						<dsp:input type="text" name="yourAddress"
							bean="GiftlistFormHandler.profileValueMap.address" maxlength="50"
							value="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.city" /></labeL>

						<dsp:input type="text" name="yourCity"
							bean="GiftlistFormHandler.profileValueMap.city" maxlength="50"
							value="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.state" /></labeL>
						<c:choose>
							<c:when test="${not empty stateCode}">
								<dsp:param name="statePicker" value="${stateCode}" />
							</c:when>
							<c:otherwise>
								<dsp:param name="statePicker" value="${editAddress.state}" />
							</c:otherwise>
						</c:choose>
						<span> <dsp:select id="atg_store_stateSelect"
								name="atg_store_stateSelect"
								bean="GiftlistFormHandler.profileValueMap.state"
								nodefault="true"><%@include
									file="/includes/global/countryState.jsp"%>
							</dsp:select>
						</span>
					</fieldset>


					<fieldset>
						<labeL><fmt:message key="wishList.zipCode" /> <sup>&#42;</sup></labeL>

						<dsp:input type="text" name="yourPostalCode"
							bean="GiftlistFormHandler.profileValueMap.postalCode"
							maxlength="50" value="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.phone" /></labeL>

						<dsp:input type="text" name="yourPhone"
							bean="GiftlistFormHandler.profileValueMap.phoneNumber"
							maxlength="50" value="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.comments" /></labeL>
						<dsp:textarea name="yourComments"
							bean="GiftlistFormHandler.profileValueMap.comments"
							maxlength="50" default="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.verifictionImage" /></labeL> <span><img
							src="captchaImage.jpg"></span>
					</fieldset>
					<fieldset></fieldset>
					<label><fmt:message key="wishList.verificationNumber" /></label>
					<dsp:input type="text" name="captchaImageNumber"
						bean="GiftlistFormHandler.profileValueMap.captchaImageNumber"
						value="" />
					</fieldset>

					<fieldset>
						<labeL><fmt:message key="wishList.respondRadioText" /></labeL>


						<dsp:input type="radio" name="selectradio"
							bean="GiftlistFormHandler.profileValueMap.respondMedium"
							value="phone" checked="true" />
						<label><fmt:message key="wishList.phone" /></label>

						<dsp:input type="radio" name="selectradio"
							bean="GiftlistFormHandler.profileValueMap.respondMedium"
							value="email" />
						<label><fmt:message key="wishList.email" /></label>
					</fieldset>
			</div>
			<dsp:getvalueof var="giftListItems"
				bean="Profile.wishlist.giftlistItems" />
			<dsp:input type="hidden"
				bean="GiftlistFormHandler.giftItemsValueMap.wishlistItem"
				value="${giftListItems}" />
			<dsp:input type="hidden" bean="GiftlistFormHandler.giftItems"
				value="${giftListId}" />
			<dsp:input type="hidden"
				bean="GiftlistFormHandler.profileValueMap.storeEmail"
				value="${storeEmail}" />
			<dsp:input type="hidden" bean="GiftlistFormHandler.wishListerrorURL"
				value="${pageContext.request.contextPath}/account/wishListLocalStore.jsp?error" />
			<dsp:input type="hidden"
				bean="GiftlistFormHandler.wishListsuccessURL"
				value="${pageContext.request.contextPath}/account/wishListLocalStore.jsp?success=true" />
			<fieldset class="buttons-wrapper">
				<dsp:a
					href="${pageContext.request.contextPath}/account/wish_list_items.jsp">
					<fmt:message key="profile.cancel" />
				</dsp:a>
				<dsp:input type="submit"
					bean="GiftlistFormHandler.wishListLocalStore" value="SEND TO STORE"
					iclass="btn-primary" />
			</fieldset>
			</dsp:form>
			<!-- droplet to display the items from ids which is in form of string   -->
		</section>
		<aside role="complementary">
			<h2>
				<fmt:message key="wishList.selectedItems" />
			</h2>
			<dsp:droplet name="LZBWishListItemDroplet">
				<dsp:param name="id" value="${giftListId}" />
				<dsp:oparam name="output">

					<!-- display the item  based on id which is selected on main wishlist  -->

					<dsp:getvalueof var="wishlistItemId" param="wishListItem.id" />
					<dsp:getvalueof var="skuId" param="wishListItem.catalogRefId" />
					<dsp:valueof param="wishListItem.description" /> - <dsp:valueof
						param="wishListItem.displayName" />
					<br>

					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="wishListItem.configurationOptions" />
						<dsp:setvalue param="wishlistOptionItem" paramvalue="element" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="option"
								param="wishlistOptionItem.optionCatalogRefid" />
							<dsp:getvalueof var="suboptions" value="${suboptions}&${option}" />
							<dsp:valueof param="wishlistOptionItem.displayName" />
							<dsp:valueof param="wishlistOptionItem.Id" />:<dsp:valueof
								value="${option}" />
							<br />
							<input type="hidden" name="opt1" value="${suboptions}" />
						</dsp:oparam>
					</dsp:droplet>

					<dsp:droplet name="SKULookup">
						<dsp:param name="id" value="${skuId}" />
						<dsp:param name="elementName" value="sku" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="skuThumbImg" param="sku.thumbnailImage" />
													${skuThumbImg}
												</dsp:oparam>
					</dsp:droplet>

				</dsp:oparam>
			</dsp:droplet>
		</aside>
		</main>

	</lzb:pageContainer>
</dsp:page>
