<dsp:page>
	<dsp:getvalueof var="order" param="order"/>
	<dsp:getvalueof var="taxDown" value="${order.taxPriceInfo.taxDown}"/>
	<dsp:getvalueof var="reviewPage" param="reviewPage"/>
	<dsp:getvalueof var="cartTax" param="cartTax"/>

	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">
		<c:choose>
			<c:when test="${taxDown == 'true' }">
				<div style="bordertop:1px solid #000;width:100%;">
					<h4><fmt:message key="cartorder.taxDown"/></h4>
					<fmt:message key="cartorder.taxDownMessage"/>
					<fmt:message key="cartorder.taxDownLearn"/>
					<p style="display:none" id="popupInfo">
						<h1><fmt:message key="cartorder.taxDowninfo"/></h1>
						<hr>
						<fmt:message key="cartorder.taxDowninfo1"/>
						<fmt:message key="cartorder.taxDowninfo2"/>

						<fmt:message var="close" key="cartorder.taxDownClose"/>
						<input type="button" name="cancel" value="${close}" />
					</p>
				</div>
			</c:when>
			<c:otherwise>
				<div class="order-pro-apply payment-row">
					<div class="cart-lpos">
						<c:choose>
							<c:when test="${reviewPage}">
								<p class="promo-percent"><fmt:message key="cartorder.salesTax"/></p>
							</c:when>
							<c:otherwise>
								<p class="promo-percent"><fmt:message key="cartorder.estimatedTax"/></p>
							</c:otherwise>
						</c:choose>
					</div>
					<p class="cart-rpos">
					<c:choose>
					 <c:when test="${not empty cartTax}">
						 <dsp:param name="tax" value="${cartTax}"/>
					 </c:when>
					 </c:choose>
						 <dsp:include page="/pricing/displayPrice.jsp">		
							<dsp:param name="currency" param="tax"/>
						 </dsp:include>
					</p>
				</div>
			</c:otherwise>
		</c:choose>
	</dsp:layeredBundle>
</dsp:page>