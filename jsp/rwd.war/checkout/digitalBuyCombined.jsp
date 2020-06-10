<dsp:page>

	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyTokenDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <dsp:getvalueof var="paymentGroups" vartype="java.lang.Object" bean="ShoppingCart.current.PaymentGroups" />
	<dsp:getvalueof var="paymentAddress" value="${paymentGroups[0].billingAddress}" />

	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" bean="ShoppingCart.current"/>
	    <dsp:param name="profile" bean="Profile" />
	    <dsp:param name="page" value="checkout"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="orderTotal" param="total"/>
		</dsp:oparam>
	</dsp:droplet>
	
	<script src="https://ubuy.syf.com/digitalbuy/js/merchant_ff.js"></script>

	<dsp:droplet name="GetDigitalBuyTokenDroplet" >
		<dsp:param name="order" bean="ShoppingCart.current" />
		<dsp:oparam name="output" >
			<dsp:getvalueof var="token" param="token" />
			<dsp:getvalueof var="postback" param="postback" />
		</dsp:oparam>	
	</dsp:droplet>
	
	<script type="text/javascript">
	function formToJSON() {
	    let JSONObject = {};
		<!-- REQUIRED FIELDS -->
	    JSONObject.processInd = document.getElementById("processInd").value;
	    JSONObject.tokenId = document.getElementById("tokenId").value;
	    JSONObject.merchantID = document.getElementById("merchantID").value;
	    JSONObject.clientTransId = document.getElementById("clientTransId").value;
	    
	    JSONObject.custFirstName = document.getElementById("custFirstName").value;
	    JSONObject.custLastName = document.getElementById("custLastName").value;
	    JSONObject.custZipCode = document.getElementById("custZipCode").value;
	    JSONObject.custAddress1 = document.getElementById("custAddress1").value;
	    JSONObject.custCity = document.getElementById("custCity").value;
	    JSONObject.custState = document.getElementById("custState").value;

	    JSONObject.transPromo1 = document.getElementById("transPromo1").value;
	    JSONObject.transAmount1 = document.getElementById("transAmount1").value;
	    
	    return JSONObject;
	}
	</script>
	
	<script type="text/javascript">
	window.addEventListener("message",function(event) {
       if (typeof event.data == 'string' && (event.data == 'Close Model' || event.data == 'Return To Merchant Shipping')) {
              console.log('SYNCHRONY MODAL CLOSED', event);
              window.location.href = '/rwd/checkout/digitalBuyCommit.jsp';
       }
	});

	$(document).ready(function(){
	     $("#dbuyform3").submit();
	});

	</script>
	

	<div id="dbuymodel3"/> 
	<form name="dbuyform3" id="dbuyform3"> 
		<input type="hidden" id="processInd" value="3" /> 
		<input type="hidden" id="tokenId" value="${token}" /> 
		<input type="hidden" id="merchantID" value="${storeConfig.digitalBuyMerchantID}" /> 
		<input type="hidden" id="clientTransId" value="<dsp:valueof bean="ShoppingCart.current.id"/>" />
		<input type="hidden" id="custFirstName" value="${paymentAddress.firstName}" />
		<input type="hidden" id="custLastName" value="${paymentAddress.lastName}" />
		<input type="hidden" id="custAddress1" value="${paymentAddress.address1}" />
		<input type="hidden" id="custCity" value="${paymentAddress.city}" />
		<input type="hidden" id="custState" value="${paymentAddress.state}" />
		<input type="hidden" id="custZipCode" value="${paymentAddress.postalCode}" />
		<input type="hidden" id="transAmount1" value="${orderTotal}" />
		<input type="hidden" id="transPromo1" value="${storeConfig.digitalBuyFinancePromoCode}" />
		 
		<button type="button" data-toggle="modal" data-target="#digBuyModal" onclick="syfDBuy.calldBuyProcess(null,formToJSON())">Modal</button> 
	</form>

</dsp:page>