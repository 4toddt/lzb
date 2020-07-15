<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBCalcOrderDepositBalanceAmountDroplet"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

	<dsp:droplet name="LZBCalcOrderDepositBalanceAmountDroplet">
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="depositAmount" param="depositAmount"/>
			<dsp:getvalueof var="balanceAmount" param="balanceAmount"/>
		</dsp:oparam>
	</dsp:droplet>

	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>
	<dsp:getvalueof bean="PaymentGroupFormHandler.splitPayment" var="isSplit"/>
	<dsp:getvalueof var="payGrpRelCount" bean="ShoppingCart.current.paymentGroupRelationshipCount"/>
	<dsp:getvalueof var="orderTotal" bean="ShoppingCart.current.priceInfo.amount"/>

	<h2><fmt:message key="checkout.deliveryAndPayment.payment"/></h2>

	<div class="payment-article">
		<h3>Payment process explanation</h3>
		<p><fmt:message key="checkout.deliveryAndPayment.payment.instruction"/></p>
	</div>

	<fieldset class="billadd-check" data-module="split-payment">
		<legend>Split Payment</legend>
		<label for="splitPay">Split Payment</label>
		<c:choose>
			<c:when test="${isSplit or (payGrpRelCount eq 2)}">
				<dsp:input type="checkbox" bean="PaymentGroupFormHandler.splitPayment" checked="true" name="splitPay" id="splitPay" />
			</c:when>
			<c:otherwise>
				<dsp:input type="checkbox" bean="PaymentGroupFormHandler.splitPayment" checked="false" name="splitPay" id="splitPay" />
			</c:otherwise>
		</c:choose>
		<fmt:message key="checkout.deliveryAndPayment.payment.twoCreditCards" />
	</fieldset>
	<%--
	<c:if test="${payGrpRelCount eq 2}">
		<dsp:include page="gadgets/appliedPayments.jsp">
			<dsp:param name="payGrpRelCount" value="${payGrpRelCount}" />
		</dsp:include>
	 </c:if>
	--%>
	<div class="split-payment-applied" style="display:none">
		<h3><fmt:message key="checkout.deliveryAndPayment.appliedPayments"/></h3>
		<a href="gadgets/removeAllPayment.jsp" class="removeall-applied-cc"><fmt:message key="checkout.deliveryAndPayment.removeAll"/></a>

	   		<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.current.PaymentGroups"/>
					<dsp:param name="elementName" value="PGroup"/>
					<dsp:oparam name="output">
	    		</dsp:oparam>
			</dsp:droplet>
	</div>
	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.creditCards"/>
		<dsp:oparam name="false">
			<c:set var="hasPaymentMethods" value="true"/>
		</dsp:oparam>
	</dsp:droplet>

	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.defaultCreditCard"/>
		<dsp:oparam name="false">
			<c:set var="hasPrimaryPaymentMethod" value="true"/>
		</dsp:oparam>
	</dsp:droplet>

	<fmt:message var="addPayment" key="checkout.deliveryAndPayment.payment.addPayment"/>

	<section class="payment1">
		<c:if test="${payGrpRelCount ge 1}">
			<dsp:param name="payGroupOne" bean="ShoppingCart.current.paymentGroups[0]"/>
		</c:if>

		<c:choose>
			<c:when test="${securityStatus >=2}">
				<c:choose>
					<c:when test="${hasPaymentMethods}">
						<c:choose>
							<c:when test="${hasPrimaryPaymentMethod}">
								<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="false" id="addNewPaymtId"/>
							</c:when>
							<c:otherwise>
								<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId"/>
							</c:otherwise>
						</c:choose>
						<dsp:include page="gadgets/displaySavedPaymentMethods.jsp">
							<dsp:param name="index" value="0"/>
						</dsp:include>
					</c:when>
					<c:otherwise>
						<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId"/>
						<dsp:include page="gadgets/creditCardForm.jsp">
							<dsp:param name="index" value="0"/>
							<dsp:param name="payGroupOne" param="payGroupOne"/>
						</dsp:include>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId"/>
				<dsp:include page="gadgets/creditCardForm.jsp">
					<dsp:param name="index" value="0"/>
					<dsp:param name="payGroupOne" param="payGroupOne"/>
				</dsp:include>
			</c:otherwise>
		</c:choose>
		<div class="add-payment-section" style="display:none">
			<legend><fmt:message key="checkout.deliveryAndPayment.payment.amount"/></legend>
			<label for="splitAmnt"><fmt:message key="checkout.deliveryAndPayment.payment.amount"/> </label>
			<div class="split-container address-primaries">
				<p class="red"><fmt:message key="checkout.deliveryAndPayment.payment.depositInstruction"/></p>
				<div class="split-container">
					<input type="text" id="splitAmnt" value="${depositAmount}" readonly />
					<input type="button" value="${addPayment}" data-parent="payment1" class="btn-primary cc-add-payment"/>
				</div>

			</div>
		</div>
	</section>

	<section class="payment2" style="display:none">
		<c:if test="${payGrpRelCount eq 2}">
			<dsp:param name="payGroupTwo" bean="ShoppingCart.current.paymentGroups[1]"/>
		</c:if>
		<c:choose>
			<c:when test="${securityStatus >=2}">
				<c:choose>
					<c:when test="${hasPaymentMethods}">
						<c:choose>
							<c:when test="${hasPrimaryPaymentMethod}">
								<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="false" id="addNewPaymtId1"/>
							</c:when>
							<c:otherwise>
								<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId1"/>
							</c:otherwise>
						</c:choose>
						<dsp:include page="gadgets/displaySavedPaymentMethods.jsp">
							<dsp:param name="index" value="1"/>
						</dsp:include>
					</c:when>
					<c:otherwise>
						<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId1"/>
						<dsp:include page="gadgets/creditCardForm.jsp">
							<dsp:param name="index" value="1"/>
							<dsp:param name="payGroupTwo" param="payGroupTwo"/>
						</dsp:include>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="true" id="addNewPaymtId1"/>
				<dsp:include page="gadgets/creditCardForm.jsp">
					<dsp:param name="index" value="1"/>
					<dsp:param name="payGroupTwo" param="payGroupTwo"/>
				</dsp:include>
			</c:otherwise>
		</c:choose>

		<fieldset>
			<legend><fmt:message key="checkout.deliveryAndPayment.payment.amount"/></legend>
			<label for="splitAmnt"><fmt:message key="checkout.deliveryAndPayment.payment.amount"/> </label>
			<div class="split-container address-primaries">
				<p><fmt:message key="checkout.deliveryAndPayment.payment.balanceInstruction"/></p>
				<div class="split-container">
					<input type="text" value="${balanceAmount}" id="splitAmnt" name="splitAmount" readonly required="required" />
					<input type="button" value="${addPayment}" data-parent="payment2" class="btn-primary cc-add-payment"/>
				</div>

			</div>
		</fieldset>
	</section>

</dsp:page>