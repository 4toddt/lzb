<dsp:page>

		<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
		<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
		<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
		<dsp:getvalueof var="anonymousOrder" param="anonymousOrder" />

		<dsp:droplet name="LZBOrderSummaryDroplet">
			<dsp:param name="order" param="anonymousOrder" />

			<dsp:oparam name="output">
				<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
				<dsp:getvalueof var="shippingCurrency" param="shippingCharge" />
				<dsp:getvalueof var="taxCost" param="tax" />
				<dsp:getvalueof var="totalItemCosts" param="totalItemCost" />
				<dsp:getvalueof var="coverPlanItems" param="planItems" />
				<dsp:getvalueof var="totalPrice" param="total" />
				<dsp:getvalueof var="surCharge" param="surCharge" />
				<dsp:getvalueof var="promoAmount" param="promoAmount" />
			</dsp:oparam>
		</dsp:droplet>

		<h1>Order Totals</h1>
		<table>
			<tbody>
				<tr>
					<td><dsp:valueof param="anonymousOrder.totalCommerceItemCount" />&nbsp;<fmt:message
							key="orderTotal.itemTotal" /></td>

					<td>
						<!-- get total item amount --> <!-- <fmt:message key="orderTotal.itemAmount"/> -->
						<dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" value="${totalItemCosts}" />
						</dsp:include>
					</td>
				</tr>
				<c:if test="${not empty coverPlanItems }">
					<tr>
						<!-- <td><fmt:message key="orderTotal.fabricPlan" /></td> -->

						<td><dsp:droplet name="ForEach">
								<dsp:param name="array" value="${coverPlanItems}" />
								<dsp:param name="elementName" value="planItem" />
								<dsp:oparam name="output">

									<tr>
										<td>
											<div>
												<h4>
													<dsp:valueof param="planItem.planItemInfo.displayName" />
													(
													<dsp:valueof param="planItem.quantity" />
													&nbsp; item)
												</h4>
											</div>
										</td>

										<td>
											<div>
												<h4>
													<dsp:include page="/pricing/displayPrice.jsp">
														<dsp:param name="currency" param="planItem.amount" />
													</dsp:include>
												</h4>
											</div>

										</td>
									</tr>

								</dsp:oparam>
							</dsp:droplet></td>
					</tr>
				</c:if>

				<tr>
					<td><fmt:message key="orderTotal.homeDelivery" /></td>

					<td><dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" value="${shippingCurrency-surCharge}" />
						</dsp:include></td>
				</tr>
				<c:if test="${not empty promoAmount}">
					<c:if test="${promoAmount gt 0.0}">
						<tr>
							<td><fmt:message key="orderTotal.discount" /></td>
							<td><dsp:include page="/pricing/displayPrice.jsp">
									<dsp:param name="currency" value="${promoAmount}" />
								</dsp:include></td>
						</tr>
					</c:if>
				</c:if>
				<c:if test="${not empty surCharge}">
					<c:if test="${surCharge gt 0.0}">
						<tr>
							<td><fmt:message key="orderTotal.surCharge" /></td>
							<td><dsp:include page="/pricing/displayPrice.jsp">
									<dsp:param name="currency" value="${surCharge}" />
								</dsp:include></td>
						</tr>
					</c:if>
				</c:if>

				<tr>
					<td><fmt:message key="orderTotal.saleTax" /></td>

					<td>
						<%-- <dsp:getvalueof var="taxAmount" param="order.taxPriceInfo.amount"/>
									<dsp:valueof value="${taxAmount}" converter="currency" /> --%>
						<dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" value="${taxCost}" />
						</dsp:include>

					</td>
				</tr>
				</hr>

				<tr>
					<td><fmt:message key="orderTotal.total" /></td>

					<td>
						<%-- 	<dsp:getvalueof var="totalAmount" param="order.priceInfo.amount"/>
								<dsp:valueof value="${totalAmount}" converter="currency" /> --%>
						<dsp:include page="/pricing/displayPrice.jsp">
							<dsp:param name="currency" value="${totalPrice}" />
						</dsp:include>
					</td>

				</tr>

			</tbody>

		</table>

</dsp:page>
