<dsp:page>
    <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:getvalueof var="anonymousOrder" param="anonymousOrder"/>
	<dsp:getvalueof var="commerceItems" param="anonymousOrder.commerceItems"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
    <dsp:importbean bean="/com/lzb/droplet/LZBOrderDetailsDroplet" />
	<dsp:getvalueof var="contextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof var="qty" param="commerceItems.quantity"/>
	<dsp:getvalueof var="orderTotal" param="commmerceItems.priceInfo.amount"/>
	<dsp:getvalueof var="saleTax" bean="ProfileFormHandler.anonymousOrder.priceInfo.tax"/>



	<dsp:droplet name="OrderLookup">
        <dsp:param name="orderId" param="anonymousOrder.id"/>
        <dsp:oparam name="output">

            <dsp:droplet name="LZBOrderDetailsDroplet">
                <dsp:param name="order" param="result"/>
                <dsp:oparam name="output">
                    <dsp:getvalueof var="cartItems" param="cartItems" />
                </dsp:oparam>
            </dsp:droplet>

		<table border="3" width="100%">
			<tr>
				<th width="50%"><fmt:message key="orderedItem.description"/></th>
				<th width="20%"><fmt:message key="orderedItem.itemPrices"/></th>
				<th><fmt:message key="orderedItem.qty"/></th>
				<th width="20%"><fmt:message key="orderedItem.itemTotal"/></th>

			</tr>

			<dsp:droplet name="ForEach">
                <dsp:param name="array" value="${cartItems}"/>
		        <dsp:param name="elementName" value="cartItem"/>

				<dsp:oparam name="output">
                    <dsp:getvalueof var="cartItem" param="cartItem" />
					<tr>
						<td>
							<table>
								<tr>
									<%--
							          Display product icon. Only navigable non-missing products
							          will be displayed as link.
							        --%>

							        <td class="image">
							          	<dsp:include page="/global/gadgets/cartItemImage.jsp">
                                            <dsp:param name="cartItem" param="cartItem" />
						              	</dsp:include>
							        </td>
									<td>
                                        <dsp:getvalueof var="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/>
											<dsp:getvalueof var="prodId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id"/>
												<dsp:droplet name="LZBPDPURLDroplet">
								     				<dsp:param name="productId" value="${prodId}" />
								     				<dsp:param name="prodName" value="${prodName}" />
								     				<dsp:param name="fromCDP" value="true" />
													<dsp:param name="elementName" value="url" />
														<dsp:oparam name="output">
															<dsp:getvalueof var="pdpurl" param="url"/>
														</dsp:oparam>
								     	        </dsp:droplet>

												<b><dsp:a href="${contextPath}${pdpurl}">${prodName}</dsp:a></b></br>
												<dsp:droplet name="ForEach">
													<dsp:param name="array" param="cartItem.commerceItem.commerceItems" />
													<dsp:param name="elementName" value="subCommerceItem" />
													<dsp:oparam name="output">
														<dsp:getvalueof var="aftertreatmentitem" param="subCommerceItem.afterTreatmentItem" />
														<%-- <c:if test="${aftertreatmentitem eq 'false'}">
															<tr>
																<td><dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName">Product</dsp:valueof></td>
															</tr>
															</c:if> --%>
															<dsp:getvalueof var="type" param="subCommerceItem.auxiliaryData.catalogRef.type"/>
															<dsp:getvalueof var="isPillow" param="subCommerceItem.additionalPillowType"/>
															<dsp:getvalueof var="aftertreatmentitem" param="subCommerceItem.afterTreatmentItem" />
															<c:if test="${type =='coverSku' }">
																<td>Cover: <dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.id"/>)</td>
															</c:if>
															<c:if test="${isPillow eq 'true' }">
																Pillow: <dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.id"/>)</td></tr>
															</c:if>

															<c:if test="${aftertreatmentitem eq 'true'}">
																<dsp:getvalueof var="planQuantity" param="subCommerceItem.quantity"/>
																<dsp:getvalueof var="planTotalPrice" param="subCommerceItem.priceInfo.amount"/>
																<dsp:getvalueof var="planSalePrice" param="subCommerceItem.priceInfo.salePrice"/>
																<td><dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName"></dsp:valueof></td>
															</c:if>
													</dsp:oparam>
											</dsp:droplet>
									</td>
								</tr>
							</table>
						</td>

						<td>
							<dsp:getvalueof var="salePrice" param="cartItem.commerceItem.priceInfo.listPrice"/>
							<dsp:valueof value="${salePrice}" converter="currency" /><br/>
						</td>
						<td><dsp:valueof param="cartItem.commerceItem.quantity"/></td>
						<td><dsp:getvalueof var="amount" param="cartItem.commerceItem.priceInfo.amount"/><dsp:valueof value="${amount}" converter="currency" format="#.00" /></td>
					</tr>
				</dsp:oparam>
			</dsp:droplet>
	</table>

		<div>
		    <dsp:include page="anonymousOrderTotals.jsp">
				  <dsp:param name="anonymousOrder" param="result" />
			</dsp:include>
		</div>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>