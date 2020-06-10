<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

	<fmt:message var="edit" key="checkout.review.edit" />
	<div class="payment-delivery">
		<h2>
			<fmt:message key="checkout.review.deliveryInfo" />
		</h2>
		<dsp:a href="/checkout/deliveryAndPayment.jsp">
			<input type="button" value="${edit}" class="edit btn-primary" />
		</dsp:a>
		<div>
			<div class="saved-address">
				<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.ShippingGroups" />
					<dsp:param name="elementName" value="SGroup" />
					<dsp:oparam name="output">
						<ul>
							<dsp:getvalueof var="ship" param="SGroup" />
							<li><dsp:valueof value="${ship.shippingAddress.firstName}" />
							<dsp:valueof value="${ship.shippingAddress.lastName}" /></li>

							<li><dsp:valueof value="${ship.shippingAddress.address1}" /></li>
							<li><dsp:valueof value="${ship.shippingAddress.address2}" /></li>

							<li><dsp:valueof value="${ship.shippingAddress.city}" />,<dsp:valueof
								value="${ship.shippingAddress.state}" />&nbsp;<dsp:valueof value="${ship.shippingAddress.postalCode}" /></li>

							<li><dsp:valueof value="${ship.shippingAddress.email}" /></li>

							<li><dsp:valueof value="${ship.shippingAddress.phoneNumber}" /></li>
						</ul>

								<fmt:message key="checkout.review.specialInstructions" />
							 <dsp:droplet name="ForEach">
								<dsp:param name="array" value="${ship.specialInstructions}" />
								<dsp:param name="elementName" value="specialInstr" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="displaySpecialInstr" param="specialInstr"/>
									<c:choose>
					    				<c:when test="${not empty displaySpecialInstr }">
					    					<dsp:valueof value="${displaySpecialInstr}"/>
					    				</c:when>
					    				<c:otherwise>
					    					<fmt:message key="checkout.review.noInstructionsEnterd"/>
					    				</c:otherwise>
					    			</c:choose>
								</dsp:oparam>
							</dsp:droplet>

					</dsp:oparam>
				</dsp:droplet>
			</div>
		</div>
	</div>
</dsp:page>