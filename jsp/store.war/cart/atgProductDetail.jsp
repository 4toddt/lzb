<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/commerce/pricing/droplet/LZBExceptionPriceDroplet"/>
<dsp:importbean bean="/com/lzb/droplet/LZBSelectHotBuyDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/catalog/ProductLookup" />
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />


<dsp:page>
<html>
	<head>
	   <link rel="stylesheet" href="/work/css/jquery-ui.css?ver=${assetVersion}">

   		<script src="/work/js/jquery.min.js?ver=${assetVersion}"></script>
		<script src="/work/js/jquery-ui.js?ver=${assetVersion}"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				var coverId = '';
				var grade = '';
				var exceptionId = '';
	        	$("a[id$='cover']").click(function(e){
	        		coverId = $(this).data("coverid");
	        		grade = $(this).data("grade");
	        		$("a[id$='cover']").css("color", "blue");
	        		$( this ).css( "color", "red" );
	        		//alert(grade);
	        		//alert(coverId);
	        	});
	        	$(".option").click(function(e){
	        		var name = $(this).attr("name");
	        		var optionId = $(this).attr("value");
	        		//alert(name);
	        		//alert(optionId);
	        		$('input[class="option"]:checked').each(function() {
	        			//alert($(this).val());
	        			//alert($(this).data("type"));
	        		});
	        	});

	        	$('#addToCartId').click(function(e){
       				var qty = $('#quantity').val();
            		var cartRequest = {};
            		if ( (coverId != undefined && coverId != '')  || (qty <=0 ) ) {
	            		cartRequest = getCartRequest();
	            		$('#iteminfo').val(JSON.stringify(cartRequest))
	            		//alert(JSON.stringify(cartRequest));
	            		//$('#addToCart').submit();
	            		//$('#addToCart').submit();
	            		 $.ajax({
	                         type: 'post',
	                         dataType: 'json',
	                         url: $('#addToCart').attr('action'),
	                         data: $('#addToCart').serialize(),
	                         beforeSend: function () {
	                         },
	                         success: function (data) {
	                        	 //alert(JSON.stringify(data));
	                        	 if (data.success != undefined && data.success == false) {
		                        	  var errorHtml = '';
		       			              if (data.errors && data.errors.length > 0) {
		       			                  for (lI = 0; lI < data.errors.length; lI++) {
		       			                      errorHtml += '<p style="color:red">' + data.errors[lI].message + '</p>';
		       			                  }
		       			                  $('#cartDiaglog').html(errorHtml);
		       			               	  $("#cartDiaglog").dialog();
		       			              }
	                        	 } else {
	                        		 //if (data.editCommerceItemId != undefined && data.editCommerceItemId != "") {
	                        			// $('#editCommerceItemId').val(data.editCommerceItemId);
	                        		 //}
	                        		 if (data.addedItems && data.addedItems.length > 0) {
	                        			 var html = "";
		       			                  for (lI = 0; lI < data.addedItems.length; lI++) {

			       			                	html += '<p style="color:black">' + data.addedItems[lI].numOfItemAdded + ' item added to your cart</p>';
			       			                	html += '<p style="color:black">you have ' + data.addedItems[lI].totalItemInCart + ' items in your cart</p>';
			       			                	html += '<p style="color:black">your shopping cart subtotal ' + data.addedItems[lI].total + ' </p>';
			       			                	html += '<p style="color:black">' + data.addedItems[lI].configSkuDisplayName + '</p>';
			       			                	html += '<p style="color:black">' + data.addedItems[lI].price + '</p>';
			       			                	if (data.addedItems[lI].performanceFabric == "true") {
			       			                		html += '<p style="color:black">Cover type: ' + data.addedItems[lI].coverType + ', Performance Fabric</p>';
			       			                	} else {
				       			                	html += '<p style="color:black">Cover type: ' + data.addedItems[lI].coverType + '</p>';
			       			                	}
			       			                	html += '<p style="color:black">Color: ' + data.addedItems[lI].color + ' '+data.addedItems[lI].coverId+'</p>';
			       			                	if (data.addedItems[lI].protectionPlanDisplayName != "") {
			       			                		html += '<p style="color:black">Protection Plan : ' + data.addedItems[lI].protectionPlanDisplayName + '</p>';
				       			                	html += '<p style="color:black">Price: ' + data.addedItems[lI].protectionPlanPrice + '</p>';
			       			                	}
		       			                  }
		       			                  html += '<p>Cart page <a href="/work/cart/cart.jsp">click here</a></p>'
		       			                  $('#cartDiaglog').html(html);
		       			               	  $("#cartDiaglog").dialog();
		       			              }

	                        		//$("#cartDiaglog").html('<p style="color:red">Item '+ data.addedItemId+' added to cart. <a href="/work/cart/cart.jsp">Click here</a></p>');
	                        		//$("#cartDiaglog").dialog();

	                        	 }
	                        	 //alert(JSON.stringify(data));
	                         },
	                         error: function (data) {
	                         },
	                         complete: function (response) {
	                         }
	                     });

            		} else {
            			$("#cartDiaglog").html('<p style="color:red">Please select cover</p>');
            			$("#cartDiaglog").dialog();
            		}
	        	});

	        	$('#calculatePrice').click(function(e){
	        		var dealerid = $('#dealerid').val();
       				var productid = $('#productid').val();
       				var catalogrefid = $('#catalogrefid').val();
       				var exceptionid = $('#exceptionid').val();
       				var qty = $('#quantity').val();
            		var cartRequest = {};
            		var coveroptionskus = [];
            		cartRequest.dealerid = dealerid;
            		cartRequest.productid = productid;
            		cartRequest.catalogrefid = catalogrefid;
            		cartRequest.exceptionid = exceptionid;
            		cartRequest.qty = qty;
            		cartRequest.coveroptionskus = coveroptionskus;
            		if (coverId != undefined && coverId != '') {
            			var coverRequest = { "subskuid":coverId , "type": "cover", "qty":1 };
            			cartRequest.coveroptionskus.push(coverRequest);
	            		$('input[class="option"]:checked').each(function() {
		        			//alert($(this).val());
		        			//alert($(this).data("type"));
		        			if ($(this).val() != undefined) {
		        				coverRequest = { "subskuid":$(this).val() , "type": "option", "qty":1 };
		        				var option ='input[id='+$(this).val()+"]:checked";
			        			if ($(option).val() != undefined) {
			                		var options = [];
			                		var optionitem = { "subskuid":$(option).val() , "type": $(option).data("type"), "qty":1 };
			                		options.push(optionitem);
			                		coverRequest = { "subskuid":$(this).val() , "type": "option", "qty":1 , "options": options}
			        			}
			        			//alert($(option).val());
			        			//alert($(option).data("type"));
				        		cartRequest.coveroptionskus.push(coverRequest);
		        			}
		        		});
	            		//$('#iteminfo').val(JSON.stringify(cartRequest))
	            		//alert(JSON.stringify(cartRequest));
	            		//$('#addToCart').submit();
	            		var req = "itemInfo=" + JSON.stringify(cartRequest);
	            		//alert(req);
	            		 $.ajax({
	                         type: 'get',
	                         dataType: 'json',
	                         url: "/work/pricing/json/exceptionPriceJson.jsp",
	                         data: req,
	                         beforeSend: function () {
	                         },
	                         success: function (data) {
	                        	 //alert(JSON.stringify(data));
	                        	 var priceHtml = "";
	                        	 if (data.hasExceptionPrice != undefined && data.hasExceptionPrice == "true") {
	                        		 $('#exceptionid').val(data.exceptionId);
	                        		 priceHtml += "Limited Offer Price -"
	                        		 if (data.exceptionSalePrice != undefined && data.exceptionSalePrice != "$0.00") {
	                        			 priceHtml += data.exceptionSalePrice;
	                        		 } else {
	                        			 priceHtml += data.exceptionListPrice;
	                        		 }
	                        	 } else {
	                        		 $('#exceptionid').val('');
	                        		 priceHtml = data.totalAmount;
	                        	 }
	                        	 //alert(priceHtml);
	                        	 $('#priceAmount').html(priceHtml);
	                        	 $('#priceAmount').css("color", "Red");
	                         },
	                         error: function (data) {
	                         },
	                         complete: function (response) {
	                         }
	                     });

            		} else {
            			$("#cartDiaglog").html('<p style="color:red">Please select cover</p>');
            			$("#cartDiaglog").dialog();
            		}

	        	});

	        	function getCartRequest() {

	        		var dealerid = $('#dealerid').val();
       				var productid = $('#productid').val();
       				var catalogrefid = $('#catalogrefid').val();
       				var exceptionid = $('#exceptionid').val();
       				var qty = $('#quantity').val();
            		var cartRequest = {};
            		var coveroptionskus = [];
            		cartRequest.dealerid = dealerid;
            		cartRequest.productid = productid;
            		cartRequest.catalogrefid = catalogrefid;
            		cartRequest.exceptionId = exceptionid;
            		cartRequest.qty = qty;
            		cartRequest.coveroptionskus = coveroptionskus;
            		var coverRequest = { "subskuid":coverId , "type": "cover", "howToStyle":"" , "qty":qty };
           			cartRequest.coveroptionskus.push(coverRequest);
            		$('input[class="option"]:checked').each(function() {
	        			//alert($(this).val());
	        			//alert($(this).data("type"));
	        			if ($(this).val() != undefined) {
	        				var optiontype = $(this).data("code");
	        				//alert("code: " + $(this).data("code"));
	        				if (optiontype != undefined && (optiontype=="P1" || optiontype=="P2" || optiontype=="WL" || optiontype=="FN" )) {
	        					optiontype = optiontype;
	        				} else {
	        					optiontype = "option";
	        				}
	        				coverRequest = { "subskuid":$(this).val() , "type": optiontype, "howToStyle":"", "qty":1 };
	        				var option ='input[id='+$(this).val()+"]:checked";
		        			if ($(option).val() != undefined) {
		                		var options = [];
		                		var optionitem = { "subskuid":$(option).val() , "type": $(option).data("type"), "howToStyle":"", "qty":1 };
		                		options.push(optionitem);
		                		coverRequest = { "subskuid":$(this).val() , "type": optiontype , "qty":1 , "howToStyle":"", "options": options}
		        			}
		        			//alert($(option).val());
		        			//alert($(option).data("type"));
			        		cartRequest.coveroptionskus.push(coverRequest);
	        			}
	        		});
	        		return 	cartRequest;
	        	}

			});
		</script>
	</head>
	<body>
		<dsp:getvalueof var="productId" param="prodId" />



		Current Store : <dsp:valueof bean="Profile.currentStore" />
		Current Dealer : <dsp:valueof bean="Profile.currentDealerId" />

		<dsp:droplet name="LZBItemJsonRequestDroplet">
			<dsp:param name="commid" param="commid" />
			<dsp:oparam name="output">
			<dsp:getvalueof var="jsonreq" param="jsonrequest" />
			<!-- hiddenjson= ${jsonreq} -->
			</dsp:oparam>
		</dsp:droplet>

		<div id="cartDiaglog" title="Add to Cart">
		</div>
		<dsp:droplet name="ProductLookup">
			<dsp:param name="id" param="prodId" />
			<dsp:param name="elementName" value="product" />
			<dsp:oparam name="output">
			    <h1><dsp:valueof param="product.displayName" /></h1>
				<p>
					<span><dsp:valueof param="product.description" /></span>
				</p>
				<h2>Sku Information</h2>
				<dsp:droplet name="ForEach">
					<dsp:param name="array" param="product.childSKUs" />
					<dsp:param name="elementName" value="sku" />
					<dsp:oparam name="output">
						    <h3>
						      <dsp:valueof param="sku.displayName" />
						      <p id="priceAmount"></p>
						    </h3>
						    <dsp:getvalueof var="skuId" param="sku.id" />
						    <dsp:getvalueof var="editCommerceItemId" param="commid" />
						    <dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />
						    <dsp:form id="addToCart" name="addToCart" method="post" action="/work/cart/atgProductDetail.jsp?prodId=${productId}">
								<input 		id="dealerid" 		type="hidden" name="dealer"  value='${dealer}' />
								<dsp:input 	id="productid" 		type="hidden" bean="CartModifierFormHandler.productId" 		value="${productId}" />
								<dsp:input 	id="catalogrefid" 	type="hidden" bean="CartModifierFormHandler.catalogRefIds" 	value="${skuId}" />
								<dsp:input 	id="exceptionid" 	type="hidden" bean="CartModifierFormHandler.exceptionId" 	value="" />
								<input 		id="quantity" 		type="text" name="${skuId}"  value="1" />
								<input 		id="subskuid" 		type="hidden" name="subskuid"  value="" />
								<input 		id="suboptionid" 	type="hidden" name="suboptionid"  value="" />
								<input 		id="iteminfo" 		type="hidden" name="iteminfo"  value="" />
								<input 		id="editCommerceItemId" type="hidden" name="editCommerceItemId"  value="${editCommerceItemId }" />
								<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="../cart/json/cartSuccessJson.jsp" />
								<dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="../cart/json/cartSuccessJson.jsp" />
								<dsp:input type="hidden" bean="CartModifierFormHandler.addConfigurableItemToOrder" value="true" />
								<input id="addToCartId" type="button" 	value="add to cart" />
								<input id="calculatePrice" type="button" 	value="Calculate Price" />
							</dsp:form>
						    <dsp:droplet name="ForEach">
							<dsp:param name="array" param="sku.configurableProperties" />
							<dsp:param name="elementName" value="configPropertyCover" />
							<dsp:oparam name="output">
							<dsp:getvalueof var="type" param="configPropertyCover.type"/>
							<dsp:getvalueof var="name" param="configPropertyCover.displayName" />
							  <c:choose>
							  <c:when test="${name eq 'Cover'}">
							    <table>

							   		<tr><td><h3><dsp:valueof param="configPropertyCover.displayName" /></h3></td></tr>
							   		<dsp:droplet name="ForEach">
									<dsp:param name="array" param="configPropertyCover.configurationOptions" />
									<dsp:param name="elementName" value="configOptionCover" />
										<dsp:oparam name="output">
										  <tr>
										  	<td>&nbsp;&nbsp;</td>
										  	<td>
										  	<p>
										  	<dsp:valueof param="configOptionCover.sku.grade" />
										  	(<dsp:include page="/pricing/priceInfo.jsp">
												   		<dsp:param name="configSkuId" param="sku.id" />
												   		<dsp:param name="skuId" param="sku.id"/>
												   		<dsp:param name="grade" param="configOptionCover.sku.grade" />
												   </dsp:include>)
										  	</p>
										  	</td>
										  	<td>&nbsp;&nbsp;</td>
										  	<td colspan="10">
										  		<dsp:getvalueof var="grade" param="configOptionCover.sku.grade" />
										  	<table><tr>
											  	<dsp:droplet name="ForEach">
												<dsp:param name="array" param="configOptionCover.sku.priceGradeCovers" />
												<dsp:param name="elementName" value="cover" />
													<dsp:oparam name="output">
													 <dsp:getvalueof var="coverId" param="cover.id" />

													  <td> <p><a href="javascript:void(0)" id="cover" data-grade="${grade}" data-coverid="${coverId}" data-type="cover" class="cover"><dsp:valueof param="cover.colorDescription"/></a></p></td>
													</dsp:oparam>
												</dsp:droplet>
										  	</tr></table>
										  	</td>
										  </tr>
										</dsp:oparam>
									</dsp:droplet>
								</table>
							  </c:when>
							  </c:choose>
							</dsp:oparam>
							</dsp:droplet>

							<h3>Options and Upgrade</h3>
							<dsp:droplet name="ForEach">
							<dsp:param name="array" param="sku.configurableProperties" />
							<dsp:param name="elementName" value="configProperty" />
							<dsp:oparam name="output">
							<dsp:getvalueof var="type" param="configProperty.type"/>
							<dsp:getvalueof var="name" param="configProperty.displayName" />
							  <c:choose>
							  <c:when test="${name eq 'Cover'}">
							  </c:when>
							  <c:when test="${(empty type || type eq 'configurableProperty') }">
							        <table>

							   		<tr><td><h4><dsp:valueof param="configProperty.displayName" /></h4></td></tr>
							   		<dsp:droplet name="ForEach">
									<dsp:param name="array" param="configProperty.configurationOptions" />
									<dsp:param name="elementName" value="configOption" />
										<dsp:oparam name="output">
										  <dsp:getvalueof var="optionSkuType" param="configOption.sku.type" />
										  <dsp:getvalueof var="optionSkuId" param="configOption.sku.id" />
										  ${optionSkuId}
										  <tr><td>&nbsp;&nbsp;</td>
										   <td>
										   <p>
										   <input type="radio" name="${name}" value="${optionSkuId }" class="option" data-type="option"/><dsp:valueof param="configOption.sku.displayName" />
										   (<c:choose>
									 		 	 <c:when test="${optionSkuType eq 'configurableSku'}">
									 		 	   <dsp:include page="/pricing/priceInfo.jsp">
												   		<dsp:param name="skuId" value="${optionSkuId}"/>
												   		<dsp:param name="grade" value="A"/>
												   		<dsp:param name="showStrickedPrice" value="false"/>
												   </dsp:include>
									 		 	 </c:when>
									 		 	 <c:otherwise>
									 		 	   <dsp:include page="/pricing/priceInfo.jsp">
												   		<dsp:param name="skuId" value="${optionSkuId}"/>
												   		<dsp:param name="showStrickedPrice" value="false"/>
												   </dsp:include>
									 		 	 </c:otherwise>
									 		 	</c:choose>)
										   </p>
										   </td>
										   <c:if test="${optionSkuType eq 'optionSku'}">
										   		<dsp:getvalueof var="optionFinish" param="configOption.sku.finishes" />
										   		<dsp:getvalueof var="optionValues" param="configOption.sku.optionValues" />
										   		<dsp:getvalueof var="optionCovers" param="configOption.sku.subOptions" />
										   		<c:if test="${not empty optionCovers}">
										   		  <td>&nbsp;&nbsp;</td>
										   		  <td colspan="10">
										   		   <table>
										   		   <tr><td><b>Option Covers</b></td></tr>

										   		   <tr>
										   			<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${optionCovers}" />
													<dsp:param name="elementName" value="optionCover" />
														<dsp:oparam name="output">
														  <dsp:getvalueof var="optionCoverId" param="optionCover.id" />
														  <td>

														  <input type="radio" name="${optionSkuId}" value="${optionCoverId }" id="${optionSkuId}"  data-type="optionCover"/><dsp:valueof param="optionCover.colorDescription"/>
														  </td>
														</dsp:oparam>
													</dsp:droplet>
													</tr>

													</table>

												   </td>

										   		</c:if>
										   		<c:if test="${not empty optionValues}">
										   		<td>&nbsp;&nbsp;</td>
										   		   <td colspan="10">
										   		   <table>
										   		   <tr><td><b>Option Values</b></td></tr>

										   		   <tr>
										   			<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${optionValues}" />
													<dsp:param name="elementName" value="optValue" />
														<dsp:oparam name="output">
														 <dsp:getvalueof var="optValue" param="optValue" />

														  <td>

														  <input type="radio" name="${optionSkuId}" value="${optValue }" id="${optionSkuId}"  data-type="optionValue"/><dsp:valueof param="optValue"/>
														  </td>
														</dsp:oparam>
													</dsp:droplet>
													</tr>
													</table>
												   </td>
										   		</c:if>
										   		<c:if test="${not empty optionFinish}">
										   		<td>&nbsp;&nbsp;</td>
										   		 <td colspan="10">
										   		   <table>
										   		   <tr><td><b>Finish</b></td></tr>

										   		   <tr>
										   			<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${optionFinish}" />
													<dsp:param name="elementName" value="optfinish" />
														<dsp:oparam name="output">
														  <dsp:getvalueof var="optfinishCode" param="optfinish.finishCode" />

														 <td><input type="radio" name="${optionSkuId}" value="${optfinishCode }" id="${optionSkuId}"  data-type="optionFinish"/><dsp:valueof param="optfinish.finishCode"/></td>
														</dsp:oparam>
													</dsp:droplet>
													</tr>
													</table>
												   </td>
										   		</c:if>
										   </c:if>
										  </tr>
										</dsp:oparam>
									</dsp:droplet>
									</table>
							   </c:when>
							   <c:otherwise>
							     <table>

							      <tr><td><h4><dsp:valueof param="configProperty.displayName" /></h4></td><tr/>
							      <dsp:droplet name="ForEach">
									<dsp:param name="array" param="configProperty.configurationOptionsGroup" />
									<dsp:param name="elementName" value="configOptionGroup" />
										<dsp:oparam name="output">
											<dsp:getvalueof var="ogName" param="configOptionGroup.displayName" />

										    <tr><td>&nbsp;</td><td><p><b><dsp:valueof param="configOptionGroup.displayName" /></b></p></td></tr>

										    <dsp:droplet name="ForEach">
											<dsp:param name="array" param="configOptionGroup.configurationOptions" />
											<dsp:param name="elementName" value="configOptionGroupOption" />
												<dsp:oparam name="output">
												<dsp:getvalueof var="ogOptionSkuId" param="configOptionGroupOption.sku.id" />
												<dsp:getvalueof var="ogOptionSkuType" param="configOptionGroupOption.sku.type" />

												 <tr>
												 	<td>&nbsp;&nbsp;</td>
												 	<td><p>
												 	<c:choose>
											 		 	 <c:when test="${ogOptionSkuType eq 'optionSku'}">
											 		 	 	<dsp:getvalueof var="optioncode" param="configOptionGroupOption.sku.optionCode" />
											 		 	 </c:when>
											 		 	 <c:otherwise>
											 		 	 	<dsp:getvalueof var="optioncode" value="" />
											 		 	 </c:otherwise>
										 		 	 </c:choose>

												 		<input type="radio" name="${ogName}" value="${ogOptionSkuId }" class="option" data-type="option" data-code="${optioncode }" /><dsp:valueof param="configOptionGroupOption.sku.displayName" />
												 			(<c:choose>
												 		 	 <c:when test="${ogOptionSkuType eq 'configurableSku'}">
												 		 	   <dsp:include page="/pricing/priceInfo.jsp">
															   		<dsp:param name="skuId" value="${ogOptionSkuId}"/>
															   		<dsp:param name="grade" value="A"/>
															   		<dsp:param name="showStrickedPrice" value="false"/>
															   </dsp:include>
												 		 	 </c:when>
												 		 	 <c:otherwise>
												 		 	   <dsp:include page="/pricing/priceInfo.jsp">
															   		<dsp:param name="skuId" value="${ogOptionSkuId}"/>
															   		<dsp:param name="showStrickedPrice" value="false"/>
															   </dsp:include>
												 		 	 </c:otherwise>
												 		 	</c:choose>)
												 		</p>
												 	</td>

														<c:if test="${ogOptionSkuType eq 'optionSku'}">
												   		<dsp:getvalueof var="ogOptionFinish" param="configOptionGroupOption.sku.finishes" />
												   		<dsp:getvalueof var="ogOptionValues" param="configOptionGroupOption.sku.optionValues" />
												   		<dsp:getvalueof var="ogOptionCovers" param="configOptionGroupOption.sku.subOptions" />
												   		<dsp:getvalueof var="ogOptionCode" param="configOptionGroupOption.sku.optionCode" />

												   		<c:if test="${not empty ogOptionCovers}">
												   		<td>&nbsp;&nbsp;</td>
												   		  <td colspan="10">
												   		   <table>
												   		    <tr><td><b>Option Covers</b></td></tr>

												   		    <tr>
												   			<dsp:droplet name="ForEach">
															<dsp:param name="array" value="${ogOptionCovers}" />
															<dsp:param name="elementName" value="ogoptionCover" />
																<dsp:oparam name="output">
																<dsp:getvalueof var="ogoptionCoverId" param="ogoptionCover.id" />

																 <td><input type="radio" name="${ogOptionSkuId}" value="${ogoptionCoverId }" id="${ogOptionSkuId}"  data-type="optionCover" data-code="${ogOptionCode }" /><dsp:valueof param="ogoptionCover.colorDescription"/></td>
																</dsp:oparam>
															</dsp:droplet>
															</tr>
															</table>
														   </td>
												   		</c:if>
												   		<c:if test="${not empty ogOptionValues}">
												   		<td>&nbsp;&nbsp;</td>
												   		   <td colspan="10">
												   		   <table>
												   		   <tr><td><b>Option Value</b></td></tr>
												   		   <tr>
												   			<dsp:droplet name="ForEach">
															<dsp:param name="array" value="${ogOptionValues}" />
															<dsp:param name="elementName" value="ogoptValue" />
																<dsp:oparam name="output">
																	<dsp:getvalueof var="ogoptValue" param="ogoptValue" />

																  <td><input type="radio" name="${ogOptionSkuId}" value="${ogoptValue }" id="${ogOptionSkuId}"  data-type="optionValue"/><dsp:valueof param="ogoptValue"/></td>
																</dsp:oparam>
															</dsp:droplet>
															</tr>
															</table>
														   </td>
												   		</c:if>
												   		<c:if test="${not empty ogOptionFinish}">
												   		 <td>&nbsp;&nbsp;</td>
												   		 <td colspan="10">
												   		   <table>
												   		   <tr><td><b>Finish</b></td></tr>
												   		   <tr>
												   			<dsp:droplet name="ForEach">
															<dsp:param name="array" value="${ogOptionFinish}" />
															<dsp:param name="elementName" value="ogoptfinish" />
																<dsp:oparam name="output">
																  <dsp:getvalueof var="ogoptfinishCode" param="ogoptfinish.finishCode" />

																  <td><input type="radio" name="${ogOptionSkuId}" value="${ogoptfinishCode }" id="${ogOptionSkuId}"  data-type="optionFinish"/><dsp:valueof param="ogoptfinish.finishCode"/></td>
																</dsp:oparam>
															</dsp:droplet>
															</tr>
															</table>
														   </td>
												   		</c:if>
												   </c:if>
												 </tr>
												</dsp:oparam>
											</dsp:droplet>
										</dsp:oparam>
									</dsp:droplet>
								</table>
							   </c:otherwise>
							  </c:choose>


							</dsp:oparam>
							</dsp:droplet>
							<!-- Limited Offer -->
							<table>
								<dsp:droplet name="LZBSelectHotBuyDroplet">
								<dsp:param name="dealerId" bean="Profile.currentDealerId" />
								<dsp:param name="configSkuId" param="sku.id"/>
								<dsp:param name="profile" bean="Profile"/>
								<dsp:oparam name="select">
								    <tr><th>Selects</th></tr>
									<dsp:droplet name="ForEach">
									<dsp:param name="array" param="selects" />
									<dsp:param name="elementName" value="select" />
										<dsp:oparam name="output">
										  	<tr><td> <dsp:valueof param="select.configSku.displayName"/><td></td>
										  	<tr><td> <dsp:valueof param="select.cover.displayName"/></td></tr>

										    <dsp:droplet name="ForEach">
											<dsp:param name="array" param="select.options" />
											<dsp:param name="elementName" value="option" />
											<dsp:oparam name="outputStart">
											<tr><td>Options{
											</dsp:oparam>
											<dsp:oparam name="output">
												  	<dsp:valueof param="option.optionCode"/>&nbsp;
											</dsp:oparam>
											<dsp:oparam name="outputEnd">
											}</td></tr>
											</dsp:oparam>
											</dsp:droplet>
											<tr><td>Promo Id : <dsp:valueof param="select.exceptionId"/> </td></tr>
										    <tr><td>List Price : <dsp:valueof param="select.listPrice"/> </td></tr>
										    <tr><td>Sale Price Id : <dsp:valueof param="select.salePrice"/> </td></tr>
										    <tr><td>&nbsp;</td></tr>
										    <tr><td>&nbsp;</td></tr>
										</dsp:oparam>
									</dsp:droplet>
								</dsp:oparam>
								<dsp:oparam name="hotBuy">
									<tr><th>Hot Buys</th></tr>
									<dsp:droplet name="ForEach">
									<dsp:param name="array" param="hotBuys" />
									<dsp:param name="elementName" value="hotBuy" />
										<dsp:oparam name="output">
										    <tr><td> <dsp:valueof param="hotBuy.configSku.displayName"/></td></tr>
										  	<tr><td><dsp:valueof param="hotBuy.cover.displayName"/></td></tr>
										  	<tr><td>:::options{
										    <dsp:droplet name="ForEach">
											<dsp:param name="array" param="hotBuy.options" />
											<dsp:param name="elementName" value="option" />
											<dsp:oparam name="outputStart">
											<tr><td>Options{
											</dsp:oparam>
												<dsp:oparam name="output">
												  	<dsp:valueof param="option.optionCode"/>&nbsp;
												</dsp:oparam>
											<dsp:oparam name="outputEnd">
											}</td></tr>
											</dsp:oparam>
											</dsp:droplet>
											<tr><td> Promo Id : <dsp:valueof param="hotBuy.exceptionId"/>  </td></tr>
											<tr><td> List Price : <dsp:valueof param="hotBuy.listPrice"/>  </td></tr>
										    <tr><td> Sale Price : <dsp:valueof param="hotBuy.salePrice"/>  </td></tr>
											<tr><td> &nbsp;</td></tr>
											<tr><td> &nbsp;</td></tr>
										</dsp:oparam>
									</dsp:droplet>
								</dsp:oparam>
							</dsp:droplet>
						</table>
					</dsp:oparam>
				</dsp:droplet>
			</dsp:oparam>
		</dsp:droplet>







	</body>
</html>
</dsp:page>
