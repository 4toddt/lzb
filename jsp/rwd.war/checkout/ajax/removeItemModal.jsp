<layout:ajax>

	<jsp:attribute name="section">modal</jsp:attribute>
	<jsp:attribute name="pageType">removeItemModal</jsp:attribute>
	
	<jsp:body>
		<dsp:getvalueof var="ciid" param="ciid" />
		
		<div class="remove-item-modal">
			<div class="modal-body">
				<p><fmt:message key="cart.item.removeConfirmation"/></p>
				<dsp:form id="removeCartItem" formid="removeCartItem" name="removeCartItem" method="post" action="#">
					<dsp:a href="/rwd/checkout/cart.jsp"  bean="/atg/commerce/order/purchase/CartModifierFormHandler.removeItemFromOrder" paramvalue="${ciid}" iclass="button secondary remove-item-yes-btn">
						<dsp:param name="commerceItemToRemove" value="${ciid}" />
						<dsp:param name="successUrl" value="/rwd/checkout/cart.jsp" />
						<dsp:param name="errorUrl" value="/rwd/checkout/cart.jsp" />
						<fmt:message key="cart.item.yes"/>
					</dsp:a>
				</dsp:form>	   					
				<a href="#" class="button secondary remove-item-no-btn" data-dismiss="modal"><fmt:message key="cart.item.no"/></a>
			</div>
		</div>
		
	</jsp:body>
</layout:ajax>
