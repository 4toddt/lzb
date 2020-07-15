<dsp:page>

	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:getvalueof var="commerceItemCount" bean="ShoppingCart.current.totalCommerceItemCount" />
	 <ul class="mini-cart-list">
		<li>
			<div class="mini-cart-links" data-classname="sign-in-modal" data-transition="elastic" data-speed="500">
				<a href="/rwd/checkout/cart.jsp" class="mini-cart-link"><fmt:message key="minicart.mycart" />(<span>${commerceItemCount}</span>)</a>
				<dsp:include page="/cart/moveToPurchase.jsp" />
			</div>
			<dsp:include page="/cart/gadgets/miniCartContent.jsp" />
		</li>
	</ul>
</dsp:page>