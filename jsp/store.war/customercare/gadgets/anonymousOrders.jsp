<dsp:page>
<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
   <lzb:pageContainer>
     <dsp:getvalueof var="anonymousOrder" bean="ProfileFormHandler.anonymousOrder"/>
     <dsp:param name="orderId" value="${anonymousOrder.id}"/>
     <dsp:getvalueof var="billing_zipCode" value="${anonymousOrder.paymentGroups[0].postalCode}"/>
     <dsp:getvalueof var="zip_Code" bean="ProfileFormHandler.zipCode"/>
     <dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
     <dsp:getvalueof var="success" param="success" />


	     <jsp:attribute name="pageSpecificCSS">
		 </jsp:attribute>

		 <jsp:attribute name="pageSpecificJS">
		 </jsp:attribute>
		   <jsp:body>

		       <lzb:breadCrumb pageKey="breadcrumb.orderStatus" divClass="breadcrumb" /></br></br>

		           <div><h1><fmt:message key="anonymousOrder.header"/></h1></br>
					    <fmt:message key="anonymousOrder.ordertext"/></br>
					    <fmt:message key="anonymousOrder.ziptext"/></br>
					    <fmt:message key="anonymousOrder.orderStatus"/></br>
						<fmt:message key="anonymousOrder.storeinfo"/></br>
						<fmt:message key="anonymousOrder.logintext1"/><dsp:a href="${pageContext.request.contextPath}/account/login.jsp">Login</dsp:a><fmt:message key="anonymousOrder.logintext2"/>
					</div>

					<div>
					    <h4><fmt:message key="anonymousOrder.noAccount"/></h4>
					    <h6><fmt:message key="anonymousOrder.signuptext1"/></br>
					        <fmt:message key="anonymousOrder.signuptext2"/></br>
					        <dsp:a href="${pageContext.request.contextPath}/account/login.jsp">CREATE AN ACCOUNT</dsp:a>
					    </h6>
					</div>
					</br>
					<c:if test="${formError eq 'true'}">
					 <dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="ProfileFormHandler" />
					 </dsp:include>
				    </c:if>
				    <c:if test="${success eq 'true' }">
	               	<c:choose>
	               	  <c:when test="${not empty anonymousOrder && billing_zipCode eq zip_Code}">

		            </c:when>
		            <c:otherwise>
		               <fmt:message key="anonymousOrder.errorMsg" />
		            </c:otherwise>
	               </c:choose>
	              </c:if>
			       <dsp:form action="#" method="post" name="anonymous_order" id="anonymous_orders">

			               <%-- <fmt:message key="form.required" /> --%>
			             <br/>  <fmt:message key="profile.required"/>

		               <fieldset>
							<div>
								<label for="account_Order_Number">
									<fmt:message key="anonymousOrder.OrderNumber"/>
								</label>
								<dsp:input type="text" id="Order_Number" name="account_Order_Number" bean="ProfileFormHandler.orderNumber" />
								<span class="field_error"></span>
							</div>
		               </fieldset>

		               <fieldset>
							<div>
								<label for="account_Zip_Code">
									<%-- <fmt:message key="profile.email" />
									<span class="required">*</span> --%>
									<fmt:message key="anonymousOrder.postalCode"/>
								</label>
								<dsp:input type="text" id="Postal_Code" name="account_Postal_Code" bean="ProfileFormHandler.zipCode" />
								<span class="field_error"></span>
							</div>
		               </fieldset>

		               <dsp:input type="submit" value="SUBMIT" name="anonymous_order" id="anonymous_order" bean="ProfileFormHandler.searchAnonymousOrder" />
		               <dsp:input type="hidden" bean="ProfileFormHandler.anonymousOrderSuccessUrl" value="${pageContext.request.contextPath}/account/gadgets/anonymousOrders.jsp?success=true" />
		               <dsp:input type="hidden" bean="ProfileFormHandler.anonymousOrderErrorUrl" value="${pageContext.request.contextPath}/account/gadgets/anonymousOrders.jsp?success=false" />
	               </dsp:form>
	               <c:if test="${success eq 'true' }">
	               	<c:choose>
	               	  <c:when test="${not empty anonymousOrder && billing_zipCode eq zip_Code}">
	               	     <div>
	               	        <h2><fmt:message key="anonymousOrder.orderNum"/>&nbsp;<dsp:valueof bean="ProfileFormHandler.anonymousOrder.id"/></h2></br>
	               	        <fmt:message key="anonymousOrder.assistance"/>&nbsp;<dsp:a href="#">websaleshelp@la-z-boy.com</dsp:a>
	               	     </div></br>
			             <table border="1" width="100%">
			                  <tbody>
			                    <tr>
			                       <td><h4><fmt:message key="anonymousOrder.orderDetails"/></h4></td>
					               <td><fmt:message key="anonymousOrder.orderNum"/>&nbsp;<dsp:valueof bean="ProfileFormHandler.anonymousOrder.id"/></td>
					               <td><fmt:message key="anonymousOrder.orderDate"/>&nbsp;<fmt:formatDate value="${anonymousOrder.submittedDate}" pattern="yyyy-MM-dd"/></td>
					               <td><fmt:message key="anonymousOrder.status"/>&nbsp;${anonymousOrder.state}</td>

					             </tr>
					             <tr>
					               <td><h6><fmt:message key="anonymousOrder.deliveryAddress"/></h6></br>
					                   ${anonymousOrder.shippingGroups[0].firstName}&nbsp;${anonymousOrder.shippingGroups[0].firstName}<br/>
									   ${anonymousOrder.shippingGroups[0].address1}</br>
									   ${anonymousOrder.shippingGroups[0].city}&nbsp;${anonymousOrder.shippingGroups[0].state}&nbsp;${anonymousOrder.shippingGroups[0].firstName}
					               </td>

					               <td><h6><fmt:message key="anonymousOrder.deliveryInstructions"/></h6></br>
					                   <dsp:droplet name="ForEach">
									     <dsp:param name="array" value="${anonymousOrder.shippingGroups[0].specialInstructions}"/>
									     <dsp:param name="elementName" value="specialInstr"/>
											<dsp:oparam name="output">
												<dsp:valueof param="specialInstr"/>
											</dsp:oparam>
									</dsp:droplet>
					               </td>
					               <td><h6><fmt:message key="anonymousOrder.billingAddress"/></h6></br>
					                   ${anonymousOrder.paymentGroups[0].firstName}&nbsp;${anonymousOrder.paymentGroups[0].lastName}</br>
					                   ${anonymousOrder.paymentGroups[0].address1}</br>
					                   ${anonymousOrder.paymentGroups[0].city}&nbsp;${anonymousOrder.paymentGroups[0].stateAddress}&nbsp;${anonymousOrder.paymentGroups[0].postalCode}
					               </td>
					               <td><h6><fmt:message key="anonymousOrder.paymentMethod"/></h6></br>
					                   <dsp:include page="/account/anonymousOrderPaymentMethods.jsp">
							           <dsp:param name="anonymousOrders" bean="ProfileFormHandler.anonymousOrder"/></dsp:include>
					               </td>
					             </tr>
			               	   </tbody>
			              </table></br>
			               	    <h4><fmt:message key="anonymousOrder.orderedItems"/></h4>
			               	    <div>
									<dsp:include page="anonymousOrderDetails.jsp">
										<dsp:param name="anonymousOrder" value="${anonymousOrder}"/>
									</dsp:include>
		                        </div>

		            </c:when>
		            <c:otherwise>

		            </c:otherwise>
	               </c:choose>
	              </c:if>
		   </jsp:body>
   </lzb:pageContainer>
</dsp:page>
