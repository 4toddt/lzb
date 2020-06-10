<%--
	- File Name: free-swatches.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the swatches page
	- Parameters:
	-
--%>


<dsp:page>
	
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
    <dsp:importbean bean="/com/lzb/catalogOrder/CatalogOrderFormHandler" />
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
	<dsp:getvalueof bean="CatalogOrderFormHandler.formError" var="formError" />
    <dsp:getvalueof var="freeSwatchContextPath" bean="/com/lzb/feed/swatch/manager/LZBFreeSwatchReqFeedMgr.jspContextPath" />

    <div id="freeSwatchesContainer">
    
    	<dsp:droplet name="InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/Shared/Responsive Content/Free Swatches Page/FS Top Content" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<c:forEach var="content" items="${element.contents}">
					<dsp:renderContentItem contentItem="${content}" />
				</c:forEach>
			</dsp:oparam>
			<dsp:oparam name="error">
			</dsp:oparam>
		</dsp:droplet>

        <section>
            <label class="error hide" id="swatchLimitMessage">Maximum 3 Swatches Allowed</label>
            <dsp:form method="post" name="freeswatch" action="${freeSwatchContextPath}" id="freeswatchForm" formid="freeswatchForm" iclass="elq-form freeswatchForm" data-validate>
				<%-- GROUP SWATCHES --%>
				<div class="group-swatches">
					<div class="swatch-heading">
						<h2><fmt:message key="freeSwatches.group.heading" /></h2>
						<p><fmt:message key="freeSwatches.group.description" /></p>
					</div>

					<div class="swatches-list">
						<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
							<dsp:param name="queryRQL" value="enabled = true AND (isSingleSwatch is null or isSingleSwatch = false)" />
							<dsp:param name="repository" bean="/atg/commerce/catalog/ProductCatalog" />
							<dsp:param name="itemDescriptor" value="freeSwatchGroup" />
							<dsp:param name="sortProperties" value="+sortOrder" />
							<dsp:param name="elementName" value="freeSwatch" />
							<dsp:oparam name="output">
								<dsp:getvalueof param='freeSwatch.title' var="fswTitle" />
								<dsp:getvalueof param='freeSwatch.imageUrl' var="fswImageUrl" />
								<dsp:getvalueof param='freeSwatch.imageAltText' var="fswImageText" />
								<dsp:getvalueof param='freeSwatch.id' var="fswArchwayId" />
								<dsp:getvalueof param='count' var="fswCount" />

								<div class="swatch-item">
									<div class="swatch-title">
										<h3>${fswTitle}</h3>
									</div>
									<div class="swatch-thumbnail">
										<c:url value="/sitewide/ajax/imageModal.jsp" var="modalUrl">
											<c:param name="title" value="${fswTitle}" />
											<c:param name="imageURL" value="${fswImageUrl}" />
											<c:param name="imageAlt" value="${fswImageText}" />
										</c:url>
										<a href="${modalUrl}" class="modal-trigger" data-dismiss="modal" data-target="swatch-modal" data-size="medium" aria-label="${fswImageText}">
											<img src="${fswImageUrl}" alt="${fswImageText}">
										</a>
									</div>
									<div class="swatch-checkbox custom-checkbox">
										<dsp:input type="checkbox" name="freeSwatchGroup" id="swatchGroup${fswCount}" value="${fswArchwayId}" bean="CatalogOrderFormHandler.freeSwatchGroup" />
										<label for="swatchGroup${fswCount}"><fmt:message key="freeSwatches.swatchLabel.group" /></label>
									</div>
								</div>
							</dsp:oparam>
						</dsp:droplet>
					</div>
                </div>

				<%-- SINGLE SWATCHES --%>
				<div class="single-swatches">
					<div class="swatch-heading">
						<h2><fmt:message key="freeSwatches.singles.heading" /></h2>
						<p><fmt:message key="freeSwatches.singles.description" /></p>
					</div>

					<div id="swatch-search">
						<fmt:message key="freeSwatches.singles.searchLabel" var="singlesSearchLabel" />
						<label for="swatch-search-field">${singlesSearchLabel}</label>
						<input type="text" id="swatch-search-field" name="swatch-search-field" placeholder="${singlesSearchLabel}" />
						<button type="button" class="btn-swatch-search"><span class="sr-only"><fmt:message key="freeSwatches.singles.searchButton" /></span><span class="icon icon-search" aria-hidden="true"></span></button>
					</div>

					<p class="swatch-search-no-results"><fmt:message key="freeSwatches.singles.searchNoResults" /></p>

					<div class="swatches-list">
						<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
							<dsp:param name="queryRQL" value="enabled = true AND isSingleSwatch = true" />
							<dsp:param name="repository" bean="/atg/commerce/catalog/ProductCatalog" />
							<dsp:param name="itemDescriptor" value="freeSwatchGroup" />
							<dsp:param name="sortProperties" value="+sortOrder" />
							<dsp:oparam name="outputStart">
							</dsp:oparam>
							<dsp:oparam name="output">
								<dsp:getvalueof param='element.title' var="fswTitle" />
								<dsp:getvalueof param='element.imageUrl' var="fswImageUrl" />
								<dsp:getvalueof param='element.imageAltText' var="fswImageText" />
								<dsp:getvalueof param='element.id' var="fswArchwayId" />
								<dsp:getvalueof param='element.keywords' var="keywords" />
								<dsp:getvalueof param='count' var="fswCount" />

								<div class="swatch-item" data-name="${fswTitle}" data-sku="${fswArchwayId}" data-keywords="${keywords}">
									<div class="swatch-title">
										<h3>${fswTitle}</h3>
									</div>
									<div class="swatch-thumbnail">
										<c:url value="/sitewide/ajax/imageModal.jsp" var="modalUrl">
											<c:param name="title" value="${fswTitle}" />
											<c:param name="imageURL" value="${fswImageUrl}" />
											<c:param name="imageAlt" value="${fswImageText}" />
										</c:url>
										<a href="${modalUrl}" class="modal-trigger" data-dismiss="modal" data-target="swatch-modal" data-size="medium" aria-label="${fswImageText}">
											<img src="${fswImageUrl}" alt="${fswImageText}">
										</a>
									</div>
									<div class="swatch-checkbox custom-checkbox">
										<dsp:input type="checkbox" name="freeSwatchGroup" id="swatchSingle${fswCount}" value="${fswArchwayId}" bean="CatalogOrderFormHandler.freeSwatchGroup" />
										<label for="swatchSingle${fswCount}"><fmt:message key="freeSwatches.swatchLabel.single" /></label>
									</div>
								</div>
							</dsp:oparam>
							<dsp:oparam name="outputEnd">
							</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>

				<div class="client-data">
					<div class="swatch-heading">
						<h2><fmt:message key="freeSwatches.form.heading" /></h2>
					</div>
	                <div class="field-group">
	                	<fmt:message  var="firstName" key="freeSwatches.firstName"/>
	               		<dsp:input iclass="move-label" id="firstName" name="firstName" type="text" data-validation="required name" autocapitalize="off" data-fieldname="First Name" aria-required="true" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.firstName"/>
	                    <label for="firstName" class="sr-only">${firstName}</label>
	               	</div>
	               	<div class="field-group">
	               		<fmt:message  var="lastName" key="freeSwatches.lastName"/>
	               		<dsp:input iclass="requiredField move-label" id="lastName" name="lastName" type="text" data-validation="required name" autocapitalize="off" data-fieldname="Last Name" aria-required="true" beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.lastName"/>
	                    <label for="lastName" class="sr-only">${lastName}</label>
	               	</div>
		           	<div class="field-group">
		           		<fmt:message  var="phoneNum" key="freeSwatches.phoneNumberOptional"/>
		               	<dsp:input iclass="move-label phone" id="homePhone1" name="homePhone1" type="tel" data-validation="usphone" autocapitalize="off" data-fieldname="Phone Number" beanvalue="CatalogOrderFormHandler.profileValueMap.phoneNumber" bean="CatalogOrderFormHandler.profileValueMap.phoneNumber" />
	                    <label for="homePhone1" class="sr-only">${phoneNum}</label>
		           	</div>
	               	<div class="field-group">
	               		<fmt:message  var="email" key="freeSwatches.emailAddress"/>
	                	<dsp:input iclass="requiredField move-label" id="emailAddress" name="emailAddress" type="text" data-validation="required email" aria-required="true" autocapitalize="off" data-fieldname="Email" beanvalue="CatalogOrderFormHandler.profileValueMap.emailAddress" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.emailAddress"/>
	                    <label for="emailAddress" class="sr-only">${email}</label>
	                </div>
	               	<div class="field-group">
	               		<fmt:message  var="address1" key="freeSwatches.streetAddress"/>
	                	<dsp:input iclass="requiredField move-label" id="address1" name="address1" type="text" data-validation="required address" aria-required="true" autocapitalize="off" data-fieldname="Address1" beanvalue="CatalogOrderFormHandler.profileValueMap.street" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.street"/>
	                    <label for="address1" class="sr-only">${address1}</label>
	               	</div>
	                <div class="field-group">
	                	<fmt:message  var="address2" key="freeSwatches.addressOptional"/>
	                   	<dsp:input iclass="move-label" id="address2" name="address2" type="text" data-validation="address" autocapitalize="off" data-fieldname="Address2" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.aptNo"/>
	                    <label for="address2" class="sr-only">${address2}</label>
	               	</div>
	                <div class="field-group">
	                    <fmt:message  var="city" key="freeSwatches.city"/>
	                    <dsp:input iclass="requiredField move-label" id="city" name="city" type="text" data-validation="required alphaspace" aria-required="true" autocapitalize="off" data-fieldname="City" beanvalue="CatalogOrderFormHandler.profileValueMap.city" maxlength="40" bean="CatalogOrderFormHandler.profileValueMap.city"/>
	                    <label for="city" class="sr-only">${city}</label>
					</div>
	                <div class="field-group dropdown-arrow">
	                    <fmt:message  var="stateProv" key="freeSwatches.stateProv"/>
	                    <dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
	                    <dsp:getvalueof var="country" bean="CatalogOrderFormHandler.profileValueMap.country" />
	                    <dsp:param name="statePicker" bean="CatalogOrderFormHandler.profileValueMap.state" />
						<dsp:select bean="CatalogOrderFormHandler.profileValueMap.state" iclass="move-label" data-validation="required" aria-required="true" data-fieldname="State/Province" id="atg_store_stateSelect" name="stateProv" placeholder="${stateProv}" nodefault="true">
							<dsp:option value=""></dsp:option>
							<c:forEach items="${countryStateMap}" var="entry">
								<c:forEach items="${entry.value}" var="state">
									<dsp:option value="${state}"><fmt:message key="state.${state}"/></dsp:option>
								</c:forEach>
							</c:forEach>
						</dsp:select>
	                    <label for="atg_store_stateSelect" class="sr-only">${stateProv}</label>
					</div>
	                <div class="field-group">
	                	<fmt:message  var="postalCode" key="freeSwatches.postalCode"/>
	                    <dsp:input iclass="requiredField move-label" type="text" id="zipPostal" name="zipPostal" data-validation="required usorcapostal" aria-required="true" autocapitalize="off" data-fieldname="Postal Code" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" maxlength="10" bean="CatalogOrderFormHandler.profileValueMap.zipCode" />
	                    <label for="zipPostal" class="sr-only">${postalCode}</label>
	                </div>
	                <div class="field-group">
                   		<p><fmt:message var="verificationLabel" key="freeSwatches.verificationNumber"/></p>
                       	<img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha" name="captcha">
                  	</div>
                  	<div class="field-group">
                    	<dsp:input iclass="move-label" id="verficationNum" name="verficationNum" type="text" data-validation="required" aria-required="true" beanvalue="CatalogOrderFormHandler.captchaImageNumber" bean="CatalogOrderFormHandler.captchaImageNumber" >
                    	  	<dsp:tagAttribute name="data-fieldName" value="${verificationLabel}"/>
	             		</dsp:input>
                   		<label for="verficationNum">${verificationLabel}<span class="required-label"><sup>*</sup></span></label>
                	</div>
	                <div class="field-group custom-checkbox">
	                	<dsp:input type="checkbox" id="emailOptIn1" name="emailOptIn1" bean="CatalogOrderFormHandler.checkedPromotionalEmail" value="on" />
	                    <label for="emailOptIn1"><fmt:message key="freeSwatches.emailOptInMsg"/></label>
	                </div>

	                <div class="field-group">
	                   	<dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="${contextPath}/contactus/json/swatchSuccess.jsp" />
	                   	<dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="${contextPath}/contactus/json/swatchError.jsp" />
	                   	<fmt:message key="freeSwatches.submit" var="freeSwatchesSubmitText" />
	                   	<dsp:input type="submit" id="sendSwatches" iclass="swatchSubmitter button primary disabled" value="${freeSwatchesSubmitText}" bean="CatalogOrderFormHandler.freeSwatchesRequest" name="formSubmitter" />
	               </div>
			   </div>

				<input type="hidden" name="elqFormName" value="freeswatch">
                <input type="hidden" name="elqSiteID" value="20103530">
                <input type="hidden" name="elqCustomerGUID" value="">
                <input type="hidden" name="elqCookieWrite" value="0">
            </dsp:form>
        </section>

		<dsp:droplet name="InvokeAssembler">
			<dsp:param name="contentCollection" value="/content/Shared/Responsive Content/Free Swatches Page/FS Bottom Content" />
			<dsp:param name="includePath" value="" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="element" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
				<c:forEach var="content" items="${element.contents}">
					<dsp:renderContentItem contentItem="${content}" />
				</c:forEach>
			</dsp:oparam>
			<dsp:oparam name="error">
			</dsp:oparam>
		</dsp:droplet>
    </div>
</dsp:page>