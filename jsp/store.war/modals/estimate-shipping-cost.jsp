<dsp:page>

	<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

		<dsp:getvalueof var="skuId" param="sku"/>
		<dsp:getvalueof var="price" param="price"/>
		<dsp:getvalueof var="qty" param="qty"/>

		<c:if test="${empty qty}">
			<dsp:getvalueof var="qty" value="1"/>
		</c:if>

		<main role="main" id="estimate-shipping-modal">
			<h3 class="section-heading">
				<fmt:message key="pdp.estimateShipping.heading"/>
			</h3>
			<div class="content">
				<div id="zipErrorMsg" class="amp-error"></div>

				<form action="/xhr/simpleFormSubmit.jsp" method="post" name="deliveryChargeForm" id="deliveryChargeForm" formid="deliveryChargeForm" data-error-messaging="#zipErrorMsg">
					<div class="left">
						<label for='.zipCode'>
							<fmt:message key="pdp.estimateShipping.zipCodeLabel"/>
						</label>
						<fmt:message key="pdp.estimateShipping.zipPlaceholder" var="zipPlaceholder"/>
						<input name=".zipCode" id="zipCodeInput" type="text" maxlength="10" placeholder="${zipPlaceholder}" />
					</div>
					<div class="right">
						<input name=".skuId" value="${skuId}" type="hidden"/>
						<input name=".price" value="${price}" type="hidden"/>
						<input name=".qty" value="${qty}" type="hidden"/>
						<input type="hidden" name="formHandler" value=".fetchEstimatedDeliveryCharge"/>
						<input type="hidden" name="formBean" value="/com/lzb/order/LZBEstimatedDeliveryChargeFormHandler"/>
						<input id="deliveryChargeInfo" type="submit" value="Calculate" class="button primary-btn" data-error-messaging="#zipErrorMsg" />
					</div>

					<dsp:include page="/xhr/getAmplifiToken.jsp">
						<dsp:param name="class" value="form-input" />
					</dsp:include>
					<br clear="all" />
				</form>

				<div class="results">
					<p class="shipping-cost"></p>
					<p class="shipping-cost-disclaimer">
						<fmt:message key="pdp.estimateShipping.disclaimer"/>
					</p>
				</div>
			</div>
		</main>

	</dsp:layeredBundle>

</dsp:page>