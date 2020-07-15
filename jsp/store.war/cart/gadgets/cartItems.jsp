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
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<%-- Get the items in the shopping cart --%>
	<dsp:getvalueof var="items" vartype="java.lang.Object" bean="ShoppingCart.current.commerceItems" />

	<c:if test="${not empty items}">
		<dsp:form id="updateItemToCartId" name="updateItemToCart" method="post" action="#" iclass="cartForm">
			<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderErrorURL" value="/cart/cart.jsp" />
			<dsp:input type="hidden" bean="CartModifierFormHandler.setOrderSuccessURL" value="/cart/cart.jsp" />
		<table id="lzb_store_itemTable" >
			<%--
        Display the headers in the form of site, item, price, quantity, total for the items
        in the shopping cart.
      --%>
			<thead>
				<tr>
					<th class="des">Description</th>
					<th>Price</th>
					<th>Quantity</th>
					<th>Total</th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.commerceItems" />
					<dsp:param name="elementName" value="commerceItem" />
					<dsp:oparam name="output">
						<tr class="product-details">
							<td class="details">
							<!-- place holder for product image  -->
							 <%--
							 	<dsp:getvalueof var="smallImg" param="commerceItem.smallImage"></dsp:getvalueof>
							 	<c:if test="${not empty smallImg}">
								<a href="#" title=""><img src="${smallImg}" alt="" /></a>
						     </c:if> --%>
						     <img src="#" alt="" >sku image</img>

						     			<dsp:valueof param="commerceItem.auxiliaryData.catalogRef.displayName">Product</dsp:valueof>
						     			<table>
											<!--<tr><td colspan="2">Sub sku items</td></tr>-->
											<dsp:droplet name="ForEach">
												<dsp:param name="array" param="commerceItem.commerceItems" />
												<dsp:param name="elementName" value="subCommerceItem" />
												<dsp:oparam name="output">
													<tr>
														<td><dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName">Product</dsp:valueof></td>
														<td>Quantity: <dsp:valueof param="subCommerceItem.quantity" /></td>
														<td>amount: <dsp:getvalueof var="subAmount" param="subCommerceItem.priceInfo.amount" />
														<dsp:include page="../../global/includes/formattedPrice.jsp">
															<dsp:param name="price" value="${subAmount}" />
														</dsp:include>
														</td>
													</tr>
												</dsp:oparam>
											</dsp:droplet>
										</table>
						     		</td>


						</td>
						<td class="price">
							<dsp:getvalueof var="skuId" param="commerceItem.catalogRefId" />

							<dsp:droplet name="/atg/targeting/RepositoryLookup">
								<dsp:param name="id" value="${skuId}" />
								<dsp:param name="itemDescriptor" value="sku" />
								<dsp:param name="repository" bean="/atg/commerce/catalog/ProductCatalog" />
								<dsp:param name="elementName" value="sku" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="listPrice" param="sku.listPrice" />
									<dsp:getvalueof var="salePrice" param="sku.salePrice" />
										<dsp:include page="../../global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${listPrice}" />
							</dsp:include><br>
										<dsp:include page="../../global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${salePrice}" />
							</dsp:include>
								</dsp:oparam>
							</dsp:droplet>
						</td>

						<td class="update-qty">
							<dsp:getvalueof var="commId" param="commerceItem.id" />

							<input type="text" size="3" name="<dsp:valueof param='commerceItem.catalogRefId'/>" value="<dsp:valueof param='commerceItem.quantity'/>">
							<br><dsp:input id="UpdateId${commId}" bean="CartModifierFormHandler.setOrder" type="submit" value="Update"  iclass="update-sym" />


						</td>
						<td>
							<dsp:getvalueof var="amount" param="commerceItem.priceInfo.amount" />
							<dsp:include page="../../global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${amount}" />
							</dsp:include>
						</td>
						<td>
							<dsp:a href="#">
								<u>Edit</u>
							</dsp:a>
							<br />
							<dsp:a href="<%=request.getRequestURI()%>"  bean="CartModifierFormHandler.removeItemFromOrder" paramvalue="${commId}" >
			  					<dsp:param name="commerceItemToRemove" value="${commId}" />
								Remove item
			  				</dsp:a>

							<br />

							<dsp:a href="<%=request.getRequestURI()%>"  bean="GiftlistFormHandler.moveItemsFromCart" value="${commId}" >
			  					<dsp:param name="commerceItemToMoveToWishList" value="${commId}" />
			  					<dsp:param name="itemQuantity" param="commerceItem.quantity" />
								Move to wishlist
			  				</dsp:a>

						</td>
						</tr>

					</dsp:oparam>
				</dsp:droplet>
			</tbody>
		</table>
		</dsp:form>
	</c:if>
</dsp:page>