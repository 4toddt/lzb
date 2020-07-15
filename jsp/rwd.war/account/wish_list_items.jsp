<%--
  - File Name: wish_list_items.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the users Wish List
  --%>

<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="postalCode" bean="Profile.currentZipCode" />
	<dsp:getvalueof bean="Profile.wishlist.giftlistItems" var="giftlistItems" />
	

	<layout:default>
		<jsp:attribute name="pageTitle">Wish List</jsp:attribute>
		<jsp:attribute name="metaDescription"></jsp:attribute>
		<jsp:attribute name="metaKeywords"></jsp:attribute>
		<jsp:attribute name="seoCanonicalURL"></jsp:attribute>
		<jsp:attribute name="seoRobots">index,follow</jsp:attribute>
		<jsp:attribute name="lastModified"></jsp:attribute>
		<jsp:attribute name="section">account</jsp:attribute>
		<jsp:attribute name="pageType">wishList</jsp:attribute>
		<jsp:attribute name="bodyClass">account wish-list</jsp:attribute>
		<jsp:attribute name="analyticsPageType">accountWishlistPage</jsp:attribute>
		<jsp:body>

			<%-- breadcrumbs --%>
			<section class="breadcrumbs">
				<ul aria-label="breadcrumbs" role="navigation">
					<li><a class="crumb" href="${contextPath}/"><fmt:message key="breadcrumb.home"/></a></li>
					<li><a class="crumb" href="${contextPath}/account/account.jsp"><fmt:message key="breadcrumb.dashboard"/></a></li>
					<li><span class="crumb active"><fmt:message key="breadcrumb.wishlist"/></span></li>
				</ul>
			</section>

			<div class="section-title">
				<h1><fmt:message key="account.wishlist.myWishlist"/></h1>
			</div>

			<!-- page content-->
			<div class="section-row">
				<div class="account-two-column-container">
					<div class="account-two-column-left hide">
						<dsp:include page="/account/includes/leftnavigation.jsp">
							<dsp:param name="selpage" value="WISHLIST" />
						</dsp:include>
					</div>
					<div class="account-two-column-right">
						<section role="region" class="my-account-content">
							<%-- <div class="section-title hide-for-small">
								<h1><fmt:message key="account.wishlist.myWishlist"/></h1>
							</div> --%>
							<div class="wish-list-content">
								<c:choose>
									<c:when test="${empty giftlistItems}">
										<%-- wish list empty --%>
										<%@ include file="/account/fragments/wishListEmpty.jspf"%>
									</c:when>
									<c:otherwise>
										<h2>You have <span class="wishlist-item-count">${fn:length(giftlistItems)} ${fn:length(giftlistItems) == 1 ? ' item' : ' items'}</span> in your wishlist</h2>
										
										<%-- wish list zipcode updates --%>
										<div class="wishlist-update">
											<p><fmt:message key="account.wishlist.zipCodeExplainMsg" /></p>
											<dsp:form id="changeDealer" formid="changeDealer" action="/account/wish_list_items.jsp" method="post" name="changeDealer" data-validate>
												<div class="field-group">
													<label for="zipcode"><fmt:message key="account.wishlist.zip" /><span class="sr-only"><fmt:message key="account.wishlist.zip" /></span></label>
													<input id="zipcode" class="zipCode" name="zipCode" type="text" autocapitalize="off" data-validation="required uspostal" data-fieldname="Zip code" placeholder="5 digits*"/>
													<dsp:input bean="ProfileFormHandler.setChangeStoreSuccessURL" value="${contextPath}/account/json/changeDealerStoreSuccess.jsp" type="hidden" />
													<dsp:input bean="ProfileFormHandler.setChangeStoreErrorURL"value="${contextPath}/account/json/profileError.jsp" type="hidden" />
													<dsp:input type="submit" id="updateZipCodeBtn" bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode" class="button secondary updateZipCodeBtn" value="Update"/>
												</div>
											</dsp:form>
										</div>
										
										<%-- add item to cart form --%>
										<dsp:form name="addItemToCartFromWishlist" id="addItemToCartFromWishlist" formid="addItemToCartFromWishlist" method="post" action="/account/wish_list_items.jsp">
											<input type="hidden" value="" id="wishlistItemIdToAddOrder" name="wishlistItemIdToAddOrder" />
											<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${contextPath}/account/json/wishListSuccess.jsp" />
											<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${contextPath}/account/json/wishListError.jsp" />
											<dsp:input type="hidden" bean="CartModifierFormHandler.addWishlistItemToOrder" value="true" />
										</dsp:form>
										
										<%-- remove item from wish list --%>
										<dsp:form name="removeSelectedItemFromWishList" id="removeSelectedItemFromWishList" formid="removeSelectedItemFromWishList" method="post" action="/account/wish_list_items.jsp">
											<input type="hidden" value="" id="wishlistItemIdToRemove" name="wishlistItemIdToRemove" />
											<dsp:input type="hidden" bean="GiftlistFormHandler.updateGiftlistItemsErrorURL" value="${contextPath}/account/json/wishListError.jsp" />
											<dsp:input type="hidden" bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL" value="${contextPath}/account/json/removeWishListItemSuccess.jsp" />
											<dsp:input type="hidden" bean="GiftlistFormHandler.removeGiftlistItems" value="true" />
										</dsp:form>
										
										<%-- wish list header --%>
										<div class="order-items-header hide">
											<div class="order-items-header-detail"><fmt:message key="account.wishlist.select" /></div>
											<div class="order-items-header-description"><fmt:message key="account.wishlist.description" /></div>
											<div class="order-items-header-price"><fmt:message key="account.wishlist.price" /></div>
											<div class="order-items-header-add-date"><fmt:message key="account.wishlist.addedOn" /></div>
											<div class="order-items-header-links">&nbsp;</div>
										</div>
										
										<%-- wish list content --%>
										<dsp:form id="addAllItemsToOrderIds" formid="addAllItemsToOrderIds" name="addAllItemsToOrderIds" method="post" action="/cart/cart.jsp">
											<dsp:droplet name="ForEach">
												<dsp:param name="array" bean="Profile.wishlist.giftlistItems" />
												<dsp:setvalue param="wishlistItem" paramvalue="element"/>
												<dsp:oparam name="output">
													<dsp:getvalueof var="wishlistItemId" param="wishlistItem.id" />
													<div class="wishlist-item" id="wishlist-item_${wishlistItemId}">
														<%@ include file="/account/fragments/wishListOrderItem.jspf"%>
													</div>
												</dsp:oparam>
											</dsp:droplet>
										</dsp:form>
										
										<%-- wish list actions --%>
										<div class="wish-list-actions">
											<div class="wish-list-buttons">
												<a href="${contextPath}/" class="primary"><span class="icon icon-arrow-left"></span>Continue Shopping</a>
											</div>
										</div>
				
									</c:otherwise>
								</c:choose>
							</div
						</section>
					</div>
				</div>
			</div>
			
		</jsp:body>
	</layout:default>

</dsp:page>
