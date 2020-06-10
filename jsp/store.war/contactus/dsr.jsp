<dsp:page>
	<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	
	<dsp:getvalueof var="successMsg" param="success"/>
	
	<fmt:message var="formSubmitButton" key="dsr.form.submit"/>
	
	<jsp:body>
		<section role="region" class="dsr" data-module="dsr form-validate" id="dsrContainer">
			<c:if test="${successMsg}">
                <div class="dsr-success-msg"><fmt:message key="dsr.form.thankyouText"/></div>
             </c:if>
             	
			<section data-module="floating-form-labels">
				<dsp:form method="post" action="${pageContext.request.contextPath}/content/CustomerCare/dsr" name="dsrForm" formid="dsrForm" id="dsrForm">
                	<p><fmt:message key="dsr.form.instructions"/></p>
             	 	
					<p class="required-key"><sup>*</sup><fmt:message key="dsr.form.requiredField"/><br/><fmt:message key="dsr.form.emailOrPhone"/></p>
					
					<c:if test="${not empty successMsg && !successMsg}">
						<div id="errorMsg">
							<div class="error-msg"><fmt:message key="dsr.form.errorText"/></div>
	                        <dsp:getvalueof bean="ContactUSFormHandler.formError" var="formError"/>
	                        <c:if test="${formError eq 'true'}">
	                            <dsp:include page="/includes/global/errors.jsp">
	                                <dsp:param name="formHandler" bean="ContactUSFormHandler"/>
	                            </dsp:include>
	                        </c:if>
	                    </div>
                    </c:if>
                    
					<h2><fmt:message key="dsr.form.basicInfo"/></h2>
					<div class="field-group clearfix">
	                	<div class="field">
	                  		<div class="text">
	                  			<dsp:input iclass="requiredField move-label" id="fName" name="fName" type="text" beanvalue="ContactUSFormHandler.requestForm.firstName" bean="ContactUSFormHandler.requestForm.firstName" />
	                        	<label for="fName"><fmt:message key="dsr.form.firstName"/><sup>*</sup></label>
	                     	</div>
	                 	</div>
	                  	<div class="field">
	                    	<div class="text">
	                    		<dsp:input iclass="requiredField move-label" id="lName" name="lName" type="text" beanvalue="ContactUSFormHandler.requestForm.lastName" bean="ContactUSFormHandler.requestForm.lastName" />
	                     		<label for="lName"><fmt:message key="dsr.form.lastName"/><sup>*</sup></label>
	                    	</div>
	                	</div>
					</div>
					<div class="text optionalMandatory">
						<dsp:input iclass="move-label" id="email" name="email" type="email" beanvalue="ContactUSFormHandler.requestForm.email" bean="ContactUSFormHandler.requestForm.email" />
	                 	<label for="email"><fmt:message key="dsr.form.emailAddress"/><sup>*</sup></label>
					</div>
					<div class="text">
						<dsp:input iclass="requiredField move-label" id="address1" name="address1" type="text" beanvalue="ContactUSFormHandler.requestForm.address" bean="ContactUSFormHandler.requestForm.address" />
	                 	<label for="address1"><fmt:message key="dsr.form.address"/><sup>*</sup></label>
					</div>
					<div class="field-group clearfix">
	                	<div class="field">
	                     	<div class="text">
	                    		<dsp:input iclass="requiredField move-label" id="city" name="city" type="text" beanvalue="ContactUSFormHandler.requestForm.city" bean="ContactUSFormHandler.requestForm.city" />
	                      		<label for="city"><fmt:message key="dsr.form.city"/><sup>*</sup></label>
	                     	</div>
	                	</div>
	                	<dsp:getvalueof bean="ContactUSFormHandler.requestForm.state" var="selState"/>
	                 	<div class="field">
	                    	<div class="text">
	                        	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
	                            <dsp:getvalueof var="countryVal" value="US" />
								
								<label class="hiddenLabel" for="state"><fmt:message key="dsr.form.state"/><sup>*</sup></label>
	                        	<dsp:select name="stateSelect" iclass="requiredField move-label" id="stateSelect" bean="ContactUSFormHandler.requestForm.state" nodefault="true">
	                            	<dsp:option value=""><fmt:message key="dsr.form.state"/> *</dsp:option>
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
	             	<div class="field-group clearfix last-row">
	                	<div class="field">
	                    	<div class="text">
	                        	<dsp:input iclass="requiredField move-label" id="postal" name="postal" type="text" beanvalue="ContactUSFormHandler.requestForm.zipCode" bean="ContactUSFormHandler.requestForm.zipCode" />
	                          	<label for="postal"><fmt:message key="dsr.form.zipCode"/><sup>*</sup></label>
	                   		</div>
	              		</div>
	                 	<div class="field">
	                    	<div class="text optionalMandatory">
	                        	<dsp:input iclass="move-label" id="phoneNumber" name="phoneNumber" type="tel" beanvalue="ContactUSFormHandler.requestForm.phone" bean="ContactUSFormHandler.requestForm.phone" />
	                       		<label for="phoneNumber"><fmt:message key="dsr.form.phone"/><sup>*</sup></label>
	                      	</div>
	                 	</div>
	              	</div>
	              	
	              	<h2><fmt:message key="dsr.form.typeOfRequest"/></h2>
	              	<div class="field-group last-row type-of-request">
						<div class="custom-radio">
							<dsp:input type="radio" value="access" id="access" name="typeOfRequest" bean="ContactUSFormHandler.requestForm.typeOfRequest" checked="true" />
							<label for="access"><fmt:message key="dsr.form.access"/></label>
						</div>
						<div class="custom-radio">
							<dsp:input type="radio" value="deletion" id="deletion" name="typeOfRequest" bean="ContactUSFormHandler.requestForm.typeOfRequest" />
							<label for="deletion"><fmt:message key="dsr.form.deletion"/></label>
						</div>
						<div class="custom-radio">
							<dsp:input type="radio" value="data" id="categoryOfData" name="typeOfRequest" bean="ContactUSFormHandler.requestForm.typeOfRequest" />
							<label for="categoryOfData"><fmt:message key="dsr.form.categoryOfData"/></label>
						</div>
						<div class="custom-radio">
							<dsp:input type="radio" value="stop of sale" id="stopOfSale" name="typeOfRequest" bean="ContactUSFormHandler.requestForm.typeOfRequest" />
							<label for="stopOfSale"><fmt:message key="dsr.form.stopOfSale"/></label>
						</div>
					</div>
					
					<div class="type-of-data-container">
						<h2><fmt:message key="dsr.form.typeOfData"/></h2>
						<div class="field-group last-row type-of-data">
							<div class="custom-checkbox">
	                    		<dsp:input name="account" type="checkbox" id="account" value="Account" bean="ContactUSFormHandler.requestForm.account" />
	                          	<label class="no-show" for="account"><fmt:message key="dsr.form.account"/></label>
	                     	</div>
	                     	<div class="custom-checkbox">
	                    		<dsp:input name="product" type="checkbox" id="product" value="Product" bean="ContactUSFormHandler.requestForm.product" />
	                          	<label class="no-show" for="product"><fmt:message key="dsr.form.product"/></label>
	                     	</div>
	                     	<div class="custom-checkbox">
	                    		<dsp:input name="marketing" type="checkbox" id="marketing" value="Marketing" bean="ContactUSFormHandler.requestForm.marketing" />
	                          	<label class="no-show" for="marketing"><fmt:message key="dsr.form.marketing"/></label>
	                     	</div>
	                    </div>
                    </div>
                   
                    <h2 class="additional-auth-info hide"><fmt:message key="dsr.form.additionalAuthentication"/></h2>
					<div class="account-data-auth hide">
						<h3><fmt:message key="dsr.form.accountAuthentication"/> (<fmt:message key="dsr.form.includeAccounts"/>)</h3>
						<div class="text additional-data">
							<dsp:input iclass="requiredField move-label" name="accountNames1" type="text" id="accountName1" bean="ContactUSFormHandler.requestForm.accountName1" />
				       		<label for="accountName1"><fmt:message key="dsr.form.accountName"/></label>
						</div>
						<div class="add-more-row"><span class="add-icon">+</span><fmt:message key="dsr.form.addAnotherAccountName"/></div>
					</div>
					<div class="text additional-data additional-account-row hide">
						<dsp:input iclass="requiredField move-label" name="accountNames2" type="text" id="accountName2" bean="ContactUSFormHandler.requestForm.accountName2" />
			          	<label for="accountName2"><fmt:message key="dsr.form.accountName"/></label>
					</div>
						
					<div class="product-data-auth hide">
						<h3><fmt:message key="dsr.form.productAuthentication"/> (<fmt:message key="dsr.form.includeProducts"/>)</h3>
						<div class="field-group additional-data clearfix">
				   			<div class="field">
				        		<div class="text">
				            		<dsp:input iclass="requiredField move-label" id="productName1" name="productName1" type="text" bean="ContactUSFormHandler.requestForm.productName1" />
				                	<label for="productName1"><fmt:message key="dsr.form.productName"/></label>
				             	</div>
				      		</div>
				         	<div class="field">
				            	<div class="text">
				             		<dsp:input iclass="move-label" id="serialNumber1" name="serialNumber1" type="text" bean="ContactUSFormHandler.requestForm.serialNumber1" />
				                  	<label for="serialNumber1"><fmt:message key="dsr.form.aliNumber"/></label>
				          		</div>
				      		</div>
						</div>
						<div class="add-more-row add-more-prod"><span class="add-icon">+</span><fmt:message key="dsr.form.addAnotherProductName"/></div>
					</div>
					<div class="field-group additional-data additional-product-row clearfix hide">
				  		<div class="field">
				       		<div class="text">
				           		<dsp:input iclass="requiredField move-label" id="productName2" name="productName2" type="text" bean="ContactUSFormHandler.requestForm.productName2" />
				           		<label for="productName2"><fmt:message key="dsr.form.productName"/></label>
				        	</div>
				     	</div>
				    	<div class="field">
				        	<div class="text">
				          		<dsp:input iclass="move-label" id="serialNumber2" name="serialNumber2" type="text" bean="ContactUSFormHandler.requestForm.serialNumber2" />
				          		<label for="serialNumber2"><fmt:message key="dsr.form.aliNumber"/></label>
				          	</div>
				      	</div>
				 	</div>
				 	<div>
				 		<div class="add-more-row additional-product-row second-add-more-product add-more-prod hide"><span class="add-icon">+</span><fmt:message key="dsr.form.addAnotherProductName"/></div>
					</div>
			      	<div class="field-group additional-data additional-product-row clearfix hide">
			        	<div class="field">
			          		<div class="text">
			            		<dsp:input iclass="requiredField move-label" id="productName3" name="productName3" type="text"  bean="ContactUSFormHandler.requestForm.productName3" />
			            		<label for="productName3"><fmt:message key="dsr.form.productName"/></label>
			          		</div>
			         	</div>
			          	<div class="field">
			          		<div class="text">
			           			<dsp:input iclass="move-label" id="serialNumber3" name="serialNumber3" type="text" bean="ContactUSFormHandler.requestForm.serialNumber3" />
			             		<label for="serialNumber3"><fmt:message key="dsr.form.aliNumber"/></label>
			          		</div>
			    		</div>
			  		</div>
	              	<div class="delete-confirmation-container hide">
				       	<h3><fmt:message key="dsr.form.secondVerificaton"/></h3>
				     	<p><fmt:message key="dsr.form.deleteConfirmation"/></p>
				       	<div class="text additional-data">
							<dsp:input iclass="requiredField move-label" id="delete" name="delete" type="text" bean="ContactUSFormHandler.requestForm.delete" maxlength="8" />
				           	<label for="delete">"<fmt:message key="dsr.form.delete"/>"</label>
						</div>
					</div>
					
					<h3 class="additional-info"><fmt:message key="dsr.form.additionalInfo"/> (<fmt:message key="dsr.form.additionalInfo.more"/>)</h3>
					<div class="text textarea additional-data">
                    	<dsp:textarea iclass="move-label" name="comments" id="comments" bean="ContactUSFormHandler.requestForm.comments" />
                    	<label for="comments"><fmt:message key="dsr.form.additionalInfo.details"/></label>
                   		<p class="characterLimitWarning"><span class="characterLimit">254</span> Characters Remaining</p>
                 	</div>
					
					<div class="captcha">
                   		<p><fmt:message key="dsr.form.verificationNumber"/></p>
                       	<img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha">
                  	</div>
                  	<div class="text verification-num">
                    	<input class="requiredField move-label" id="verficationNum" name="verficationNum" type="text" />
                   		<label for="verficationNum"><fmt:message key="dsr.form.verificationNumber"/><sup>*</sup></label>
                	</div>
                	
                	<div class="custom-checkbox text legal-consent">
                  		<dsp:input type="checkbox" id="legal-consent" name="legalConsent" value="Yes" bean="ContactUSFormHandler.requestForm.legalStr" />
                   		<label for="legal-consent"><fmt:message key="dsr.form.legal"/></label>
                 	</div>
                 	
					<div>
                   		<dsp:input type="hidden" bean="ContactUSFormHandler.errorUrl" value="${pageContext.request.contextPath}/content/CustomerCare/dsr?success=false"/>
                   		<dsp:input type="hidden" bean="ContactUSFormHandler.successUrl" value="${pageContext.request.contextPath}/content/CustomerCare/dsr?success=true"/>
                  		<dsp:input type="submit" iclass="button primary-btn" value="${formSubmitButton}" name="dsrFormSubmit" id="dsrFormSubmit" bean="ContactUSFormHandler.requestContactForm" />
                	</div>
				</dsp:form>
			</section>
		</section>
	</jsp:body>
</dsp:page>