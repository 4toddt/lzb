<dsp:page>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	<dsp:importbean bean="/com/lzb/catalogOrder/CatalogOrderFormHandler"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	
	<dsp:getvalueof var="formError" bean="CatalogOrderFormHandler.formError" />
	<dsp:getvalueof var="heroBannerPath" bean="LZBStoreConfiguration.npcCatalogHeroBannerPath" />
	<dsp:getvalueof var="catalogOptionImagePath" bean="LZBStoreConfiguration.npcCatalogOptionImagePath" />
	<dsp:getvalueof var="catalogOptionAlt" bean="LZBStoreConfiguration.npcCatalogOptionImageAlt" />
	<dsp:getvalueof var="viewCatalogLink" bean="LZBStoreConfiguration.npcCatalogViewCatalogLink" />
	<dsp:getvalueof var="successMsg" param="success" />
	<dsp:layeredBundle basename="com.lzb.common.WebAppResources"/>
	<fmt:message var="formSubmitButton" key="contactus.form.submitButton"/>
	
	<link href="https://cloud.typography.com/7057696/7391412/css/fonts.css" rel="stylesheet">
	
	<div class="catalog-request-content" data-module="catalog-request">
		<c:if test="${successMsg}">
			<div class="catalog-request-success-msg"><fmt:message key="catalogrequest.form.successMsg"/></div>
		</c:if>
		
		<div class="head-copy">
			<h1><fmt:message key="catalogrequest.heading.getInspired"/></h1>
			<p><fmt:message key="catalogrequest.heading.requestCatalog"/></p>
		</div>
		
		<img class="hero-banner" src="//${storeConfig.contentHostName}${heroBannerPath}"/>
		<div class="catalog-option-container">
			<div class="catalog-image">
				<img src="//${storeConfig.contentHostName}${catalogOptionImagePath}" alt="${catalogOptionAlt}">
				<p>${catalogOptionAlt}</p>
			</div>
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
		</div>
		
		<div class="floating-label-form" data-module="floating-form-labels eloqua-submit form-validate">
			<c:if test="${formError eq 'true'}">
		    	<dsp:include page="/includes/global/errors.jsp">
		         	<dsp:param name="formHandler" bean="CatalogOrderFormHandler"/>
		    	</dsp:include>
      		</c:if>
      			
			<p class="instructions">
				<span class="required-label"><sup>*</sup></span>&nbsp;<fmt:message key="catalogrequest.requiredField" />
			</p>
			<p class="instructions">
				<fmt:message key="catalogrequest.delivery" />
			</p>
			
			<dsp:form method="post" action="${pageContext.request.contextPath}/content/CustomerCare/catalogs/" name="catalogRequest" id="catalogRequest" formid="catalogRequest" >
			    <div class="field-group clearfix">
	            	<div class="field">
	            		<div class="text">
	            			<dsp:input iclass="move-label" type="text" id="firstName" name="firstName" maxlength="40" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" bean="CatalogOrderFormHandler.profileValueMap.firstName" />
							<label for="firstName"><fmt:message key="catalogrequest.form.firstName"/><sup>*</sup></label>
	              		</div>
	              	</div>
	              	<div class="field">
	              		<div class="text">
		                	<dsp:input iclass="move-label" type="text" id="lastName" name="lastName" maxlength="40" beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" bean="CatalogOrderFormHandler.profileValueMap.lastName" />
		                 	<label for="lastName"><fmt:message key="catalogrequest.form.lastName"/><sup>*</sup></label>
	              		</div>
	              	</div>
	          	</div> 
	          	
	          	<div class="field-group clearfix">
	          		<div class="field">
	          			<div class="text">
			          		<dsp:input iclass="move-label" type="text" id="address1" name="address1" maxlength="50" beanvalue="CatalogOrderFormHandler.profileValueMap.street" bean="CatalogOrderFormHandler.profileValueMap.street" />
			          		<label for="address1"><fmt:message key="catalogrequest.form.streetAddress"/><sup>*</sup></label> 
	          			</div>
	          		</div>
	            	<div class="field">
	            		<div class="text">
			          		<dsp:input iclass="move-label" type="text" id="address2" name="address2" maxlength="50" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" bean="CatalogOrderFormHandler.profileValueMap.aptNo" />
			          		<label for="address2"><fmt:message key="catalogrequest.form.apt"/></label> 
		          		</div>
		          	</div>
            	</div>   
            	
            	<div class="field-group clearfix">
					<div class="field">
						<div class="text">
							<dsp:input iclass="move-label" type="text" id="city" name="city" maxlength="30" beanvalue="CatalogOrderFormHandler.profileValueMap.city" bean="CatalogOrderFormHandler.profileValueMap.city" />
							<label for="city"><fmt:message key="catalogrequest.form.city"/><sup>*</sup></label>
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
                                    	
                      		<label class="hiddenLabel" for="state"><fmt:message key="catalogrequest.form.state"/><sup>*</sup></label>
                      		<dsp:select name="state" iclass="move-label" id="state" bean="CatalogOrderFormHandler.profileValueMap.state" nodefault="true">
                       			<dsp:option value=""><fmt:message key="common.selectState"/></dsp:option>
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
                         	<dsp:input iclass="move-label" id="postal" name="postal" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" bean="CatalogOrderFormHandler.profileValueMap.zipCode" />
                    		<label for="postal"><fmt:message key="catalogrequest.form.zip"/><sup>*</sup></label>
                   		</div>
                	</div>
                	<div class="field">
                    	<div class="text">
                      		<label class="hiddenLabel" for="selCountry"><fmt:message key="catalogrequest.form.country"/><sup>*</sup></label>
                       		<dsp:select name="selCountry" iclass="move-label" id="selCountry" bean="CatalogOrderFormHandler.profileValueMap.country" onchange='populateState(this)'>
                            	<%@include file="/includes/global/countryList.jsp" %>
                         	</dsp:select>
                     		<span class="icon-arrow-down" aria-hidden="true"></span>
                    	</div>
                	</div>
             	</div>
				<p class="instructions"><fmt:message key="catalogrequest.form.furnitureType"/><span class="required-label"><sup>*</sup></span></p>
				
				<div class="field-group text furniture-type">
					<div class="custom-radio">
						<dsp:input type="radio" value="STATIONARY" id="stationary" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook" />
						<label for="stationary"><fmt:message key="catalogrequest.form.furnitureType.stationary"/></label>
					</div>
					<div class="custom-radio">
						<dsp:input type="radio" value="RECLINER" id="recliner" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook" />
						<label for="recliner"><fmt:message key="catalogrequest.form.furnitureType.recliner"/></label>
					</div>
					<div class="custom-radio">
						<dsp:input type="radio" value="BOTH" id="both" name="styleChoice" bean="CatalogOrderFormHandler.profileValueMap.catalogBook" />
						<label for="both"><fmt:message key="catalogrequest.form.furnitureType.both"/></label>
					</div>
				</div>
				<div class="field-group custom-checkbox">
	            	<dsp:input type="checkbox" name="reciveEmail" id="reciveEmail" bean="CatalogOrderFormHandler.checkedPromotionalEmail" value="on" />
					<label><fmt:message key="catalogrequest.form.signupEmail"/></label>
	         	</div>
	            <div class="field-group email-addr clearfix">
	            	<div class="field">
						<div class="text">
							<dsp:input iclass="move-label" type="email" id="contactEmail" name="contactEmail" maxlength="40" beanvalue="CatalogOrderFormHandler.emailAddress" bean="CatalogOrderFormHandler.emailAddress" />
			          		<label for="contactEmail"><fmt:message key="catalogrequest.form.email"/></label>
			          	</div>
			    	</div>
	            </div>
	            <div class="field-group">
	         		<dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="${pageContext.request.contextPath}/content/CustomerCare/catalogs?success=true"/>
					<dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="${pageContext.request.contextPath}/content/CustomerCare/catalogs?success=false"/>
				
	             	<dsp:input type="submit" iclass="hide" value="Submit" name="formSubmitter" bean="CatalogOrderFormHandler.catalogOrder" />
               		<input type="button" class="button primary-btn" id="catalogRequestSubmit" name="catalogRequestSubmit" value="${formSubmitButton}" />
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
	
	<script>
		function populateState(countrySelect) {
			$.ajax({
                url:  '/contactus/stateList.jsp?selectedCountry=' + $(countrySelect).val(),
                type: 'GET',
                error : function(data){
                	console.log('An error occurred during state list retrieval.');
                },
                success : function(data){
                	$('#state').html(data);
                }
            });
		}
	</script>
</dsp:page>
