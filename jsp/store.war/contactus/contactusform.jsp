<dsp:page>
    <dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
    <dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
    <dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />
    <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
    
    <%-- Page Variables --%>
    <fmt:message var="generalPhoneNum" key="contactus.phonenumber.general"/>
    <fmt:message var="formSubmitButton" key="contactus.form.submitButton"/>
    <fmt:message var="outdoorFurniturePhoneNum" key="contactus.phonenumber.outdoorFurniture"/>
    <fmt:message var="officeFurniturePhoneNum" key="contactus.phonenumber.officeFurniture"/>
    
    <jsp:body>
        <dsp:layeredBundle basename="com.lzb.common.WebAppResources">
            <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
            
            <section role="region" class="cust-support" data-module="contact-us" id="contactUsContainer">
                <div class="cust-contact" data-module="form-validate">
                    <dsp:getvalueof var="successMsg" param="success"/>
                    <c:if test="${successMsg eq 'true'}">
                        <div class="contact-us-success-msg"><fmt:message key="common.successMsg"/></div>
                    </c:if>
                    
                    <h1><fmt:message key="contactus.pageHeading"/></h1>
                    <p><fmt:message key="contactus.pageDescription"/> <a href="tel:+${generalPhoneNum}">${generalPhoneNum}</a>.</p>
                    
                    <p class="required-key"><sup>*</sup><fmt:message key="contactus.form.required"/></p>
                    
                    <div id="errorMsg">
                        <dsp:getvalueof bean="ContactUSFormHandler.formError" var="formError"/>
                        <c:if test="${formError eq 'true'}">
                            <dsp:include page="/includes/global/errors.jsp">
                                <dsp:param name="formHandler" bean="ContactUSFormHandler"/>
                            </dsp:include>
                        </c:if>
                    </div>
                    
                    <section data-module="floating-form-labels eloqua-submit">
                        <dsp:form method="get" action="${pageContext.request.contextPath}/content/CustomerCare/contactus" name="cust-contact" id="cust-contact">
                            <dsp:getvalueof value="" var="contactUsCatItem"/>
                            <div class="text first">
                                <label for="category"><fmt:message key="common.category"/><sup>*</sup></label>
                                <dsp:select id="category" iclass="category-select requiredField move-label" name="category" bean="ContactUSFormHandler.valueMap.contactUsCategory">
                                    <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
                                        <dsp:param name="queryRQL" value="all"/>
                                        <dsp:param name="repository" bean="/com/lzb/repository/content/LZBContentRepository"/>
                                        <dsp:param name="itemDescriptor" value="contactUsCategory"/>
                                        <dsp:param name="elementName" value="contactUsCatItem" />
                                        <dsp:oparam name="outputStart">
                                            <dsp:option value=""></dsp:option>
                                        </dsp:oparam>
                                        <dsp:oparam name="output">
                                            <dsp:getvalueof param="contactUsCatItem" var="contactUsCatItem"/>
                                            <dsp:droplet name="ForEach">
                                                <dsp:param name="array" param="contactUsCatItem" />
                                                <dsp:param name="elementName" value="subCat" />
                                                <dsp:oparam name="output">
                                                    <dsp:valueof param="subCat"/>
                                                </dsp:oparam>
                                            </dsp:droplet>
                                            <c:if test="${not empty contactUsCatItem }">
                                                <dsp:option value="${contactUsCatItem.id }">
                                                    ${contactUsCatItem.name }</dsp:option>
                                            </c:if>
                                            contactUsSubCategories
                                        </dsp:oparam>
                                    </dsp:droplet>
                                </dsp:select>
                                <span class="icon-arrow-down" aria-hidden="true"></span>
                            </div>
                            <div class="text disabled">
                                <label for="subCategory"><fmt:message key="common.subCategory"/><sup>*</sup></label>
                                <c:if test="${not empty contactUsCatItem}">
                                    <dsp:select id="subCategory" iclass="requiredField move-label" name="subCategory" bean="ContactUSFormHandler.valueMap.contactUsSubCategory" disabled="true">
                                        <dsp:option value=""></dsp:option>
                                        <dsp:getvalueof value="${contactUsCatItem}" var="contactUsCatItem"/>
                                        <c:forEach items="${contactUsCatItem.contactUsSubCategories}" var="contactUsSubCategory">
                                            <dsp:option value="${contactUsSubCategory.id}">
                                                ${contactUsSubCategory.name }</dsp:option>
                                        </c:forEach>
                                    </dsp:select>
                                    <span class="icon-arrow-down" aria-hidden="true"></span>
                                </c:if>
                            </div>
                            <div class="field-group clearfix">
                                <div class="field">
                                    <div class="text">
                                        <dsp:input iclass="requiredField move-label eloquaFormField" id="fName" name="fName" type="text" beanvalue="ContactUSFormHandler.valueMap.firstName" bean="ContactUSFormHandler.valueMap.firstName" />
                                        <label for="fName"><fmt:message key="common.firstName"/><sup>*</sup></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="text">
                                        <dsp:input iclass="requiredField move-label eloquaFormField" id="lName" name="lName" type="text" beanvalue="ContactUSFormHandler.valueMap.lastName" bean="ContactUSFormHandler.valueMap.lastName" />
                                        <label for="lName"><fmt:message key="common.lastName"/><sup>*</sup></label>
                                    </div>
                                </div>
                            </div>
                            <div class="text">
                                <dsp:input iclass="requiredField move-label eloquaFormField" id="address1" name="address1" type="text" beanvalue="ContactUSFormHandler.valueMap.address1" bean="ContactUSFormHandler.valueMap.address1" />
                                <label for="address1"><fmt:message key="contactus.address"/><sup>*</sup></label>
                            </div>
                            <div class="text">
                                <dsp:input iclass="move-label eloquaFormField" id="address2" name="address2" type="text" beanvalue="ContactUSFormHandler.valueMap.address2" bean="ContactUSFormHandler.valueMap.address2" />
                                <label for="address2"><fmt:message key="common.addressLine2"/></label>
                            </div>
                            <div class="field-group clearfix">
                                <div class="field">
                                    <div class="text">
                                        <dsp:input iclass="requiredField move-label eloquaFormField" id="city" name="city" type="text" beanvalue="ContactUSFormHandler.valueMap.city" bean="ContactUSFormHandler.valueMap.city" />
                                        <label for="city"><fmt:message key="common.city"/><sup>*</sup></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="text">
                                    	<dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect"/>
                                    	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
                                    	<dsp:getvalueof var="countryVal" param="countryCode" />
										<dsp:getvalueof var="selState" param="statePicker" />
										
										<c:if test="${empty countryVal}">
											<dsp:getvalueof var="countryVal" value="US" />
										</c:if>
                                    	
                                        <label for="state"><fmt:message key="address.state"/><sup>*</sup></label>
                                        <dsp:select name="atg_store_stateSelect" iclass="requiredField move-label eloquaFormField" id="atg_store_stateSelect" bean="ContactUSFormHandler.valueMap.state" nodefault="true">
                                            <dsp:option value=""></dsp:option>
                                            <c:forEach items="${countryStateMap}" var="entry">
												<c:forEach items="${entry.value}" var="state">
													<c:if test="${entry.key == countryVal}">
														<dsp:option value="${state}" selected="${selState eq state}"><fmt:message key="state.${state}"/></dsp:option>
													</c:if>
												</c:forEach>
											</c:forEach>
                                        </dsp:select>
                                        <span class="icon-arrow-down" aria-hidden="true"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="field-group clearfix">
                                <div class="field">
                                    <div class="text">
                                        <dsp:input iclass="requiredField move-label eloquaFormField" id="postal" name="postal" type="text" beanvalue="ContactUSFormHandler.valueMap.zipCode" bean="ContactUSFormHandler.valueMap.zipCode" />
                                        <label for="postal"><fmt:message key="common.zipOrPostalCode"/><sup>*</sup></label>
                                    </div>
                                </div>
                                <div class="field">
                                    <div class="text">
                                        <label class="hiddenLabel" for="selCountry"><fmt:message key="common.country"/><sup>*</sup></label>
                                        <dsp:select name="selCountry" iclass="requiredField move-label eloquaFormField" id="selCountry" bean="ContactUSFormHandler.valueMap.country" onchange='populateState(this)'>
                                            <%@include file="/includes/global/countryList.jsp" %>
                                        </dsp:select>
                                        <span class="icon-arrow-down" aria-hidden="true"></span>
                             		</div>
                                </div>
                            </div>
                            <div class="text">
                                <dsp:input iclass="requiredField move-label eloquaFormField" id="email" name="email" type="email" beanvalue="ContactUSFormHandler.valueMap.email" bean="ContactUSFormHandler.valueMap.email" />
                                <label for="email"><fmt:message key="common.email"/><sup>*</sup></label>
                            </div>
                            <div class="field-group clearfix">
                                <div class="field">
                                    <div class="text">
                                        <dsp:input iclass="move-label eloquaFormField" id="phoneNumber" name="phoneNumber" maxlength="10" type="tel" beanvalue="ContactUSFormHandler.valueMap.phoneNumber" bean="ContactUSFormHandler.valueMap.phoneNumber" />
                                        <label for="phoneNumber"><fmt:message key="common.phone"/></label>
                                    </div>
                                </div>
                            </div>
                            <div class="text textarea">
                                <dsp:textarea iclass="move-label" name="comments" id="comments" bean="ContactUSFormHandler.valueMap.comments" />
                                <label for="comments"><fmt:message key="contactus.form.comments"/></label>
                                <p class="characterLimitWarning"><span class="characterLimit">254</span> Characters Remaining</p>
                            </div>
                            <%--
                            XXXXXXXXXXXXXXXXXXXXXXXXXX
                            additional fields
                            XXXXXXXXXXXXXXXXXXXXXXXXXX
                            --%>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Acknowledgment Number">
                                <dsp:input iclass="move-label" id="acknowledgementNumber" name="acknowledgementNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.acknowledgmentNumber" bean="ContactUSFormHandler.valueMap.acknowledgmentNumber" />
                                <label for="acknowledgementNumber"><fmt:message key="common.acknowledgmentNumber"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Style Number">
                                <dsp:input iclass="move-label" id="styleNumber" name="styleNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.styleNumber" bean="ContactUSFormHandler.valueMap.styleNumber" />
                                <label for="styleNumber"><fmt:message key="common.styleNumber"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Cover Number">
                                <dsp:input iclass="move-label" id="coverNumber" name="coverNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.coverNumber" bean="ContactUSFormHandler.valueMap.coverNumber" />
                                <label for="coverNumber"><fmt:message key="common.coverNumber"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Date of Delivery">
                                <dsp:input iclass="move-label" id="dateOfDelivery" name="dateOfDelivery" type="text" beanvalue="ContactUSFormHandler.valueMap.dateOfDelivery" bean="ContactUSFormHandler.valueMap.dateOfDelivery" />
                                <label for="dateOfDelivery"><fmt:message key="common.dateofDelivery"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Name of Dealer Purchased From">
                                <dsp:input iclass="move-label" id="dealerName" name="dealerName" type="text" beanvalue="ContactUSFormHandler.valueMap.dealerName" bean="ContactUSFormHandler.valueMap.dealerCity" />
                                <label for="dealerName"><fmt:message key="common.dealerPurchaseFrom"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Dealer City">
                                <dsp:input iclass="move-label" id="dealerCity" name="dealerCity" type="text" beanvalue="ContactUSFormHandler.valueMap.dealerCity" bean="ContactUSFormHandler.valueMap.dealerCity" />
                                <label for="dealerCity"><fmt:message key="common.dealerCity"/></label>
                            </div>
                            <div class="text cust-supp-add cust-supp-hidden" data-return="Dealer State / Province">
                                <label for="stateSelect"><fmt:message key="common.dealerState"/></label>
                                <dsp:select name="stateSelect" iclass="move-label" id="stateSelect" bean="ContactUSFormHandler.valueMap.dealerState">
                                    <dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
                                    <c:forEach items="${countryStateMap}" var="entry">
                                        <dsp:getvalueof var="countryCode" value="${entry.key}" />
                                        <dsp:option value=""></dsp:option>
                                        <optgroup label="${countryCode}">
                                            <c:forEach items="${entry.value}" var="stateCode">
                                                <dsp:getvalueof var="codeValue" value="${countryCode}-${stateCode}" />
                                                <dsp:option value="${codeValue}" selected="${state eq codeValue}"><fmt:message key="state.${stateCode}"/></dsp:option>
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </dsp:select>
                                <span class="icon-arrow-down" aria-hidden="true"></span>
                            </div>
                            <div class="captcha">
                                <p><fmt:message key="common.captchaImage"/></p>
                                <img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha">
                            </div>
                            <div class="text">
                                <dsp:input iclass="requiredField move-label" id="verficationNum" name="verficationNum" type="text" beanvalue="ContactUSFormHandler.valueMap.captchaImageNumber" bean="ContactUSFormHandler.valueMap.captchaImageNumber" />
                                <label for="verficationNum"><fmt:message key="contactus.verificationText"/><sup>*</sup></label>
                            </div>
                            <div class="checkbox">
                                <p class="ckek">
                                    <dsp:input name="getEmail" type="checkbox" id="getEmail" bean="ContactUSFormHandler.sendPromotionalEmail" />
                                    <label class="no-show" for="getEmail"><fmt:message key="contactus.form.emailOptIn"/></label>
                                    <%-- Eloqua hidden email opt in field requires value "on" managed in AJAX request--%>
                                    <input type="hidden" name="emailOptIn" id="emailOptIn" value="" />
                                </p>
                            </div>
                            <div class="cust-contact-but">
                                <dsp:input type="hidden" bean="ContactUSFormHandler.errorUrl" value="${pageContext.request.contextPath}/content/CustomerCare/contactus"/>
                                <dsp:input type="hidden" bean="ContactUSFormHandler.successUrl" value="${pageContext.request.contextPath}/content/CustomerCare/contactus"/>
                                <dsp:input type="submit" iclass="hide" value="Submit" name="formSubmitter" bean="ContactUSFormHandler.contactUS" />
                                <input type="button" class="contact-us-submit button primary-btn" id="contactUsFormSubmit" name="contactUsFormSubmit" value="${formSubmitButton}" />
                                <a href="#" class="form-reset"><fmt:message key="npcCatalog.reset"/></a>
                            </div>
                            <%-- Eloqua hidden form fields --%>
                            <input class="eloquaFormField" type="hidden" name="elqFormName" value="ContactUs">
                            <input class="eloquaFormField" type="hidden" name="elqSiteID" value="20103530">
                            <input class="eloquaFormField" type="hidden" name="elqCustomerGUID" value="">
                            <input class="eloquaFormField" type="hidden" name="elqCookieWrite" value="0">
                        </dsp:form>
                        <p><fmt:message key="contactus.formThankYou"/></p>
                    </section>
                </div>

                <%-- .cust-contact --%>
                <div class="contact-chat">
                    <div class="contact-detls">
                        <p><fmt:message key="contactus.sidenavIntro"/></p>
                        
                        <h2><fmt:message key="contactus.heading.getHelp"/></h2>
                        
                        <h3><fmt:message key="contactus.heading.generalInquiries"/></h3>
                        <p><a href="tel:+${generalPhoneNum}">${generalPhoneNum}</a></p>
                        
                        <h3><fmt:message key="contactus.heading.outdoorFurniture"/></h3>
                        <p><a href="tel:+${outdoorFurniturePhoneNum}">${outdoorFurniturePhoneNum}</a></p>
                        
                        <h3><fmt:message key="contactus.heading.officeFurniture"/></h3>
                        <p><a href="tel:+${officeFurniturePhoneNum}">${officeFurniturePhoneNum}</a></p>
                        
                        <a class="dsr-link" href="${pageContext.request.contextPath}/content/CustomerCare/dsr"><h3><fmt:message key="contactus.dsrlink"/></h3></a>
                    </div>
                
                </div>
            
            </section><%-- .cust-support --%>
            
            <script>
				function populateState(countrySelect) {
					$.ajax({
                        url:  '/contactus/stateList.jsp?selectedCountry=' + $(countrySelect).val(),
                        type: 'GET',
                        error : function(data){
                        	console.log('An error occurred during state list retrieval.');
                        },
                        success : function(data){
                        	$('#atg_store_stateSelect').html(data);
                        }
                    });
				}
			</script>
        </dsp:layeredBundle>
    </jsp:body>

</dsp:page>
