<%--
	This page generates the turnto order feed.  See http://www.turnto.com/docs/jsfeed
--%>

<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:getvalueof var="turnToEnabled"	bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
	<dsp:getvalueof var="siteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
	<dsp:getvalueof var="order" param="order" />

	<c:choose>
		<c:when test="${turnToEnabled}">
			<script type="text/javascript">
				
			<%-- This must be declared before any other TurnTo items --%>
				turnToConfig = {
					siteKey : "${siteKey}",
					skipCssLoad : true,
				};
				
			 </script>
			 <script type="text/javascript" src="//static.www.turnto.com/tra4_3/turntoFeed.js"></script>		
			<%--
              orderId (r) - It will be the id of the order
              email (r) - The is the email of the customer.
              firstName (r) - The first name of the customer.
              lastName (r) - The last name of the customer.
              postalCode (o)
              emailOptOut (o) - Set to the boolean value 'true' if this user is to receive no emails from TurnTo. Defaults to false.
            --%>

			<dsp:getvalueof var="firstName"	value="${order.paymentGroups[0].billingAddress.firstName}" />
			<dsp:getvalueof var="lastName" value="${order.paymentGroups[0].billingAddress.lastName}" />
			<dsp:getvalueof var="email"	value="${order.paymentGroups[0].billingAddress.email}" />
			<dsp:getvalueof var="zip" value="${order.paymentGroups[0].billingAddress.postalCode}" />
			
		<script type="text/javascript">
            TurnToFeed.addFeedPurchaseOrder({
                orderId : '${order.id}',
                email : '${email}',
                firstName : '${fn:replace(firstName, "'", "\\'")}',
                lastName : '${fn:replace(lastName, "'", "\\'")}',
                postalCode : '${zip}',
                emailOptOut : false
            });
		</script>
            <%--
              title (r) - This is the name of the product
              url (r) - This is the url on your site to link the product to.
              sku (r) - The the sku of the product.  The sku id in TT is == product id in ATG
              price (r) - The the price of the product.
              itemImageUrl (r) - The the url to the image of the product.
            --%>
			<dsp:droplet name="/atg/dynamo/droplet/ForEach">
				<dsp:param name="array" param="order.CommerceItems" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="displayName" param="element.auxiliaryData.productRef.displayName" />
					<dsp:getvalueof var="productId"	param="element.auxiliaryData.productRef.id" />
					<dsp:getvalueof var="quantity" param="element.quantity" />
					<dsp:getvalueof var="unitPrice" param="element.priceInfo.listPrice" />
					
					<dsp:getvalueof var="imageUrl" param="element.auxiliaryData.catalogRef.cdpDefaultImage" />

					<dsp:droplet name="/com/lzb/droplet/LZBPDPURLDroplet">
						<dsp:param name="productId" param="element.auxiliaryData.productRef" />
						<dsp:param name="prodName" value="${displayName}" />
						<dsp:param name="fromCDP" value="false" />
						<dsp:param name="elementName" value="url" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="productUrl" param="url"/>
						</dsp:oparam>
					</dsp:droplet>

					<script type="text/javascript">
	                    TurnToFeed.addFeedLineItem({
	                        title : '${fn:replace(displayName, "'", "\\'")}',
	                        url : '${productUrl}',
	                        sku : '${productId}',
	                        price : '${unitPrice}',
	                        itemImageUrl : '${imageUrl}'
	                    });
                    </script>                    
                </dsp:oparam>
			</dsp:droplet>
		<script>
            TurnToFeed.sendFeed();
         </script>
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>
	
	<script type="text/javascript" src="//static.www.turnto.com/traServer4_3/trajs/${siteKey}/tra.js"></script>
</dsp:page>
