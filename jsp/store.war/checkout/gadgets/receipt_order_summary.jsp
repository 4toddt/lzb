<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPromotionDisplayDroplet" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="order" bean="ShoppingCart.last"/>
	<dsp:droplet name="LZBOrderSummaryDroplet">
		<dsp:param name="order" value="${order}"/>
		<dsp:param name="profile" bean="Profile"/>
	    <dsp:oparam name="output">
	       <dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
	       <dsp:getvalueof var="totalItemCost" param="totalItemCost" scope="request"/>
	       <dsp:getvalueof var="itemsList" param="itemsList" scope="request"/>

    	   <input type="hidden" id="orderItemCost" value="${totalItemCost}" />
    	   <input type="hidden" id="itemsList" value="${itemsList}" />

			<div class="order-sum">
				<div class="order-sum1">
					<h3><fmt:message key="cartorder.summary"/></h3>
					<div class="order-tot">
						<p class="cart-lpos">
							<span>${commerceItemCount}</span>
							<c:if test="${commerceItemCount eq 1}">
						 		<fmt:message key="cartorder.itemtotal" />
						    </c:if>
							<c:if test="${commerceItemCount gt 1}">
								<fmt:message key="cartorder.itemstotal" />
							</c:if>
						</p>
						<p class="cart-rpos">
							<span>
								<dsp:include page="/pricing/displayPrice.jsp">
						         	<dsp:param name="currency" param="totalItemCost"/>
						    	</dsp:include>
							</span>
						</p>
					</div><%-- .order-tot --%>


					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="planItems" />
						<dsp:param name="elementName" value="planItem" />
						<dsp:oparam name="output">
							<div class="order-pro">
								<p class="cart-lpos">
									<dsp:valueof param="planItem.planItemInfo.displayName"/>(<dsp:valueof param="planItem.quantity"/> &nbsp; item)
								</p>
								<p class="cart-rpos">
									<dsp:include page="/pricing/displayPrice.jsp">
								    	<dsp:param name="currency" param="planItem.amount"/>
								    </dsp:include>
								</p>
							</div>
						</dsp:oparam>
					</dsp:droplet>


					<dsp:droplet name="LZBPromotionDisplayDroplet">
						<dsp:param name="order" bean="ShoppingCart.last"/>
						<dsp:oparam name="output">
							<dsp:getvalueof var="couponCode" param="couponCode" />
							<dsp:getvalueof var="couponName" param="name" />
							<dsp:getvalueof var="discountAmt" param="discountAmt" />
							<c:if test="${not empty couponCode}">
								<div class="order-pro">
									<p class="cart-lpos">
										 ${couponName}
									</p>
									<p class="cart-rpos">
										<dsp:setvalue param="discountAmt" value="${discountAmt * -1}" />
										<dsp:include page="/pricing/displayPrice.jsp">
									    	<dsp:param name="currency" param="discountAmt"/>
									    </dsp:include>
									</p>
								</div>
							</c:if>
						</dsp:oparam>
					</dsp:droplet>
					<div class="order-pro">
						<p class="cart-lpos""><fmt:message key="cartorder.homeDelivery"/></p>
						<p class="cart-rpos">
							<dsp:include page="/pricing/displayPrice.jsp">
								<dsp:param name="currency" param="shippingCharge"/>
							</dsp:include>
						</p>
					</div>
				</div><%-- .order-sum1 --%>
			    <div class="order-sum2">
			    	<div class="order-tot">
			    		<dsp:include page="/global/gadgets/taxwareInfo.jsp">
							<dsp:param name="order" value="${order}"/>
							<dsp:param name="reviewPage" value="true"/>
						</dsp:include>
			    	</div>
			    	<div class="order-amnt">
						<p class="cart-lpos"><span><fmt:message key="cartorder.total"/></span></p>
						<p class="cart-rpos">
							<span>
								<dsp:include page="/pricing/displayPrice.jsp">
									      <dsp:param name="currency" param="total"/>
								</dsp:include>
							</span>${currencyCode}
						</p>
					</div>
					<div class="order-amnt">
						<p class="cart-lpos"><span><fmt:message key="cartorder.totalPayments"/></span></p>
						<p class="cart-rpos">
							<span>
								<dsp:include page="/pricing/displayPrice.jsp">
									      <dsp:param name="currency" param="total"/>
								</dsp:include>
							</span>${currencyCode}
						</p>
					</div>
					
			    </div><%-- .order-sum2 --%>
			</div><%-- .order-sum --%>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>