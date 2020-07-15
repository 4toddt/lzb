<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean
		bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:getvalueof var="index" param="index" />
	<p>
		lzbCardForm.jsp ver 1.12<br />
		    <c:set var="addNewBillAddrId" value="addNewBillAddrId1"/>
			<c:set var="cardTypeId" value="cardTypeId1"/>
			<c:set var="cardHoldId" value="cardHoldId1"/>
			<c:set var="cardNoId" value="cardNoId1"/>
			<c:set var="cardExpMonthId" value="cardExpMonthId1"/>
			<c:set var="cardExpYearId" value="cardExpYearId1"/>
			<c:set var="cardCvv" value="cardCvv1"/>

		<dsp:param name="payGroup" param="payGroup" />
		<dsp:getvalueof var="payGroupvar" param="payGroup" />
		<dsp:setvalue bean="PaymentGroupFormHandler.termsAndConditions" value="true"/>

		<label><fmt:message
				key="checkout.deliveryAndPayment.creditCardNumber" /></label>
		<dsp:input bean="PaymentGroupFormHandler.synchronyCardNumber"
			beanvalue="PaymentGroupFormHandler.synchronyCardNumber" type="text"
			id="crdno" name="crdno" />
		<br /> <br>
		<label><fmt:message
				key="checkout.deliveryAndPayment.cardExpiration" /></label>
		<dsp:select bean="PaymentGroupFormHandler.expirationMonth">
			<dsp:option>
				<fmt:message key="common.month" />
			</dsp:option>
			<%-- Display months --%>
			<c:forEach var="count" begin="1" end="12" step="1" varStatus="status">
				<dsp:option value="${count}">
					<fmt:message key="common.month${count}" />
				</dsp:option>
			</c:forEach>
		</dsp:select>
		<jsp:useBean id="date" class="java.util.Date" />
		<c:set var="currentYear">
			<fmt:formatDate value="${date}" pattern="yyyy" />
		</c:set>

		<dsp:select bean="PaymentGroupFormHandler.expirationYear" id="year">
			<dsp:option value="">
				<fmt:message key="common.year" />
			</dsp:option>
			<c:forEach var="i" begin="${currentYear}" end="${currentYear+45}">
				<dsp:option value="${i}">${i}</dsp:option>
			</c:forEach>
		</dsp:select>

		<a href="#"><fmt:message key="checkout.deliveryAndPayment.whereFind" /></a></br> <br>
		<label><fmt:message	key="checkout.deliveryAndPayment.billingAddress" /> </label>
               hello
        <input type="checkbox" id="${sameAddr}" checked="true"/> <fmt:message key="checkout.deliveryAndPayment.sameAsDelivery"/></br>   
        <!--  initializing month of 2nd array is for validation.xml -->
        <dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewPaymtMethd" value="false" id="addNewPaymtMethd1"/> 
        <dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="false" id="addNewBillAddr1" />
        <dsp:input type="hidden" bean="PaymentGroupFormHandler.splitPayment" value="false" id="addNewBillAddr1" />
		<dsp:input type="hidden" bean="PaymentGroupFormHandler.copyShippingAddrToBillingAddr" value="true" id="${shipToBill}"/>	
		
	    <dsp:input type="hidden" bean="PaymentGroupFormHandler.splitPayment" value="false" id="splitPayment"/>
                    <dsp:include page="billingForm.jsp">
						<dsp:param name="index" value="0"/>
						<dsp:param name="payGroup" param="payGroup"/>	
					</dsp:include>
		</br>
</dsp:page>
