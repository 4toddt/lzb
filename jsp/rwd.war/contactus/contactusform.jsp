<%--
	- File Name: contactusform.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the Contact Us page
	- Parameters:
	-
--%>


<dsp:page>
	<dsp:importbean bean="/com/lzb/contactus/ContactUSFormHandler"/>
    <dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />
	
	<fmt:message var="categoryLabel" key="common.category"/>
	<fmt:message var="subCategoryLabel" key="common.subCategory"/>
	<fmt:message var="firstNameLabel" key="contactus.form.firstName"/>
	<fmt:message var="lastNameLabel" key="contactus.form.lastName"/>
	<fmt:message var="cityLabel" key="contactus.form.city"/>
	<fmt:message var="stateLabel" key="contactus.form.state"/>
	<fmt:message var="zipLabel" key="contactus.form.zip"/>
	<fmt:message var="countryLabel" key="contactus.form.country"/>
	<fmt:message var="emailLabel" key="contactus.form.email"/>
	<fmt:message var="phoneLabel" key="contactus.form.phone"/>
	<fmt:message var="commentLabel" key="contactus.form.comments"/>
	<fmt:message var="verificationLabel" key="contactus.form.verificationText"/>
	<fmt:message var="generalPhoneNum" key="contactus.phonenumber.general"/>
    <fmt:message var="formSubmitButton" key="contactus.form.submitButton"/>
    <fmt:message var="outdoorFurniturePhoneNum" key="contactus.phonenumber.outdoorFurniture"/>
    <fmt:message var="officeFurniturePhoneNum" key="contactus.phonenumber.officeFurniture"/>
    
    <dsp:getvalueof var="successFlag" param="success" />
    
    <dsp:getvalueof var="countryVal" param="countryCode" />
	
	<c:if test="${empty countryVal}">
		<dsp:getvalueof var="countryVal" value="US" />
	</c:if>
    
	<div class="contact-us-content">
		<div class="floating-label-form">
		<c:if test="${successFlag}">
			<div class="alert-box success" role="alert">
				<p class="alert-message">
					<fmt:message key="contactus.form.successMsg" />
				</p>
			</div>
		</c:if>
		
		<%-- Error messages via Mustache template --%>
		<div class="error-box">
		</div>
		
		<p class="details-text"><fmt:message key="contactus.pageDescription"/> <a href="tel:+${generalPhoneNum}">${generalPhoneNum}</a>.</p>
		
		<p class="required-key"><sup>*</sup><fmt:message key="contactus.form.required"/></p>
		<dsp:form name="contactusForm" id="contactusForm" formid="contactusForm" data-validate method="post">  
			<div class="field-group">
				<div class="custom-select">
					<dsp:select iclass="move-label" id="category" name="category" bean="ContactUSFormHandler.valueMap.contactUsCategory" nodefault="true">
		                <dsp:tagAttribute name="data-validation" value="required"/>
			            <dsp:tagAttribute name="aria-required" value="true"/>
			            <dsp:tagAttribute name="data-fieldName" value="${categoryLabel}"/>
		                <dsp:droplet name="RQLQueryForEach">
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
		                 	<c:if test="${not empty contactUsCatItem}">
		                    	<dsp:option value="${contactUsCatItem.id}">${contactUsCatItem.name}</dsp:option>
		                 	</c:if>
		           		</dsp:oparam>
		             	</dsp:droplet>
	         		</dsp:select>
	              	<span class="icon icon-arrow-down" aria-hidden="true"></span>
	              	<label for="category">${categoryLabel}<span class="required-label"><sup>*</sup></span></label>
              	</div>
			</div>             
			
			<div class="field-group">
				<div class="custom-select disabled">
					<c:if test="${not empty contactUsCatItem}">
						<dsp:select iclass="move-label" id="subCategory" name="subCategory" bean="ContactUSFormHandler.valueMap.contactUsSubCategory" nodefault="true" disabled="true">
			            	<dsp:tagAttribute name="data-validation" value="required"/>
			            	<dsp:tagAttribute name="aria-required" value="true"/>
			            	<dsp:tagAttribute name="data-fieldName" value="${subCategoryLabel}"/>
			            	<dsp:option value=""></dsp:option>
                     		<dsp:getvalueof value="${contactUsCatItem}" var="contactUsCatItem"/>
                    		<c:forEach items="${contactUsCatItem.contactUsSubCategories}" var="contactUsSubCategory">
                             	<dsp:option value="${fn:trim(contactUsSubCategory.id)}">${contactUsSubCategory.name}</dsp:option>
                            </c:forEach>
                      	</dsp:select>
                 		<span class="icon icon-arrow-down" aria-hidden="true"></span>
                 		<label for="subCategory">${subCategoryLabel}<span class="required-label"><sup>*</sup></span></label>
                  	</c:if>     
				</div>
			</div>  
	
			<div class="field-group">
            	<div class="field">
            		<dsp:input iclass="move-label eloquaFormField" type="text" id="fName" name="fName" maxlength="40" beanvalue="ContactUSFormHandler.valueMap.firstName" bean="ContactUSFormHandler.valueMap.firstName">
						<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
		                <dsp:tagAttribute name="aria-required" value="true"/>
		                <dsp:tagAttribute name="autocapitalize" value="off"/>
		                <dsp:tagAttribute name="data-fieldName" value="${firstNameLabel}"/>
		            </dsp:input>
					<label for="fName" class="sr-only">${firstNameLabel}<span class="required-label"><sup>*</sup></span></label>
              	</div>
              	<div class="field">
                	<dsp:input iclass="move-label eloquaFormField" type="text" id="lName" name="lName" maxlength="40" beanvalue="ContactUSFormHandler.valueMap.lastName" bean="ContactUSFormHandler.valueMap.lastName">
                 		<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
		                <dsp:tagAttribute name="aria-required" value="true"/>
		                <dsp:tagAttribute name="autocapitalize" value="off"/>
		                <dsp:tagAttribute name="data-fieldName" value="${lastNameLabel}"/>
		           	</dsp:input>
                 	<label for="lName">${lastNameLabel}<span class="required-label"><sup>*</sup></span></label>
              	</div>
          	</div>      
          	
          	<div class="field-group">
          		<div>
	          		<dsp:input iclass="move-label eloquaFormField" type="text" id="address1" name="address1" maxlength="50" beanvalue="ContactUSFormHandler.valueMap.address1" bean="ContactUSFormHandler.valueMap.address1">
	          			<dsp:tagAttribute name="data-validation" value="required"/>
			         	<dsp:tagAttribute name="aria-required" value="true"/>
			         	<dsp:tagAttribute name="autocapitalize" value="off"/>
			          	<dsp:tagAttribute name="data-fieldName" value="Address 1"/>
	          		</dsp:input>
	          		<label for="address1"><fmt:message key="contactus.form.address"/><span class="required-label"><sup>*</sup></span></label> 
          		</div>
            </div>  
            
            <div class="field-group">
            	<div>
	          		<dsp:input iclass="move-label eloquaFormField" type="text" id="address2" name="address2" maxlength="50" beanvalue="ContactUSFormHandler.valueMap.address2" bean="ContactUSFormHandler.valueMap.address2">
	          			<dsp:tagAttribute name="autocapitalize" value="off"/>
			          	<dsp:tagAttribute name="data-fieldName" value="Address 2"/>
	          		</dsp:input>
	          		<label for="address2"><fmt:message key="contactus.form.address2"/></label> 
	          	</div>
            </div>        
            
            <div class="field-group">
				<div class="field">
					<dsp:input iclass="move-label eloquaFormField" type="text" id="city" name="city" maxlength="30" beanvalue="ContactUSFormHandler.valueMap.city" bean="ContactUSFormHandler.valueMap.city">
						<dsp:tagAttribute name="data-validation" value="required"/>
		         		<dsp:tagAttribute name="aria-required" value="true"/>
		         		<dsp:tagAttribute name="autocapitalize" value="off"/>
		          		<dsp:tagAttribute name="data-fieldName" value="${cityLabel}"/>
					</dsp:input>
              		<label for="city">${cityLabel}<span class="required-label"><sup>*</sup></span></label>
				</div>
				<div class="field">
					<div class="custom-select">
						<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
						
	          			<dsp:select iclass="move-label eloquaFormField" id="atg_store_stateSelect" name="atg_store_stateSelect" bean="ContactUSFormHandler.valueMap.state" nodefault="true">
							<dsp:tagAttribute name="data-validation" value="required"/>
				            <dsp:tagAttribute name="aria-required" value="true"/>
				            <dsp:tagAttribute name="data-fieldName" value="${stateLabel}"/>
							<dsp:option value=""></dsp:option>
							<c:forEach items="${countryStateMap}" var="entry">
								<c:forEach items="${entry.value}" var="state">
									<c:if test="${entry.key == countryVal}">
										<dsp:option value="${state}"><fmt:message key="state.${state}"/></dsp:option>
									</c:if>
								</c:forEach>
							</c:forEach>
						</dsp:select>
						<span class="icon icon-arrow-down" aria-hidden="true"></span>
						<label for="atg_store_stateSelect">${stateLabel}<span class="required-label"><sup>*</sup></span></label>
					</div>
				</div>
			</div>               
			
			<div class="field-group">
				<div class="field">
					<dsp:input iclass="move-label eloquaFormField" type="text" id="postal" name="postal" maxlength="15" beanvalue="ContactUSFormHandler.valueMap.zipCode" bean="ContactUSFormHandler.valueMap.zipCode">
						<dsp:tagAttribute name="data-validation" value="required usorcapostal"/>
		         		<dsp:tagAttribute name="aria-required" value="true"/>
		         		<dsp:tagAttribute name="autocapitalize" value="off"/>
		          		<dsp:tagAttribute name="data-fieldName" value="${zipLabel}"/>
					</dsp:input>
              		<label for="postal">${zipLabel}<span class="required-label"><sup>*</sup></span></label>
              	</div>
				<div class="field">
					<div class="custom-select">
                    	<dsp:select iclass="move-label eloquaFormField" id="selCountry" name="selCountry" bean="ContactUSFormHandler.valueMap.country" nodefault="true">
							<dsp:tagAttribute name="data-validation" value="required"/>
				      		<dsp:tagAttribute name="aria-required" value="true"/>
				      		<dsp:tagAttribute name="data-fieldName" value="${countryLabel}"/>
							<%@include file="/sitewide/includes/countryList.jsp" %>
						</dsp:select>
                        <span class="icon icon-arrow-down" aria-hidden="true"></span>
                        <label for="selCountry" class="hidden-label sr-only">${countryLabel}<span class="required-label"><sup>*</sup></span></label>
					</div>
				</div>
			</div>   
			
			<div class="field-group">
				<div>
	          		<dsp:input iclass="move-label eloquaFormField" type="email" id="email" name="email" maxlength="40" beanvalue="ContactUSFormHandler.valueMap.email" bean="ContactUSFormHandler.valueMap.email">
	          			<dsp:tagAttribute name="data-validation" value="required email"/>
			         	<dsp:tagAttribute name="aria-required" value="true"/>
			         	<dsp:tagAttribute name="autocapitalize" value="off"/>
			          	<dsp:tagAttribute name="data-fieldName" value="${emailLabel}"/>
	          		</dsp:input>
	          		<label for="email">${emailLabel}<span class="required-label"><sup>*</sup></span></label> 
	          	</div>
            </div> 
            
            <div class="field-group">
            	<div>
	            	<dsp:input iclass="phone move-label eloquaFormField" type="tel" id="phoneNumber" name="phoneNumber" beanvalue="ContactUSFormHandler.valueMap.phoneNumber" bean="ContactUSFormHandler.valueMap.phoneNumber">
	              		<dsp:tagAttribute name="data-validation" value="usphone"/>
			         	<dsp:tagAttribute name="data-fieldName" value="${phoneLabel}"/>
			        </dsp:input>
	              	<label for="phoneNumber">${phoneLabel}</label>
	       		</div>
            </div>
            
            <div class="field-group comments-textarea">
            	<div>
	            	<dsp:textarea iclass="move-label comments-box" type="text" id="comments" name="comments" bean="ContactUSFormHandler.valueMap.comments" />
	              	<label for="comments">${commentLabel}</label>
	           		<p class="characterLimitWarning"><span class="characterLimit">254</span> Characters Remaining</p>
	           	</div>
            </div>
            
            <%-- additional fields based on selected Category and Subcategory values--%>
            <div class="field-group hide">
            	<div class="cust-supp-add cust-supp-hidden" data-return="Acknowledgment Number">
                	<dsp:input iclass="move-label" id="acknowledgementNumber" name="acknowledgementNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.acknowledgmentNumber" bean="ContactUSFormHandler.valueMap.acknowledgmentNumber" />
               		<label for="acknowledgementNumber"><fmt:message key="contactus.form.acknowledgmentNumber"/></label>
            	</div>
            </div>
            <div class="field-group hide">
            	<div class="cust-supp-add cust-supp-hidden" data-return="Style Number">
               		<dsp:input iclass="move-label" id="styleNumber" name="styleNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.styleNumber" bean="ContactUSFormHandler.valueMap.styleNumber" />
                	<label for="styleNumber"><fmt:message key="contactus.form.styleNumber"/></label>
            	</div>
        	</div>
          	<div class="field-group hide">
           		<div class="cust-supp-add cust-supp-hidden" data-return="Cover Number">
               		<dsp:input iclass="move-label" id="coverNumber" name="coverNumber" type="text" beanvalue="ContactUSFormHandler.valueMap.coverNumber" bean="ContactUSFormHandler.valueMap.coverNumber" />
               		<label for="coverNumber"><fmt:message key="contactus.form.coverNumber"/></label>
           		</div>
       		</div>
          	<div class="field-group hide">
            	<div class="cust-supp-add cust-supp-hidden" data-return="Date of Delivery">
              		<dsp:input iclass="move-label" id="dateOfDelivery" name="dateOfDelivery" type="text" beanvalue="ContactUSFormHandler.valueMap.dateOfDelivery" bean="ContactUSFormHandler.valueMap.dateOfDelivery" />
          			<label for="dateOfDelivery"><fmt:message key="contactus.form.dateofDelivery"/></label>
           		</div>
           	</div>
           	<div class="field-group hide">
            	<div class="cust-supp-add cust-supp-hidden" data-return="Name of Dealer Purchased From">
                	<dsp:input iclass="move-label" id="dealerName" name="dealerName" type="text" beanvalue="ContactUSFormHandler.valueMap.dealerName" bean="ContactUSFormHandler.valueMap.dealerCity" />
                 	<label for="dealerName"><fmt:message key="contactus.form.dealerPurchaseFrom"/></label>
           		</div>
           	</div>
           	<div class="field-group hide">
            	<div class="cust-supp-add cust-supp-hidden" data-return="Dealer City">
                	<dsp:input iclass="move-label" id="dealerCity" name="dealerCity" type="text" beanvalue="ContactUSFormHandler.valueMap.dealerCity" bean="ContactUSFormHandler.valueMap.dealerCity" />
               		<label for="dealerCity"><fmt:message key="contactus.form.dealerCity"/></label>
             	</div>  
            </div>
            
            <div class="field-group hide">
            	<div class="custom-select cust-supp-add cust-supp-hidden" data-return="Dealer State / Province">
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
                 	<span class="icon icon-arrow-down" aria-hidden="true"></span>
					<label for="stateSelect"><fmt:message key="contactus.form.dealerState"/></label>
				</div>           
            </div>
                             
            <div class="captcha captcha-container">
            	<p>${verificationLabel}</p>
           		<img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha">
         	</div>
         	
         	<div class="field-group">
         		<div>
	             	<dsp:input iclass="move-label" type="text" id="verficationNum" name="verficationNum" beanvalue="ContactUSFormHandler.valueMap.captchaImageNumber" bean="ContactUSFormHandler.valueMap.captchaImageNumber">
	             		<dsp:tagAttribute name="data-validation" value="required"/>
			         	<dsp:tagAttribute name="aria-required" value="true"/>
			          	<dsp:tagAttribute name="data-fieldName" value="${verificationLabel}"/>
	             	</dsp:input>
	           		<label for="verficationNum">${verificationLabel}<span class="required-label"><sup>*</sup></span></label>
	           	</div>
        	</div>
        	<div class="field-group custom-checkbox">
            	<dsp:input name="getEmail" type="checkbox" id="getEmail" bean="ContactUSFormHandler.sendPromotionalEmail" />
              	<label for="getEmail"><fmt:message key="contactus.form.emailOptIn"/></label>
               	<%-- Eloqua hidden email opt in field requires value "on" managed in AJAX request--%>
              	<input type="hidden" name="emailOptIn" id="emailOptIn" value="" />
         	</div>
         	
         	<div class="field-group">
         		<dsp:input type="hidden" bean="ContactUSFormHandler.errorUrl" value="${contextPath}/contactus/json/contactusError.jsp"/>
             	<dsp:input type="hidden" bean="ContactUSFormHandler.successUrl" value="${contextPath}/contactus/json/contactusSuccess.jsp"/>
            	
             	<dsp:input type="submit" iclass="button primary submit-btn" value="${formSubmitButton}" name="contactUsFormSubmit" id="contactUsFormSubmit" bean="ContactUSFormHandler.contactUS" />
				
				<a href="#" class="form-reset"><fmt:message key="contactus.form.reset"/></a>
        	</div>
	               
			<%-- Eloqua hidden form fields --%>
       		<input class="eloquaFormField" type="hidden" name="elqFormName" value="ContactUs">
          	<input class="eloquaFormField" type="hidden" name="elqSiteID" value="20103530">
         	<input class="eloquaFormField" type="hidden" name="elqCustomerGUID" value="">
          	<input class="eloquaFormField" type="hidden" name="elqCookieWrite" value="0">
        </dsp:form>
        
		<p class="thank-you-text"><fmt:message key="contactus.formThankYou"/></p>
		</div>
		
		<div class="more-info-container">
			<p class="more-info-text"><fmt:message key="contactus.moreInfo"/></p>
			
			<div class="live-help-container">
	        	<h2><fmt:message key="contactus.heading.getHelp"/></h2>
	                        
	         	<h3><fmt:message key="contactus.heading.generalInquiries"/></h3>
	          	<p class="phone-number-text"><a href="tel:+${generalPhoneNum}">${generalPhoneNum}</a></p>
	                        
	         	<h3><fmt:message key="contactus.heading.outdoorFurniture"/></h3>
	        	<p class="phone-number-text"><a href="tel:+${outdoorFurniturePhoneNum}">${outdoorFurniturePhoneNum}</a></p>
	                        
	       		<h3><fmt:message key="contactus.heading.officeFurniture"/></h3>
	         	<p class="phone-number-text"><a href="tel:+${officeFurniturePhoneNum}">${officeFurniturePhoneNum}</a></p>
	         	
	         	<a class="dsr-link" href="${contextPath}/content/CustomerCare/dsr"><h3><fmt:message key="contactus.dsrlink"/></h3></a>
            </div>
        </div>       
	</div>
</dsp:page>