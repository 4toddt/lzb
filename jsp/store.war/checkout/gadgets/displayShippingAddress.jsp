<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/atg/commerce/util/MapToArrayDefaultFirst" />
	<dsp:importbean bean="/atg/commerce/order/purchase/PaymentGroupFormHandler" />
	<dsp:importbean bean="/com/lzb/droplet/LZBGetShippingGroupAddressDroplet"/>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />

	<dsp:getvalueof var="defaultShippingAddress" bean="Profile.shippingAddress" />
	<dsp:getvalueof var="defaultBillingAddress" bean="Profile.billingAddress" />
	<dsp:getvalueof var="frmPayment" param="frmPayment" />
	<dsp:getvalueof var="index" param="index"/>

	<dsp:droplet name="LZBGetShippingGroupAddressDroplet">
		<dsp:param name="order" bean="ShoppingCart.current"/>
		<dsp:oparam name="output">
			<dsp:getvalueof var="contactAddressId" param="selectedAddressId"/>
		</dsp:oparam>
	</dsp:droplet>

	<c:choose>
		<c:when test="${frmPayment and (index eq 1)}">
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.selectedBillingAddressId" value="${defaultBillingAddress.id}" id="selBillAddrId1"/>
			<dsp:getvalueof var="radioBtnClass" value="billRadioBtn1"/>
			<dsp:getvalueof var="defaultAddressId" value="${defaultBillingAddress.id}"/>
		</c:when>
		<c:when test="${frmPayment}">
			<dsp:input type="hidden" bean="PaymentGroupFormHandler.selectedBillingAddressId" value="${defaultBillingAddress.id}" id="selBillAddrId"/>
			<dsp:getvalueof var="radioBtnClass" value="billRadioBtn"/>
			<dsp:getvalueof var="defaultAddressId" value="${defaultBillingAddress.id}"/>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${contactAddressId ne null}">
					<dsp:input type="hidden" bean="PaymentGroupFormHandler.selectedShippingAddressId" value="${contactAddressId}" id="selShipAddrId"/>
				</c:when>
				<c:otherwise>
					<dsp:input type="hidden" bean="PaymentGroupFormHandler.selectedShippingAddressId" value="${defaultShippingAddress.id}" id="selShipAddrId"/>
				</c:otherwise>
			</c:choose>
			<dsp:getvalueof var="radioBtnClass" value="shipRadioBtn"/>
			<dsp:getvalueof var="defaultAddressId" value="${defaultShippingAddress.id}"/>
		</c:otherwise>
	</c:choose>

	<c:if test="${frmPayment eq true}">
		<fieldset class="billadd-check">
			<legend>shipping addresses</legend>
	</c:if>

		<dsp:droplet name="MapToArrayDefaultFirst">
			<dsp:param name="map" bean="Profile.secondaryAddresses" />
			<dsp:param name="defaultId" value="${defaultAddressId}"/>
			<dsp:param name="sortByKeys" value="true" />
			<dsp:param name="isAddrSelected" value="false" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="sortedArray" vartype="java.lang.Object" param="sortedArray" />
				<c:forEach var="shippingAddress" items="${sortedArray}" varStatus="status">
					<dsp:getvalueof var="address" value="${shippingAddress.value}" />
					<div class="saved-address">
						<c:choose>
							<c:when test="${frmPayment and (index eq 1)}">
								<c:choose>
									<c:when test="${defaultBillingAddress.repositoryId eq address.id && page ne 'orderReview'}">
										<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}" checked="true"/>
										<c:set value="true" var="isAddrSelected" />
									</c:when>
									<c:otherwise>
										<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}">
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:when test="${frmPayment}">
								<c:choose>
									<c:when test="${defaultBillingAddress.repositoryId eq address.id && page ne 'orderReview'}">
									<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}" checked="true"/>
									<c:set value="true" var="isAddrSelected" />
									</c:when>
									<c:otherwise>
										<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}">
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${defaultShippingAddress.repositoryId eq address.id && page ne 'orderReview'}">
										<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}" checked="true"/>
										<c:set value="true" var="isAddrSelected" />
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${contactAddressId eq address.id}">
												<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}" checked="true"/>
												<c:set value="true" var="isAddrSelected" />
											</c:when>
											<c:otherwise>
												<input type="radio" value="${address.id}" class="${radioBtnClass}" name="${radioBtnClass}">
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						<input type="hidden" value="${address.postalCode}" name="${address.id}" id="postalcode-${address.id}" />

						<ul>
							<li>${shippingAddress.key}</li>

							<li>${address.firstName}&nbsp;${address.lastName}</li>

							<li>${address.address1}</li>

							<li>${address.address2}</li>

							<li>${address.city},&nbsp;${address.state}&nbsp;${address.postalCode}</li>

							<li>${address.country}</li>

							<li>${address.phoneNumber}</li>

							<li>${address.altPhoneNumber}</li>

							<c:choose>
								<c:when test="${frmPayment}">
									<c:if test="${defaultBillingAddress.repositoryId eq address.id}">
										<li>&#10003; <fmt:message key="checkout.deliveryAndPayment.primary"/></li>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${defaultShippingAddress.repositoryId eq address.id}">
										<li>&#10003; <fmt:message key="checkout.deliveryAndPayment.primary"/></li>
									</c:if>
								</c:otherwise>
							</c:choose>

							<li>
								<dsp:a href="${pageContext.request.contextPath}/checkout/gadgets/editAddress_checkout.jsp" iclass="cboxElement">
									<dsp:param name="isCheckoutFlow" value="true"/>
									<dsp:param name="nickName" value="${shippingAddress.key}" /> <fmt:message key="common.button.editText"/>
								</dsp:a>
								<c:choose>
									<c:when test="${frmPayment}">
										<c:if test="${defaultBillingAddress.repositoryId ne address.id}">
											<dsp:a href="${pageContext.request.contextPath}/checkout/gadgets/editAddress_checkout.jsp" iclass="setas-payment">
												<dsp:param name="isCheckoutFlow" value="true"/>
												<dsp:param name="nickName" value="${shippingAddress.key}" /> <fmt:message key="checkout.deliveryAndPayment.setAsPrimary"/>
											</dsp:a>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${defaultShippingAddress.repositoryId ne address.id}">
											<dsp:a href="${pageContext.request.contextPath}/checkout/gadgets/editAddress_checkout.jsp" iclass="setas-payment">
												<dsp:param name="isCheckoutFlow" value="true"/>
												<dsp:param name="nickName" value="${shippingAddress.key}" /> <fmt:message key="checkout.deliveryAndPayment.setAsPrimary"/>
											</dsp:a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</li>

						</ul>
					</div>
				</c:forEach>
			</dsp:oparam>
		</dsp:droplet>

		<div class="new-address">
			<c:choose>
				<c:when test="${frmPayment and (index eq 1)}">
					<c:choose>
						<c:when test="${isAddrSelected}">
							<input type="radio" name="${radioBtnClass}" id="addNewBillAddr1" class="toggle" data-module="toggle"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="${radioBtnClass}" id="addNewBillAddr1" checked="true" class="toggle" data-module="toggle"/>
						</c:otherwise>
					</c:choose>
					<fmt:message key="checkout.deliveryAndPayment.addNewAddress"/>
					<div class="newBillAddr1 add-new-address">
						<dsp:include page="billingForm.jsp">
							<dsp:param name="index" param="index"/>
						</dsp:include>
					</div>
				</c:when>
				<c:when test="${frmPayment}">
					<c:choose>
						<c:when test="${isAddrSelected}">
							<input type="radio" name="${radioBtnClass}" id="addNewBillAddr" class="toggle" data-module="toggle"/>
						</c:when>
						<c:otherwise>
							<input type="radio" name="${radioBtnClass}" id="addNewBillAddr" checked="true" class="toggle" data-module="toggle"/>
						</c:otherwise>
					</c:choose>
					<fmt:message key="checkout.deliveryAndPayment.addNewAddress"/>
					<div class="newBillAddr add-new-address">
						<dsp:include page="billingForm.jsp">
							<dsp:param name="index" param="index"/>
						</dsp:include>
					</div>
				</c:when>
				<c:otherwise>
					<div class="toggle" data-module="toggle">
						<c:choose>
							<c:when test="${isAddrSelected}">
								<input type="radio" name="${radioBtnClass}" id="addNewShipAddr" class="toggle" data-module="toggle"/>
							</c:when>
							<c:otherwise>
								<input type="radio" name="${radioBtnClass}" id="addNewShipAddr" checked="true" class="toggle" data-module="toggle"/>
							</c:otherwise>
						</c:choose>
						<fmt:message key="checkout.deliveryAndPayment.addNewAddress"/>
					</div>
					<div class="newAddr add-new-address" >
						<dsp:include page="shippingForm.jsp">
							<dsp:param name="displayNickNameField" value="true"/>
						</dsp:include>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	<c:if test="${frmPayment eq true}">
		</fieldset>
	</c:if>
</dsp:page>