<%--
	- File Name: estimateShippingCostModal.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the estimate shipping cost modal for the product detail page.
	- Required Parameters:
		- productSkuId: product sku id,
		- price
	- Optional Parameters:
--%>

<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/order/LZBEstimatedDeliveryChargeFormHandler"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="productSkuId" param="productSkuId" />
	<dsp:getvalueof var="price" param="price" />

	<layout:ajax>
		<jsp:attribute name="section">modal</jsp:attribute>
		<jsp:attribute name="pageType">estimateShippingCostModal</jsp:attribute>

		<jsp:body>
			<div class="estimate-shipping-cost-modal" role="dialog" id="estimateShippingCostModal">
				<div class="modal-header">
					<div class="title-bar">
						<h2 class="title">
							<fmt:message key="pdp.estimateShipping.heading"/>
						</h2>
					</div>
				</div>

				<div class="modal-body">
					<dsp:form action="" method="post" name="deliveryChargeForm" id="deliveryChargeForm" formid="deliveryChargeForm" class="deliveryChargeForm" data-validate>
						<div class="field-group">
							<div class="field">
								<label for='zipCode' class="hide">
									<fmt:message key="pdp.estimateShipping.zipCodeLabel"/>
								</label>
								<fmt:message key="pdp.estimateShipping.zipPlaceholder" var="zipPlaceholder"/>
								<dsp:input bean="LZBEstimatedDeliveryChargeFormHandler.zipCode" id="zipCodeInput" type="text" min-length="5" maxlength="10" data-validation="required minlength usorcapostal" placeholder="${zipPlaceholder}" aria-required="true" />
							</div>
							<div class="field">
								<dsp:input bean="LZBEstimatedDeliveryChargeFormHandler.skuId" value="${productSkuId}" type="hidden"/>
								<dsp:input bean="LZBEstimatedDeliveryChargeFormHandler.price" value="${price}" type="hidden"/>
								<dsp:input bean="LZBEstimatedDeliveryChargeFormHandler.qty" value="${qty}" id="estShippingQty" type="hidden"/>
								<dsp:input type="hidden" bean="LZBEstimatedDeliveryChargeFormHandler.deliveryChargeErrorUrl" value="${contextPath}/browse/json/estimateShippingCostError.jsp" />
								<dsp:input type="hidden" bean="LZBEstimatedDeliveryChargeFormHandler.deliveryChargeSuccessUrl" value="${contextPath}/browse/json/estimateShippingCostSuccess.jsp" />
								<dsp:input id="deliveryChargeInfo" type="submit" bean="LZBEstimatedDeliveryChargeFormHandler.fetchEstimatedDeliveryCharge" value="Calculate" class="button primary"/>
							</div>
						</div>
					</dsp:form>
				
					<div class="results hide">
						<p class="shipping-cost"></p>
						<p class="shipping-cost-disclaimer"><fmt:message key="pdp.estimateShipping.disclaimer"/></p>
					</div>
				</div>
				<%-- <div class="modal-footer hide">
        			<button type="button" class="button primary" data-dismiss="modal">Done</button>
      			</div> --%>
			</div>
		</jsp:body>
	</layout:ajax>
</dsp:page>
