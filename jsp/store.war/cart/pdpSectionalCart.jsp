<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/commerce/promotion/CouponFormHandler" />
<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
<dsp:importbean bean="/com/lzb/service/SessionBean" var="SessionBeanvar"/>
<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.commerceItemCount" />

<dsp:page>
	<html>
		<head>
		  <link rel="stylesheet" href="/work/css/jquery-ui.css?ver=${assetVersion}">

   			<script src="/work/js/jquery.min.js?ver=${assetVersion}"></script>
			<script src="/work/js/jquery-ui.js?ver=${assetVersion}"></script>
		</head>
			<body>

			<lzb:pageContainer>
				<jsp:attribute name="title">Shopping Cart</jsp:attribute>

				<jsp:attribute name="pageSpecificCSS">
				</jsp:attribute>
		   		<jsp:attribute name="pageSpecificJS">
				</jsp:attribute>

				<jsp:body>
				<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
					<lzb:breadCrumb pageKey="breadcrumb.shoppingCart" separator="/" divClass="breadCrumb" />

					<dsp:setvalue bean="GiftlistFormHandler.moveItemsFromCartSuccessURL" value="${contextPath}/cart/cart.jsp"/>
					<dsp:setvalue bean="GiftlistFormHandler.moveItemsFromCartErrorURL" value="${contextPath}/cart/cart.jsp"/>

					<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty"/>

					<dsp:getvalueof bean="CartModifierFormHandler.formError" var="formError" />

					<dsp:include page="/global/includes/reprice.jsp">
						<dsp:param name="pageReprice" value="cart"/>
					</dsp:include>

					<div><h2><fmt:message key="cart.cart"/></h2></div>
					<%-- JIRA DMI-1763 Hide Wishlist UI
					<hr>
					<br>
					<c:if test="${SessionBeanvar.cartItemMovedSucessfully}">
				      	 ${SessionBeanvar.moveItemDisplayName}
				      	 <fmt:message key="cart.wishListMsg"/>
				      	 <a href="${contextPath}/account/wish_list_items.jsp">
				      	 	<fmt:message key="cart.viewWishlist"/>
				      	 </a>
				      	 <a href="#"> <fmt:message key="cart.wishlistHide"/> </a>
				  	</c:if>
					--%>

					<c:if test="${formError eq 'true'}">
						<dsp:include page="/global/errors.jsp">
							<dsp:param name="formHandler" bean="CartModifierFormHandler" />
						</dsp:include>
					</c:if>

					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="/com/lzb/order/LZBDeliveryChargeFormHandler" />
					</dsp:include>
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="CouponFormHandler" />
					</dsp:include>
					<br><br>
					<c:choose>
						<c:when test='${commerceItemCount == 0}'>
							<b><fmt:message key="cart.empty"/></b><a href="${contextPath}" ><fmt:message key="cart.emptyContinueShop"/></a>
						</c:when>
						<c:otherwise>
							<div>
								<fmt:message key="cart.cartInfo1"/><br/>
								<fmt:message key="cart.cartInfo2"/><br/>
								<fmt:message key="cart.cartInfo3"/>
							</div><br>
							<div>
								<fmt:message key="cart.depBalance"/><br>
								<fmt:message key="cart.depBalanceInfo"/>
							</div>
							<table border="0" >
								<tr>
									<td colspan="5">
										<dsp:include page="/cart/gadgets/pdpSectionalCartContents.jsp"/>
									</td>
								</tr>
							</table>

							<a href="${contextPath}"><fmt:message key="cart.continueShop"/></a>
							<dsp:include page="moveToPurchase.jsp"/>

							<%--
						    	cross sell - up sell section.
						   	--%>

								<dsp:include page="gadgets/relateditemslot.jsp" flush="true"/>

							<%--
						    	render the order summary content.
						   --%>
							 <c:if test="${cartEmpty eq 'false'}">
								<dsp:include page="/cart/gadgets/pdp_sec_cart_order_summary.jsp"/>
							</c:if>
						</c:otherwise>
					</c:choose>

					<%-- cross sell /up sell content slot --%>
					<div>
						<dsp:include page="/global/pageTargeter.jsp">
							<dsp:param name="targeterName" value="CartPromoBlock"/>
						</dsp:include>
					</div>

				</dsp:layeredBundle>
			</jsp:body>
		</lzb:pageContainer>
	</body>
</html>
</dsp:page>
