<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
    <dsp:importbean bean="/com/lzb/catalogOrder/CatalogOrderFormHandler" />
    <dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />

    <%-- Page Variables --%>
    <dsp:getvalueof bean="CatalogOrderFormHandler.formError" var="formError" />
    <dsp:getvalueof var="freeSwatchContextPath" bean="/com/lzb/feed/swatch/manager/LZBFreeSwatchReqFeedMgr.jspContextPath" />

    <div id="freeSwatchesContainer">

        <c:if test="${formError eq 'true'}">
            <dsp:include page="/includes/global/errors.jsp">
                <dsp:param name="formHandler" bean="CatalogOrderFormHandler" />
            </dsp:include>
        </c:if>
        <dsp:layeredBundle basename="com.lzb.common.WebAppResources" />

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

        <section data-module="free-swatches modal-jquery-validation eloqua-submit">
            <label class="error hide" id="swatchLimitMessage">Maximum 3 Swatches Allowed</label>
            <dsp:form method="post" name="freeswatch" action="${freeSwatchContextPath}" id="freeswatchForm" iclass="elq-form freeswatchForm">
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
                            <dsp:oparam name="outputStart">
                            </dsp:oparam>
                            <dsp:oparam name="output">
                                <dsp:getvalueof param='element.title' var="fswTitle" />
                                <dsp:getvalueof param='element.imageUrl' var="fswImageUrl" />
                                <dsp:getvalueof param='element.imageAltText' var="fswImageText" />
                                <dsp:getvalueof param='element.id' var="fswArchwayId" />
                                <dsp:getvalueof param='count' var="fswCount" />

                                <div class="swatch-item">
                                    <div class="swatch-title">
                                        <h3>${fswTitle}</h3>
                                    </div>
                                    <div class="swatch-thumbnail">
                                        <img src="${fswImageUrl}" alt="${fswImageText}">
                                    </div>
                                    <dsp:input type="checkbox" name="freeSwatchGroup" id="swatchGroup${fswCount}" value="${fswArchwayId}" bean="CatalogOrderFormHandler.freeSwatchGroup" />
                                    <label for="swatchGroup${fswCount}"><fmt:message key="freeSwatches.swatchLabel.group" /></label>
                                </div>
                            </dsp:oparam>
                            <dsp:oparam name="outputEnd">
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
                        <button type="button" class="btn-swatch-search"><span class="sr-only"><fmt:message key="freeSwatches.singles.searchButton" /></span><span class="icon-search" aria-hidden="true"></span></button>
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
                                        <img src="${fswImageUrl}" alt="${fswImageText}">
                                    </div>
                                    <dsp:input type="checkbox" name="freeSwatchGroup" id="swatchSingle${fswCount}" value="${fswArchwayId}" bean="CatalogOrderFormHandler.freeSwatchGroup" />
                                    <label for="swatchSingle${fswCount}"><fmt:message key="freeSwatches.swatchLabel.single" /></label>
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
                    <div class="field-group text">
                        <dspel:input iclass="requiredField move-label" id="firstName" name="firstName" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.firstName">
                        </dspel:input>
                        <label for="firstName" class="sr-only">First Name</label>
                    </div>
                    <div class="field-group text">
                        <dspel:input iclass="requiredField move-label" id="lastName" name="lastName" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.lastName">
                        </dspel:input>
                        <label for="lastName" class="sr-only">Last Name</label>
                    </div>
                    <div class="field-group text">
                        <dsp:input iclass="move-label" id="homePhone1" name="homePhone1" type="tel" beanvalue="CatalogOrderFormHandler.profileValueMap.phoneNumber" maxlength="30" bean="CatalogOrderFormHandler.profileValueMap.phoneNumber" />
                        <label for="homePhone1" class="sr-only">Phone Number (optional)</label>
                    </div>
                    <div class="field-group text">
                        <dspel:input iclass="requiredField move-label" id="emailAddress" name="emailAddress" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.emailAddress" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.emailAddress">
                        </dspel:input>
                        <label for="emailAddress" class="sr-only">Email</label>
                    </div>
                    <div class="field-group text">
                        <dspel:input iclass="requiredField move-label" id="address1" name="address1" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.street" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.street">
                        </dspel:input>
                        <label for="address1" class="sr-only">Street Address</label>
                    </div>
                    <div class="field-group text">
                        <dspel:input iclass="move-label" id="address2" name="address2" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.aptNo">
                        </dspel:input>
                        <label for="address2" class="sr-only">Address line 2 (optional)</label>
                    </div>
                    <div class="field-group text">
                        <dspel:input iclass="requiredField move-label" id="city" name="city" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.city" maxlength="40" bean="CatalogOrderFormHandler.profileValueMap.city">
                        </dspel:input>
                        <label for="city" class="sr-only">City</label>
                    </div>
                    <div class="field-group text dropdown-arrow">
                        <dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
                        <dsp:getvalueof var="country" bean="CatalogOrderFormHandler.profileValueMap.country" />
                        <dsp:param name="statePicker" bean="CatalogOrderFormHandler.profileValueMap.state" />
                        <dsp:select iclass="requiredField move-label" name="stateProv" id="atg_store_stateSelect" bean="CatalogOrderFormHandler.profileValueMap.state" nodefault="true">
                            <dsp:option value=""></dsp:option>
                            <%@include file="/includes/global/countryStateOrProvince.jsp" %>
                        </dsp:select>
                        <label for="atg_store_stateSelect" class="hiddenLabel" class="sr-only"><fmt:message key="freeSwatches.stateProv"/></label>
                    </div>
                    <div class="field-group text">
                        <dsp:input iclass="requiredField move-label" type="text" id="zipPostal" name="zipPostal" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" maxlength="50" bean="CatalogOrderFormHandler.profileValueMap.zipCode" />
                        <label for="zipPostal" class="sr-only"><fmt:message key="freeSwatches.postalCode"/></label>
                    </div>
                    <div class="field-group text">
                   		<p><fmt:message key="freeSwatches.verificationNumber"/></p>
                       	<img src="${pageContext.request.contextPath}/contactus/captchaImage.jpg" class="captcha" alt="captcha">
                  	</div>
                  	<div class="field-group text">
                  		<dsp:input iclass="requiredField move-label" id="verficationNum" name="verficationNum" type="text" beanvalue="CatalogOrderFormHandler.captchaImageNumber" bean="CatalogOrderFormHandler.captchaImageNumber" />
                    	<label for="verficationNum"><fmt:message key="freeSwatches.verificationNumber"/><sup>*</sup></label>
                	</div>
                    <div class="field-group custom-checkbox">
                        <dsp:input type="checkbox" id="emailOptIn1" name="emailOptIn1" bean="CatalogOrderFormHandler.checkedPromotionalEmail" value="on"/>
                        <label for="emailOptIn1"><fmt:message key="freeSwatches.emailOptInMsg"/></label>
                    </div>

                    <div class="field-group">
                        <dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="${freeSwatchContextPath}/thank-you" />
                        <dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="${freeSwatchContextPath}/?error=true" />
                        <fmt:message key="freeSwatches.submit" var="freeSwatchesSubmitText" />
                        <dsp:input type="submit" iclass="hiddenSubmitter" value="${freeSwatchesSubmitText}" bean="CatalogOrderFormHandler.freeSwatchesRequest" name="formSubmitter" />
                        <input type="button" class="button primary-btn" value="${freeSwatchesSubmitText}" name="sendSwatches" id="sendSwatches" disabled />
                    </div>
                </div>

                <%-- I Replaced the hidden inputs with the ones from Eloqua - TT --%>
                
                <%-- <input value="80" type="hidden" name="freeswatch" />
                <input value="20103530" type="hidden" name="elqSiteID" />
                <input name="elqCampaignId" type="hidden" />
                <input type="hidden" name="elqCustomerGUID" value="" />
                <input type="hidden" name="elqCookieWrite" value="0" /> --%>
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