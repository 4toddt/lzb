<dsp:page>
	<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	
	<dsp:getvalueof var="successMsg" param="success"/>
	
	<fmt:message var="firstNameLabel" key="dsr.form.firstName"/>
	<fmt:message var="lastNameLabel" key="dsr.form.lastName"/>
	<fmt:message var="emailLabel" key="dsr.form.emailAddress"/>
	<fmt:message var="addressLabel" key="dsr.form.address"/>
	<fmt:message var="cityLabel" key="dsr.form.city"/>
	<fmt:message var="stateLabel" key="dsr.form.state"/>
	<fmt:message var="zipLabel" key="dsr.form.zipCode"/>
	<fmt:message var="phoneLabel" key="dsr.form.phone"/>
	<fmt:message var="formSubmitButton" key="dsr.form.submit"/>
	
	<div class="dsr-content">
		<div class="floating-label-form">
			<c:if test="${successMsg}">
				<div class="alert-box success" role="alert">
					<p class="alert-message">
						<fmt:message key="dsr.form.thankyouText" />
					</p>
				</div>
			</c:if>
		
			<%-- Error messages via Mustache template --%>
			<dsp:include page="/global/includes/errors.jsp">
				<dsp:param name="formHandler" bean="ContactUSFormHandler" />
			</dsp:include>
		
			<dsp:form name="dsrForm" id="dsrForm" formid="dsrForm" data-validate method="post">
				<p class="details-text"><fmt:message key="dsr.form.instructions"/></p>
			
				<p class="required-key"><sup>*</sup><fmt:message key="dsr.form.requiredField"/><br/><fmt:message key="dsr.form.emailOrPhone"/></p>
				
				<h2><fmt:message key="dsr.form.basicInfo"/></h2>
				
				<div class="field-group">
	          		<div>
		          		<dsp:input iclass="move-label" type="text" id="fName" name="fName" maxlength="40" beanvalue="ContactUSFormHandler.requestForm.firstName" bean="ContactUSFormHandler.requestForm.firstName">
		          			<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
				         	<dsp:tagAttribute name="aria-required" value="true"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${firstNameLabel}"/>
		          		</dsp:input>
		          		<label for="fName" class="sr-only">${firstNameLabel}<span class="required-label"><sup>*</sup></span></label>
	          		</div>
	            </div>  
	            
	            <div class="field-group">
	          		<div>
		          		<dsp:input iclass="move-label" type="text" id="lName" name="lName" maxlength="40" beanvalue="ContactUSFormHandler.requestForm.lastName" bean="ContactUSFormHandler.requestForm.lastName">
		          			<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
				         	<dsp:tagAttribute name="aria-required" value="true"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${lastNameLabel}"/>
		          		</dsp:input>
		          		<label for="lName" class="sr-only">${lastNameLabel}<span class="required-label"><sup>*</sup></span></label>
	          		</div>
	            </div> 
	            
	            <div class="field-group">
	          		<div class="optionalMandatory">
		          		<dsp:input iclass="move-label" type="email" id="email" name="email" maxlength="40" beanvalue="ContactUSFormHandler.requestForm.email" bean="ContactUSFormHandler.requestForm.email">
		          			<dsp:tagAttribute name="data-validation" value="emailOrPhoneRequired email"/>
				         	<dsp:tagAttribute name="aria-required" value="true"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${emailLabel}"/>
		          		</dsp:input>
		          		<label for="email" class="sr-only">${emailLabel}<span class="required-label"><sup>*</sup></span></label>
	          		</div>
	            </div> 
	            
	            <div class="field-group">
	          		<div>
		          		<dsp:input iclass="move-label" type="text" id="address1" name="address1" maxlength="50" beanvalue="ContactUSFormHandler.requestForm.address" bean="ContactUSFormHandler.requestForm.address">
		          			<dsp:tagAttribute name="data-validation" value="required"/>
				         	<dsp:tagAttribute name="aria-required" value="true"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${addressLabel}"/>
		          		</dsp:input>
		          		<label for="address1" class="sr-only">${addressLabel}<span class="required-label"><sup>*</sup></span></label>
	          		</div>
	            </div> 
	            
	            <div class="field-group">
	            	<div class="field">
	            		<dsp:input iclass="move-label" type="text" id="city" name="city" maxlength="30" beanvalue="ContactUSFormHandler.requestForm.city" bean="ContactUSFormHandler.requestForm.city">
							<dsp:tagAttribute name="data-validation" value="required"/>
			                <dsp:tagAttribute name="aria-required" value="true"/>
			                <dsp:tagAttribute name="autocapitalize" value="off"/>
			                <dsp:tagAttribute name="data-fieldName" value="${cityLabel}"/>
			            </dsp:input>
						<label for="city" class="sr-only">${cityLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
	              	<div class="field">
	                	<div class="custom-select">
	                		<dsp:getvalueof var="selState" bean="ContactUSFormHandler.requestForm.state" />
							<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
							<dsp:getvalueof var="countryVal" value="US" />
							
		          			<dsp:select iclass="move-label" id="stateSelect" name="stateSelect" bean="ContactUSFormHandler.requestForm.state" nodefault="true">
								<dsp:tagAttribute name="data-validation" value="required"/>
					            <dsp:tagAttribute name="aria-required" value="true"/>
					            <dsp:tagAttribute name="data-fieldName" value="${stateLabel}"/>
								<dsp:option value=""></dsp:option>
								<c:forEach items="${countryStateMap}" var="entry">
									<c:forEach items="${entry.value}" var="state">
										<c:if test="${entry.key == countryVal}">
											<dsp:option value="${state}" selected="${selState eq state}"><fmt:message key="state.${state}"/></dsp:option>
										</c:if>
									</c:forEach>
								</c:forEach>
							</dsp:select>
							<span class="icon icon-arrow-down" aria-hidden="true"></span>
							<label for="stateSelect">${stateLabel}<span class="required-label"><sup>*</sup></span></label>
						</div>
	              	</div>
	          	</div>   
	          	
	          	<div class="field-group last-row">
	            	<div class="field">
	            		<dsp:input iclass="move-label" type="text" id="postal" name="postal" maxlength="15" beanvalue="ContactUSFormHandler.requestForm.zipCode" bean="ContactUSFormHandler.requestForm.zipCode">
							<dsp:tagAttribute name="data-validation" value="required uspostal"/>
			                <dsp:tagAttribute name="aria-required" value="true"/>
			                <dsp:tagAttribute name="autocapitalize" value="off"/>
			                <dsp:tagAttribute name="data-fieldName" value="${zipLabel}"/>
			            </dsp:input>
						<label for="postal" class="sr-only">${zipLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
	              	<div class="field optionalMandatory">
	              		<dsp:input iclass="phone move-label" type="tel" id="phoneNumber" name="phoneNumber" maxlength="15" beanvalue="ContactUSFormHandler.requestForm.phone" bean="ContactUSFormHandler.requestForm.phone">
							<dsp:tagAttribute name="data-validation" value="emailOrPhoneRequired phone"/>
			                <dsp:tagAttribute name="aria-required" value="true"/>
			                <dsp:tagAttribute name="data-fieldName" value="${phoneLabel}"/>
			            </dsp:input>
						<label for="phoneNumber" class="sr-only">${phoneLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
				</div>
	            
	            <h2><fmt:message key="dsr.form.typeOfRequest"/></h2>
	            <div class="field-group last-row type-of-request" tabindex="0">
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
					<h3><fmt:message key="dsr.form.accountAuthentication"/></h3>
					<p>(<fmt:message key="dsr.form.includeAccounts"/>)</p>
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
					<h3><fmt:message key="dsr.form.productAuthentication"/></h3>
					<p class="no-top-margin">(<fmt:message key="dsr.form.includeProducts"/>)</p>
					<div class="field-group additional-data">
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
				<div class="field-group additional-data additional-product-row hide">
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
				<div class="field-group additional-data additional-product-row hide">
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
				<h3 class="additional-info"><fmt:message key="dsr.form.additionalInfo"/></h3>
				<p>(<fmt:message key="dsr.form.additionalInfo.more"/>)</p>
				<div class="text textarea additional-data">
	            	<dsp:textarea iclass="move-label" name="comments" id="comments" bean="ContactUSFormHandler.requestForm.comments" />
	             	<label for="comments"><fmt:message key="dsr.form.additionalInfo.details"/></label>
	         		<p class="characterLimitWarning"><span class="characterLimit">254</span> Characters Remaining</p>
	          	</div>	
		
	            <div class="captcha captcha-container">
	            	<p><fmt:message key="dsr.form.verificationNumber"/></p>
	           		<img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha">
	         	</div>
	         	
	         	<div class="field-group">
	         		<div class="text verification-num">
	                	<input class="requiredField move-label" id="verficationNum" name="verficationNum" type="text" />
	             		<label for="verficationNum"><fmt:message key="dsr.form.verificationNumber"/><sup>*</sup></label>
	               	</div>
	        	</div>
	        	
	        	<div class="field-group custom-checkbox legal-consent">
	            	<dsp:input name="legalConsent" type="checkbox" id="legal-consent" value="Yes" bean="ContactUSFormHandler.requestForm.legalStr" />
	              	<label for="legal-consent"><fmt:message key="dsr.form.legal"/></label>
	         	</div>
	         	
	            <div class="field-group">
	         		<dsp:input type="hidden" bean="ContactUSFormHandler.errorUrl" value="${contextPath}/content/CustomerCare/dsr?success=false"/>
	             	<dsp:input type="hidden" bean="ContactUSFormHandler.successUrl" value="${contextPath}/content/CustomerCare/dsr?success=true"/>
	            	
	             	<dsp:input type="submit" iclass="button primary submit-btn" value="${formSubmitButton}" name="dsrFormSubmit" id="dsrFormSubmit" bean="ContactUSFormHandler.requestContactForm" />
				</div>
			</dsp:form>
		</div>
	</div>
</dsp:page>