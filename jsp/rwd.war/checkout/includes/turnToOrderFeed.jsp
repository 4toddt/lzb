<%--
    - File Name: turnToOrderFeed.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page generates the turnto order feed.  See http://www.turnto.com/docs/jsfeed
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />

    <%-- Page Variables --%>
	<dsp:getvalueof var="turnToEnabled"	bean="/com/lzb/common/LZBTurnToConfiguration.turnToEnabled" />
	<dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
	<dsp:getvalueof var="order" param="order" />

	<c:choose>
		<c:when test="${turnToEnabled}">
			<script type="text/javascript">
				// This must be declared before any other TurnTo items
				var turnToConfig = {
					locale: 'en_US',
					pageId: 'order-confirmation-page'
				}
				window.TurnToCmd=window.TurnToCmd||function(){(TurnToCmd.q=TurnToCmd.q||[]).push(arguments)};
			</script>
			<script src="https://widgets.turnto.com/v5/widgets/${turnToSiteKey}/js/turnto.js" async></script>
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
				var TT_orderData = {
					orderId: ${order.id},
					email: '${email}',
					postalCode: '${zip}',
					firstName: '${fn:replace(firstName, "'", "\\'")}',
					lastName: '${fn:replace(lastName, "'", "\\'")}',
					items: []
				};
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
						TT_orderData.items.push({
							title: '${fn:replace(displayName, "'", "\\'")}',
							url: '${productUrl}',
							sku: '${productId}',
							price: '${unitPrice}',
							itemImageUrl: '${imageUrl}'
						})
					</script>
				</dsp:oparam>
			</dsp:droplet>
		<script>
			TurnToCmd('feed.send', TT_orderData);
		</script>
		</c:when>
		<c:otherwise>
			<%-- TurnTo not enabled.  No special treatment at this time.  --%>
		</c:otherwise>
	</c:choose>
</dsp:page>
