<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/order/LZBDeliveryChargeFormHandler" />
	<dsp:importbean bean="/atg/commerce/promotion/CouponFormHandler" />
	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPromotionDisplayDroplet" />
	<dsp:getvalueof var="order" bean="ShoppingCart.current" />
	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" value="${order}" />
		<dsp:param name="profile" bean="Profile" />
		<dsp:param name="page" value="cart"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />

			<div class="order-sum">
				<div class="order-sum1">

				<h2>
					<fmt:message key="cartorder.summary" />
				</h2>
				<div class="order-sum1">
					<c:choose>
						<c:when test="${cartEmpty eq 'false'}">
							<div class="order-tot">
								<p class="cart-lpos">
									<span>${commerceItemCount}</span>&nbsp;
									<c:if test="${commerceItemCount eq 1}">

										<fmt:message key="cartorder.itemtotal" />
									</c:if>
									<c:if test="${commerceItemCount gt 1}">

										<fmt:message key="cartorder.itemstotal" />
									</c:if>
								</p>
						</c:when>
					</c:choose>
					<p class="cart-rpos">
						<span> <dsp:include page="/pricing/displayPrice.jsp">

								<dsp:param name="currency" param="totalItemCost" /></span>

						</dsp:include>
					</p>
				</div></div>
			</div>
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="planItems" />
				<dsp:param name="elementName" value="planItem" />
				<dsp:oparam name="output">

					<div class="order-pro">
						<p class="cart-lpos">
							<dsp:valueof param="planItem.planItemInfo.displayName" />
							<br>&#40;
							<dsp:valueof param="planItem.quantity" />
							&nbsp;&#41;
						</p>
						<p class="cart-rpos">
							<dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" param="planItem.amount" />
							</dsp:include>
						</p>
					</div>
				</dsp:oparam>
			</dsp:droplet>
			<dsp:droplet name="LZBPromotionDisplayDroplet">
				<dsp:param name="order" bean="ShoppingCart.current" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="couponCode" param="couponCode" />
					<dsp:getvalueof var="couponName" param="name" />
					<dsp:getvalueof var="discountAmt" param="discountAmt" />
					<dsp:getvalueof var="promoDetailsVO" param="promoDetailsVO"/>
					<dsp:getvalueof var="shippingDiscount" param="shippingDiscount"/>

					<c:if test="${not empty promoDetailsVO}">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" value="${promoDetailsVO}" />
							<dsp:param name="elementName" value="promoVO" />
							<dsp:oparam name="output">

								<div class="order-pro-apply">
									<div class="cart-lpos">
										<p class="promo-percent"><dsp:valueof param="promoVO.couponName" />
											<fmt:message key="cart.couponCode" /><dsp:valueof param="promoVO.couponCode" />
											<fmt:message key="cart.couponApplied" />
										</p>
										<a class="tooltip" href="#" title="dxxx dxx dfdfdfdff" data-tip="Coupon code">
											<div class="triangle-with-shadow"></div>
											<div class="tooltip-img" title=""></div>
										</a>
										<p>
											<dsp:getvalueof var="couponCode" param="promoVO.couponCode" />
											<dsp:setvalue param="discountAmt" value="${discountAmt * -1}" />
											<dsp:valueof param="promoVO.adjustmentAmount" converter="currency" />
											<dsp:form name="removeCoupon" method="post" id="removeCoupon" formid="removeCoupon" action="${siteBaseUrl}/cart/cart.jsp">
												<dsp:input bean="CouponFormHandler.removeCouponCode" type="hidden" value="${couponCode}" />
												<dsp:input bean="CouponFormHandler.removeCouponSuccessUrl" type="hidden" value="${siteBaseUrl}/cart/cart.jsp" />
												<dsp:input bean="CouponFormHandler.removeCouponErrorUrl" type="hidden" value="${siteBaseUrl}/cart/cart.jsp" />
												<dsp:input bean="CouponFormHandler.removeCoupon" type="submit" value="REMOVE" />
											</dsp:form>
										</p>
									</div>
								</div>
							</dsp:oparam>
						</dsp:droplet>
					</c:if>

					<dsp:getvalueof var="couponCode" param="couponCode" />
					<dsp:getvalueof var="couponName" param="name" />
					<dsp:getvalueof var="discountAmt" param="discountAmt" />

				</dsp:oparam>
			</dsp:droplet>
			<div class="delivery-zip">
				<div class="delivery-content order-msg order-base">
					<h2>
						<fmt:message key="cart.weDeliver" />
					</h2>
					<label for="zipCodeInput" class="del-zip-txt">
						<fmt:message key="cart.deliveryInfo" />
					</label >
					<dsp:getvalueof param="shippingCharge" var="shippingCharge" />
					
					
					<div id="zipErrorMsg" class="amp-error"></div>
					<form action="/xhr/amplifiSubmit.jsp" 
						  method="post" name="deliveryChargeForm" 
						  id="deliveryChargeForm" formid="deliveryChargeForm" data-error-messaging="#zipErrorMsg" data-module="update-zip">
					
						<input name=".zipCode" id="zipCodeInput" type="text" class="amplifi-input" maxlength="40" />
						<input id="deliveryChargeInfo" type="submit" value="UPDATE" class="btn-primary update cart-rpos amplifi-submitter" data-error-messaging="#zipErrorMsg" />
						<input type="hidden" name="amplifiHandler" value=".fetchDeliveryCharge" class="amplifi-input" />
						<input type="hidden" name="amplifiBean" value="/com/lzb/order/LZBDeliveryChargeFormHandler" class="amplifi-input" />
						
						<dsp:include page="/xhr/getAmplifiToken.jsp">
							<dsp:param name="class" value="amplifi-input" />
						</dsp:include>
					</form>
					
					<span data-module="cbox" data-transition="elastic" data-speed="500" style="display:none;">
							<a href="${siteBaseUrl}/cart/gadgets/changed_delivery_charge.jsp" class="modal update-zip-click">hit</a>
					</span>
				</div>
			</div>
			<div class="order-sum2">
				<div class="esitmate-del">
					<div class="cart-lpos">
						<p>
							<fmt:message key="cartorder.shipping" />
						</p>
						
						<a class="final-delivery-tool" tabindex="0" data-tip="Estimated delivery" href="#"
							aria-label="Tooltip information: Final Delivery and tax will be calculated during checkout based on the selected Delivery address. Due the large size of our items, a freight surcharge may be applied to orders delivered to the following states: AK, AZ, CA, CO, ID, MT, NV, NM, OR,WA, WY."
							title="Final Delivery and tax will be calculated during checkout based on the selected Delivery address. Due the large size of our items, a freight surcharge may be applied to orders delivered to the following states: AK, AZ, CA, CO, ID, MT, NV, NM, OR,WA, WY.">
							<div class="triangle-with-shadow"></div>
							<div class="tooltip-img" title=""></div>
							<div style="display:none" class="delivery-tooltip">
								Final Delivery and tax will be calculated during checkout based on the selected Delivery address. 
								Due the large size of our items, a freight surcharge may be applied to orders delivered to the 
								following states: AK, AZ, CA, CO, ID, MT, NV, NM, OR,WA, WY.
							</div>
						</a>
					</div>

					<p class="cart-rpos">
						<dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" param="shippingCharge" />
						</dsp:include>
					</p>
				</div>
			</div>

			<!-- For discounts if any -->
			<dsp:getvalueof var="promoAmount" param="promoAmount" />
			<c:if test="${ not empty promoAmount}">
				<div class="order-sum2">
					<div class="esitmate-del">
						<div class="cart-lpos">
							<p>
								<fmt:message key="orderTotal.discount" />
							</p>
						</div>
						<p class="cart-rpos">
							<dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" value="${promoAmount}" />
							</dsp:include>
						</p>
					</div>
				</div>
			</c:if>

			<!-- for tax -->
			<%--As we are showing the estimated tax so commented the global tax jsp --%>
			<div class="delivery-zip">
				<div class="delivery-content taxware-down order-base">
					<p class="estimated-tax">
						<dsp:getvalueof var="cartTaxAmount" value="${cartTaxAmount}"/>
						<dsp:getvalueof var="cartTaxDown" value="${cartTaxDown}"/>
						<c:choose>
							<c:when test="${cartTaxDown == 'true' }">
								<div style="bordertop:1px solid #000;width:100%;">
									<h4><fmt:message key="cartorder.taxDown"/></h4>
									<fmt:message key="cartorder.taxDownMessage"/>
									<fmt:message key="cartorder.taxDownLearn"/>
									<p style="display:none" id="popupInfo">
										<h1><fmt:message key="cartorder.taxDowninfo"/></h1>
										<hr>
										<fmt:message key="cartorder.taxDowninfo1"/>
										<fmt:message key="cartorder.taxDowninfo2"/>
										<fmt:message var="close" key="cartorder.taxDownClose"/>
										<input type="button" name="cancel" value="${close}" />
									</p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="order-pro-apply payment-row">
									<div class="cart-lpos">
										<c:choose>
											<c:when test="${reviewPage}">
												<p class="promo-percent"><fmt:message key="cartorder.salesTax"/></p>
											</c:when>
											<c:otherwise>
												<p class="promo-percent"><fmt:message key="cartorder.estimatedTax"/></p>
											</c:otherwise>
										</c:choose>
									</div>
									<p class="cart-rpos">
										 <dsp:include page="/pricing/displayPrice.jsp">
											<dsp:param name="currency" value="${cartTaxAmount}"/>
										 </dsp:include>
									</p>
								</div>
							</c:otherwise>
						</c:choose>
						<%-- <dsp:include page="/global/gadgets/taxwareInfo.jsp">
							<dsp:param name="order" value="${order}" />
						</dsp:include> --%>
					</p>
				</div>
			</div>

			<div class="order-sum2">
				<dsp:getvalueof var="total" param="total"/>
				<div class="order-amnt">
					<p class="cart-lpos">
						<span> <fmt:message key="cartorder.total" />
						</span>
					</p>
					<p class="cart-rpos">
						<span> <dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" value="${total- shippingDiscount+cartTaxAmount}" />
							</dsp:include>
						</span>${currencyCode}
					</p>
				</div>

				<dsp:getvalueof var="defaultShippingAddress" bean="Profile.shippingAddress" />
				<dsp:getvalueof var="defaultBillingAddress" bean="Profile.billingAddress" />
				<dsp:getvalueof var="defaultCreditCard" bean="Profile.defaultCreditCard" />
				<c:choose>
					<c:when
						test="${securityStatus >=2 and not empty defaultShippingAddress and not empty defaultBillingAddress and not empty defaultCreditCard}">
						<dsp:include page="/cart/express_checkout.jsp" />
					</c:when>
					<c:otherwise>
						<dsp:include page="/cart/moveToPurchase.jsp" />
					</c:otherwise>
				</c:choose>

					<div class="order-promo">
						<label for="cart-lpos"><fmt:message key="cartorder.promocode" /></labeL>
						<dsp:form id="couponForm" name="couponForm" method="post" formid="couponForm" action="${siteBaseUrl}/cart/cart.jsp">
							<dsp:input bean="CouponFormHandler.couponClaimCode" type="text" maxlength="40" id="cart-lpos" iclass="cart-lpos" />
							<dsp:input bean="CouponFormHandler.claimCoupon" id="claimCoupon" type="submit" value="APPLY" iclass="submitBtn btn-primary update cart-rpos" />
							<dsp:input bean="CouponFormHandler.claimCouponErrorURL" value="${siteBaseUrl}/cart/cart.jsp" type="hidden" />
							<dsp:input bean="CouponFormHandler.claimCouponSuccessURL" value="${siteBaseUrl}/cart/cart.jsp" type="hidden" />
						</dsp:form>
					</div>

			</div>
			</div>
			</div>
			<div class="need-help">
				<div class="order-base">
					<h2><fmt:message key="cart.liveChatHdr" /></h2>
					<p><fmt:message key="cart.liveChatMsg" /></p>
				</div>
			</div>
			<div class="remain-info" data-module="cbox">
				<div class="order-base">
					<div>
						<h2>
							<fmt:message key="cart.warrantyInformation" />
						</h2>
						<p>With every La-Z-Boy product, you receive the famous La-Z-Boy limited warranty; one of the best in the industry.</p>
						<a href="/content/CustomerCare/WarrantyInformation" target="_blank">Review Our Warranty</a>
						<dsp:droplet name="/atg/targeting/TargetingFirst">
							<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/WarrantyInformationContent" />
							<dsp:oparam name="output">
								<dsp:valueof param="element.content.data" valueishtml="true" />
							</dsp:oparam>
						</dsp:droplet>
					</div>
					<div>
						<h2>
							<fmt:message key="cart.returnPolicy" />
						</h2>
						<p>Have a return? Read our online return policy to find out all of the details that you will need to know.</p>
						<a href="/content/policies/return-policy" target="_blank">Learn About Returns</a>
						<dsp:droplet name="/atg/targeting/TargetingFirst">
							<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/ReturnPolicyContent" />
							<dsp:oparam name="output">
								<dsp:valueof param="element.content.data" valueishtml="true" />
							</dsp:oparam>
						</dsp:droplet>
					</div>
					<div>
						<h2>
							<fmt:message key="cart.securedShopping" />
						</h2>
						<p>We work to protect the security of your information during transmission by using Secure Sockets Layer (SSL) software.</p>
						<a href="/content/policies/privacy-policy" target="_blank">Read How We Protect Your Info</a>
						<dsp:droplet name="/atg/targeting/TargetingFirst">
							<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/SecuredShoppingContent" />
							<dsp:oparam name="output">
								<dsp:valueof param="element.content.data" valueishtml="true" />
							</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>