<%--
  This gadget renders the header for the item list on the Shopping Cart page. It then
  iterates through the cart, rendering each item. Details included with each item are:
  Required parameters:
    None.

  Optional parameters:
    None.
--%>

<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean var="profile" bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBItemStatusDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>

	<%-- Get the items in the shopping cart --%>
	<dsp:droplet name="LZBDisplayCartItemsDroplet">
		<dsp:param name="order" bean="ShoppingCart.current" />
		<dsp:param name="profile" bean="Profile" />
		<dsp:param name="cart" value="true" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="cartItems" param="cartItems" />
			<dsp:form id="updateItemToCartId" name="updateItemToCart" method="post" action="${siteBaseUrl}/cart/cart.jsp" iclass="cartForm">
				<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderErrorURL" value="${siteBaseUrl}/cart/cart.jsp" />
				<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" />

				<dsp:getvalueof var="discontinueditemexistsinorder" param="discontinueditemexists" />
				<c:if test="${discontinueditemexistsinorder}">
					<h3>
						<fmt:message key="cart.discontinueditemexistsmsg" />
					</h3>
				</c:if>

				<table id="lzb_store_itemTable" data-module="updatecart" aria-label="items in cart">
					<%--
				        Display the headers in the form of site, item, price, quantity, total for the items
				        in the shopping cart.
				      --%>
					<thead>
						<tr>
							<th><fmt:message key="cart.tableH1" /></th>
							<th><fmt:message key="cart.tableH2" /></th>
							<th><fmt:message key="cart.tableH3" /></th>
							<th><fmt:message key="cart.tableH4" /></th>
							<%-- JIRA DMI-1763 Hide Wishlist UI
							<th>Edit/Remove/Wishlist</th>
							--%>
							<th>Edit/Remove</th>
						</tr>
					</thead>
					<tbody>
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItems" />
							<dsp:param name="elementName" value="cartItem" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id" />
								<dsp:getvalueof var="catalogRefId" param="cartItem.commerceItem.catalogRefId" />
								
								<!--  DOUG commerceItem = ${cartItem.commerceItem} -->
								
								<dsp:droplet name="LZBPDPURLDroplet">
													<dsp:param name="productId" value="${catalogRefId}" />
													<dsp:param name="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
													<dsp:param name="fromCDP" value="true" />
													<dsp:param name="elementName" value="url" />
													<dsp:oparam name="output">
														<dsp:getvalueof var="pdpurl" param="url" />
													</dsp:oparam>
								</dsp:droplet>
								<tr>
									<td>
									
										<dsp:include page="/includes/styleCollectionsByItem.jsp">
										<dsp:param name="skuId"	value="${catalogRefId}" />
										<dsp:param name="skuItem" param="cartItem.commerceItem.auxiliaryData.catalogRef"/>
										<dsp:param name="coverId" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
										</dsp:include>
									
										<dsp:include page="/global/gadgets/cartItemImage.jsp">
											<dsp:param name="cartItem" param="cartItem" />
											<dsp:param name="asLink" value="${pdpurl}?commid=${commerceItemId}" />
										</dsp:include>
										<ul class="shopping-cart-sublist">
											<li>
												<a href="${cotextPath}${pdpurl}?commid=${commerceItemId}">
													<dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
												</a>
													<dsp:getvalueof var="skuId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id" />
													<dsp:getvalueof var="productId" param="cartItem.commerceItem.auxiliaryData.productRef.id" />
													<dsp:droplet name="ForEach">
														<dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories" />
														<dsp:param name="elementName" value="category" />
														<dsp:oparam name="output">
															<dsp:getvalueof var="categoryName" param="category.displayName" />
														</dsp:oparam>
													</dsp:droplet>

													<dsp:getvalueof param="cartItem.commerceItem.auxiliaryData.catalogRef.status" var="status" /> <%-- pdp url --%>

													<dsp:droplet name="LZBItemStatusDroplet">
														<dsp:param name="commerceitem" param="cartItem.commerceItem" />
														<dsp:oparam name="output">
															<dsp:getvalueof var="status" param="itemdiscontinued" />
															<dsp:getvalueof var="isOptionDiscontinued" param="isOptionDiscontinued" />
														</dsp:oparam>
													</dsp:droplet>
													<dsp:getvalueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" var="productDisplayName" />
													<c:choose>
														<c:when test="${status}">
															<span class="cart-content-item-error">
																${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />, <fmt:message key="cart.addproduct" />.&nbsp;
																<a href="#">Hide</a>
															</span>
														</c:when>
														<c:when test="${isOptionDiscontinued}">
															<dsp:getvalueof var="coverItem" param="cartItem.coverItem" />
															<c:if test="${not empty coverItem}">
																<dsp:getvalueof param="cartItem.coverItem.auxiliaryData.catalogRef.status" var="coverstatus" />
																<c:if test="${coverstatus eq 'D'}">
																	<span class="cart-content-item-error">
																		The Cover&nbsp;<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName" />
																		(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id" />)&nbsp;<fmt:message key="cart.selected" />
																		&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,&nbsp;<fmt:message key="cart.newoption" />.
																		&nbsp;
																		<a href="#">Hide</a>&nbsp;
																		<a href="${cotextPath}${pdpurl}?ac=edit&commid=${commerceItemId}">Edit Item</a>
																	</span>
																</c:if>
															</c:if>
															<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem" />
															<c:if test="${not empty pillowItem}">
																<dsp:getvalueof param="cartItem.pillowItem.auxiliaryData.catalogRef.status" var="pillowstatus" />
																<c:if test="${pillowstatus eq 'D'}">
																	<span class="cart-content-item-error">
																		The Option&nbsp;<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName" />
																		&nbsp;<fmt:message key="cart.selected" />&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,
																		&nbsp;<fmt:message key="cart.newoption" />.&nbsp;<a href="#">Hide</a>
																		&nbsp;<a href="${cotextPath}${pdpurl}?ac=edit&commid=${commerceItemId}">Edit Item</a>
																	</span>																	
																</c:if>
															</c:if>
															<dsp:getvalueof var="customOptions" param="cartItem.customOptions" />
															<c:if test="${ not empty customOptions }">
																<dsp:droplet name="ForEach">
																	<dsp:param name="array" param="cartItem.customOptions" />
																	<dsp:param name="elementName" value="customOption" />
																	<dsp:oparam name="output">
																		<dsp:getvalueof param="customOption.auxiliaryData.catalogRef.status" var="optionstatus" />
																		<c:if test="${optionstatus eq 'D'}">
																			<span class="cart-content-item-error">
																				The Option&nbsp;<dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
																				&nbsp;<fmt:message key="cart.selected" />&nbsp;${productDisplayName}&nbsp;<fmt:message key="car.discontinued" />,
																				&nbsp;<fmt:message key="cart.newoption" />.&nbsp;<a href="#">Hide</a>
																				&nbsp;<a href="${cotextPath}${pdpurl}?ac=edit&commid=${commerceItemId}">Edit Item</a>
																			</span>
																			<br>
																		</c:if>
																	</dsp:oparam>
																</dsp:droplet>
															</c:if>
														</c:when>
													</c:choose>
											</li>
											<li>
											
													<fmt:message key="cart.cover" /> <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName" />
													(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id" />)
											</li>
											
											<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem" />
											<c:if test="${ not empty pillowItem }">
												<li>
														<fmt:message key="cart.pillow" />
														<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName"/>&nbsp;(<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.id"/>)
														<dsp:getvalueof var="pillowoptionItemInfo" value="${pillowItem.optionInfo}" />
														<c:if test="${ not empty pillowoptionItemInfo}">
																	<ul>
                                                                                   <li>
																					<c:out value="${pillowoptionItemInfo.colorName}" />
																						(<c:out value="${pillowoptionItemInfo.optionValue}" />)
																					</li>
																	</ul>
														</c:if>

												</li>
											</c:if>
											<dsp:getvalueof var="customOptions" param="cartItem.customOptions" />
											<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
											<dsp:include page="/cart/gadgets/sectionalOptionalItemsFragment.jsp">
														<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
														<dsp:param name="customOptions" value="${customOptions}" />
											</dsp:include>
										</ul>
									</td>
									<td class="price">
										<!-- Price -->
										<dsp:getvalueof var="listPrice" param="cartItem.listPrice" />
										<dsp:getvalueof var="salePrice" param="cartItem.salePrice" />
										<c:choose>
											<c:when test="${empty salePrice || salePrice <= 0.0}">
												<span>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${listPrice}" />
													</dsp:include>
												</span>
											</c:when>
											<c:otherwise>
												<p>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${listPrice}" />
													</dsp:include>
												</p>
												<p>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${salePrice}" />
													</dsp:include>
												</p>
											</c:otherwise>
										</c:choose>
									</td>
									<td data-prodsku="${skuId }" data-prodgroup="${categoryName }" data-prodname="${productId}" data-prodqty="<dsp:valueof param='cartItem.commerceItem.quantity'/>">
										<!-- Quantity -->
										<dsp:getvalueof var="commId" param="cartItem.commerceItem.id" />
										<label for="updateCommItem_${commId}">Quantity</label>
										<input type="text" size="3" class="quantity" id="updateCommItem_${commId}" name="<dsp:valueof param='cartItem.commerceItem.id'/>" value="<dsp:valueof param='cartItem.commerceItem.quantity'/>">
										<c:if test="${not status && not isOptionDiscontinued}">
										
										<a id="updateCommItem" href="#" rel="${commId}" value="<dsp:valueof param='cartItem.commerceItem.quantity'/>">
										<fmt:message key="cart.update" />
										</a>
										</c:if>
									</td>
									<td>
										<!-- Total -->
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="price" param="cartItem.itemTotal" />
										</dsp:include>
									</td>
									<td>
										<!--  buttons-->
										<c:if test="${not status}">
											<dsp:a href="${cotextPath}${pdpurl}?ac=edit&commid=${commId}">
												<fmt:message key="cart.edit" />
											</dsp:a>
										</c:if>
										<br />
										<dsp:a href="${siteBaseUrl}/cart/gadgets/removeItemPopup.jsp" iclass="modal cboxElement remove-item">
											<dsp:param name="remCommItemId" value="${commId}" />
											<fmt:message key="cart.remove" />
										</dsp:a>
										<br />
										<c:if test="${not status && not isOptionDiscontinued}">
										<dsp:getvalueof var="itemQuantity" param="cartItem.commerceItem.quantity" />
										<dsp:getvalueof var="reqString" param="cartItem.commerceItem.requestString" />
										<dsp:getvalueof var="displayName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
											<%-- JIRA DMI-1763 Hide Wishlist UI
											<a href="#" class="cart-move-wishlist" data-module="cart-wishlist" data-quantity='${itemQuantity}' data-commerceID='${commId}' data-itemInfo='${reqString}' data-displayName="${displayName}" >
												<fmt:message key="cart.moveWish" />
											</a>
											--%>

											<%-- <dsp:a href="${cotextPath}/cart/cart.jsp" bean="GiftlistFormHandler.moveItemsFromCart" iclass="comm-move-wishlist-a" value="${commId}" style="display:none">
												<dsp:param name="commerceItemToMoveToWishList" value="${commId}" />
												<dsp:param name="itemQuantity" param="cartItem.commerceItem.quantity" />
												<dsp:param name="displayName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
												<fmt:message key="cart.moveWish" />
											</dsp:a> --%>
										</c:if>
									</td>
								</tr>
								<tr>
									<!-- for after treatment details -->
									<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
									<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment" />
									<dsp:getvalueof var="afterTreatmentPlan" param="cartItem.afterTreatmentPlan" />
									<c:choose>
										<c:when test="${ hasTreatment =='false' && not empty afterTreatmentPlan}">
											<!-- Cart does not have after treatment paln -->
											<dsp:getvalueof var="planName" 	param="cartItem.afterTreatmentPlan.displayName" />
											<dsp:getvalueof var="skuId" param="cartItem.afterTreatmentPlan.id" />
											<dsp:getvalueof var="smallImagePath" param="cartItem.afterTreatmentPlan.smallImage.url" />
											<dsp:getvalueof var="largeImagePath" param="cartItem.afterTreatmentPlan.largeImage.url" />
											<dsp:getvalueof var="salePrice" param="cartItem.protectionPlanAmount" />
											<dsp:getvalueof var="qty" param="cartItem.afterTreatmentPlan.quantity" />
											<c:if test="${salePrice gt 0 && categoryName ne 'Sectionals' }">
											<td scope="row">
												<!-- image -->
												<c:choose>
													<c:when test="${not empty smallImagePath}">
														<img width="25" height="25" src="${smallImagePath}" alt="${planName}" />
													</c:when>
													<c:when test="${not empty largeImagePath}">
														<img width="25" height="25" " src="${largeImagePath}" alt="${planName}" />
													</c:when>
													<c:otherwise>
														<img width="25" height="25" alt="" src="/crsdocroot/content/images/products/small/MissingProduct_small.jpg">
													</c:otherwise>
												</c:choose>
												<span><!-- plan name  --> ${planName}</span>
											</td>
											
											<td scope="row">
												<dsp:include page="/global/includes/formattedPrice.jsp">
													<dsp:param name="price" value="${salePrice}" />
												</dsp:include>
											</td>

											<td scope="row" class="sc-colspan-adjust">
												<label for="planQuantity_${commerceItemId}">protection plan quantity</label>
												<input type="text" id="planQuantity_${commerceItemId}" name="quantity" class="plan-quantity-input" size="3" value="${1}" />
												<a id="treat_${commerceItemId}" title="${commerceItemId}" class="add-this-link-anchor" href="#">
													<input type="checkbox" id="planCheck" data-id="${commerceItemId}" />
													<label for="planCheck"><fmt:message key="cart.addThis" /></label>
												</a>
											</td>
											<td colspan="2"></td>
											
											</c:if>
										</c:when>
										<c:otherwise>
											<!-- Cart has protection plan -->
											<c:if test="${not empty protectionPlan}">
												<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
												<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
												<dsp:getvalueof var="skuId" param="cartItem.protectionPlan.id" />
												<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
												<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice' />
												<dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice' />
												<dsp:getvalueof var="qty" param="cartItem.protectionPlan.quantity" />
												<dsp:getvalueof var="smallImagePath" param="cartItem.protectionPlan.auxiliaryData.catalogRef.smallImage.url"/>
					     						<dsp:getvalueof var="largeImagePath" param="cartItem.protectionPlan.auxiliaryData.catalogRef.largeImage.url"/>
												<td scope="row">
													<c:choose>
														<c:when test="${not empty smallImagePath}">
															<img width="25" height="25" src="${smallImagePath}" alt="${planName}" />
														</c:when>
														<c:when test="${not empty largeImagePath}">
															<img width="25" height="25" " src="${largeImagePath}" alt="${planName}" />
														</c:when>
														<c:otherwise>
															<img width="25" height="25" alt="" src="${siteBaseUrl}/content/images/products/small/MissingProduct_small.jpg"/>
														</c:otherwise>
													</c:choose>
													<span><!-- plan name  --> ${planName}</span>
												</td>
												<td scope="row">
													<c:choose>
														<c:when test="${planSalePrice gt 0 }">
															<dsp:getvalueof var="planPrice" value="${planSalePrice}"/>
														</c:when>
														<c:otherwise>
															<dsp:getvalueof var="planPrice" value="${planListPrice}"/>
														</c:otherwise>
													</c:choose>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${planPrice}" />
													</dsp:include>
												</td>
												<td scope="row">
													<!-- quantity -->
													<div id="plan">
														<label for="updatePlanQuantity_${commId}">protection plan quantity</label>
														<input type="text" id="updatePlanQuantity_${commId}" name="quantity" size="3" value="${qty}" />														
														<input type="button" data-commerceid="${commId}" id="updatePlanButton" name="update" value="update" />
														
													</div>
												</td>
												<td scope="row">
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${totalPrice}" />
													</dsp:include>
												</td>
												<td scope="row">
													<a id="treat_${commerceItemId}" title="${commerceItemId}" href="#" class="add-this-link-anchor">
														<input type="checkbox" id="planCheck" data-id="${commerceItemId}" checked="checked" />
														<fmt:message key="cart.addThis" />
													</a>

												</td>
											</c:if>
										</c:otherwise>
									</c:choose>
								</tr>
							</dsp:oparam>
						</dsp:droplet>

					</tbody>
				</table>
				
				

						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItems" />
							<dsp:param name="elementName" value="cartItem" />
							<dsp:oparam name="outputStart">
								<input type="hidden" value="
							</dsp:oparam>
							<dsp:oparam name="output">
								<dsp:getvalueof var="skuId" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
								<dsp:getvalueof param="size" var="size"/>
								<dsp:getvalueof param="count" var="count"/>
								${skuId }<c:if test="${size!=count}">;</c:if>
							</dsp:oparam>
							<dsp:oparam name="outputEnd">
								" id="skuId" />
							</dsp:oparam>
						</dsp:droplet>

						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItems" />
							<dsp:param name="elementName" value="cartItem" />
							<dsp:oparam name="outputStart">
								<input type="hidden" value="
							</dsp:oparam>
							<dsp:oparam name="output">
								<dsp:getvalueof var="quantity" param="cartItem.commerceItem.quantity"/>
								<dsp:droplet name="ForEach">
									<dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories" />
									<dsp:param name="elementName" value="category" />
									<dsp:oparam name="output">
										<dsp:getvalueof var="categoryName" param="category.displayName" />
									</dsp:oparam>
								</dsp:droplet>
								<dsp:getvalueof param="size" var="size"/>
								<dsp:getvalueof param="count" var="count"/>
								${categoryName }<c:if test="${size!=count}">;</c:if>
							</dsp:oparam>
							<dsp:oparam name="outputEnd">
								" id="catName" />
							</dsp:oparam>
						</dsp:droplet>

					<dsp:include page="/cart/gadgets/monetateCartData.jsp">
						<dsp:param name="commerceItemsVarForMonetate" value="${cartItems}" />
					</dsp:include>			

						
			</dsp:form>
		</dsp:oparam>
	</dsp:droplet>
	<dsp:form action="${siteBaseUrl}/cart/cart.jsp" method="post" id="addPlan" formid="addPlan" name="addPlan">
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value="" />
		<dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value="" />
		<dsp:input type="hidden" id="removePlan" bean="CartModifierFormHandler.removePlan" value="false" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.addTreatmentPlanToOrder" value="true" />
	</dsp:form>
	<dsp:form action="${siteBaseUrl}/cart/cart.jsp" method="post" id="updatePlan" formid="updatePlan" name="updatePlan">
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value="" />
		<dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value="" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.updateTreatmentPlanToOrder" value="true" />
	</dsp:form>
	<!-- Form for update Commerce Item -->
	<dsp:form action="${siteBaseUrl}/cart/cart.jsp" method="post" id="updateCommerceItem" formid="updateCommerceItem" name="updateCommerceItem">
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderErrorURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" />
		<dsp:input type="hidden" id="itemQuantity" bean="CartModifierFormHandler.updateItemQuantity" value="" />
		<dsp:input type="hidden" id="updateCommerceItemId" bean="CartModifierFormHandler.updateCommerceItemId" value="" />
		<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderByCommerceId" value="true" />
	</dsp:form>
	
</dsp:page>
