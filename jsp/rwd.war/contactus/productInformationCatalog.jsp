<%--
	- File Name: productInformationCatalog.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the Catalog Request page
	- Parameters:
	-
--%>

<dsp:page>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	<dsp:importbean bean="/com/lzb/catalogOrder/CatalogOrderFormHandler" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<dsp:getvalueof var="heroBannerPath" bean="LZBStoreConfiguration.npcCatalogHeroBannerPath" />
	<dsp:getvalueof var="catalogOptionImagePath" bean="LZBStoreConfiguration.npcCatalogOptionImagePath" />
	<dsp:getvalueof var="catalogOptionAlt" bean="LZBStoreConfiguration.npcCatalogOptionImageAlt" />
	<dsp:getvalueof var="viewCatalogLink" bean="LZBStoreConfiguration.npcCatalogViewCatalogLink" />
	<dsp:getvalueof var="successFlag" param="success" />
	<dsp:getvalueof var="countryVal" param="countryCode" />
	
	<c:if test="${empty countryVal}">
		<dsp:getvalueof var="countryVal" value="US" />
	</c:if>
	
	<fmt:message var="firstNameLabel" key="catalogrequest.form.firstName"/>
	<fmt:message var="lastNameLabel" key="catalogrequest.form.lastName"/>
	<fmt:message var="streetAddressLabel" key="catalogrequest.form.streetAddress"/>
	<fmt:message var="aptLabel" key="catalogrequest.form.apt"/>
	<fmt:message var="cityLabel" key="catalogrequest.form.city"/>
	<fmt:message var="stateLabel" key="catalogrequest.form.state"/>
	<fmt:message var="zipLabel" key="catalogrequest.form.zip"/>
	<fmt:message var="countryLabel" key="catalogrequest.form.country"/>
	<fmt:message var="emailLabel" key="catalogrequest.form.email"/>
	
	<link href="https://cloud.typography.com/7057696/7391412/css/fonts.css" rel="stylesheet">
	
	<div class="catalog-request-content">
		<c:if test="${successFlag}">
			<div class="alert-box success" role="alert">
				<p class="alert-message">
					<fmt:message key="catalogrequest.form.successMsg" />
				</p>
			</div>
		</c:if>
			
		<div class="head-copy">
			<h1><fmt:message key="catalogrequest.heading.getInspired"/></h1>
			<p><fmt:message key="catalogrequest.heading.requestCatalog"/></p>
		</div>
		
		<img class="hero-banner" src="//${storeConfig.contentHostName}${heroBannerPath}"/>
		<div class="catalog-option-container">
			<div class="catalog-option-content">
				<fmt:message key="catalogrequest.selectOpton"/>:
					
				<div class="field-group catalog-options">
					<div class="custom-radio">
						<input type="radio" value="print" id="print" name="catalogOptions" checked />
						<label for="print"><fmt:message key="catalogrequest.selectOption.print"/></label>
					</div>
					<div class="custom-radio">
						<input type="radio" value="digital" id="digital" name="catalogOptions" />
						<label for="digital"><fmt:message key="catalogrequest.selectOption.digital"/></label>
					</div>
				</div>
			</div>
			<div class="catalog-image">
				<img src="//${storeConfig.contentHostName}${catalogOptionImagePath}" alt="${catalogOptionAlt}">
				<p>${catalogOptionAlt}</p>
			</div>
			
		</div>
		
		<div class="floating-label-form">
			<dsp:form name="catalogRequestForm" id="catalogRequestForm" formid="catalogRequestForm" data-validate method="post">
				<p class="instructions">
					<span class="required-label"><sup>*</sup></span>&nbsp;<fmt:message key="catalogrequest.requiredField" />
				</p>
				<p class="instructions">
					<fmt:message key="catalogrequest.delivery" />
				</p>
				<div class="field-group">
	            	<div class="field">
	            		<dsp:input iclass="move-label" type="text" id="firstName" name="firstName" maxlength="40" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" bean="CatalogOrderFormHandler.profileValueMap.firstName">
							<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
			                <dsp:tagAttribute name="aria-required" value="true"/>
			                <dsp:tagAttribute name="autocapitalize" value="off"/>
			                <dsp:tagAttribute name="data-fieldName" value="${firstNameLabel}"/>
			            </dsp:input>
						<label for="firstName" class="sr-only">${firstNameLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
	              	<div class="field">
	                	<dsp:input iclass="move-label" type="text" id="lastName" name="lastName" maxlength="40" beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" bean="CatalogOrderFormHandler.profileValueMap.lastName">
	                 		<dsp:tagAttribute name="data-validation" value="required alphaspace"/>
			                <dsp:tagAttribute name="aria-required" value="true"/>
			                <dsp:tagAttribute name="autocapitalize" value="off"/>
			                <dsp:tagAttribute name="data-fieldName" value="${lastNameLabel}"/>
			           	</dsp:input>
	                 	<label for="lastName">${lastNameLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
	          	</div> 
	          	
	          	<div class="field-group">
	          		<div class="field">
		          		<dsp:input iclass="move-label" type="text" id="address1" name="address1" maxlength="50" beanvalue="CatalogOrderFormHandler.profileValueMap.street" bean="CatalogOrderFormHandler.profileValueMap.street">
		          			<dsp:tagAttribute name="data-validation" value="required"/>
				         	<dsp:tagAttribute name="aria-required" value="true"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${streetAddressLabel}"/>
		          		</dsp:input>
		          		<label for="address1">${streetAddressLabel}<span class="required-label"><sup>*</sup></span></label> 
	          		</div>
	            	<div class="field">
		          		<dsp:input iclass="move-label" type="text" id="address2" name="address2" maxlength="50" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" bean="CatalogOrderFormHandler.profileValueMap.aptNo">
		          			<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${aptLabel}"/>
		          		</dsp:input>
		          		<label for="address2">${aptLabel}</label> 
		          	</div>
            	</div>   
            	
            	<div class="field-group">
					<div class="field">
						<dsp:input iclass="move-label" type="text" id="city" name="city" maxlength="30" beanvalue="CatalogOrderFormHandler.profileValueMap.city" bean="CatalogOrderFormHandler.profileValueMap.city">
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
							
		          			<dsp:select iclass="move-label" id="stateSelect" name="stateSelect" bean="CatalogOrderFormHandler.profileValueMap.state" nodefault="true">
								<dsp:tagAttribute name="data-validation" value="required"/>
					            <dsp:tagAttribute name="aria-required" value="true"/>
					            <dsp:tagAttribute name="data-fieldName" value="${stateLabel}"/>
								<dsp:option value="">${stateLabel}*</dsp:option>
								<c:forEach items="${countryStateMap}" var="entry">
									<c:forEach items="${entry.value}" var="state">
										<c:if test="${entry.key == countryVal}">
											<dsp:option value="${state}"><fmt:message key="state.${state}"/></dsp:option>
										</c:if>
									</c:forEach>
								</c:forEach>
							</dsp:select>
							<span class="icon icon-arrow-down" aria-hidden="true"></span>
							<label for="stateSelect" class="hidden-label sr-only">${stateLabel}<span class="required-label"><sup>*</sup></span></label>
						</div>
					</div>
				</div> 
				
				<div class="field-group">
					<div class="field">
						<dsp:input iclass="move-label" type="text" id="postal" name="postal" maxlength="15" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" bean="CatalogOrderFormHandler.profileValueMap.zipCode">
							<dsp:tagAttribute name="data-validation" value="required usorcapostal"/>
			         		<dsp:tagAttribute name="aria-required" value="true"/>
			         		<dsp:tagAttribute name="autocapitalize" value="off"/>
			          		<dsp:tagAttribute name="data-fieldName" value="${zipLabel}"/>
						</dsp:input>
	              		<label for="postal">${zipLabel}<span class="required-label"><sup>*</sup></span></label>
	              	</div>
					<div class="field">
						<div class="custom-select">
	                    	<dsp:select iclass="move-label" id="countrySelect" name="countrySelect" bean="CatalogOrderFormHandler.profileValueMap.country" nodefault="true">
								<dsp:tagAttribute name="data-validation" value="required"/>
					      		<dsp:tagAttribute name="aria-required" value="true"/>
					      		<dsp:tagAttribute name="data-fieldName" value="${countryLabel}"/>
								<%@include file="/sitewide/includes/countryList.jsp" %>
							</dsp:select>
	                        <span class="icon icon-arrow-down" aria-hidden="true"></span>
	                        <label for="countrySelect" class="hidden-label sr-only">${countryLabel}<span class="required-label"><sup>*</sup></span></label>
						</div>
					</div>
				</div>     
				<p><fmt:message key="catalogrequest.form.furnitureType"/><span class="required-label"><sup>*</sup></span></p>
				<div class="field-group radio-group" data-validation="required" data-fieldName="Furniture Type" aria-required="true" name="furnitureStyle" id="furnitureStyle" tabindex="0">
					<div class="custom-radio">
						<dsp:input type="radio" value="STATIONARY" id="stationary" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook" />
						<label for="stationary"><fmt:message key="catalogrequest.form.furnitureType.stationary"/></label>
					</div>
					<div class="custom-radio">
						<dsp:input type="radio" value="RECLINER" id="recliner" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook" />
						<label for="recliner"><fmt:message key="catalogrequest.form.furnitureType.recliner"/></label>
					</div>
					<div class="custom-radio">
						<dsp:input type="radio" value="BOTH" id="both" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook">
							
				        </dsp:input>
						<label for="both"><fmt:message key="catalogrequest.form.furnitureType.both"/></label>
					</div>
				</div>
				<div class="field-group custom-checkbox">
	            	<dsp:input type="checkbox" name="reciveEmail" id="reciveEmail" bean="CatalogOrderFormHandler.checkedPromotionalEmail" value="on" />
					<label><fmt:message key="catalogrequest.form.signupEmail"/></label>
	         	</div>
	         	<div class="field-group">
					<div>
		          		<dsp:input iclass="move-label" type="email" id="contactEmail" name="contactEmail" maxlength="40" beanvalue="CatalogOrderFormHandler.emailAddress" bean="CatalogOrderFormHandler.emailAddress">
		          			<dsp:tagAttribute name="data-validation" value="email"/>
				         	<dsp:tagAttribute name="autocapitalize" value="off"/>
				          	<dsp:tagAttribute name="data-fieldName" value="${emailLabel}"/>
		          		</dsp:input>
		          		<label for="contactEmail">${emailLabel}</label>
		          	</div>
	            </div>
	            <div class="field-group">
	         		<dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="${contextPath}/contactus/json/catalogRequestError.jsp"/>
	             	<dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="${contextPath}/contactus/json/catalogRequestSuccess.jsp"/>
	            	
	             	<dsp:input type="submit" iclass="button primary submit-btn" value="Submit" name="catalogRequestSubmit" id="catalogRequestSubmit" bean="CatalogOrderFormHandler.catalogOrder" />
				</div>
	               
				<%-- Eloqua hidden form fields --%>
	       		<input type="hidden" name="elqFormName" value="catalogRequest" />
				<input type="hidden" name="elqSiteID" value="20103530" />
				<input type="hidden" name="elqCustomerGUID" value="" />
				<input type="hidden" name="elqCampaignId" />
				<input type="hidden" name="elqCookieWrite" value="0" />
				<input type="hidden" name="lead_source_original_hidden" value="Website - Catalog Request"  />
				<input type="hidden" name="hiddenField" value="Website - Catalog Request"  />
			</dsp:form>
		</div>
		
		<%-- View Catalog Button for Digital option --%>
		<a class="button primary hide" id="viewCatalogBtn" href="${viewCatalogLink}" target="_blank"><fmt:message key="catalogrequest.viewCatalog"/></a>
	</div>
</dsp:page>