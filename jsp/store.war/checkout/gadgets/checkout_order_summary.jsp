<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:getvalueof var="cartEmpty" bean="ShoppingCart.currentEmpty"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>
	<dsp:importbean bean="/atg/commerce/order/purchase/RepriceOrderDroplet"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPromotionDisplayDroplet" />
	<dsp:getvalueof var="order" bean="ShoppingCart.current"/>
	<dsp:getvalueof var="reviewPage" param="reviewPage"/>
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>

	<div class="order-sum checkout-payment">
		<div class="order-sum1">
			<dsp:droplet name="LZBOrderSummaryDroplet">
				<dsp:param name="order" value="${order}"/>
				<dsp:param name="profile" bean="Profile"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
					<h2><fmt:message key="cartorder.summary"/></h2>
					<dsp:a href="/cart/cart.jsp" iclass="edit-sym"><fmt:message key="cartorder.edityourorder"/></dsp:a>
					<div class="order-tot">
						<c:choose>
							<c:when test="${cartEmpty eq 'false'}">
								<p class="cart-lpos">
									<span>${commerceItemCount}&nbsp;</span>
									<c:if test="${commerceItemCount eq 1}">
										<fmt:message key="cartorder.itemtotal" />
									</c:if>
									<c:if test="${commerceItemCount gt 1}">
										<fmt:message key="cartorder.itemstotal" />
									</c:if>
								</p>
							</c:when>
						</c:choose>
						<p class="cart-rpos">
							<span>
								<dsp:include page="/pricing/displayPrice.jsp">
									<dsp:param name="currency" param="totalItemCost"/>
								</dsp:include>
							</span>
						</p>
					</div>


					<!--  protection plan totals -->
					<div class="order-tot">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="planItems" />
							<dsp:param name="elementName" value="planItem" />
							<dsp:oparam name="output">
								<p class="cart-lpos">
									<dsp:valueof param="planItem.planItemInfo.displayName"/>(<dsp:valueof param="planItem.quantity"/> &nbsp; item)
								</p>
								<p class="cart-rpos">
									<dsp:include page="/pricing/displayPrice.jsp">
										<dsp:param name="currency" param="planItem.amount"/>
									</dsp:include>
								</p>
							</dsp:oparam>
						</dsp:droplet>
					</div>

					<!--  discount totals -->
					<dsp:droplet name="LZBPromotionDisplayDroplet">
						<dsp:param name="order" bean="ShoppingCart.current"/>
						<dsp:oparam name="output">
							<dsp:getvalueof var="couponCode" param="couponCode" />
							<dsp:getvalueof var="couponName" param="name" />
							<dsp:getvalueof var="discountAmt" param="discountAmt" />
							<c:if test="${not empty couponCode}">
								<div class="order-tot">
									<p class="cart-lpos">${couponName}</p>
									<p class="cart-rpos">
										<dsp:setvalue param="discountAmt" value="${discountAmt * -1}" />
										<dsp:valueof param="discountAmt" converter="currency"/>
									</p>
								</div>
							</c:if>
						</dsp:oparam>
					</dsp:droplet>


					<div class="order-pro-apply payment-row">
						<div class="cart-lpos">
							<c:choose>
								<c:when test="${reviewPage}">
									<p class="promo-percent"><fmt:message key="cartorder.homeDelivery"/></p>
								</c:when>
								<c:otherwise>
									 <p class="promo-percent"><fmt:message key="cartorder.shipping"/></p >
								</c:otherwise>
							</c:choose>
						</div>
						<p class="cart-rpos">
							<dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" param="shippingCharge"/>
							</dsp:include>
						</p>
					</div>



					<!-- for tax -->
					<dsp:getvalueof var="cartTaxAmount" value="${cartTaxAmount}"/>
					<dsp:include page="/global/gadgets/taxwareInfo.jsp">
						<dsp:param name="order" value="${order}"/>
						<dsp:param name="reviewPage" value="${reviewPage}"/>
						<dsp:param name="cartTax" value="${cartTaxAmount}"/>
					</dsp:include>

					<div class="order-tot">
						<p class="cart-lpos"><fmt:message key="cartorder.ordertotal"/></p>
						<p class="cart-rpos">
							<dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" param="total"/>
							</dsp:include>${currencyCode}
						</p>
					</div>

				</dsp:oparam>
			</dsp:droplet>
		</div>
		<div class="order-items order-sum1" id="cartForm">
			<dsp:getvalueof var="items" vartype="java.lang.Object" bean="ShoppingCart.current.commerceItems" />
			<c:if test="${not empty items}">
				<h2><fmt:message key="cartorder.orderitems"/> </h2>
				<%-- Get the items in the shopping cart --%>
				<dsp:droplet name="LZBDisplayCartItemsDroplet">
					<dsp:param name="order" bean="ShoppingCart.current"/>
					<dsp:param name="profile" bean="Profile"/>
					<dsp:oparam name="output">
						<dsp:getvalueof var="cartItems" param="cartItems" />
						<dsp:getvalueof var="commerceItemsForMonetate" param="commerceItems" scope="request" />
						<section class="cartForm">
							<table id="lzb_store_itemTable">
								<caption style="display:none">Ordered Items</caption>
								<thead style="display:none">
									<th>Item Description</th>
									<th>Quantity</th>
									<th>Amount</th>
								</thead>
								<tbody>
									<dsp:droplet name="ForEach">
										<dsp:param name="array" param="cartItems" />
										<dsp:param name="elementName" value="cartItem" />
										<dsp:oparam name="output">
											<dsp:getvalueof var="commerceItemId" param="cartItem.commerceItem.id"/>
											<tr class="product-details">
												<td class="details">
												
													<dsp:include page="/includes/styleCollectionsByItem.jsp">
														<dsp:param name="skuId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id"/>
														<dsp:param name="skuItem" param="cartItem.commerceItem.auxiliaryData.catalogRef" />
														<dsp:param name="coverId" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
													</dsp:include>
												
													<dsp:include page="/global/gadgets/cartItemImage.jsp">
														<dsp:param name="commerceItem" param="cartItem.commerceItem" />
													</dsp:include>
													<ul>
														<li>
															<h3><dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/></h3>
														</li>
														<li>
															Cover: <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>)
														</li>
														<li>
															<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem"/>
															<c:if test="${ not empty pillowItem }">
																<fmt:message key="cart.pillow" /> <dsp:valueof param="cartItem.pillowItem.optionInfo.colorName"/>(<dsp:valueof param="cartItem.pillowItem.optionInfo.optionValue"/>) <br />
															<dsp:getvalueof var="pillowoptionItemInfo" value="${pillowItem.optionInfo}" />
																<c:if test="${ not empty pillowoptionItemInfo}">
																	<ul>
                                                                                   <li>
																					<c:out value="${pillowoptionItemInfo.colorName}" />
																						(<c:out value="${pillowoptionItemInfo.optionValue}" />)
																					</li> 
																	</ul>
																</c:if>
															
															</c:if>
														</li>
														<li>
															<dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
															<c:if test="${ not empty customOptions }">
																<ul>
																	<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
																	<dsp:include page="/cart/gadgets/sectionalOptionalItemsFragment.jsp">
																				<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
																				<dsp:param name="customOptions" value="${customOptions}" />
																	</dsp:include>
																	<!--  																
																	<dsp:droplet name="ForEach">
																		<dsp:param name="array" param="cartItem.customOptions" />
																		<dsp:param name="elementName" value="customOption" />
																		<dsp:oparam name="output">
																			 <li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName"/>
																			 <dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />
																			<c:if test="${ not empty optionItemInfo}">
																			<br>
																				<dsp:getvalueof var="optionType" value="${optionItemInfo.optionType }" />
																				<ul>
																				<c:if test="${ not empty optionType and optionType eq 'optionCover'}">
																					<li>
																					<c:out value="${optionItemInfo.colorName}" />
																						(<c:out value="${optionItemInfo.optionValue}" />)
																					</li>
																				</c:if>
																				<c:if test="${ not empty optionType and optionType eq 'optionValue'}">
																					<li>
															
																						<c:out value="${optionItemInfo.optionValue}" />
																					</li>
																				</c:if>
																				</ul>
																			</c:if>
																			 </li>
																		</dsp:oparam>
																	</dsp:droplet> -->
																</ul>
															</c:if>
														</li>

														<!-- Price -->
														<li>
															<dsp:getvalueof var="listPrice" param="cartItem.listPrice"/>
															<dsp:getvalueof var="salePrice" param="cartItem.salePrice"/>
															<c:choose>
																<c:when test="${empty salePrice || salePrice <= 0.0}">
																	<dsp:include page="/global/includes/formattedPrice.jsp">
																		<dsp:param name="price" value="${listPrice}" />
																	</dsp:include>
																</c:when>
																<c:otherwise>
																	<!-- <dsp:include page="/global/includes/formattedPrice.jsp">
																		<dsp:param name="price" value="${listPrice}" />
																	</dsp:include>-->
																	<dsp:include page="/global/includes/formattedPrice.jsp">
																		<dsp:param name="price" value="${salePrice}" />
																	</dsp:include>
																</c:otherwise>
															</c:choose>
														</li>
														<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
														<c:if test="${not empty protectionPlan}">													
															<li><dsp:valueof param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" /></li>
														</c:if>
													</ul>
												</td>
												<td class="quantity">
													<!-- Quantity -->
													Qty : <dsp:valueof param='cartItem.commerceItem.quantity'/>
												</td>
												<td class="update-qty">
													<!-- Total -->
													<p>
														<span>
															<dsp:include page="../../global/includes/formattedPrice.jsp">
																<dsp:param name="price"param="cartItem.itemTotal"/>
															</dsp:include>
														</span>
													</p>
													<c:if test="${not empty protectionPlan}">
														<dsp:getvalueof var="planTotalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
														<p>
															<span>
																<dsp:include page="../../global/includes/formattedPrice.jsp">
																	<dsp:param name="price" value="${planTotalPrice}" />
																</dsp:include>
															</span>
														</p>
													</c:if>
												</td>
											</tr>
										</dsp:oparam>
									</dsp:droplet>
								</tbody>
							</table>
						</section>
					</dsp:oparam>
				</dsp:droplet>
			</c:if>
		</div><%-- .order-sum1 --%>
	</div>
						<dsp:include page="/cart/gadgets/monetateCartData.jsp" flush="true" >
						<dsp:param name="commerceItemsVarForMonetate" value="${commerceItemsForMonetate}" />
					</dsp:include>
</dsp:page>