<dsp:page>
	<dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler" />

	<dsp:getvalueof var="token" param="token" />
	<dsp:getvalueof var="postback" param="postback" />

	<dsp:form id="digital-buy-form" method="post" name="digital-buy-form" formid="digital-buy-form">
	  	<dsp:input type="hidden" bean="CommitOrderFormHandler.usingDigitalBuy" value="true" />
	  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderSuccessURL"  value="/rwd/checkout/orderConfirmation.jsp" />
	  	<dsp:input type="hidden" bean="CommitOrderFormHandler.commitOrderErrorURL"  value="/rwd/checkout/checkout.jsp" />
	  	<dsp:input type="submit" bean="CommitOrderFormHandler.commitOrder" iclass="button tertiary review-continue checkout-btn" value="COMMIT ORDER" />
	</dsp:form>

	<script type="text/javascript">
	$(document).ready(function(){
	     $("#digital-buy-form").submit();
	});
	</script>
</dsp:page>
