<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder"/>
	<dsp:importbean bean="/atg/commerce/catalog/ProductLookup"/>
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup"/>

	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">npc checkout</jsp:attribute>

		<jsp:attribute name="title">
			<fmt:message key="account.wishlist.myWishlist" />
		</jsp:attribute>

		<lzb:breadCrumb pageKey="breadcrumb.wishlist" divClass="breadcrumb" />
		<a href=".cartDiaglog" class="cboxElement addToCartWL" data-module="cbox">
		 	<div class="cartDiaglogModalWrapper" title="Add to Cart" style="display:none">
		 		<div class="cartDiaglog" style="">
		 		</div>
		 	</div>
		</a>
		<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
			<dsp:importbean bean="/com/lzb/service/SessionBean"
				var="SessionBeanvar" />
			<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
			<dsp:importbean
				bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
			<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
			<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
			<dsp:getvalueof var="postalCode" bean="Profile.currentZipCode" />
			<dsp:importbean bean="/com/lzb/droplet/LZBWishListDisplayDroplet" />
			<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
			<dsp:getvalueof bean="GiftlistFormHandler.formError" var="giftformError" />
			<dsp:getvalueof bean="CartModifierFormHandler.formError" var="cartformError" />
			<dsp:getvalueof bean="ProfileFormHandler.formError" var="profileformError" />
			<dsp:importbean bean="/atg/userprofiling/Profile" />
			<c:if test="${giftformError eq  true || cartformError eq true || profileformError eq true}">
					<div class="message-container">
						<div class="message-wrapper">
							<dsp:include page="/global/giftlisterrors.jsp">
								<dsp:param name="formHandler" bean="GiftlistFormHandler" />
							</dsp:include>
							<dsp:include page="/global/errors.jsp">
								<dsp:param name="formHandler" bean="ProfileFormHandler" />
							</dsp:include>
							<dsp:include page="/global/errors.jsp">
								<dsp:param name="formHandler" bean="CartModifierFormHandler" />
							</dsp:include>
						</div>
					</div>
			</c:if>


		<main role="main" data-module="wishlistitems">
			<dsp:include page="/includes/leftnavigation.jsp">
				<dsp:param name="selpage" value="WISHLIST" />
			</dsp:include>

		<section role="region" class="my-account-content">
			<h1>
				<fmt:message key="account.wishlist.myWishlist" />
			</h1>

			<%-- Left-hand menu with highlighted 'Wish list' menu item --%>


			<dsp:form id="addAllItemsToOrderIds" name="addAllItemsToOrderIds" method="post" action="/rwd/checkout/cart.jsp">
				<c:if test="${SessionBeanvar.wishListRemovedSucessFully}">
					<fmt:message key="account.wishlist.delete" />
				</c:if>


				<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="Profile.wishlist.giftlistItems" />
					<dsp:setvalue param="wishlistItem" paramvalue="element" />

					<dsp:oparam name="empty">
						<div class="standard-border">
							<div class="info">
								<div class="info-mark">i</div>
							</div>
							<fmt:message key="account.wishlist.noWishlistItemsMsg" />
							<a href="#"><fmt:message key="account.wishlist.continueShoppingLbl" /></a>
						</div>
						<div>
							<fmt:message key="account.wishlist.continueShoppingLbl" />
							<fmt:message key="account.wishlist.noWishlistItemsMsg1" />
							<a href="#"><fmt:message key="account.wishlist.getStartedMsg" /></a>
							&mdash;
							<fmt:message key="account.wishlist.clickOnHeartMsg" />
						</div>
					</dsp:oparam>



					<dsp:oparam name="outputStart">
						<div class="wishlist-update">
							<fmt:message key="account.wishlist.zipCodeExplainMsg" />
							<input type="text" name="zipCode" class="zip-input" />
							<input type="submit" name="updatezipCodZe" value="Update" id="updateZipCodeBtn" class="btn-primary" />
						</div>
						<ul class="wishlist-nav">
							<li>
								<label class="wishlist-label"><input type="checkbox" id="selecct_all">
								<fmt:message key="account.wishlist.selectAll" /></label>
							</li>
							<%--
							<li>
								<a data-form="wishListItemEmail" class="modal cboxElement" href="/modals/wisthlistShareEmail.jsp?giftItemId=">
								<span class="wish-share">&nbsp;</span>
								<fmt:message key="account.wishlist.shareSelected" />
								<div class="change-arrow"></div>
								</a>
							</li>
							<li>
								<span class="wish-store">&nbsp;</span>
								<a href="#" class="modal add-locale-store">
									<fmt:message key="account.wishlist.checkWithMyStore" />
								</a>
							</li>
							 --%>
							<li>
								<span class="wish-remove">&nbsp;</span>
								<a href="#" class="remove-select-values">
								<fmt:message key="account.wishlist.removeItems" />
							</a>
							</li>
							<li>
							<!-- when user click on Add all to  cart button in that case only checked item into wishlist should move to cart  -->
					  			<!--if when user click on Add all to cart  in that case there is only one item in wishlist ,cart pop up should display just like cart pop on pdp-->
					  			<!--if when user click on Add all to shopping cart and in that case there is more then one item in wishlist ,all the item should added into cart and user redirect to cart page-->
							<!-- Please do not use button.as all the button are within a single form and it will always  the same form. -->
							<a href="#" class="orange-button add-selected-cart">
								<fmt:message key="account.wishlist.addItemsToCart" />
							</a>
							</li>
						</ul>

						<div class=" wishlist-heading">
								<div class="wishlist-heading wishlist-select"><fmt:message key="account.wishlist.select" /></div>
								<div class="wishlist-heading wishlist-description"><fmt:message key="account.wishlist.description" /></div>
								<div class="wishlist-heading wishlist-price"><fmt:message key="account.wishlist.price" /></div>
								<div class="wishlist-heading wishlist-add-date"><fmt:message key="account.wishlist.addedOn" /></div>
								<div class="wishlist-heading wishlist-item-options">&nbsp;</div>
							</div>
							</dsp:oparam>

							<dsp:oparam name="output">
							<dsp:getvalueof var="wishlistItemId" param="wishlistItem.id" />
								<div class="wishlist-item" id="wishlist-item_${wishlistItemId}">
								<dsp:droplet name="LZBPDPURLDroplet">
									<dsp:param name="productId" param="wishlistItem.catalogRefId" />
									<dsp:param name="prodName" param="wishlistItem.displayName" />
									<dsp:param name="fromCDP" value="true" />
									<dsp:param name="elementName" value="url" />
									<dsp:oparam name="output">
										<dsp:getvalueof var="url" param="url" />
									</dsp:oparam>
								</dsp:droplet>

								<dsp:getvalueof var="wishlistdescriptoon"
									param="wishlistItem.description" />
								<dsp:getvalueof var="pdpurl"
									value="${url}?giftId=${wishlistItemId}" />

									<div class="wishlist-select">
										<dsp:getvalueof var="wishlistItemId" param="wishlistItem.id" />
										<dsp:input type="checkbox"
											bean="CartModifierFormHandler.wishlistItemIds"
											value="${wishlistItemId}" name="wishlistcheckbox"
											id="wishlistcheckbox" iclass="wishlist-checkbox" />

											<dsp:droplet name="ProductLookup">
												<dsp:param name="id" param="wishlistItem.productId" />
												<dsp:param name="elementName" value="product" />
												<dsp:oparam name="output">
													<dsp:getvalueof var="product" param="product"/>
												</dsp:oparam>
											</dsp:droplet>
											<dsp:droplet name="SKULookup">
												<dsp:param name="id" param="wishlistItem.catalogRefId" />
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
														<dsp:param name="json" param="wishlistItem.requestJson"/>
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
													<c:set var="storeConfigHostName" value="${contentHostName}" />
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

										<a href="${contextPath}${pdpurl}" title="">
											<img src="${marxentImageURL}" width="75" alt="${wishlistdescriptoon}" />
											<meta property="og:image" content="${marxentImageURL}" />
										</a>
										</div>
									<div class="wishlist-description">

									<dsp:getvalueof var="suboptions" value="" />
										<dsp:valueof param="wishlistItem.description" /> -
										<dsp:valueof param="wishlistItem.displayName" />
										<br>
										<a href="${contextPath}${pdpurl}">
											<dsp:getvalueof var="suboptions" value="" />
											<dsp:valueof param="wishlistItem.description" /> -
											<dsp:valueof param="wishlistItem.displayName" />
											<br>

												<dsp:droplet name="LZBWishListDisplayDroplet">
												<dsp:param name="wishListItem" param="wishlistItem" />
												<dsp:oparam name="output">

												<dsp:getvalueof var="status" param="itemdiscontinued" />
												<dsp:getvalueof var="isOptionDiscontinued" param="isOptionDiscontinued" />
													<dsp:getvalueof var="priceString" param="configuartionOptionItem.priceString" />

													<dsp:getvalueof var="cover" param="configuartionOptionItem.cover" />

													<dsp:getvalueof var="pillow" param="configuartionOptionItem.pillow.item" />
													<dsp:getvalueof var="pillowSubOptions" param="configuartionOptionItem.pillow.subItem" />

														<dsp:getvalueof var="optionList" param="configuartionOptionItem.option" />

														<dsp:getvalueof param="wishlistItem.displayName" var="productDisplayName" />


													<c:choose>
														<c:when test="${status}">
															<span style="color: red">${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />, <fmt:message key="cart.addproduct" />.&nbsp;<a href="#">Hide</a></span>
														</br>
														</c:when>
														<c:when test="${isOptionDiscontinued}">
															<c:if test="${not empty cover }">
																<dsp:getvalueof value="${cover.status}" var="coverstatus" />
																<c:if test="${coverstatus eq 'D'}">
																	<br>
																	<span style="color: red">
																		The Cover&nbsp;<dsp:valueof param="configuartionOptionItem.cover.displayName" />
																		(${cover.id})&nbsp;<fmt:message key="cart.selected" />
																		&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,&nbsp;<fmt:message key="cart.newcover" />.
																		&nbsp;<a href="#">Hide</a>&nbsp;<a href="${contextPath}${pdpurl}">Edit Item</a></span>
																	<br>
																</c:if>
															</c:if>
															<c:if test="${not empty pillow }">
																	<dsp:getvalueof value="${pillow.status}" var="pillowstatus" />

																<c:if test="${pillowstatus eq 'D'}">

																	<br>
																	<span style="color: red">
																	The Option&nbsp;<dsp:valueof value="${pillow.displayName}" />
																		&nbsp;<fmt:message key="cart.selected" />&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,
																		&nbsp;<fmt:message key="cart.newoption" />.&nbsp;<a href="#">Hide</a>
																		&nbsp;<a href="${contextPath}${pdpurl}">Edit Item</a></span>
																	<br>
																</c:if>
															</c:if>
													<c:if test="${ not empty optionList}">
														<dsp:droplet name="ForEach">
															<dsp:param name="array" value="${optionList}" />
															<dsp:setvalue param="level2optionItem" paramvalue="element" />
															<dsp:oparam name="output">
															<dsp:getvalueof param="level2optionItem.item" var="optionItem" />
															<dsp:getvalueof param="optionItem.status" var="optionstatus" />
																<c:if test="${optionstatus eq 'D'}">
																	<br>
																	<span style="color: red">
																	The Option&nbsp;<dsp:valueof param="optionItem.displayName" />
																		&nbsp;<fmt:message key="cart.selected" />&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,
																		&nbsp;<fmt:message key="cart.newoption" />.&nbsp;<a href="#">Hide</a>
																		&nbsp;<a href="${contextPath}${pdpurl}">Edit Item</a></span>
																	<br>
																</c:if>

															</dsp:oparam>
														</dsp:droplet>
													</c:if>
														</c:when>
													</c:choose>

													<c:if test="${not empty cover }">
														<b>Cover :</b>&nbsp;<dsp:valueof param="configuartionOptionItem.cover.displayName" />(${cover.id})</br>
													</c:if>
													<c:if test="${ not empty pillow}">
														<b>Pillow :</b>&nbsp;<dsp:valueof value="${pillow.displayName}" />(${pillow.id})</br>
														<c:if test="${not empty pillowSubOptions}">
															<dsp:droplet name="ForEach">
																		<dsp:param name="array" value="${pillowSubOptions}" />
																		<dsp:setvalue param="pillowoptionItemInfo" paramvalue="element" />
																		<dsp:oparam name="outputStart">
																		<ul>
																		</dsp:oparam>
																			<dsp:oparam name="output">
																			<dsp:getvalueof var="pillowoptionItemInfo" param="pillowoptionItemInfo" />
																			<c:if test="${ not empty pillowoptionItemInfo}">
																					<li>
																					<c:out value="${pillowoptionItemInfo.displayName}" />
																						(<c:out value="${pillowoptionItemInfo.optionCatalogRefid}" />)
																					</li>
																			</c:if>
																			</dsp:oparam>
																			<dsp:oparam name="outputEnd">
																			</ul>
																		</dsp:oparam>
																		</dsp:droplet>
														</c:if>

													</c:if>
													<c:if test="${ not empty optionList}">
														<b></br>Selected custom options</b>
														</br>
														<dsp:droplet name="ForEach">
															<dsp:param name="array" value="${optionList}" />
															<dsp:setvalue param="secondlevelOption" paramvalue="element" />
															<dsp:oparam name="output">
																<dsp:valueof param="secondlevelOption.item.displayName" />
																<dsp:getvalueof var="thirdLevelOptions" param="secondlevelOption.subItem" />
																<c:if test="${not empty thirdLevelOptions}">
																		<dsp:droplet name="ForEach">
																		<dsp:param name="array" value="${thirdLevelOptions}" />
																		<dsp:setvalue param="optionItemInfo" paramvalue="element" />
																		<dsp:oparam name="outputStart">
																		<ul>
																		</dsp:oparam>
																			<dsp:oparam name="output">
																			<dsp:getvalueof var="optionItemInfo" param="optionItemInfo" />

																			<c:if test="${ not empty optionItemInfo}">
																				<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />

																				 <c:if test="${ not empty optionType and optionType eq 'optionCover'}">
																					<li>
																					<c:out value="${optionItemInfo.displayName}" />
																						(<c:out value="${optionItemInfo.optionCatalogRefid}" />)
																					</li>
																				</c:if>
																				<c:if test="${ not empty optionType}">
																					<li>
																						<c:out value="${optionItemInfo.displayName}" />
																					</li>
																				</c:if>

																			</c:if>


																			</dsp:oparam>
																			<dsp:oparam name="outputEnd">
																			</ul>
																		</dsp:oparam>
																		</dsp:droplet>
																</c:if>
																</br>
															</dsp:oparam>
														</dsp:droplet>
													</c:if>

												</dsp:oparam>
											</dsp:droplet>

									</a></div>
									<div class="wishlist-price">
										<dsp:droplet name="/atg/commerce/pricing/PriceItem">
											<dsp:param name="item" param="wishlistItem.catalogRefId" />
											<dsp:param name="quantity" param="wishlistItem.quantityDesired" />
											<dsp:param name="product" param="wishlistItem.productId" />
											<dsp:param name="jsonString" param="wishlistItem.requestJson" />
											<dsp:param name="profile" bean="Profile" />
											<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
											<dsp:param value="pricedItem" name="elementName" />
											<dsp:oparam name="output">
												<!-- Price -->
												<dsp:getvalueof var="listPrice"
													param="pricedItem.priceInfo.listPrice" />
												<dsp:getvalueof var="salePrice"
													param="pricedItem.priceInfo.salePrice" />
												<c:choose>
													<c:when test="${empty salePrice || salePrice <= 0.0}">
														<span>
															<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price" value="${listPrice}" />
															</dsp:include>
														</span>
													</c:when>
													<c:otherwise>
														<span>
															<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price" value="${listPrice}" />
															</dsp:include>
														 	</br>
														 	<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price" value="${salePrice}" />
															</dsp:include>
														</span>
													</c:otherwise>
												</c:choose>
											</dsp:oparam>
										</dsp:droplet>
										</div>
									<div class="wishlist-add-date"><dsp:valueof param="wishlistItem.creationDate" date="yyyy-MM-dd">null</dsp:valueof></div>
									<div class="wishlit-icon wishlist-item-options share-icons" data-module="social-share-icons social-share" data-imageUrl="${marxentImageURL}">
											<!-- When user adding single item into cart in that case add item to cart popup window should display jsut like on pdp add to cart pop window is displaying -->
											<c:if test="${not status && not isOptionDiscontinued}">
												<a href="#" class="wish-addcart-anchor" giftlistid="${wishlistItemId}" data-coverid="${cover.id}" data-prodname="${productDisplayName }">
													<span class="wish-addcart">&nbsp;</span>
													<fmt:message key="account.wishlist.addItemsToCart" />
												</a>
											</c:if>

											<!-- When user remove item from cart page should not refersh.It should be ajax call -->
											<a id="removeWishListAnchorId" href="#" title="${wishlistItemId}" giftlistid="${wishlistItemId}">
											<span class="wish-remve">&nbsp;</span>
												<fmt:message key="account.wishlist.remove" />
											</a>
	                                       <c:if test="${not status && not isOptionDiscontinued}">




												<a class="social-share-click">
													<span class="wish-sharitm">&nbsp;</span><fmt:message
														key="account.wishlist.shareItem" />
												</a>
												<ul class="social-bubble pdp-social-bubble">
						                          <li>
						                			<a href="https://www.facebook.com/lazboy" data-service="facebook" title="Facebook">
						                				<%-- <img width="36" height="35" src="//content.la-z-boy.com/Images/elementsImages/share_fb.png" alt="Like on Facebook"> --%>
						                				<img src="//${storeConfig.contentHostName}/Images/social-share-icons/fb-share-button-35h.png" alt="Like on Facebook" />
						                			</a>
						                          </li>
						                          <li>
						                              <a href="https://twitter.com/intent/tweet" data-service="twitter" title="Twitter"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Twit.png" alt="Twitter"></a>
						                          </li>
						                          <li>
						                              <a title="Pinterest" href="#" data-service="pinterest" data-sharesku="${wishlistItemId}"><img width="36" height="35" alt="Twitter" src="//content.la-z-boy.com/Images/fg/ico_fg_pinit.png"></a>
						                          </li>
						                          <%--
																			<li>
						                              <a href="/modals/wisthlistShareEmail.jsp?giftItemId=${wishlistItemId}" class="modal cboxElement" data-form="wishListItemEmail"><img width="36" height="35" src="//content.la-z-boy.com/Images/fg/ico_fg_Email.png" alt="Mailing List"></a>
						                          </li>
																			 --%>
						                      </ul>


											<%--
											<div data-speed="500" data-transition="elastic"
												data-classname="wishlist-modal" data-module="cbox" class="">
												<a href="/modals/wisthlistShareEmail.jsp?skuId=${wishlistItemId}"
													class="modal cboxElement" data-form="wishListItemEmail">
													<span class="wish-sharitm">&nbsp;</span><fmt:message
														key="account.wishlist.shareItem" />
												</a>
											</div>
											 --%>
											</c:if>
										</div>


								</div>
							</dsp:oparam>

							<dsp:oparam name="outputEnd">

						<div class="wishlist-but wishlist-link">
							<a href="/rwd/checkout/cart.jsp"><fmt:message key="account.wishlist.continueShopping" /></a> <span>
								 <a href="javascript:window.print()" class="btn-primary">	<fmt:message key="account.wishlist.printWishlist" /></a>
								 <input type="hidden" value="" id="allWishlistItemIdToAddOrder" name="allWishlistItemIdToAddOrder" />
								 <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/rwd/checkout/cart.jsp" />
								<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/account/wish_list_items.jsp" />
								<dsp:input type="hidden" bean="CartModifierFormHandler.addAllSelectedWishlistItemToOrder" value="true"  />
					  			<!-- when user click on Add all to shopping cart button in that case it does not matter check box is chekced or not all the item into wishlist should move to cart  -->
					  			<!--if when user click on Add all to shopping cart and in that case there is only one item in wishlist ,cart pop up should display just like cart pop on pdp-->
					  			<!--if when user click on Add all to shopping cart and in that case there is more then one item in wishlist ,all the item should added into cart and user redirect to cart page-->
					  			<a href="#" class="btn-primary add-all-cart">ADD ALL TO SHOPPING CART</a>

							</span>
						</div>
					</dsp:oparam>
				</dsp:droplet>

			</dsp:form>

			<dsp:form name="addItemToCartFromWishlist"
				id="addItemToCartFromWishlist" method="post"
				action="/account/wish_list_items.jsp">
				<input type="hidden" value="" id="wishlistItemIdToAddOrder"
					name="wishlistItemIdToAddOrder" />
				<dsp:input type="hidden"
					bean="CartModifierFormHandler.addItemToOrderSuccessURL"
					value="../cart/json/cartSuccessJson.jsp" />
				<dsp:input type="hidden"
					bean="CartModifierFormHandler.addItemToOrderErrorURL"
					value="../cart/json/cartSuccessJson.jsp" />
				<dsp:input type="hidden"
					bean="CartModifierFormHandler.addWishlistItemToOrder" value="true" />
			</dsp:form>
			<dsp:form name="removeSelectedItemFromWishList"
				id="removeSelectedItemFromWishList" method="post"
				action="/account/wish_list_items.jsp">
				<input type="hidden" value="" id="wishlistItemIdToRemove"
					name="wishlistItemIdToRemove" />
				<dsp:input type="hidden"
					bean="GiftlistFormHandler.updateGiftlistItemsErrorURL"
					value="/account/wish_list_items.jsp" />
				<dsp:input type="hidden"
					bean="GiftlistFormHandler.updateGiftlistItemsSuccessURL"
					value="/account/wish_list_items.jsp" />
				<dsp:input type="hidden"
					bean="GiftlistFormHandler.removeGiftlistItems" value="true" />
			</dsp:form>
			<dsp:form id="changeDealer"
				action="/account/wish_list_items.jsp"
				method="post" name="changeDealer" formid="changeDealer">
				<dsp:input bean="ProfileFormHandler.setChangeStoreSuccessURL"
					value="/account/wish_list_items.jsp" type="hidden" />
				<dsp:input bean="ProfileFormHandler.setChangeStoreErrorURL"
					value="/account/wish_list_items.jsp"
					type="hidden" />
				<input type="hidden" value="" id="zipCodeId" name="zipCode" />
				<dsp:input type="hidden"
					bean="ProfileFormHandler.updateDealerStoreBasedOnZipCode"
					value="true" />
			</dsp:form>
			<dsp:setvalue bean="SessionBean.wishListRemovedSucessFully" value="false" />
		</section>
		</main>
		<script type="text/javascript">





		</script>
	</lzb:pageContainer>

</dsp:page>
