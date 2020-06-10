<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/commerce/util/MapToArrayDefaultFirst" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />

	<dsp:getvalueof var="defaultCreditCard" bean="Profile.defaultCreditCard"/>
	<dsp:getvalueof var="index" param="index"/>
	<dsp:getvalueof var="page" param="page" />

	<c:choose>
		<c:when test="${index eq 1}">
			<c:set var="selCreditCardId" value="selCreditCardId1"/>
			<c:set var="creditCardRadioBtn" value="creditCardRadioBtn1"/>
			<c:set var="addNewCC" value="addNewCC1"/>
			<c:set var="newPayment" value="newPayment1"/>
		</c:when>
		<c:otherwise>
			<c:set var="selCreditCardId" value="selCreditCardId"/>
			<c:set var="creditCardRadioBtn" value="creditCardRadioBtn"/>
			<c:set var="addNewCC" value="addNewCC"/>
			<c:set var="newPayment" value="newPayment"/>
		</c:otherwise>
	</c:choose>

	<dsp:input type="hidden" bean="PaymentGroupFormHandler.selectedCreditCardId" value="${defaultCreditCard.id}" id="${selCreditCardId}"/>


	<h4><fmt:message key="checkout.deliveryAndPayment.selectPaymentMethod"/></h4>

	<dsp:droplet name="MapToArrayDefaultFirst">
		<dsp:param name="map" bean="Profile.creditCards" />
		<dsp:param name="defaultId" value="${defaultCreditCard.id}"/>
		<dsp:param name="sortByKeys" value="true" />
		<dsp:param name="isCCSelected" value="false" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="sortedArray" vartype="java.lang.Object" param="sortedArray" />
				<c:forEach var="paymentMethod" items="${sortedArray}" varStatus="status">
					<dsp:getvalueof var="creditCard" value="${paymentMethod.value}" />
					<div class="saved-address">
						<c:choose>
							<c:when test="${defaultCreditCard.repositoryId eq creditCard.id && page ne 'orderReview'}">
								<input type="radio" value="${creditCard.id}" class="${creditCardRadioBtn} saved-cc-radio checked" name="${creditCardRadioBtn}" checked="checked"/>
								<c:set value="true" var="isCCSelected" />
							</c:when>
							<c:otherwise>
								<input type="radio" value="${creditCard.id}" class="${creditCardRadioBtn} saved-cc-radio" name="${creditCardRadioBtn}" />
							</c:otherwise>
						</c:choose>

						<ul>
							<li class="ccType-li">${creditCard.creditCardType}</li>
							<li class="ccNum-li"><fmt:message key="checkout.deliveryAndPayment.ending"/> <dsp:valueof converter="CreditCard" numcharsunmasked="4" maskcharacter=" " value="${creditCard.creditCardNumber}"/></li>
							<li>${creditCard.cardHolderName}</li>
							<li><fmt:message key="checkout.deliveryAndPayment.expires"/> ${creditCard.expirationMonth}/${creditCard.expirationYear}</li>
							<c:if test="${defaultCreditCard.repositoryId eq creditCard.id}">
								<li><fmt:message key="checkout.deliveryAndPayment.primary"/></li>
							</c:if>
							<li>
								<dsp:a href="${pageContext.request.contextPath}/account/editPayment.jsp" >
								 	<dsp:param name="isCheckoutFlow" value="true"/>
									<dsp:param name="nickName" value="${paymentMethod.key}"/>
									<span><fmt:message key="common.button.editText"/></span>
								</dsp:a>
								<c:if test="${defaultCreditCard.repositoryId ne creditCard.id}">
									<dsp:a href="${pageContext.request.contextPath}/account/editPayment.jsp" iclass="setas-primary">
										<dsp:param name="isCheckoutFlow" value="true"/>
										<dsp:param name="nickName" value="${paymentMethod.key}"/> <fmt:message key="checkout.deliveryAndPayment.setAsPrimary"/>
									</dsp:a>
								</c:if>
							</li>
						</ul>
					</div><%-- .saved-address --%>
				</c:forEach>
		</dsp:oparam>
	</dsp:droplet>
	<div class="new-address">
		<c:choose>
			<c:when test="${isCCSelected}">
				<input type="radio" name="${creditCardRadioBtn}" id="${addNewCC}" class="toggle add-new-cc-radio" data-module="toggle" />
			</c:when>
			<c:otherwise>
				<input type="radio" name="${creditCardRadioBtn}" id="${addNewCC}" class="toggle add-new-cc-radio" data-module="toggle" checked="true"/>
			</c:otherwise>
		</c:choose>
		<fmt:message key="checkout.deliveryAndPayment.addNewPayment"/>
		<div class="${newPayment} add-payment-method" style="display:none">
			<dsp:include page="creditCardForm.jsp">
				<dsp:param name="index" param="index"/>
			</dsp:include>
		</div>
	</div>
</dsp:page>