<dsp:page>
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />
<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
<dsp:importbean var="profile" bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/common/LZBImageURLBuilder" />
	<c:choose>
		<c:when test="${commerceItemCount gt '0' }">
			<li>
				<p><strong><fmt:message key="minicart.recentlyItem"/></strong></p>
				<!--  
				<p class="mini-cart-intro">
					<fmt:message key="minicart.pricinginfo"/>&nbsp;<a class="mcZipCode" href="#"><fmt:message key="minicart.zipCode"/></a>
				</p>
				-->
			</li>
			<dsp:droplet name="/atg/commerce/order/purchase/RepriceOrderDroplet">
				<dsp:param value="ORDER_SUBTOTAL" name="pricingOp"/>
			</dsp:droplet>
			<dsp:droplet name="LZBDisplayCartItemsDroplet">
					<dsp:param name="order" bean="ShoppingCart.current"/>
					<dsp:param name="profile" bean="Profile"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="cartItems" param="cartItems" />
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItems" />
							<dsp:param name="elementName" value="cartItem" />				
							<dsp:oparam name="output">
									<li>
										<div class="mincart-pic">
											<dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id" />
											<dsp:getvalueof var="catalogRefId" param="cartItem.commerceItem.catalogRefId" />
											<dsp:droplet name="LZBPDPURLDroplet">
												<dsp:param name="productId" value="${catalogRefId}" />
												<dsp:param name="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
												<dsp:param name="fromCDP" value="true" />
												<dsp:param name="elementName" value="url" />
												<dsp:oparam name="output">
													<dsp:getvalueof var="pdpurl" param="url" /> 
												</dsp:oparam>
											</dsp:droplet>
											<dsp:droplet name="LZBImageURLBuilder">
												<dsp:param name="json" param="cartItem.commerceItem.requestString"/>
												<dsp:param name="secureURL" value="true"/>
												<dsp:oparam name="output">
													<dsp:getvalueof var="marxentImageURL" param="elements"/>
												</dsp:oparam>
											</dsp:droplet>
											<c:choose>
												<c:when test="${not empty marxentImageURL}">
													<a href="${cotextPath}${pdpurl}?commid=${commerceItemId}" tabindex="0">
														<img alt="image" src="${marxentImageURL}" />
													</a>
													<meta property="og:image" content="${marxentImageURL}" />
												</c:when>
												<c:otherwise>
													<img src="http://placehold.it/75x90" alt="product thumb">
												</c:otherwise>
											</c:choose>
										</div>
										<div class="product-detials">
										<a href="${cotextPath}${pdpurl}?commid=${commerceItemId}" tabindex="0">
											<p class="product-title"><strong><dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/></strong></p>
										</a>
				     						<p class="product-title" tabindex="0"><strong><dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.description"/></strong></p>
											
											<p class="product-info" tabindex="0"><fmt:message key="cart.cover"/> <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>)</p>
											
											<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem"/>	
											<c:if test="${ not empty pillowItem }">				
												<p class="product-info" tabindex="0"><fmt:message key="cart.pillow"/> <dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.id"/>)
												<dsp:getvalueof var="pillowoptionItemInfo" value="${pillowItem.optionInfo}" />
													<c:if test="${ not empty pillowoptionItemInfo}">
															<c:out value="${pillowoptionItemInfo.colorName}" />(<c:out value="${pillowoptionItemInfo.optionValue}" />)	
													</c:if>
												</p>
											</c:if>
											
											<%-- Beginning of Options and Sectional pieces display--%>
											<dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
											<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
											<dsp:include page="/cart/gadgets/miniCartSectionsAndOptionsFragment.jsp">
												<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
												<dsp:param name="customOptions" value="${customOptions}" />
											</dsp:include>
											<%-- End of Sectional pieces display--%>
											
											 <p class="product-price" tabindex="0">
											<dsp:include page="miniCartPrice.jsp">
												<dsp:param name="priceInfo" param="cartItem"/>
											</dsp:include>
											</p>
											
											<p class="product-qty" tabindex="0">
												<fmt:message key="minicart.qty"/>:<dsp:valueof param='cartItem.commerceItem.quantity'/>
												<strong>
													<dsp:include page="../../global/includes/formattedPrice.jsp">
															<dsp:param name="price" param="cartItem.itemTotal" />
													</dsp:include>
												</strong>
											</p>
											<dsp:getvalueof var="commId" param="cartItem.commerceItem.id" />
					
											<a href="${cotextPath}${pdpurl}?commid=${commId}" tabindex="0"><fmt:message key="minicart.viewdetail"/></a>
											
											
											<c:choose>           
											   <c:when test="${ not empty isHomePage and isHomePage eq true}">
												<c:set var="currentPageUrl" value="/index.jsp" />
											</c:when>
											   
											   <c:when test="${not empty requestScope['javax.servlet.forward.request_uri']}">
											   <c:set var="currentPageUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
											   </c:when>
											   <c:otherwise>
											   <c:set var="currentPageUrl" value="${pageContext.request.requestURI}"/>
											   </c:otherwise>
										   </c:choose>
										   
										  <dsp:a href="${siteBaseUrl}/cart/gadgets/removeItemPopup.jsp" iclass="modal cboxElement remove-item">
											<dsp:param name="remCommItemId" value="${commId}" />
											<fmt:message key="cart.remove" />
										</dsp:a>

										</div><%-- .product-detials --%>
									</li>
								</dsp:oparam>
							</dsp:droplet>
					</dsp:oparam>
				</dsp:droplet>
			<li>
			<p class="mini-cart-total" tabindex="0"><strong><fmt:message key="minicart.carttotal"/></strong>(${commerceItemCount} items)
			<strong><dsp:valueof converter="currency" bean="ShoppingCart.current.priceInfo.rawSubTotal" format="##.##" /></strong></p></li>
			<li data-module="cbox" data-className="checkout-sign-in-modal" data-transition="elastic" data-speed="500" class="mini-cart-checkout-li"><a class="triangle-forwards" href="${cotextPath}/cart/cart.jsp"><fmt:message key="minicart.viewshoppingcart"/></a><dsp:include page="/cart/moveToPurchase.jsp"/>
			</li>
		</c:when>
		<c:otherwise>
			<li>
				<p><strong>Your cart is empty.</strong></p>
				<p class="mini-cart-intro">continue shopping</p>
			</li>
		</c:otherwise>
	</c:choose>

</dsp:page>