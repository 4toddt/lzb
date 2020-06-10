<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:getvalueof var="loginStatus" bean="Profile.transient"/>
<dsp:page>
	<c:choose>
		<c:when test="${loginStatus==true}">

                <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
                  <dsp:param name="inUrl" value="/"/>
                  <dsp:oparam name="output">
                        <dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
                  </dsp:oparam>
                </dsp:droplet>
                
		<span data-domain="${updatedProtocolURL}" data-module="checkout-modal" data-target="#bPopupContainer">
				<a href="${updatedProtocolURL }modals/checkoutSignIn.jsp" class="signin-checkout sign-in btn-primary checkout-sign-in-click" data-module="modal-jquery-validation" data-form="signInForm"  data-domain="${updatedProtocolURL}" >Checkout</a>
		</span>
		</c:when>
		<c:otherwise>
			<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
			
			<dsp:form id="addItemToCartForm" action="#" method="post" name="addItemToCartForm" action="/cart/cart.jsp">
				<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelIdSuccessURL" value="/checkout/deliveryAndPayment.jsp" />
				<dsp:input type="hidden" bean="CartModifierFormHandler.moveToPurchaseInfoByRelIdErrorURL" value="/cart/cart.jsp" />
				<dsp:input bean="CartModifierFormHandler.moveToPurchaseInfoByRelId" iclass="btn-primary" type="submit" value="Checkout" />
			</dsp:form>
		</c:otherwise>

	</c:choose>
</dsp:page>
