<dsp:page>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	<dsp:importbean bean="/com/lzb/commerce/customercare/LZBProductRegisterFormHandler" />
		<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
		<dsp:importbean bean="/atg/commerce/util/StateListDroplet" />
		<dsp:getvalueof var="cotextPath"
			value="${originatingRequest.ContextPath}" />
			<dsp:getvalueof bean="LZBProductRegisterFormHandler.formError"
			var="formError" />

<c:choose>
		<c:when test="${formError eq 'true'}">
			<div class="message-container">
				<div class="message-wrapper">
					<dsp:include page="/global/errors.jsp">
						<dsp:param name="formHandler" bean="LZBProductRegisterFormHandler" />
					</dsp:include>
				</div>
			</div>
		</c:when>
		<c:otherwise>
		
		</c:otherwise>
	</c:choose>      
		<dsp:getvalueof var="successMsg" param="success"/> 
		<c:if test="${successMsg eq 'true'}">
			you have successfully submitted the details.
		</c:if>
	

		<dsp:layeredBundle basename="com.lzb.common.WebAppResources">

			<section role="region" class="cust-support two-column-support"
				data-module="form-validate">
				<div class="cust-contact">
					<dsp:form  method="post" name="productRegistration"
						id="productRegistration">

						<h1>
							<label for="pageTitle"><fmt:message
									key="prodReg.pagetitle" /></label>
						</h1>						
						<p>&#42; Required Field</p>
						<h2>CONTACT INFORMATION</h2>
						<div>
							<fieldset>
								<label><fmt:message key="prodReg.title" />:<sup>&#42;</sup></label>
								<dsp:select bean="LZBProductRegisterFormHandler.valueMap.title"
									name="title">
									<dsp:option value="Mr.">Mr.</dsp:option>
									<dsp:option value="Mrs.">Mrs.</dsp:option>
									<dsp:option value="Ms.">Ms.</dsp:option>
									<dsp:option value="Miss">Miss</dsp:option>
								</dsp:select>
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.firstName" /> <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.firstName"
									name="firstName" maxlength="40"  />
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.mi" />:
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.mi" maxlength="40"
									 name="mi" />
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.lastName" />: <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.lastName"
									name="lastName" maxlength="40"  />
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.street" />: <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.street"
									name="street" maxlength="40" />
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.aptno" />:
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.aptNo"
									maxlength="40"  />
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.city" />: <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.city" name="city"
									maxlength="40"  />
							</fieldset>
							<fieldset>
								<label for="atg_store_stateSelect"> <fmt:message
										key="prodReg.state" />: <span class="required">&#42;</span>
								</label>
								<dsp:param name="statePicker"
									bean="LZBProductRegisterFormHandler.valueMap.state" />

								<span class="selct">
									<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
										<dsp:getvalueof var="countryVal" param="countryCode" />
										<dsp:getvalueof var="selState" param="statePicker" />

										<c:choose>
											<c:when test="${empty countryVal}">
												<dsp:getvalueof var="countryVal" value="US" />
												<dsp:getvalueof var="stateSelectClass" value="show-us" />
											</c:when>
											<c:when test="${countryVal eq 'US'}">
												<dsp:getvalueof var="stateSelectClass" value="show-us" />
											</c:when>
											<c:when test="${countryVal eq 'CA'}">
												<dsp:getvalueof var="stateSelectClass" value="show-ca" />
											</c:when>
										</c:choose>

										<dsp:select name="atg_store_stateSelect" id="atg_store_stateSelect" iclass="${stateSelectClass}" bean="LZBProductRegisterFormHandler.valueMap.state" nodefault="true">
											<dsp:option value=""><fmt:message key="common.selectState"/></dsp:option>
											<c:forEach items="${countryStateMap}" var="entry">
												<c:forEach items="${entry.value}" var="state">
													<dsp:option iclass="stateSelect${entry.key}" value="${state}" selected="${selState eq state}"><fmt:message key="state.${state}"/></dsp:option>
												</c:forEach>
											</c:forEach>
										</dsp:select>
								</span>
							</fieldset>
							<fieldset>
								<label> <fmt:message key="prodReg.zip" />: <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.zipCode"
									name="zipCode" maxlength="40" />
							</fieldset>
							<fieldset>
								<label>country</label>
								<dsp:select bean="LZBProductRegisterFormHandler.valueMap.country" id="selCountry" name="country" onchange='populateState(this)'>
									<dsp:option value="US">United States</dsp:option>
									<dsp:option value="CA">Canada</dsp:option> 	
								</dsp:select>
							</fieldset>
							
							<fieldset>
								<label> <fmt:message key="prodReg.email" />: <sup>&#42;</sup>
								</label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.emailAddress"
									name="emailAddress" maxlength="40"  />
							</fieldset>
							<fieldset>
								<label>
									<div class="registrationdob">Date of Birth</div>
								</label>
								<div class="registration-month">
									<dsp:select
										bean="LZBProductRegisterFormHandler.valueMap.dobMonth"
										name="dobMonth" id="dobmonth">
											<dsp:option selected="true">Select Month...</dsp:option>
										<dsp:option value="01">January</dsp:option>
										<dsp:option value="02">February</dsp:option>
										<dsp:option value="03">March</dsp:option>
										<dsp:option value="04">April</dsp:option>
										<dsp:option value="05">May</dsp:option>
										<dsp:option value="06">June</dsp:option>
										<dsp:option value="07">July</dsp:option>
										<dsp:option value="08">August</dsp:option>
										<dsp:option value="09">September</dsp:option>
										<dsp:option value="10">October</dsp:option>
										<dsp:option value="11">November</dsp:option>
										<dsp:option value="12">December</dsp:option>
									</dsp:select>
								</div>

								<jsp:useBean id="date" class="java.util.Date" />
								<c:set var="currentYear">
									<fmt:formatDate value="${date}" pattern="yyyy" />
								</c:set>
								<div class="registration-year">
									<dsp:select
										bean="LZBProductRegisterFormHandler.valueMap.dobYear"
										name="dobYear" id="dobyear">

										<dsp:option  selected="true">Select Year...</dsp:option>
										<c:forEach var="count" begin="${currentYear-115}"
											end="${currentYear}" step="1" varStatus="status">
											<dsp:option value="${count}">
															  ${count}
													   </dsp:option>
										</c:forEach>
									</dsp:select>
								</div>
							</fieldset>
							<fieldset>
								<label><fmt:message key="prodReg.marital" /></label> <span
									class="mstatus"><dsp:input type="radio"
										name="maritalStatus" value="Married"
										bean="LZBProductRegisterFormHandler.valueMap.maritalStatus" />
									Married</span> <span class="mstatus"><dsp:input type="radio"
										name="maritalStatus" value="Single"
										bean="LZBProductRegisterFormHandler.valueMap.maritalStatus" />
									Single </span>
							</fieldset>

							<h2>PRODUCT INFORMATION</h2>
							<fieldset>
								<label>
									<div class="registrationdob">
										<fmt:message key="prodReg.dop" />
									</div>
								</label>
								<div class="registration-day">
									<dsp:select
										bean="LZBProductRegisterFormHandler.valueMap.dopDate"
										name="dopDate">
										<dsp:option  selected="true">Select Date...</dsp:option>
										<c:forEach var="count" begin="1" end="31" step="1"
											varStatus="status">
											<dsp:option value="${count}">
										${count}
									</dsp:option>
										</c:forEach>
									</dsp:select>

								</div>
								<div class="registration-month">
									<dsp:select
										bean="LZBProductRegisterFormHandler.valueMap.dopMonth"
										name="dopMonth">
										<dsp:option selected="true">Select Month...</dsp:option>
										<dsp:option value="1">January</dsp:option>
										<dsp:option value="2">February</dsp:option>
										<dsp:option value="3">March</dsp:option>
										<dsp:option value="4">April</dsp:option>
										<dsp:option value="5">May</dsp:option>
										<dsp:option value="6">June</dsp:option>
										<dsp:option value="7">July</dsp:option>
										<dsp:option value="8">August</dsp:option>
										<dsp:option value="9">September</dsp:option>
										<dsp:option value="10">October</dsp:option>
										<dsp:option value="11">November</dsp:option>
										<dsp:option value="12">December</dsp:option>
									</dsp:select>
								</div>
								<div class="registration-year">
									<dsp:select
										bean="LZBProductRegisterFormHandler.valueMap.dopYear"
										name="dopYear">
										<dsp:option  selected="true">Select Year...</dsp:option>
										<c:forEach var="count" begin="2000" end="${currentYear }" step="1"
											varStatus="status">
											<dsp:option value="${count}">${count}</dsp:option>
										</c:forEach>
									</dsp:select>
								</div>
							</fieldset>
							<fieldset>
								<label><fmt:message key="prodReg.ali" /></label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.ali1"
									maxlength="40" />
							</fieldset>
							<fieldset>
								<small> <fmt:message key="prodReg.alicomment" /></small>
							</fieldset>
							<fieldset>
								<label><fmt:message key="prodReg.style" /></label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.styleNumber"
									maxlength="40"  />
							</fieldset>
							<fieldset>

								<label><fmt:message key="prodReg.cover" /></label>
								<dsp:input type="text"
									bean="LZBProductRegisterFormHandler.valueMap.coverNumber1"
									maxlength="40"  />
							</fieldset>
							<fieldset class="where-purchased">
								<p>Please indicate where you purchased this product</p>
								<div>
									<dsp:input type="radio" value="La-Z-Boy Furniture Galleries"
										bean="LZBProductRegisterFormHandler.valueMap.purchaseLocation"
										maxlength="40" value="La-Z-Boy Furniture Galleries"
										id="furnitureGallery" />
									<label class="no-show no-top-margin" for="furniture-galleries">La-Z-Boy
										Furniture Galleries</label>
								</div>
								<div>
									<div>
										<dsp:input type="radio" value="Department store (name)"
											bean="LZBProductRegisterFormHandler.valueMap.purchaseLocation"
											maxlength="40" value="Department store"
											id="departStoreNameButton" />
										<label class="no-show no-top-margin" for="department-store">Department
											store (name)</label>
									</div>
									<div id="departStoreNameInput">
										<dsp:input type="text"
											bean="LZBProductRegisterFormHandler.valueMap.store"
											maxlength="40" value="" />
									</div>
								</div>
								<div>
									<div>
										<dsp:input type="radio" value="Local Furniture Store (name)"
											bean="LZBProductRegisterFormHandler.valueMap.purchaseLocation"
											maxlength="40" value="Local Furniture Store"
											id="localStoreNameButton" />
										<label class="no-show no-top-margin"
											for="local-furniture-store">Local Furniture Store
											(name</label>
									</div>
									<div id="localStoreNameInput">
										<dsp:input type="text"
											bean="LZBProductRegisterFormHandler.valueMap.store1"
											maxlength="40" value="" />
									</div>
								</div>
								<div>

									<dsp:input type="checkbox" name="subscriptionFlag"
										bean="LZBProductRegisterFormHandler.valueMap.subscriptionFlag" />
									<label class="no-show" for="get-email">Yes, sign me up
										to receive emails about special offers and promotions</label>

								</div>
							</fieldset>
							<dsp:input type="hidden" name="feedProcess"
								bean="LZBProductRegisterFormHandler.valueMap.feedProcess"
								value='N' />
								

							<%-- Cancel button --%>
							<c:choose>
								<c:when test="${pageContext.request.requestURI eq '/customercare/productRegContent.jsp'}">
									<c:set var="redirectURL" value="${pageContext.request.contextPath}/customercare/productRegContent.jsp"/>
								</c:when>
								<c:otherwise>
									<c:set var="redirectURL" value="${pageContext.request.contextPath}/content/CustomerCare/ProductRegistration"/>
								</c:otherwise>
							</c:choose>
							
							<div class="cust-contact-but">
								<dsp:a href="${redirectURL}"
									iclass="atg_store_basicButton secondary ">
									<span>Reset</span>
								</dsp:a>
								<dsp:input type="hidden"
									bean="LZBProductRegisterFormHandler.successUrl"
									value="${redirectURL}?success=true" />
								<dsp:input type="hidden"
									bean="LZBProductRegisterFormHandler.errorUrl"
									value="${redirectURL}?error=true" />

								<%-- Save Address button --%>
								<dsp:input bean="LZBProductRegisterFormHandler.registerProduct"
									type="submit" value="Register" iclass="btn-primary" />

							</div>
						</div>
					</dsp:form>

				</div>

			<%-- .cust-contact --%>
			<div class="contact-chat">

				<div class="contact-detls">

					<h3><fmt:message key="contactus.Byphone"/></h3>

					<p><fmt:message key="contactus.questionOnline"/></p>

					<a href="tel:+18003756890"><fmt:message key="accountEmail.customerCareNo"/></a>

					<p><fmt:message key="contactus.warrantyEnquiries"/></p>

					<a href="tel:+18003756890"><fmt:message key="contactus.comfort"/></a>

					<p>or <a href="tel:+18558026636"><fmt:message key="contactus.optionalCallNo"/></a></p>

					<p><fmt:message key="contactus.Timing"/></p>

				</div>

			</div>

				<script>
					$("#departStoreNameButton").click(function() {
						$("#departStoreNameInput").css("display", "block");
						$("#localStoreNameInput").css("display", "none");
					});

					$("#localStoreNameButton").click(function() {
						$("#localStoreNameInput").css("display", "block");
						$("#departStoreNameInput").css("display", "none");
					});

					$("#furnitureGallery").click(function() {
						$("#departStoreNameInput").css("display", "none");
						$("#localStoreNameInput").css("display", "none");
					});

					function populateState(countrySelect) {
						var stateSelect = document.getElementById('atg_store_stateSelect');

						if (countrySelect.value === 'US') {
							stateSelect.className = '';
							stateSelect.className += 'show-us';
						}
						else {
							stateSelect.className = '';
							stateSelect.className += 'show-ca';
						}
						stateSelect.selectedIndex = 0;
					}

					document.addEventListener("DOMContentLoaded", function(event) {
						// handles state select update if form error occurs due to state not having valid value and country was set to Canada.
						if (document.getElementById('selCountry').value === 'CA') {
							document.getElementById('atg_store_stateSelect').className = '';
							document.getElementById('atg_store_stateSelect').className = 'show-ca';
						}

					});

				</script>
			</section>
		</dsp:layeredBundle>
</dsp:page>