<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<dsp:getvalueof var="order" param="order" />
	
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderDetailsDroplet" />
		<dsp:droplet name="LZBOrderDetailsDroplet">
			<dsp:param name="order" value="${order}"/>
			<dsp:oparam name="output">
				<dsp:getvalueof var="cartItems" param="cartItems" />
			</dsp:oparam>
		</dsp:droplet>
	
	
	<dsp:droplet name="ForEach">
        <dsp:param name="array" value="${cartItems}"/>
		<dsp:param name="elementName" value="cartItem"/>
		<dsp:oparam name="output">
			<div class="order-item">
				<!-- item details -->
                <dsp:getvalueof var="cartItem" param="cartItem" />
				<dsp:getvalueof var="prodName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/>
				<dsp:getvalueof var="prodId" param="cartItem.commerceItem.auxiliaryData.catalogRef.id"/>
				 <dsp:droplet name="LZBPDPURLDroplet">
     				<dsp:param name="productId" value="${prodId}" />
     				<dsp:param name="prodName" value="${prodName}" />
     				<dsp:param name="fromCDP" value="true" />
     				<dsp:param name="isMobile" value="true" />
						<dsp:param name="elementName" value="url" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="pdpurl" param="url"/>
						</dsp:oparam>
     			</dsp:droplet>
				<div class="item-image order-item-section">
					<!-- item image -->
					<dsp:getvalueof var="imageUrl" param="cartItem.commerceItem.auxiliaryData.catalogRef.smallImage.url"/>
					<dsp:include page="/checkout/includes/cartItemImage.jsp">
		                <dsp:param name="cartItem" param="cartItem" />
		                <dsp:param name="productName" param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName" />
		                <dsp:param name="asLink" value="${pdpurl}"/>
	              	</dsp:include>
				</div>
				<div class="item-details order-item-section">
					<div class="product-name-details">
						<a href="${contextPath}/${pdpurl}?commid=${prodId}" class="product-name">		 
							${prodName}
						</a>
					</div>
					
                    <c:if test="${not cartItem.licensedProduct}">
                        <div class="cover-item">
                            <dsp:droplet name="ForEach">
                                <dsp:param name="array" param="cartItem.commerceItem.commerceItems"/>
                                <dsp:param name="elementName" value="subCommerceItem"/>
                                <dsp:oparam name="output">
                                    <dsp:getvalueof var="type" param="subCommerceItem.auxiliaryData.catalogRef.type"/>
                                    <c:if test="${type =='coverSku' }">
                                        <span><fmt:message key="orderSummaryItems.cover"/>&nbsp;<dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName"/>&nbsp;(<dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.id"/>)</span>
                                    </c:if>
                                </dsp:oparam>
                            </dsp:droplet>
                        </div>
                    </c:if>
						
					<div class="item-price" id="item-price-${commerceItemId}">
						<div class="price">
							<fmt:message key="orderSummaryItems.Price"/>&nbsp;
							<dsp:getvalueof var="salePrice" param="cartItem.commerceItem.priceInfo.salePrice"/>
							<dsp:getvalueof var="listPrice" param="cartItem.commerceItem.priceInfo.listPrice"/>
							<c:choose>
								<c:when test="${empty salePrice || salePrice <= 0.0}">
									<span class="item-total-price"> 
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="price" value="${listPrice}" />
										</dsp:include>
								</c:when>
								<c:otherwise>
									<span class="regular-price">
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="price" value="${listPrice}" />
										</dsp:include>
									</span>
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="price" value="${salePrice}" />
										</dsp:include>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
						
					<div class="quantity">
						<span><fmt:message key="orderSummaryItems.Qty"/>&nbsp;<dsp:valueof param="cartItem.commerceItem.quantity"/></span>
					</div>
						
					<div class="item-total">
						<dsp:getvalueof var="totalAmount" param="cartItem.commerceItem.priceInfo.amount"/>
						<div class="price">
							<fmt:message key="orderSummaryItems.IteamTotal"/>&nbsp;
							<dsp:include page="/global/includes/formattedPrice.jsp">
								<dsp:param name="price" value="${totalAmount}"/>
							</dsp:include>
						</div>
					</div>
					
					<div class="item-protection-plan">
						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="cartItem.commerceItem.commerceItems"/>
							<dsp:param name="elementName" value="subCommerceItem"/>
							<dsp:oparam name="output">
								<dsp:getvalueof var="aftertreatmentitem" param="subCommerceItem.afterTreatmentItem" />
								<c:if test="${aftertreatmentitem =='true' }">
									<span class="year"><dsp:valueof param="subCommerceItem.auxiliaryData.catalogRef.displayName"/></span>
									<span class="order-code">
										<dsp:getvalueof var="planAmount" param="subCommerceItem.priceInfo.amount"/>
										<dsp:include page="/global/includes/formattedPrice.jsp">
											<dsp:param name="currency" value="${planAmount}"/>
										</dsp:include>
									</span>
								</c:if>
							</dsp:oparam>
						</dsp:droplet>
					</div>

                    <%-- order status --%>
                    <div class="item-status">
                        <span><fmt:message key="orderDetail.itemStatus" />&nbsp;${cartItem.commerceItem.stateAsString}</span>
                    </div>

                    <%-- order tracking - only shown for licensed sku items --%>
                    <c:if test="${cartItem.licensedProduct}">
                        <div class="item-tracking">
                            <span>
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
                            </span>
                        </div>
                    </c:if>
				</div>
			</div>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>