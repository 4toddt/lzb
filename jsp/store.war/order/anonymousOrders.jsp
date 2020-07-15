<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<lzb:pageContainer>
		<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
		<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
		<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
		<dsp:getvalueof var="anonymousOrder" bean="ProfileFormHandler.anonymousOrder" />
		<dsp:param name="orderId" value="${anonymousOrder.id}" />
		<dsp:getvalueof var="billing_zipCode" value="${anonymousOrder.paymentGroups[0].postalCode}" />
		<dsp:getvalueof var="zip_Code" bean="ProfileFormHandler.zipCode" />
		<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
		<dsp:getvalueof var="success" param="success" />
		<jsp:attribute name="bodyClass">npc</jsp:attribute>
		<jsp:attribute name="seoAlternateURL">${originatingRequest.getRequestURI()}</jsp:attribute>
		<jsp:attribute name="seoCanonicalURL">${originatingRequest.getRequestURI()}</jsp:attribute>

<main role="main">


		<section role="region" class="profile-account-content" data-module="profile-validate">

		<div>
			<h1>
				<fmt:message key="anonymousOrder.header" />
			</h1>
			</br>
			<h4><fmt:message key="anonymousOrder.whereIsOrderText"/></h4>
			<br/>
			<fmt:message key="anonymousOrder.orderText" />
			</br>
			<fmt:message key="anonymousOrder.zipText" />
			</br>
			<fmt:message key="anonymousOrder.orderStatus" />
			</br>
			<fmt:message key="anonymousOrder.storeInfo" />
			<dsp:a
				href="${pageContext.request.contextPath}/storeLocator/storeLocator.jsp">
				<fmt:message key="anonymousOrder.storeContact" />
			</dsp:a>
			<fmt:message key="anonymousOrder.storeContactStament" />
			</br>
			<fmt:message key="anonymousOrder.logintext1" />
			<dsp:a href="${pageContext.request.contextPath}/account/login.jsp">Login</dsp:a>
			<fmt:message key="anonymousOrder.logintext2" />
		</div>

		<div>
			<h4>
				<fmt:message key="anonymousOrder.noAccount" />
			</h4>
			<h6>
				<fmt:message key="anonymousOrder.signuptext1" />
				</br>
				<fmt:message key="anonymousOrder.signuptext2" />
				</br>
				<dsp:a
					href="${pageContext.request.contextPath}/account/register.jsp">CREATE AN ACCOUNT</dsp:a>
			</h6>
		</div>
		</br>
		<c:if test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					</dsp:include>
				</div>
			</div>
		</c:if>

		<c:if test="${success eq 'true' }">
			<c:choose>
				<c:when
					test="${not empty anonymousOrder && billing_zipCode eq zip_Code}">

				</c:when>
				<c:otherwise>
					<fmt:message key="anonymousOrder.errorMsg" />
				</c:otherwise>
			</c:choose>
		</c:if>
		<dsp:form action="#" method="post" name="anonymous_order"
			id="anonymous_orders">

			<%-- <fmt:message key="form.required" /> --%>
			<br />
			<fmt:message key="anonymousOrder.requiredFieldText" />

			<fieldset>
				<div>
					<label for="account_Order_Number"> <fmt:message
							key="anonymousOrder.OrderNumber" /><sup>&#42;</sup>
					</label>
					<dsp:input type="text" id="Order_Number"
						name="account_Order_Number" bean="ProfileFormHandler.orderNumber" />
					<span class="field_error"></span>
				</div>
			</fieldset>

			<fieldset>
				<div>
					<label for="account_Zip_Code"> <%-- <fmt:message key="profile.email" />
									<span class="required">*</span> --%> <fmt:message
							key="anonymousOrder.postalCode" /><sup>&#42;</sup>
					</label>
					<dsp:input type="text" id="Postal_Code" name="account_Postal_Code"
						bean="ProfileFormHandler.zipCode" />
					<span class="field_error"></span>
				</div>
			</fieldset>

			<dsp:input type="submit" value="SUBMIT" name="anonymous_order"
				id="anonymous_order" bean="ProfileFormHandler.searchAnonymousOrder" iclass="btn-primary"/>
			<dsp:input type="hidden"
				bean="ProfileFormHandler.anonymousOrderSuccessUrl"
				value="${pageContext.request.contextPath}/order/anonymousOrders.jsp?success=true" />
			<dsp:input type="hidden"
				bean="ProfileFormHandler.anonymousOrderErrorUrl"
				value="${pageContext.request.contextPath}/order/anonymousOrders.jsp?success=false" />
		</dsp:form>
		<c:if test="${success eq 'true' }">
			<c:choose>
				<c:when
					test="${not empty anonymousOrder && billing_zipCode eq zip_Code}">
					<div>
						<h2>
							<fmt:message key="anonymousOrder.orderNum" />
							&nbsp;
							<dsp:valueof bean="ProfileFormHandler.anonymousOrder.id" />
						</h2>
						</br>
					</div>
					</br>
					<table border="1" width="100%">
						<tbody>
							<tr>
								<td><h4>
										<fmt:message key="anonymousOrder.orderDetails" />
									</h4></td>
								<td><fmt:message key="anonymousOrder.orderNum" />&nbsp;<dsp:valueof
										bean="ProfileFormHandler.anonymousOrder.id" /></td>
								<td><fmt:message key="anonymousOrder.orderDate" />&nbsp;
								<fmt:formatDate pattern="yyyy-MM-dd" value="${anonymousOrder.submittedDate}"/> </td>
								<td><fmt:message key="anonymousOrder.status" />&nbsp;${anonymousOrder.state}</td>

							</tr>
							<tr>
								<td><h6>
										<fmt:message key="anonymousOrder.deliveryAddress" />
									</h6>
									</br>
									${anonymousOrder.shippingGroups[0].firstName}&nbsp;${anonymousOrder.shippingGroups[0].firstName}<br />
									${anonymousOrder.shippingGroups[0].address1}</br>
									${anonymousOrder.shippingGroups[0].city}&nbsp;${anonymousOrder.shippingGroups[0].stateAddress}&nbsp;
									${anonymousOrder.shippingGroups[0].postalCode}&nbsp;<br />
									</td>

								<td><h6>
										<fmt:message key="anonymousOrder.deliveryInstructions" />
									</h6>
									</br> <dsp:droplet name="ForEach">
										<dsp:param name="array"
											value="${anonymousOrder.shippingGroups[0].specialInstructions}" />
										<dsp:param name="elementName" value="specialInstr" />
										<dsp:oparam name="output">
											<dsp:valueof param="specialInstr" />
										</dsp:oparam>
									</dsp:droplet></td>
								<td><h6>
										<fmt:message key="anonymousOrder.billingAddress" />
									</h6>
									</br>
									${anonymousOrder.paymentGroups[0].firstName}&nbsp;${anonymousOrder.paymentGroups[0].lastName}</br>
									${anonymousOrder.paymentGroups[0].address1}</br>
									${anonymousOrder.paymentGroups[0].city}&nbsp;${anonymousOrder.paymentGroups[0].stateAddress}&nbsp;${anonymousOrder.paymentGroups[0].postalCode}
								</td>
								<td><h6>
										<fmt:message key="anonymousOrder.paymentMethod" />
									</h6>
									</br> <dsp:include page="anonymousOrderPaymentMethods.jsp">
										<dsp:param name="anonymousOrders"
											bean="ProfileFormHandler.anonymousOrder" />
									</dsp:include></td>
							</tr>
						</tbody>
					</table>
					</br>
					<h4>
						<fmt:message key="anonymousOrder.orderedItems" />
					</h4>
					<div>
						<dsp:include page="anonymousOrderDetails.jsp">
							<dsp:param name="anonymousOrder" value="${anonymousOrder}" />
						</dsp:include>
					</div>

				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>
		</c:if>
		</section>
		</main>
	</lzb:pageContainer>
</dsp:page>
