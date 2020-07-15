<dsp:page>
	<lzb:pageContainer>
		<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
		<dsp:importbean bean="/atg/userprofiling/Profile" />

		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="title">Add Cover to Profile</jsp:attribute>


		<dsp:getvalueof bean="GiftlistFormHandler.formError" var="formError" />
		<c:if test="${formError eq 'true'}">
			<dsp:include page="/global/errors.jsp">
				<dsp:param name="formHandler" bean="GiftlistFormHandler" />
			</dsp:include>
		</c:if>


		<lzb:breadCrumb pageKey="myAccount.savedCovers" divClass="breadcrumb" />

		<c:if test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					</dsp:include>
				</div>
			</div>
		</c:if>

		<dsp:getvalueof var="updateSuccess" param="success" />
		<c:if test="${updateSuccess}">
			<div class="message-wrapper">
				<p>
					<fmt:message key="success.message" />
				</p>
			</div>
		</c:if>
		<main role="main"> <dsp:include
			page="/includes/leftnavigation.jsp">
			<dsp:param name="selpage" value="PROFILE" />
		</dsp:include>

		<section role="region" class="profile-account-content"
			data-module="profile-validate">
			<dsp:form id="addcovertofavouritesfrmid" name="addcovertofavouritesfrm" method="post" action="ProductDetails.jsp">
				<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistSuccessURL" value="/work/account/designeCenter/my_design_center.jsp" />
				<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlistErrorURL" value="/work/account/designeCenter/my_design_center.jsp" />

				<dsp:input type="hidden" bean="GiftlistFormHandler.giftlistId" beanvalue="Profile.savedCovers.id" />

				<dsp:input 	id="productid" 		type="text" bean="GiftlistFormHandler.productId" />
				<dsp:input 	id="catalogrefid" 	type="text" bean="GiftlistFormHandler.catalogRefIds" />
				<fmt:message key="account.designCenter.favourites.quantity" />
				<dsp:input 	id="quantityid" 	type="text" bean="GiftlistFormHandler.quantity" />
				<input 		id="favouriteiteminfo" 		type="hidden" name="favouriteiteminfo" /> <br />

				<dsp:input type="hidden" bean="GiftlistFormHandler.addItemToGiftlist"  value="" />
				<fmt:message var="addToFavourites" key="account.designCenter.favourites.addCovers" />



				<input id="addcovertofavouritesid" type="button"  class="btn-primary"	value="${addToFavourites}" />

				<div id="favouritedetailsdivid"></div>

			</dsp:form>
		</section>
		</main>
		<script type="text/javascript">

			window.onload = function(){

	        	$("#addcovertofavouritesid").click(function(e){
	        		var iteminfo = getItemInfo();
	        		var data = JSON.stringify(iteminfo);
	        		$('#favouriteiteminfo').val(data);

	        		//define success method
	        		 var options = {
	        		 	success : resultOfAddToFavourites
	        		 };
	        		//submit form using ajax
	        		$('#addcovertofavouritesfrmid').ajaxSubmit(options);
	        	});

			};

			function resultOfAddToFavourites(result) {
				$('#favouritedetailsdivid').html(JSON.stringify(result));
			};

			function getItemInfo() {
   				var dealerid = "";
   				var productid = $('#productid').val();
   				var catalogrefid = $('#catalogrefid').val();
   				var qty = $('#quantityid').val();
        		var iteminfo = {};
        		iteminfo.dealerid = dealerid;
        		iteminfo.productid = productid;
        		iteminfo.catalogrefid = catalogrefid;
        		iteminfo.qty = qty;
        		return iteminfo;
			};

		</script>
	</lzb:pageContainer>
</dsp:page>
