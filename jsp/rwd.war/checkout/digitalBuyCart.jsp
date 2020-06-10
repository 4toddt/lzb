<dsp:page>

	<dsp:importbean bean="/com/lzb/droplet/GetDigitalBuyTokenDroplet" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

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
	    return JSONObject;
	}
	</script>
	
	<script type="text/javascript">
	window.addEventListener("message",function(event) {
       if (typeof event.data == 'string' && (event.data == 'Close Model' || event.data == 'Return To Merchant Shipping')) {
              console.log('SYNCHRONY MODAL CLOSED', event);
              window.location.href = '/rwd/checkout/digitalBuyShipping.jsp';
       }
	});
	</script>

	<div id="dbuymodel1"/> 
		<form name="dbuyform1" id="dbuyform1"> 
			<input type="hidden" id="processInd" value="1" /> 
			<input type="hidden" id="tokenId" value="${token}" /> 
			<input type="hidden" id="merchantID" value="${storeConfig.digitalBuyMerchantID}" /> 
			<input type="hidden" id="clientTransId" value="<dsp:valueof bean="ShoppingCart.current.id"/>" /> 
			<button type="button" data-toggle="modal" data-target="#digBuyModal" onclick="syfDBuy.calldBuyProcess(null,formToJSON())">Modal</button> 
		</form>
	</div>

</dsp:page>