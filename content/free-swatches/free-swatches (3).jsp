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
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
	<dsp:getvalueof bean="CatalogOrderFormHandler.formError" var="formError" />
    <dsp:getvalueof var="freeSwatchContextPath" bean="/com/lzb/feed/swatch/manager/LZBFreeSwatchReqFeedMgr.jspContextPath" />
    <!-- <c:set var="freeSwatchContextPath" value="/content/CustomerCare/Free-Swatches-Request"/> -->
    
    
	<link href="https://fonts.googleapis.com/css?family=Lato:400,700" rel="stylesheet">
    <div id="freeSwatchesContainer" class="freeSwatchesContainer">

        <dsp:droplet name="/atg/targeting/TargetingFirst">
            <dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/FreeSwatchesTopBanner" />
            <dsp:param name="elementName" value="element" />
            <dsp:oparam name="output">
                <dsp:getvalueof param="element" var="element" />
                <c:if test="${fn:contains(element.itemDescriptor,'media-external')}">
                    <section class="hero hidden-sm">
                        <div class="copy-overlay">
                            <div class="copy-block">
                                <h1>${element.name}</h1>
                                <hr>
                                <p>${element.description}</p>
                            </div>
                        </div>
                        <img src="https://www.la-z-boy.com/Images/npc/free-swatches/desktop/hero.jpg" alt="${element.name}" />
                    </section>
                    <section class="hero visible-sm">
                        <h1>${element.name}</h1>
                        <img src="https://www.la-z-boy.com/Images/npc/free-swatches/mobile/hero.jpg" alt="${element.name}" />
                        <p>${element.description}</p>
                    </section>
                    </a>
                </c:if>
                <c:if test="${fn:contains(element.itemDescriptor,'media-internal-text')}">
                    <a title="${element.name}" href="${actionURL}">
                        <dsp:valueof param="element.data" valueishtml="true" />
                    </a>
                </c:if>
            </dsp:oparam>
        </dsp:droplet>

        <section>
            <label class="error hide" id="swatchLimitMessage">Maximum 3 Swatches Allowed</label>
            <dsp:form method="post" name="freeswatch" action="${freeSwatchContextPath}" id="freeswatchForm" iclass="elq-form freeswatchForm" data-validate>
                <div class="swatches-list">
                    <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
                        <dsp:param name="queryRQL" value="enabled = true" />
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
                                	<label for="swatchGroup${fswCount}">Select Swatch</label>
                                </div>
                            </div>
                        </dsp:oparam>
                    </dsp:droplet>
                </div>
				
                <div class="field-group">
                	<fmt:message  var="firstName" key="freeSwatches.firstName"/>
               		<dsp:input iclass="move-label" id="firstName" name="firstName" type="text" data-validation="required name" autocapitalize="off" data-fieldname="First Name" aria-required="true" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.firstName"/>
                    <label for="firstName" class="sr-only"><fmt:message key="freeSwatches.firstName"/></label>
               	</div>
               	<div class="field-group">
               		<fmt:message  var="lastName" key="freeSwatches.lastName"/>
               		<dsp:input iclass="requiredField move-label" id="lastName" name="lastName" type="text" data-validation="required name" autocapitalize="off" data-fieldname="Last Name" aria-required="true"beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.lastName"/>
                    <label for="lastName" class="sr-only"><fmt:message key="freeSwatches.lastName"/></label>
               	</div>
	           	<div class="field-group">
	           		<fmt:message  var="phoneNum" key="freeSwatches.phoneNumberOptional"/>
	               	<dsp:input iclass="move-label phone" id="homePhone1" name="homePhone1" type="tel" data-validation="usphone" autocapitalize="off" data-fieldname="Phone Number" beanvalue="CatalogOrderFormHandler.profileValueMap.phoneNumber" bean="CatalogOrderFormHandler.profileValueMap.phoneNumber" />
                    <label for="homePhone1" class="sr-only"><fmt:message key="freeSwatches.phoneNumber"/></label>
	           	</div>
               	<div class="field-group">
               		<fmt:message  var="email" key="freeSwatches.emailAddress"/>
                	<dsp:input iclass="requiredField move-label" id="emailAddress" name="emailAddress" type="text" data-validation="required email" aria-required="true" autocapitalize="off" data-fieldname="Email" beanvalue="CatalogOrderFormHandler.profileValueMap.emailAddress" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.emailAddress"/>
                    <label for="emailAddress" class="sr-only"><fmt:message key="freeSwatches.emailAddress"/></label>
                </div>
               	<div class="field-group">
               		<fmt:message  var="address1" key="freeSwatches.streetAddress"/>
                	<dsp:input iclass="requiredField move-label" id="address1" name="address1" type="text" data-validation="required address" aria-required="true" autocapitalize="off" data-fieldname="Address1" beanvalue="CatalogOrderFormHandler.profileValueMap.street" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.street"/>
                    <label for="address1" class="sr-only"><fmt:message key="freeSwatches.streetAddress"/></label>
               	</div>
                <div class="field-group">
                	<fmt:message  var="address2" key="freeSwatches.addressOptional"/>
                   	<dsp:input iclass="move-label" id="address2" name="address2" type="text" data-validation="address" autocapitalize="off" data-fieldname="Address2" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.aptNo"/>
                    <label for="address2" class="sr-only"><fmt:message key="freeSwatches.address2"/></label>
               	</div>
                <div class="field-group">
                    <fmt:message  var="city" key="freeSwatches.city"/>
                    <dsp:input iclass="requiredField move-label" id="city" name="city" type="text" data-validation="required alphaspace" aria-required="true" autocapitalize="off" data-fieldname="City" beanvalue="CatalogOrderFormHandler.profileValueMap.city" maxlength="40" bean="CatalogOrderFormHandler.profileValueMap.city"/>
                    <label for="city" class="sr-only"><fmt:message key="freeSwatches.city"/></label>
				</div>
                <div class="field-group">
                    <fmt:message  var="stateProv" key="freeSwatches.stateProv"/>
                    <dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
                    <dsp:getvalueof var="country" bean="CatalogOrderFormHandler.profileValueMap.country" />
                    <dsp:param name="statePicker" bean="CatalogOrderFormHandler.profileValueMap.state" />
                    <div class="custom-select">
                        <dsp:select bean="CatalogOrderFormHandler.profileValueMap.state" data-validation="required" aria-required="true" data-fieldname="State/Province" id="atg_store_stateSelect" name="atg_store_stateSelect" placeholder="${stateProv}" nodefault="true">
                            <dsp:option value=""><fmt:message key="common.stateOrProvince"/></dsp:option>
                            <c:forEach items="${countryStateMap}" var="entry">
                                <c:forEach items="${entry.value}" var="state">
                                    <dsp:option value="${state}"><fmt:message key="state.${state}"/></dsp:option>
                                </c:forEach>
                            </c:forEach>
                        </dsp:select>
                        <span class="icon icon-arrow-down" aria-hidden="true"></span>
                    </div>
                    <label for="atg_store_stateSelect" class="sr-only"><fmt:message key="freeSwatches.stateProv"/></label>
				</div>
                <div class="field-group">
                	<fmt:message  var="postalCode" key="freeSwatches.postalCode"/>
                    <dsp:input iclass="requiredField move-label" type="text" id="zipPostal" name="postalCode" data-validation="required uspostal" aria-required="true" autocapitalize="off" data-fieldname="Postal Code" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" maxlength="10" bean="CatalogOrderFormHandler.profileValueMap.zipCode" /><br/>
                    <label for="zipPostal" class="sr-only"><fmt:message key="freeSwatches.postalCode"/></label>
                </div>
                <div class="field-group custom-checkbox">
                	<dsp:input type="checkbox" id="emailOptIn1" name="emailOptIn1" bean="CatalogOrderFormHandler.checkedPromotionalEmail" value="on" />
                    <label for="emailOptIn1"><fmt:message key="freeSwatches.emailOptInMsg"/></label>
                </div>

                <div class="field-group">
                   	<dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="${contextPath}/contactus/json/swatchSuccess.jsp" />
                   	<dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="${contextPath}/contactus/json/swatchError.jsp" />
                   	<fmt:message key="freeSwatches.submit" var="freeSwatchesSubmitText" />
                   	<dsp:input type="submit" id="sendSwatches" iclass="swatchSubmitter button primary" value="${freeSwatchesSubmitText}" bean="CatalogOrderFormHandler.freeSwatchesRequest" name="formSubmitter" />
               </div>

                <input type="hidden" name="elqFormName" value="freeswatch">
                <input type="hidden" name="elqSiteID" value="20103530">
                <input type="hidden" name="elqCustomerGUID" value="">
                <input type="hidden" name="elqCookieWrite" value="0">

            </dsp:form>
        </section>
    </div>
</dsp:page>