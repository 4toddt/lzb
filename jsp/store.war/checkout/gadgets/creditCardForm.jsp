<dsp:page>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty"/>
	<dsp:getvalueof var="index" param="index"/>
	
	
	<c:choose>
		<c:when test="${index eq 1}">
			<dsp:param name="payGroup" param="payGroupTwo"/>
			<c:set var="addNewBillAddrId" value="addNewBillAddrId1"/>
			<c:set var="cardTypeId" value="cardTypeId1"/>
			<c:set var="cardHoldId" value="cardHoldId1"/>
			<c:set var="cardNoId" value="cardNoId1"/>
			<c:set var="cardExpMonthId" value="cardExpMonthId1"/>
			<c:set var="cardExpYearId" value="cardExpYearId1"/>
			<c:set var="cardCvv" value="cardCvv1"/>
		</c:when>
		<c:otherwise>
			<dsp:param name="payGroup" param="payGroupOne"/>
			<c:set var="addNewBillAddrId" value="addNewBillAddrId"/>
			<c:set var="cardTypeId" value="cardTypeId"/>
			<c:set var="cardHoldId" value="cardHoldId"/>
			<c:set var="cardNoId" value="cardNoId"/>
			<c:set var="cardExpMonthId" value="cardExpMonthId"/>
			<c:set var="cardExpYearId" value="cardExpYearId"/>
			<c:set var="cardCvv" value="cardCvv"/>
		</c:otherwise>
	</c:choose>

	<dsp:getvalueof bean="Profile.securityStatus" var="securityStatus"/>

	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.secondaryAddresses"/>
		<dsp:oparam name="false">
			<c:set var="hasSecondaryAddresses" value="true"/>
		</dsp:oparam>
	</dsp:droplet>
	
	<dsp:droplet name="IsEmpty">
		<dsp:param name="value" bean="Profile.billingAddress"/>
		<dsp:oparam name="false">
			<c:set var="hasPrimaryBillingAddress" value="true"/>
		</dsp:oparam>
	</dsp:droplet>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.cardType"/></legend>
		<label for="cardType${index}" id="lblcardType${index}"><fmt:message key="checkout.deliveryAndPayment.cardType"/> <sup>&#42;</sup></label>		
		<dsp:getvalueof bean="PaymentGroupFormHandler.creditCardType[param:index]" var="cardType"/>
		<c:if test="${empty cardType}">
			<dsp:getvalueof var="cardType" param="payGroup.creditCardType" />
		</c:if>
		<dsp:select bean="PaymentGroupFormHandler.creditCardType" 
			name="cardType" id="cardType${index}" 
			iclass="cv-check cardType"  
			required="required" title="Credit Card Type" >
			<dsp:tagAttribute name="data-cv-type" value="dropdown" />
			<dsp:option>
				<fmt:message key="creditcard.selectMsg" />
			</dsp:option>
			<dsp:option value="Visa" selected="${cardType eq 'Visa'}">
				<fmt:message key="creditcard.visa" />
			</dsp:option>
			<dsp:option value="MasterCard" selected="${cardType eq 'MasterCard'}">
				<fmt:message key="creditcard.masterCard" />
			</dsp:option>
			<dsp:option value="Discover" selected="${cardType eq 'Discover'}">
				<fmt:message key="creditcard.discover" />
			</dsp:option>
			<dsp:option value="AmericanExpress" selected="${cardType eq 'AmericanExpress'}">
				<fmt:message key="creditcard.amex" />
			</dsp:option>
			<dsp:tagAttribute name="aria-labelledby" value="lblcardType${index} errcardType${index}" />
		</dsp:select>
	</fieldset>
	<dsp:param name="payGroup" param="payGroup"/>
	<dsp:getvalueof var="payGroupvar" param="payGroup"/>
	<fieldset>
		<label for="CName${index}" id="lblCName${index}"><fmt:message key="checkout.deliveryAndPayment.nameOnCard"/> <sup>&#42;</sup></label>
		<dsp:getvalueof var="cardholdername" param="payGroup.cardHolderName"/>
		<dsp:droplet name="IsEmpty">
			<dsp:param name="value" value="${cardholdername}" />
			<dsp:oparam name="true">
				<dsp:input bean="PaymentGroupFormHandler.cardHolderName" beanvalue="PaymentGroupFormHandler.cardHolderName[param:index]" 
					maxlength="20" type="text" name="CName" id="CName${index}" 
					iclass="cv-check CName" required="required" title="Name on Card">
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblCName${index} errCName${index}" />
				</dsp:input><br/>
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:input bean="PaymentGroupFormHandler.cardHolderName" value="${cardholdername}" 
					maxlength="20" type="text" name="CName" id="CName${index}" 
					iclass="cv-check CName" required="required" title="Name on Card" >
					<dsp:tagAttribute name="data-cv-type" value="input" />
					<dsp:tagAttribute name="aria-labelledby" value="lblCName${index} errCName${index}" />
				</dsp:input><br/>
			</dsp:oparam>
		</dsp:droplet>
	</fieldset>

	<fieldset>
		<legend><fmt:message key="checkout.deliveryAndPayment.creditCardNumber"/></legend>
		<label for="ccNum${index}" id="lblccNum${index}"><fmt:message key="checkout.deliveryAndPayment.creditCardNumber"/> <sup>&#42;</sup></label>
		<dsp:getvalueof var="creditCardNumber" bean="PaymentGroupFormHandler.creditCardNumber[param:index]"/>
		<c:if test="${empty creditCardNumber}">
			<dsp:getvalueof var="creditCardNumber" param="payGroup.unMaskedCreditCardNumber"/>
		</c:if>
		<dsp:input bean="PaymentGroupFormHandler.creditCardNumber" value="${creditCardNumber}" 
			maxlength="16" type="text" name="ccNum" id="ccNum${index}" 
			iclass="cv-check ccNum" required="required" title="Credit Card Number">
			<dsp:tagAttribute name="data-cv-type" value="input" />
			<dsp:tagAttribute name="aria-labelledby" value="lblccNum${index} errccNum${index}" />
		</dsp:input><br/>
	</fieldset>

	<fieldset class="month-year-select-wrapper">
		<legend><fmt:message key="checkout.deliveryAndPayment.cardExpiration"/></legend>
		<div class="month-select">
			<span class="month-select-span-title"><fmt:message key="checkout.deliveryAndPayment.cardExpiration"/> <sup>&#42;</sup></span>
			<label for="cardExpMonth${index}" id="lblcardExpMonth${index}" style="display:none">card month expiration</label>
			<dsp:getvalueof var="expMonth" bean="PaymentGroupFormHandler.expirationMonth[param:index]"/>
			<c:if test="${empty expMonth}">
				<dsp:getvalueof var="expMonth" param="payGroup.expirationMonth" />
			</c:if>
			<dsp:select bean="PaymentGroupFormHandler.expirationMonth" name="cardExpMonth" id="cardExpMonth${index}" 
				iclass="cv-check cardExpMonth" required="required" title="Card Expiration Month">
				<dsp:tagAttribute name="data-cv-type" value="expmonth" />
				<dsp:option>
					<fmt:message key="common.month"/>
				 </dsp:option>
				<%-- Display months --%>
				 <c:forEach var="count" begin="1" end="12" step="1" varStatus="status">
					<option value="${count}" <c:if test="${expMonth eq count}">selected</c:if>>
						<fmt:message key="common.month${count}"/>
					</option>
				 </c:forEach>
				 <dsp:tagAttribute name="aria-labelledby" value="lblcardExpMonth${index} errcardExpMonth${index}" />
			</dsp:select>
		</div>

		<div class="year-select">
			<label for="cardExpYear${index}" id="lblcardExpYear${index}" style="display:none">card year expiration</label>
			<jsp:useBean id="date" class="java.util.Date" />
			<c:set var="currentYear">
				<fmt:formatDate value="${date}" pattern="yyyy" />
			</c:set>
			<dsp:getvalueof var="expYear" bean="PaymentGroupFormHandler.expirationYear[param:index]"/>
			<c:if test="${empty expYear}">
				<dsp:getvalueof var="expYear" param="payGroup.expirationYear" />
			</c:if>
			<dsp:select	bean="PaymentGroupFormHandler.expirationYear" id="cardExpYear${index}" 
				name="cardExpYear" iclass="cv-check cardExpYear" title="Card Expiration Year">
				<dsp:tagAttribute name="data-cv-type" value="expyear" />
				<dsp:option value=""><fmt:message key="common.year"/></dsp:option>
				<c:forEach var="i" begin="${currentYear}" end="${currentYear+15}">
					<option value="${i}" <c:if test="${expYear eq i}">selected</c:if>>${i}</option>
				</c:forEach>
				<dsp:tagAttribute name="aria-labelledby" value="lblcardExpYear${index} errcardExpYear${index}" />
			</dsp:select>
		</div>
	</fieldset>

	<fieldset class="security-code" data-module="cbox">
		<legend><fmt:message key="checkout.deliveryAndPayment.securityCode"/></legend>
		<label for="secCode${index}" id="lblsecCode${index}"><fmt:message key="checkout.deliveryAndPayment.securityCode"/>* </label>
		<dsp:input type="password" value="" autocomplete="off" bean="PaymentGroupFormHandler.cardVerificationNumber" 
			maxlength="4" name="secCode" id="secCode${index}" required="required" 
			maxlength="4" iclass="cv-check secCode security-code-input" title="Security Code">
			<dsp:tagAttribute name="data-cv-type" value="input" />
			<dsp:tagAttribute name="aria-labelledby" value="lblsecCode${index} errsecCode${index}" />
		</dsp:input>
		
		<div data-module="cbox" class="secure-modal"><a class="modal cboxElement" href="/modals/securityCode.jsp"><fmt:message key="checkout.deliveryAndPayment.whereFind"/></a></div>
	</fieldset>

	<fieldset class="billadd-check ">
		<legend><fmt:message key="checkout.deliveryAndPayment.billingAddress"/> </legend>
		<label for="${addNewBillAddrId}" id="lbl${addNewBillAddrId}"><fmt:message key="checkout.deliveryAndPayment.billingAddress"/> </label>
	</fieldset>
	<c:choose>
		<c:when test="${securityStatus >=2}">
			<c:choose>
				<c:when test="${hasSecondaryAddresses}">
					<c:choose>
						<c:when test="${hasPrimaryBillingAddress}">
							<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="false" id="${addNewBillAddrId}" />
						</c:when>
						<c:otherwise>
							<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="true" id="${addNewBillAddrId}" />
						</c:otherwise>
					</c:choose>					
					<dsp:include page="displayShippingAddress.jsp">
						<dsp:param name="frmPayment" value="true"/>
						<dsp:param name="index" param="index"/>
					</dsp:include>
				</c:when>
				<c:otherwise>
					<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="true"/>
					<dsp:include page="billingForm.jsp">
						<dsp:param name="index" param="index"/>
						<dsp:param name="payGroup" param="payGroup"/>	
					</dsp:include>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.addNewBillAddr" value="true"/>
			<dsp:include page="billingForm.jsp">
				<dsp:param name="index" param="index"/>
				<dsp:param name="payGroup" param="payGroup"/>
			</dsp:include>
		</c:otherwise>
	</c:choose>
</dsp:page>