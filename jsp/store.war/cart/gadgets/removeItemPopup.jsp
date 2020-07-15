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
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="remCommItemId" param="remCommItemId"/>


	<div class="zip-code-content item-remove-content">
			<dsp:droplet name="LZBDisplayCartItemsDroplet">
				<dsp:param name="order" bean="ShoppingCart.current" />
				<dsp:param name="profile" bean="Profile" />
				<dsp:param name="cart" value="true" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="cartItems" param="cartItems" />
					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="cartItems" />
						<dsp:param name="elementName" value="cartItem" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id" />
							<c:if test="${remCommItemId eq commerceItemId}">
								<h2><fmt:message key="cart.removePop1"/></h2>
								<p><fmt:message key="cart.removeMessage"/></p>
								<%-- Get the items in the shopping cart --%>
								<dsp:form id="updateItemToCartId" name="updateItemToCart" method="post" action="#">
									<div class="cart-item-details">
										<dsp:getvalueof var="commId" param="cartItem.commerceItem.id" />
										<div class="item-image">
							     		   <dsp:include page="/global/gadgets/cartItemImage.jsp">
													<dsp:param name="cartItem" param="cartItem" />
											</dsp:include>
										</div>
										<div class="cart-product-details">

																<dsp:getvalueof var="catalogRefId" param="cartItem.commerceItem.catalogRefId" />
																<dsp:getvalueof param="cartItem.commerceItem.auxiliaryData.catalogRef.status" var="status"/>
																<%-- pdp url--%>
																<dsp:droplet name="LZBPDPURLDroplet">
														     		<dsp:param name="productId" value="${catalogRefId}" />
														     		 <dsp:param name="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
																					<dsp:param name="fromCDP" value="true" />
																	<dsp:param name="elementName" value="url" />
																	<dsp:oparam name="output">
																	<dsp:getvalueof var="pdpurl" param="url"/>
																	</dsp:oparam>
																</dsp:droplet>

																<p><dsp:a href="${pdpurl}"><dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/></dsp:a></p>


																<p><fmt:message key="cart.cover"/> <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>)</p>

														<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem"/>
														<c:if test="${ not empty pillowItem }">

																<p>
																	<fmt:message key="cart.pillow"/>
																	<dsp:valueof param="cartItem.pillowItem.optionInfo.colorName" />
																	(<dsp:valueof param="cartItem.pillowItem.optionInfo.optionValue" />)
																</p>

														</c:if>
														<!-- Total -->
										     			<p class="prod-text">
											     			<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price"param="cartItem.itemTotal"/>
															</dsp:include>
														</p>

														<%-- Beginning of Options and Sectional pieces display--%>
														<dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
														<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
														<dsp:include page="/cart/gadgets/sectionalOptionalItemsFragment.jsp">
																	<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
																	<dsp:param name="customOptions" value="${customOptions}" />
																	<dsp:param name="page" value="removeItem" />
														</dsp:include>
														<%-- End of Sectional pieces display--%>
									     		</div>

								     			<!-- for after treatment details -->
								     			<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>
								     			<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment"/>
								     			<dsp:getvalueof var="afterTreatmentPlan" param="cartItem.afterTreatmentPlan"/>

								     			<c:if test="${hasTreatment =='true' && not empty protectionPlan}">
							    						<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>
							    						<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName"/>
							    						<dsp:getvalueof var="skuId" param="cartItem.protectionPlan.id"/>
							    						<dsp:getvalueof var="totalPrice" param='cartItem.protectionPlan.priceInfo.amount'/>
							    						<dsp:getvalueof var="salePrice" param='cartItem.protectionPlan.priceInfo.salePrice'/>
							    						<dsp:getvalueof var="qty" param="cartItem.protectionPlan.quantity"/>
							     					<div class="cart-product-details">
							     					<p>
									     				<!-- scene 7 image logic should go here -->
									     				<img width="25" height="25" alt="" src="/content/images/products/small/MissingProduct_small.jpg">
									     			</p>
									     			<p>
														<!-- plan name  -->
														${planName}
													</p>
													<p>
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
													</p>
													<p>
														<!-- quantity -->

														<div id="plan">
															${qty}
														</div>
													</p>
													<p>
														<dsp:include page="/global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${totalPrice}" />
														</dsp:include>
													</p>
<%--													<p>
														<a id="treat_${commerceItemId}" title="${commerceItemId}" href="#"><input type="checkbox" id="planCheck" data-id="${commerceItemId}" checked="checked" /><fmt:message key="cart.addThis"/></a>
													</p>--%>
													</div>
												</c:if>
								     		</div>
								     <dsp:droplet name="ForEach">
										<dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories" />
										<dsp:param name="elementName" value="category" />
										<dsp:oparam name="output">
											<dsp:getvalueof var="categoryName" param="category.displayName" />
										</dsp:oparam>
									</dsp:droplet>

									<p><span><fmt:message key="cart.removePopSure"/></span> <fmt:message key="cart.removePopAction"/></p>
									<dsp:getvalueof var="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
									<dsp:getvalueof var="prodSku" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
									<dsp:getvalueof var="prodQty" param="cartItem.commerceItem.quantity" />
									<div class="zip-code-buttons" data-prodname="${prodName }" data-prodsku="${prodSku }" data-prodqty="${prodQty }" data-prodgroup="${categoryName }">
										<a href="${contextPath}/cart/cart.jsp"><fmt:message key="cart.removeCancel"/></a>
										<dsp:a href="${contextPath}/cart/cart.jsp"  bean="CartModifierFormHandler.removeItemFromOrder" paramvalue="${commId}" iclass="btn-primary accept remove-item">
						  					<dsp:param name="commerceItemToRemove" value="${commId}" />
						  					<dsp:param name="successUrl" value="${contextPath}/cart/cart.jsp" />
						  					<dsp:param name="errorUrl" value="${contextPath}/cart/cart.jsp" />
											REMOVE
					  					</dsp:a>
					  				</div>
							</dsp:form>
							</c:if>
						</dsp:oparam>
					</dsp:droplet>
				</dsp:oparam>
			</dsp:droplet>
			</div>




</dsp:page>
