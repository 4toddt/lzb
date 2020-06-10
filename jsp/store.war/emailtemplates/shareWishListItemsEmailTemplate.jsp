<dsp:page>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
	<style type="text/css">
	@import url(http://fonts.googleapis.com/css?family=Open+Sans:400,300,700);

	table td {
		border-collapse: collapse;
	}
	</style>
	</head>
	<body>
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler"/>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}" />

    <dsp:getvalueof var="hostName" bean="LZBStoreConfiguration.hostName" />
<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
<dsp:importbean bean="/com/lzb/droplet/LZBWishListItemDroplet"/>
<dsp:importbean bean="/com/lzb/droplet/LZBWishListDisplayDroplet" />
<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<!-- email template messages -->
	<dsp:getvalueof var="firstName" param="firstName" />
	<dsp:getvalueof var="lastName" param="lastName" />
	<dsp:getvalueof var="message" param="message" />
	<table class="fullWidth" width="600" cellpadding="5" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
			<tr>
				<td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#000;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Hey,</font></td>
			</tr>
			<tr>
				<td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#d13126;"><font face="'Open Sans', Helvetica, Arial, sans-serif">${message}</font></td>
			</tr>
	</table>

	<!-- param which hold the Selected wishList items id -->
	<dsp:getvalueof param="selectedWishListId" var="giftListId"/>
	<dsp:getvalueof param="wishListItems" var="wishlist"/>
	<dsp:droplet name="LZBWishListItemDroplet">
			<dsp:param name="id" value="${wishlist}"/>
			<dsp:oparam name="output">
			<dsp:getvalueof var="wishlistItemId" param="wishListItem.id" />
			<dsp:getvalueof var="giftItem" param="wishListItem" />
			<dsp:getvalueof var="catalogRefId" param="wishListItem.catalogRefId" />
			<dsp:getvalueof var="displayName" param="wishListItem.displayName" />
			<dsp:getvalueof var="skuId" param="wishListItem.catalogRefId" />
			<dsp:droplet name="LZBPDPURLDroplet">
				<dsp:param name="productId" value="${catalogRefId}" />
				<dsp:param name="prodName" value="${displayName}" />
				<dsp:param name="fromCDP" value="true" />
				<dsp:param name="elementName" value="url" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="url" param="url" />
				</dsp:oparam>
			</dsp:droplet>

			<%-- This email template is not in used as the share wishlist buttons were disabled --%>
			<%-- Image URL needs to be considered if template is enabled --%>
			<dsp:getvalueof var="marxentImageURL" value="/"/>

			<dsp:getvalueof var="pdpurl" value="${hostName}${contextPath}${url}?giftId=${wishlistItemId}" />
				<!-- display the item  based on id which is selected on main wishlist  -->
			<table width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
	    		  <tr>
	       		 <td style="padding:20px 0;">

			<table class="fullWidth" align="left" cellpadding="0" cellspacing="0" border="0">
	            <tr>
	              <td><a href="${pdpurl}?WT.mc_id=Email-System-Share-Wish-List" title="[]" target="_blank"><img width="110" height="110" class="mobileAlignCenter" src="${marxentImageURL}" alt="[]" width="110" border="0" style="display:block;"></a></td>
	            </tr>
	         </table>

			<table class="fullWidth" width="250" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
	            <tr>
	              <td class="paddingLeft10 paddingTop15" style="padding-left:15px;">
	                <table align="left" cellpadding="0" cellspacing="0" border="0">


					 <tr>
	                    <td class="copy13" style="padding-bottom:5px;font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif"><a href="${pdpurl}?WT.mc_id=Email-System-Share-Wish-List" style="text-decoration:underline; color:#000;"><dsp:valueof param="wishListItem.displayName"/></a></font></td>
	                 </tr>

					<dsp:droplet name="LZBWishListDisplayDroplet">
						<dsp:param name="wishListItem" value="${giftItem}" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="priceString" param="configuartionOptionItem.priceString" />
							<dsp:getvalueof var="cover" param="configuartionOptionItem.cover" />
							<dsp:getvalueof var="pillow" param="configuartionOptionItem.pillow" />
							<dsp:getvalueof var="optionList" param="configuartionOptionItem.option" />
							<dsp:getvalueof param="wishlistItem.displayName" var="productDisplayName" />
							<c:if test="${not empty cover }">
							 <tr>
	                  			  <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Cover: <dsp:valueof param="configuartionOptionItem.cover.displayName" /> (${cover.id})</font></td>
	                 		 </tr>
							</c:if>
							<c:if test="${not empty pillow }">
							  <tr>
	                   			 <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;"><font face="'Open Sans', Helvetica, Arial, sans-serif">Pillwo: <dsp:valueof param="configuartionOptionItem.pillow.displayName" /> (${pillow.id})</font></td>
	                		  </tr>
							</c:if>
							<c:if test="${ not empty optionList}">
						 <tr>
	                    <td class="copy13" style="padding-bottom:5px; font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:12px; font-weight:normal; mso-line-height-rule:exactly; line-height:12px; text-align:left; color:#444444;">
	                     <font face="'Open Sans', Helvetica, Arial, sans-serif">
	                      Selected custom options:
	                      <table>
							<dsp:droplet name="ForEach">
								<dsp:param name="array" value="${optionList}" />
								<dsp:setvalue param="optionItem" paramvalue="element" />
								<dsp:oparam name="output">
								<dsp:valueof param="optionItem.displayName" />
								 <tr><td><dsp:valueof param="optionItem.displayName"/></td></tr>
								</dsp:oparam>
							</dsp:droplet>
	                      </table>
	                     </font>
	                    </td>
	                  </tr>
							</c:if>
							</dsp:oparam>
					</dsp:droplet>
					</table>
	              </td>
	            </tr>
	          </table>
				</td>
			</tr>
		</table>
	</dsp:oparam>
		</dsp:droplet>
		<!-- <table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
			<tr>
				<td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#000; padding-bottom:20px"><font face="'Open Sans', Helvetica, Arial, sans-serif"><a href="#" style="text-decoration:underline;color:#000;">View all My Favorite items</a></font></td>
			</tr>
		</table> -->

		<table class="fullWidth" width="600" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt;">
			<tr>
				<td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#000;padding-bottom:5px"><font face="'Open Sans', Helvetica, Arial, sans-serif">Thank you,</font></td>
			</tr>
			<tr>
				<td style="font-family:'Open Sans', Helvetica, Arial, sans-serif; font-size:14px; font-weight:bold;mso-line-height-rule:exactly; line-height:16px; text-align:left; color:#000;"><font face="'Open Sans', Helvetica, Arial, sans-serif">${firstName} &nbsp;${lastName} </font></td>
			</tr>
		</table>

	 </body>
	</html>
</dsp:page>