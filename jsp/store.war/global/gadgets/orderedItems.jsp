<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<dsp:getvalueof var="contextPath"
		value="${originatingRequest.ContextPath}" />
		<thead>
			<tr>
				<th colspan="2" class="order-description">ORDERED ITEMS</th>
				<th>ITEM PRICE </th>
				<th>QTY</th>
				<th>ITEM TOTAL</th>
			</tr>
		</thead>
	<tbody>
	<dsp:droplet name="LZBDisplayCartItemsDroplet">
		<dsp:param name="profile" bean="Profile"/>
		<dsp:param name="order" param="order"/>
		<dsp:oparam name="output">
		<dsp:getvalueof var="cartItems" param="cartItems"/>
		<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${cartItems}"/>
			<dsp:param name="elementName" value="cartItem"/>
			<dsp:oparam name="output">
			<tr>				
                            <dsp:getvalueof var="cartItem" param="cartItem" />
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
					 		<td class="prod-list-img">
								<dsp:include page="${pageContext.request.contextPath}/global/gadgets/cartItemImage.jsp">
					            	<dsp:param name="cartItem" param="cartItem" />
					                <dsp:param name="asLink" value="${pdpurl}"/>
			              		</dsp:include>
			              		
							</td> 
							<td class="order-description">
							<!-- for after treatment details -->
							<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
							<dsp:getvalueof var="hasTreatment" param="cartItem.hasTreatment" />
							<dsp:getvalueof var="afterTreatmentPlan" param="cartItem.afterTreatmentPlan" />
							
							<c:if test="${hasTreatment =='true' && not empty protectionPlan}">
								<dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan" />
								<dsp:getvalueof var="planName" param="cartItem.protectionPlan.auxiliaryData.catalogRef.displayName" />
								<dsp:getvalueof var="protectionSkuId" param="cartItem.protectionPlan.id" />
								<dsp:getvalueof var="protectionTotalPrice" param='cartItem.protectionPlan.priceInfo.amount' />
								<dsp:getvalueof var="protectionSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice' />
								<dsp:getvalueof var="protectionListPrice" param='cartItem.protectionPlan.priceInfo.listPrice' />
								<dsp:getvalueof var="protectionQty" param="cartItem.protectionPlan.quantity" />
							</c:if>
												
							<div class="prod-name"><dsp:a href="${contextPath}${pdpurl}">${prodName}</dsp:a></div>

                            <c:if test="${not cartItem.licensedProduct}">
                                <div>Cover: <span><dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.displayName"/> (<dsp:valueof param="cartItem.coverItem.auxiliaryData.catalogRef.id"/>)</span></div>
                            </c:if>

							<dsp:getvalueof var="pillowItem" param="cartItem.pillowItem"/>
							<c:if test="${ not empty pillowItem }">
								<div>Pillow: <span><dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.displayName"/> (<dsp:valueof param="cartItem.pillowItem.auxiliaryData.catalogRef.id"/>)
											<dsp:getvalueof var="pillowoptionItemInfo" value="${pillowItem.optionInfo}" />
														<c:if test="${ not empty pillowoptionItemInfo}">
																	<ul>
                                                                                   <li>
																					<c:out value="${pillowoptionItemInfo.colorName}" />
																						(<c:out value="${pillowoptionItemInfo.optionValue}" />)
																					</li> 
																	</ul>
														</c:if></span>
								</div>
							</c:if>
							<c:if test="${not empty planName}">
								<p>${planName}</p>
							</c:if>
							
							<dsp:getvalueof var="configurableItem" param="cartItem.commerceItem"/>
							<dsp:getvalueof var="customOptions" param="cartItem.customOptions"/>
							
							 <c:if test="${ not empty customOptions }">
							 		<div class="toggle" data-module="toggle">
									 <a href="#">Selected pieces &amp; custom options</a>
									 <div class="change-arrow"></div>
									</div>
									<div class="custom-options">
										 <div>
										  <ul>
										   <dsp:droplet name="ForEach">
												<dsp:param name="array" param="cartItem.customOptions" />
												<dsp:param name="elementName" value="customOption" />
												<dsp:oparam name="output">
													<li><dsp:valueof param="customOption.auxiliaryData.catalogRef.displayName"/>
													
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
										 </div>
									</div>								
								</c:if>
								
						<%-- <c:if test="${aftertreatmentitem eq 'false'}">
							<div><dsp:valueof
										param="subCommerceItem.auxiliaryData.catalogRef.displayName">Product</dsp:valueof></div>
						</c:if> --%>

                                <%-- order status --%>
                                <div class="item-status">
                                    <fmt:message key="orderDetail.itemStatus" />&nbsp;${cartItem.commerceItem.stateAsString}
                                </div>

                                <%-- order tracking - only shown for licensed sku items --%>
                                <c:if test="${cartItem.licensedProduct}">
                                    <div class="item-tracking">
                                        <fmt:message key="orderDetail.trackShipment" />
                                        <c:if test="${not empty cartItem.commerceItem.trackingNumber}">
                                        <c:choose>
											<c:when test="${cartItem.commerceItem.carrierCode == 'UPS'}">	
                                            	<a href="${storeConfig.orderTrackingURL_UPS}${cartItem.commerceItem.trackingNumber}" target="_blank"><fmt:message key="orderDetail.trackingLink" /></a>
                                            </c:when>
											<c:when test="${cartItem.commerceItem.carrierCode == 'LTL'}">	
                                            	<a href="${storeConfig.orderTrackingURL_LTL}${cartItem.commerceItem.trackingNumber}" target="_blank"><fmt:message key="orderDetail.trackingLink" /></a>
                                            </c:when>                                            
                                        </c:choose>
                                        </c:if>
                                    </div>
                                </c:if>
				</td>
				<td class="item-price">
				
					<dsp:getvalueof var="listPrice" param="cartItem.listPrice"/>
					<dsp:getvalueof var="salePrice" param="cartItem.salePrice"/>
					<c:choose>
						<c:when test="${empty salePrice || salePrice <= 0.0}">
							<span> 
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${listPrice}" />
							</dsp:include>
						</c:when>
						<c:otherwise>
							<span> 
								<font style="text-decoration: line-through;">
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${listPrice}" />
									</dsp:include>
									</br>
								</font> 
								<dsp:include page="/global/includes/formattedPrice.jsp">
									<dsp:param name="price" value="${salePrice}" />
								</dsp:include>
							</span>
						</c:otherwise>
					</c:choose>
				<%-- 	<dsp:valueof value="${salePrice}" converter="currency" /><br />  --%>
				
					<!-- protection plan price -->
					
					<c:if test="${hasTreatment =='true' && not empty protectionPlan}">
						<c:choose>
							<c:when test="${empty protectionSalePrice || protectionSalePrice <= 0.0}">
								<p> 
								<dsp:include page="/global/includes/formattedPrice.jsp">
									<dsp:param name="price" value="${protectionListPrice}" />
								</dsp:include>
								</p>
							</c:when>
							<c:otherwise>
								<p> 
									<font style="text-decoration: line-through;">
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="price" value="${protectionListPrice}" />
										</dsp:include>
										</br>
									</font> 
									<dsp:include page="/global/includes/formattedPrice.jsp">
										<dsp:param name="price" value="${protectionSalePrice}" />
									</dsp:include>
								</p>
							</c:otherwise>
						</c:choose>
					</c:if>
				
				</td>
				<td class="order-qty">
					<dsp:valueof param='cartItem.commerceItem.quantity'/>
					<c:if test="${hasTreatment =='true' && not empty protectionQty}">
						</br>${protectionQty}
					</c:if>
				</td>
				<td class="item-total">
					
					<dsp:include page="/global/includes/formattedPrice.jsp">
						<dsp:param name="price" param="cartItem.itemTotal" />
					</dsp:include>
					<c:if test="${hasTreatment =='true' && not empty protectionTotalPrice}">
						</br>${protectionTotalPrice}
					</c:if>
				</td>
			</tr>
			</dsp:oparam>
			</dsp:droplet>
	</dsp:oparam>
	</dsp:droplet>
</tbody>

</dsp:page>