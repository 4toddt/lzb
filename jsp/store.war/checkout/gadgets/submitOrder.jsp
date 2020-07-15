<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler"/>
	
	  <fmt:message var="submit" key="checkout.review.submitOrder"/>
	  <dsp:input type="submit" iclass="btn-primary review-button" bean="/atg/commerce/order/purchase/CommitOrderFormHandler.commitOrder"  value="${submit} >" />
	  <dsp:input type="hidden" bean="/atg/commerce/order/purchase/CommitOrderFormHandler.commitOrderSuccessURL"  value="/checkout/orderConfirmation.jsp" />
	  <dsp:input type="hidden" bean="/atg/commerce/order/purchase/CommitOrderFormHandler.commitOrderErrorURL"  value="/checkout/orderReview.jsp" />
</dsp:page>