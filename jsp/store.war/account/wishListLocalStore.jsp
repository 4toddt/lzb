<dsp:page>

<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>
<dsp:importbean bean="/com/lzb/droplet/LZBWishListItemDroplet"/>
<dsp:getvalueof param="skuId" var="giftListId"/>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder"/>


<lzb:pageContainer>

		<jsp:attribute name="pageSpecificJS">
		</jsp:attribute>

		<jsp:attribute name="bodyClass">two-column-last npc wish-list-local-store</jsp:attribute>

<jsp:body>
<dsp:getvalueof param="success" var="successMsg"/>
<c:if test="${successMsg eq 'true' }">
	<fmt:message key="wishlist.successMsgs"/>
</c:if>
<main role="main">

				<section role="region" class="wishlist-storeinfo">

		<h1><fmt:message key="wishList.contactText"/></h1>
		<div>
			<p><fmt:message key="wishList.infoText"/><br/>
			<fmt:message key="wishList.localStoreInfo"/></p>
		</div>
		<h4><fmt:message key="account.wishlist.requiredFields"/></h4>
		<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError"/>

			<c:if test="${formError eq 'true'}">
				<dsp:include page="/includes/global/errors.jsp">
				<dsp:param name="formHandler" bean="GiftlistFormHandler"/>
				</dsp:include>
			</c:if>
	<div>
			<p><fmt:message key="wishList.storeContact"/></p>

			<p>
				<fmt:message key="wishList.storeInfo"/><br/>
				<dsp:getvalueof var="currentStore" bean="Profile.currentStore"/>
				<dsp:getvalueof var="preferredStore" bean="Profile.preferredStore"/>
				<c:choose>
					<c:when test="${not empty preferredStore}">
						<dsp:getvalueof var="store" value="${preferredStore}"/>
					</c:when>
					<c:otherwise>
						<dsp:getvalueof var="store" value="${currentStore}"/>
					</c:otherwise>
				</c:choose>

				<c:set var="storeEmail" value="${store.email}"/>
				${store.name}<br/>
				${store.address1},${store.address2},${store.city},<br/>
				${store.stateAddress},${store.country},${store.postalCode}<br/>
			</p>


				<div><!-- need to add logic for store to display store to contact detail -->
 			<dsp:getvalueof var="prefStoreUrl" value="${Store.storeWebsiteUrl}"/>
		   <c:choose>
			    <c:when test="${not empty prefStoreUrl}">
			     <dsp:getvalueof var="storeUrl" value="${prefStoreUrl}"/>
			    </c:when>
		    <c:otherwise>
		   		 <dsp:getvalueof var="storeUrl" value="#"/>
		    </c:otherwise>
		   </c:choose>
		   <dsp:a href="${storeUrl}"><fmt:message key="wishList.visitWebsite"/></dsp:a>|
		   <dsp:a href="#">
			    <fmt:message key="wishList.getDirections"/>
			    <input type="hidden" name="longitude" value="${Store.longitude}"/>
			    <input type="hidden" name="latitude" value="${Store.latitude}"/>
		   </dsp:a>|
		   <dsp:a href="${sitebaseurl}/work/storeLocator/storeLocator.jsp"><fmt:message key="wishList.changeStore"/></dsp:a>
		  </div>
			</div>
				<br/><br/>
			<div>

	<dsp:form name="wishlistStore" method="post">
		<fieldset>
			<label><fmt:message key="wishList.yourName"/></label>

				<dsp:input type="text"  name="yourName" bean="GiftlistFormHandler.profileValueMap.fullName" maxlength="50" value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.yourEmail"/></label>

				<dsp:input type="text"  name="yourEmail" bean="GiftlistFormHandler.profileValueMap.email" maxlength="50" value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.address"/></label>

				<dsp:input type="text"  name="yourAddress" bean="GiftlistFormHandler.profileValueMap.address" maxlength="50" value=""/>

		</fieldset>

		<fieldset>
			<label><fmt:message key="wishList.city"/></label>

				<dsp:input type="text"  name="yourCity" bean="GiftlistFormHandler.profileValueMap.city" maxlength="50" value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.state"/></label>


					<c:choose>
					<c:when test="${not empty stateCode}">
						<dsp:param name="statePicker" value="${stateCode}" />
					</c:when>
					<c:otherwise>
						<dsp:param name="statePicker" value="${editAddress.state}"/>
					</c:otherwise>
					</c:choose>
						<span>
						   <dsp:select id="atg_store_stateSelect" name="atg_store_stateSelect" bean="GiftlistFormHandler.profileValueMap.state"
								nodefault="true"><%@include file="/includes/global/countryState.jsp"%>
							</dsp:select>
						</span>


		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.zipCode"/>*</label>

				<dsp:input type="text"  name="yourPostalCode" bean="GiftlistFormHandler.profileValueMap.postalCode" maxlength="50" value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.phone"/></label>

				<dsp:input type="text"  name="yourPhone" bean="GiftlistFormHandler.profileValueMap.phoneNumber" maxlength="50" value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.comments"/></label>

				<dsp:textarea  name="yourComments"  bean="GiftlistFormHandler.profileValueMap.comments" maxlength="50"  default=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.verifictionImage"/></label>

				 <span><img src="captchaImage.jpg"></span>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.verificationNumber"/></label>


				<dsp:input type="text"  name="captchaImageNumber" bean="GiftlistFormHandler.profileValueMap.captchaImageNumber"  value=""/>

		</fieldset>
		<fieldset>
			<label><fmt:message key="wishList.respondRadioText"/></label>

			<dsp:input type="radio"  name="selectradio" bean="GiftlistFormHandler.profileValueMap.respondMedium"  value="phone" checked="true"/>
			<label class="short-label"><fmt:message key="wishList.phone"/></label>
			<dsp:input type="radio"  name="selectradio" bean="GiftlistFormHandler.profileValueMap.respondMedium"  value="email"/>
			<label class="short-label"><fmt:message key="wishList.email"/></label>
		</fieldset>
		<fieldset class="buttons-wrapper">
		<dsp:getvalueof var="giftListItems" bean="Profile.wishlist.giftlistItems"/>
		<dsp:input  type="hidden" bean="GiftlistFormHandler.giftItemsValueMap.wishlistItem" value="${giftListItems}"/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.giftItems" value="${giftListId}"/>
		<dsp:input  type="hidden" bean="GiftlistFormHandler.profileValueMap.storeEmail" value="${storeEmail}"/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.wishListerrorURL" value="${pageContext.request.contextPath}/account/wishListLocalStore.jsp?error"/>
		<dsp:input type="hidden" bean="GiftlistFormHandler.wishListsuccessURL" value="${pageContext.request.contextPath}/account/wishListLocalStore.jsp?success=true"/>
		<dsp:a href="${pageContext.request.contextPath}/account/wish_list_items.jsp" ><fmt:message key="profile.cancel"/></dsp:a>

		<input type="submit" class="btn-primary" value="SEND TO STORE" name="/atg/commerce/gifts/GiftlistFormHandler.wishListLocalStore">
		</fieldset>
	</dsp:form>




	</div>
	</section>
	<aside  class="mywishlist-item" role="complementary">
			<h2>
				<fmt:message key="wishList.selectedItems" />
			</h2>
			<div class="wishlist-scroll">
			<dsp:droplet name="LZBWishListItemDroplet">
				<dsp:param name="id" value="${giftListId}" />
				<dsp:oparam name="output">

					<!-- display the item  based on id which is selected on main wishlist  -->
					<div class="mywishlist-item">
						<dsp:getvalueof var="wishlistItemId" param="wishListItem.id" />
						<dsp:getvalueof var="skuId" param="wishListItem.catalogRefId" />
						<dsp:valueof param="wishListItem.description" />

						<dsp:droplet name="/com/lzb/droplet/LZBGiftItemLookUp">
							<dsp:param name="id" value="${wishlistItemId}"/>
							<dsp:param value="giftItem" name="elementName"/>
							<dsp:oparam name="output">
								<dsp:getvalueof var="giftItemPrdId" param="giftItem.productId"/>
								<dsp:getvalueof var="giftItemJson" param="giftItem.requestJson"/>
							</dsp:oparam>
						</dsp:droplet>

						<dsp:droplet name="ProductLookup">
							<dsp:param name="id" value="${giftItemPrdId}" />
							<dsp:param name="elementName" value="product" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="product" param="product"/>
							</dsp:oparam>
						</dsp:droplet>
						<dsp:droplet name="SKULookup">
							<dsp:param name="id" value="${skuId}" />
							<dsp:setvalue param="sku" paramvalue="element" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="sku" param="sku"/>
							</dsp:oparam>
							<dsp:oparam name="wrongCatalog">
								<dsp:getvalueof var="sku" param="sku"/>
      						</dsp:oparam>
						</dsp:droplet>
						<c:set var="isActive" value="A" scope="request"/>
						<c:set var="isPurchasable" value="true" scope="request"/>
						<c:choose>
        					<c:when test="${empty sku.status}">
            					<c:set var="isActive" value="D" scope="request" />
        					</c:when>
        					<c:otherwise>
            					<c:set var="isActive" value="${sku.status}" scope="request" />
        					</c:otherwise>
    					</c:choose>
						<c:choose>
							<c:when test="${empty sku.isPurchaseable}">
								<c:set var="isPurchasable" value="false" scope="request" />
							</c:when>
							<c:otherwise>
								<c:set var="isPurchasable" value="${sku.isPurchaseable}" scope="request" />
							</c:otherwise>
						</c:choose>
						<c:set var="validMarxentProduct" value="false"/>
						<c:if test="${(sku.type eq 'configurableSku' && isPurchasable eq 'true' && isActive eq 'A') || (product.type eq 'sectional' && isActive eq 'A')}">
							<c:set var="validMarxentProduct" value="true"/>
						</c:if>

						<%-- Droplet used to build Marxent Imager URL --%>
						<c:choose>
							<c:when test="${storeConfig.marxentImagerEnabled && validMarxentProduct}">
								<dsp:getvalueof var="marxentImageURL" value="/"/>
								<dsp:droplet name="LZBImageURLBuilder">
									<dsp:param name="json" value="${giftItemJson}"/>
									<dsp:param name="width" value="75"/>
									<dsp:param name="height" value="75"/>
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
								<%-- when Marxent Imager is disabled or it is not an Marxent product use a fallback image --%>
								<c:set var="contentHostName" value="${pageContext.request.scheme}://${storeConfig.contentHostName}"/>
								<c:set var="storeConfigHostName" value="${contentHostName}"/>
								<c:set var="imagePath" value="${storeConfig.imagePath}"/>
								<c:choose>
									<c:when test="${not empty product.type && product.type eq 'sectional'}">
										<c:set var="cdpImage" value="${product.cdpImage}"/>
									</c:when>
									<c:otherwise>
										<c:set var="cdpImage" value="${sku.cdpDefaultImage}"/>
									</c:otherwise>
								</c:choose>
								<c:set var="marxentImageURL" value="${storeConfigHostName}${imagePath}${cdpImage}"/>
							</c:otherwise>
						</c:choose>

						<div class="wishlist-select">
							<img src="${marxentImageURL}" width="75" alt="${wishlistdescriptoon}" />
							<meta property="og:image" content="${marxentImageURL}" />
						</div>

						<div class="wishlist-cover">
						<strong><dsp:valueof param="wishListItem.displayName" /></strong>

						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="wishListItem.configurationOptions" />
							<dsp:setvalue param="wishlistOptionItem" paramvalue="element" />
							<dsp:oparam name="output">
								<p>
								<dsp:getvalueof var="option"
									param="wishlistOptionItem.optionCatalogRefid" />
								<dsp:getvalueof var="suboptions" value="${suboptions}&${option}" />
								<dsp:valueof param="wishlistOptionItem.displayName" />
								<dsp:valueof param="wishlistOptionItem.Id" />:<dsp:valueof
									value="${option}" />

								<input type="hidden" name="opt1" value="${suboptions}" />
								</p>
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
						</div>
					</div>
				</dsp:oparam>
			</dsp:droplet>
			</div>
		</aside>
        </main>
	</jsp:body>
	</lzb:pageContainer>
</dsp:page>
