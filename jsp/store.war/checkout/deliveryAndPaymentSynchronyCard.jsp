<dsp:page>

	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <dsp:importbean bean="/com/lzb/service/ge/Configuration" />
    <dsp:importbean bean="/com/lzb/service/SessionBean" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty"/>
	deliveryAndPaymentSynchronyCard version 1.0 <br/>
	OrderId=<dsp:valueof bean="ShoppingCart.current.id"/><br/>
	From Session:ShopperId=<dsp:valueof bean="SessionBean.gEShopperId"/><br/>
    From Session:Token=<dsp:valueof bean="SessionBean.gEToken"/><br/>

	<dsp:include page="includes/checkoutHeader.jsp">
		<dsp:param name="page" value="delPay"/>
	</dsp:include>
	<h2><fmt:message key="checkout.deliveryAndPaymentText"/></h2>
	<p><fmt:message key="checkout.deliveryAndPayment.instruction"/></p>


	<%-- formhandler Errors --%>
	<dsp:getvalueof bean="PaymentGroupFormHandler.formError" var="formError" />
	<c:if test="${formError eq 'true'}">
		<dsp:include page="/global/errors.jsp">
			<dsp:param name="formHandler" bean="PaymentGroupFormHandler" />
		</dsp:include>
	</c:if>
	<dsp:form name="deliveryAndPaymentForm" action="/checkout/deliveryAndPaymentSynchornyCard.jsp" formid="deliveryAndPaymentForm" id="deliveryAndPaymentForm" method="post">
		<dsp:include page="gadgets/continueToReviewButton.jsp"></dsp:include></br>
		<dsp:include page="shipping.jsp"></dsp:include></br></br></br></br></br></br>
		</br></br></br></br></br></br>
		<dsp:include page="paymentSynchronyCard.jsp"></dsp:include></br>
		<dsp:include page="gadgets/continueToReviewButton.jsp"></dsp:include>
	</dsp:form>
	</br>
	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/SecuredShoppingContent" />
		<dsp:oparam name="output">
			<dsp:valueof param="element.content.data" valueishtml="true" />
		</dsp:oparam>
	</dsp:droplet>

	<c:if test="${cartEmpty eq 'false'}">
		<dsp:include page="/checkout/gadgets/checkout_order_summary.jsp"/>
	</c:if></br>
	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/OurGauranteeContent" />
		<dsp:oparam name="output">
			<dsp:valueof param="element.content.data" valueishtml="true" />
		</dsp:oparam>
	</dsp:droplet></br>

	<dsp:droplet name="/atg/targeting/TargetingFirst">
		<dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/CustomerCareContent" />
		<dsp:oparam name="output">
			<dsp:valueof param="element.content.data" valueishtml="true" />
		</dsp:oparam>
	</dsp:droplet>
	<div style="border-top:1px solid #000;width:100%;">
		<dsp:a href="#" title="" onclick=""><fmt:message key="cart.liveChat"/></dsp:a>
	</div>
	<script>
		$(".shipRadioBtn").on("click", function(event) {
			var addressId = $(this).val();
			if (addressId == "") {
				return false;
			}
			$('#selShipAddrId').val(addressId);
			$('#addNewAddrId').val("false");
		});
		$("#addNewShipAddr").on("click", function(event) {
			$('#selShipAddrId').val("");
			$('#addNewAddrId').val("true");
		});
		$("#sameAddr").change(function() {
			if ($('#sameAddr').is(':checked')) {
				$("#shipToBill").val("true");
			} else {
				$("#shipToBill").val("false");
			}
		});
		$(".creditCardRadioBtn").on("click", function(event) {
			var creditCardId = $(this).val();
			if (creditCardId == "") {
				return false;
			}
			$('#selCreditCardId').val(creditCardId);
			$('#addNewPaymtId').val("false");
		});
		$("#addNewCC").on("click", function(event) {
			$('#selCreditCardId').val("");
			$('#addNewPaymtId').val("true");
		});
		$(".billRadioBtn").on("click", function(event) {
			var billAddrId = $(this).val();
			if (billAddrId == "") {
				return false;
			}
			$('#selBillAddrId').val(billAddrId);
			$('#addNewBillAddrId').val("false");
		});
		$("#addNewBillAddr").on("click", function(event) {
			$('#selBillAddrId').val("");
			$('#addNewBillAddrId').val("true");
		});
		$("#sameAddr1").change(function() {
			if ($('#sameAddr1').is(':checked')) {
				$("#shipToBill1").val("true");
			} else {
				$("#shipToBill1").val("false");
			}
		});
		$(".creditCardRadioBtn1").on("click", function(event) {
			var creditCardId = $(this).val();
			if (creditCardId == "") {
				return false;
			}
			$('#selCreditCardId1').val(creditCardId);
			$('#addNewPaymtId1').val("false");
		});
		$("#addNewCC1").on("click", function(event) {
			$('#selCreditCardId1').val("");
			$('#addNewPaymtId1').val("true");
		});
		$(".billRadioBtn1").on("click", function(event) {
			var billAddrId = $(this).val();
			if (billAddrId == "") {
				return false;
			}
			$('#selBillAddrId1').val(billAddrId);
			$('#addNewBillAddrId1').val("false");
		});
		$("#addNewBillAddr1").on("click", function(event) {
			$('#selBillAddrId1').val("");
			$('#addNewBillAddrId1').val("true");
		});
		$("input[id$='continueToReview']").click(function(e){
			$("#deliveryAndPaymentForm").submit();
		});
	</script>
</dsp:page>
