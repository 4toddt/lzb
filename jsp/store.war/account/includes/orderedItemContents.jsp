<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:getvalueof var="commerceItems" param="orderNo"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<table>
		<thead>
			<tr>
				<th class="des"><fmt:message key="orderedItem.description"/></th>
				<th><fmt:message key="orderedItem.itemPrices"/></th>
				<th><fmt:message key="orderedItem.qty"/></th>
				<th><fmt:message key="orderedItem.itemTotal"/></th>
			</tr>
		</thead>
		<tbody>
			<dsp:droplet name="LZBDisplayCartItemsDroplet">
				<dsp:param name="profile" bean="Profile"/>
				<dsp:param name="order" param="orderNo"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="cartItems" param="cartItems"/>
					<dsp:getvalueof var="commerceItemsForMenetate" param="commerceItems" scope="request"/>

					<dsp:droplet name="ForEach">
						<dsp:param name="array" value="${cartItems}"/>
						<dsp:param name="elementName" value="cartItem"/>
						<dsp:oparam name="output">
						<dsp:include page="/includes/styleCollectionsByItem.jsp">
							<dsp:param name="skuId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id"/>
							<dsp:param name="skuItem" param="cartItem.commerceItem.auxiliaryData.catalogRef" />
							<dsp:param name="coverId" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
						</dsp:include>
							<tr>
								<td class="details">
									<ul>
										<dsp:getvalueof var="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
						 				<dsp:getvalueof var="prodId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id" />
						 				<dsp:droplet name="LZBPDPURLDroplet">
											<dsp:param name="productId" value="${prodId}" />
											<dsp:param name="prodName" value="${prodName}" />
											<dsp:param name="fromCDP" value="true" />
											<dsp:param name="elementName" value="url" />
											<dsp:oparam name="output">
												<dsp:getvalueof var="pdpurl" param="url" />
											</dsp:oparam>
										</dsp:droplet>

							 			<dsp:include page="${pageContext.request.contextPath}/global/gadgets/cartItemImage.jsp">
				            				<dsp:param name="cartItem" param="cartItem" />
				               				<dsp:param name="asLink" value="${pdpurl}"/>
			              				</dsp:include>

										<li><dsp:a href="${contextPath}${pdpurl}">${prodName}</dsp:a></li>
			              				<br />
										<fmt:message key="cart.cover" /> <dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/>(<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>)<br/>
										<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem" />
										<c:if test="${ not empty pillowItem }">
										<fmt:message key="cart.pillow" />
														<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName"/>&nbsp;(<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.id"/>)
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
										<dsp:getvalueof var="configurableItem" param="cartItem.commerceItem"/>
										<dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
											<dsp:getvalueof var="sectionalPieces" param="cartItem.sectionalPieces" />
										<c:if test="${ not empty customOptions }">
											<dsp:include page="/cart/gadgets/sectionalOptionalItemsFragment.jsp">
														<dsp:param name="sectionalPieces" value="${sectionalPieces}" />
														<dsp:param name="customOptions" value="${customOptions}" />
														<dsp:param name="page" value="orderSummary" />
											</dsp:include>
											<%--  										
											<tr>
												<td><fmt:message key="cart.options" /><br></td>
											</tr>
											<tr>
												<td>
															<ul>
															<dsp:droplet name="ForEach">
																<dsp:param name="array" value="${customOptions}" />
																<dsp:param name="elementName" value="customOption" />
																<dsp:oparam name="output">
																		<li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName" />
																		<dsp:getvalueof var="optionItemInfo" param="customOption.optionInfo" />

																			<c:if test="${ not empty optionItemInfo}">
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
															</dsp:droplet>
														</ul>
													<c:if test="${ not empty sectionalPieces }">
													<fmt:message key="cart.sectional.pieces" /><br>
													<dsp:droplet name="ForEach">
														<dsp:param name="array" param="cartItem.sectionalPieces" />
														<dsp:param name="elementName" value="sectionalPiece" />
														<dsp:oparam name="output">
															<dsp:valueof param="sectionalPiece.auxiliaryData.catalogRef.displayName" /><br/>
														</dsp:oparam>
													</dsp:droplet>
													</c:if>
												</td>--%>
											</tr>
										</c:if><br />
										<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
										<c:if test="${not empty protectionPlan}">
											<dsp:valueof param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
										</c:if>
		              				</ul>
								</td>
								<td class="price">
									<ul>
										<dsp:getvalueof var="listPrice" param="cartItem.listPrice"/>
										<dsp:getvalueof var="salePrice" param="cartItem.salePrice"/>
										<c:choose>
											<c:when test="${empty salePrice || salePrice <= 0.0}">
												<li>
													<dsp:include page="/global/includes/formattedPrice.jsp">
														<dsp:param name="price" value="${listPrice}" />
													</dsp:include>
												</li>
											</c:when>
											<c:otherwise>
												<li>
													<c:choose>
														<c:when test="${not empty salePrice && (salePrice < listPrice)}">
															<strike>
																<dsp:include page="/global/includes/formattedPrice.jsp">
																	<dsp:param name="price" value="${listPrice}" />
																</dsp:include>
															</strike>
															<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price" value="${salePrice}" />
															</dsp:include>
														</c:when>
														<c:otherwise>
															<dsp:include page="/global/includes/formattedPrice.jsp">
																<dsp:param name="price" value="${listPrice}" />
															</dsp:include>
														</c:otherwise>
													</c:choose>
												</li>
											</c:otherwise>
										</c:choose>
										<c:if test="${not empty protectionPlan}">
											<dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice' />
											<li>
												<dsp:include page="/global/includes/formattedPrice.jsp">
													<dsp:param name="price" value="${planSalePrice}" />
												</dsp:include>
											</li>
										</c:if>
									</ul>
								</td>
								<td class="update-qty">
									<ul>
										<li>
											<dsp:valueof param='cartItem.commerceItem.quantity'/>
										</li>
										<c:if test="${not empty protectionPlan}">
											<li>
												<dsp:valueof param="cartItem.protectionPlan.quantity" />
											</li>
										</c:if>
									</ul>
								</td>
								<td class="total">
									<ul>
										<li>
											<dsp:include page="/global/includes/formattedPrice.jsp">
												<dsp:param name="price" param="cartItem.itemTotal" />
											</dsp:include>
										</li>
										<c:if test="${not empty protectionPlan}">
											<dsp:getvalueof var="planTotalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
											<li>
												<dsp:include page="/global/includes/formattedPrice.jsp">
													<dsp:param name="price" value="${planTotalPrice}"/>
												</dsp:include>
											</li>
										</c:if>
									</ul>
								</td>
							</tr>

						</dsp:oparam>
					</dsp:droplet>
			</tbody>
		</table>

		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="cartItems" />
			<dsp:param name="elementName" value="cartItem" />
			<dsp:oparam name="outputStart">
				<input type="hidden" value="
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="skuId" param="cartItem.coverItem.auxiliaryData.catalogRef.id" />
				<dsp:getvalueof param="size" var="size"/>
				<dsp:getvalueof param="count" var="count"/>
				${skuId }<c:if test="${size!=count}">;</c:if>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				" id="skuId" />
			</dsp:oparam>
		</dsp:droplet>

		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="cartItems" />
			<dsp:param name="elementName" value="cartItem" />
			<dsp:oparam name="outputStart">
				<input type="hidden" value="
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="quantity" param="cartItem.commerceItem.quantity"/>
				<dsp:droplet name="ForEach">
					<dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories" />
					<dsp:param name="elementName" value="category" />
					<dsp:oparam name="output">
						<dsp:getvalueof var="categoryName" param="category.displayName" />
					</dsp:oparam>
				</dsp:droplet>
				<dsp:getvalueof param="size" var="size"/>
				<dsp:getvalueof param="count" var="count"/>
				${categoryName }<c:if test="${size!=count}">;</c:if>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				" id="catName" />
			</dsp:oparam>
		</dsp:droplet>

		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="cartItems" />
			<dsp:param name="elementName" value="cartItem" />
			<dsp:oparam name="outputStart">
				<input type="hidden" value="
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="productId" param="cartItem.commerceItem.auxiliaryData.productRef.id" />
				<dsp:getvalueof var="productName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
				<dsp:getvalueof param="size" var="size"/>
				<dsp:getvalueof param="count" var="count"/>
				${productName}/${productId }<c:if test="${size!=count}">;</c:if>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				" id="prodId" />
			</dsp:oparam>
		</dsp:droplet>

		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="cartItems" />
			<dsp:param name="elementName" value="cartItem" />
			<dsp:oparam name="outputStart">
				<input type="hidden" value="
			</dsp:oparam>
			<dsp:oparam name="output">
				<dsp:getvalueof var="qty" param='cartItem.commerceItem.quantity'/>
				<dsp:getvalueof param="size" var="size"/>
				<dsp:getvalueof param="count" var="count"/>
				${qty }<c:if test="${size!=count}">;</c:if>
			</dsp:oparam>
			<dsp:oparam name="outputEnd">
				" id="qty" />
			</dsp:oparam>
		</dsp:droplet>

		</dsp:oparam>
	</dsp:droplet>



</dsp:page>