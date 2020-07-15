<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean
	bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean
	bean="/atg/commerce/order/purchase/ExpressCheckoutFormHandler" />
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet" />
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/commerce/promotion/CouponFormHandler" />
<dsp:getvalueof var="contextPath"
	value="${originatingRequest.ContextPath}" />
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar" />
<dsp:getvalueof var="commerceItemCount"
	bean="ShoppingCart.current.commerceItemCount" />

<dsp:page>
 <dsp:include page="/includes/webtrendsContent.jsp">
  <dsp:param name="page" value="Checkout"  />
  <c:set var="pageTypeForTracking" value="cart" scope="request" />

  </dsp:include>
	<lzb:pageContainer>
		<jsp:attribute name="bodyClass">
			checkout cart
		</jsp:attribute>

		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
			<lzb:breadCrumb pageKey="breadcrumb.shoppingCart" divClass="breadCrumb" />
			<dsp:getvalueof bean="CartModifierFormHandler.formError" var="formError" />
			<dsp:getvalueof bean="ExpressCheckoutFormHandler.formError" var="expressFormError" />
			<c:if test="${formError eq 'true'}">
				<div class="message-container">
					<div class="message-wrapper">
						<dsp:include page="/global/errors.jsp">
							<dsp:param name="formHandler" bean="CartModifierFormHandler" />
						</dsp:include>
					</div>
				</div>
			</c:if>
			<c:if test="${expressFormError eq 'true'}">
				<div class="message-container">
					<div class="message-wrapper">
						<dsp:include page="/global/errors.jsp">
							<dsp:param name="formHandler" bean="ExpressCheckoutFormHandler" />
						</dsp:include>
					</div>
				</div>
			</c:if>


			<dsp:setvalue bean="GiftlistFormHandler.moveItemsFromCartSuccessURL" value="${contextPath}/cart/cart.jsp" />
			<dsp:setvalue bean="GiftlistFormHandler.moveItemsFromCartErrorURL" value="${contextPath}/cart/cart.jsp" />

			<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />

			<dsp:include page="/global/includes/reprice.jsp">
				<dsp:param name="pageReprice" value="cart" />
			</dsp:include>

			<main role="main" class="two-column-last cart">

			<section role="region">
			<dsp:include page="/global/pageTargeter.jsp">
						<dsp:param name="targeterName" value="CartPromoBlock"/>
					</dsp:include>
				<div class="cart-head">
					<h1>
						<fmt:message key="cart.cart" />
					</h1>
				</div>
				<%-- JIRA DMI-1763 Hide Wishlist UI
				<c:if test="${SessionBeanvar.cartItemMovedSucessfully}">
				      	 ${SessionBeanvar.moveItemDisplayName}
				      	 &nbsp;<fmt:message key="cart.wishListMsg" />
					<a href="${contextPath}/account/wish_list_items.jsp">
						<fmt:message key="cart.viewWishlist" />
					</a>
					<a href="#"> <fmt:message key="cart.wishlistHide" />
					</a>
				</c:if>
				--%>
				<dsp:setvalue bean="SessionBean.cartItemMovedSucessfully" value="false" />
				<dsp:include page="/global/errors.jsp">
					<dsp:param name="formHandler"
						bean="/com/lzb/order/LZBDeliveryChargeFormHandler" />
				</dsp:include>


				<dsp:include page="/global/errors.jsp">
					<dsp:param name="formHandler" bean="CouponFormHandler" />
				</dsp:include>

				<c:choose>
					<c:when test='${commerceItemCount == 0}'>
						<b><fmt:message key="cart.empty" /></b>
						<a href="${SessionBeanvar.previousPageVisited}"><fmt:message key="cart.emptyContinueShop" /></a>
						
						<%-- Monetate empty cart --%>
						<script>
							window.monetateQ.push(["addCartRows", []]);
						</script>
					</c:when>
					<c:otherwise>
						<dsp:include page="/global/includes/cartTax.jsp">
							<dsp:param name="callTax" value="true" />
						</dsp:include>
						<p><fmt:message key="cart.cartInfo1" /><fmt:message key="cart.cartInfo2" /><fmt:message key="cart.cartInfo3" /></p>
						<div class="cart-deposit">
							<h2><fmt:message key="cart.depBalance"/><!-- Deposit &amp; Balance --></h2>
							<p><fmt:message key="cart.depBalanceInfo"/><!-- Your credit card will be charged a 50% nonrefundable deposit on all merchandise plus any elected after treatments. The nonrefundable deposit will not be charged until you and the store confirm your order and production time. --></p>
						</div>
						<dsp:include page="/cart/gadgets/cartContents.jsp" /></td>

						<a href="${SessionBeanvar.previousPageVisited}"><fmt:message key="cart.continueShop" /></a>
						<dsp:include page="moveToPurchase.jsp" />

						<%-- cross sell - up sell section. --%>

						<dsp:include page="gadgets/relateditemslot.jsp" flush="true" />

						<%-- render the order summary content. --%>
						<c:if test="${cartEmpty eq 'false'}">
							</section>
							<aside role="complementary">
								<dsp:include page="/cart/gadgets/cart_order_summary.jsp" />
							</aside>
						</c:if>
						<c:if test="$!{cartEmpty eq 'false'}">
							</section>
						</c:if>
					</c:otherwise>
				</c:choose>

				<%-- cross sell /up sell content slot --%>
				<div>



				</div>
				</main>
				<script>

					<c:if test='${commerceItemCount == 0}'>
					_ltk.SCA.ClearCart();
					</c:if>

				</script>

		</dsp:layeredBundle>
	</lzb:pageContainer>
</dsp:page>
