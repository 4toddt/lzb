<dsp:page>

    <!-- Begin DMI-1467 -->
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700|Open+Sans:400,700" rel="stylesheet">
    <style>
        section.cust-support>h1,
        section.cust-support>hr {
            /* hide h1 and mobile hr coming from ATG */
            display: none;
        }
        
        body.two-column-first section[role="region"] {
            /* reset the 775px width and default margin on the content section */
            width: 100%;
            margin-left: 0;
        }
        
        main {
            /* reset the 10px padding on mobile */
            padding: 0;
            /* reset the 980px width and default margins on desktop */
            width: 100%;
            margin: 0;
        }
        
        section.cust-support {
            width: 100%;
            margin: 0;
            /* force desktop to be non-responsive */
            min-width: 980px;
        }
        
        body.mobileSite section.cust-support {
            /* reset min-width on mobile */
            min-width: auto;
        }
        
        body.mobileSite section.cust-support {
            /* default margins on mobile */
            margin: 5px 0 60px;
        }
        
        @media only screen and (max-width: 567px) {
            /* mobile portrait */
            body.mobileSite section.cust-support {
                margin-bottom: 10.6%;
            }
        }
    </style>
    <!-- End DMI-1467 -->

    <section id="freeSwatchesContainer" class="test">
        <dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
        <dsp:importbean bean="/com/lzb/catalogOrder/CatalogOrderFormHandler" />
        <dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
        <dsp:getvalueof bean="CatalogOrderFormHandler.formError" var="formError" />
        <dsp:getvalueof var="freeSwatchContextPath" bean="/com/lzb/feed/swatch/manager/LZBFreeSwatchReqFeedMgr.jspContextPath" />
        <!--c:set var="freeSwatchContextPath" value="/content/CustomerCare/Free-Swatches-Request"/-->

        <dsp:getvalueof param="success" var="successMsg" />

        <c:if test="${formError eq 'true'}">
            <dsp:include page="/includes/global/errors.jsp">
                <dsp:param name="formHandler" bean="CatalogOrderFormHandler" />
            </dsp:include>
        </c:if>
        <dsp:layeredBundle basename="com.lzb.common.WebAppResources" />
        <c:if test="${successMsg eq 'true'}">
            <div class="prod-cata-success-msg">
                <img src="/img/box_40.png" width="40px" height="30px" />
                <span><fmt:message key="customercare.freeswatch.successmsg" /></span>
            </div>
        </c:if>



        <dsp:droplet name="/atg/targeting/TargetingFirst">
            <dsp:param name="targeter" bean="/atg/registry/RepositoryTargeters/FreeSwatchesTopBanner" />
            <dsp:param name="elementName" value="element" />
            <dsp:oparam name="output">
                <dsp:getvalueof param="element" var="element" />
                <c:if test="${fn:contains(element.itemDescriptor,'media-external')}">
                    <section class="hero hidden-xs">
                        <div class="copy-overlay">
                            <div class="copy-block">
                                <h1>${element.name}</h1>
                                <hr>
                                <p>${element.description}</p>
                            </div>
                        </div>
                        <img src="${element.url}" alt="${element.name}" />
                    </section>
                    <section class="hero visible-xs">
                        <h1>${element.name}</h1>
                        <img src="${element.url}" alt="${element.name}" />
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

        <section data-module="free-swatches modal-jquery-validation eloqua-submit">
            <label class="error" id="swatchLimitMessage">Maximum 3 Swatches Allowed</label>
            <dsp:form method="post" name="freeswatch" action="${freeSwatchContextPath}" id="80" iclass="elq-form freeswatchForm">

                <div class="swatches">
                    <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
                        <dsp:param name="queryRQL" value="enabled = true" />
                        <dsp:param name="repository" bean="/atg/commerce/catalog/ProductCatalog" />
                        <dsp:param name="itemDescriptor" value="freeSwatchGroup" />
                        <dsp:param name="sortProperties" value="+sortOrder" />
                        <dsp:param name="elementName" value="freeSwatch" />
                        <dsp:oparam name="outputStart">
                        </dsp:oparam>
                        <dsp:oparam name="output">
                            <dsp:getvalueof param='freeSwatch.title' var="fswTitle" />
                            <dsp:getvalueof param='freeSwatch.imageUrl' var="fswImageUrl" />
                            <dsp:getvalueof param='freeSwatch.imageAltText' var="fswImageText" />
                            <dsp:getvalueof param='freeSwatch.id' var="fswArchwayId" />
                            <dsp:getvalueof param='count' var="fswCount" />
                            <div class="swatch">
                                <div class="swatch-title">
                                    <h3>${fswTitle}</h3>
                                </div>
                                <div class="swatch-thumbnail">
                                    <img src="${fswImageUrl}" alt="${fswImageText}">
                                </div>
                                <dsp:input type="checkbox" name="freeSwatchGroup" id="swatchGroup${fswCount}" value="${fswArchwayId}" bean="CatalogOrderFormHandler.freeSwatchGroup" />
                                <label for="swatchGroup${fswCount}">Select Swatch</label>
                            </div>
                        </dsp:oparam>
                        <dsp:oparam name="outputEnd">
                        </dsp:oparam>
                    </dsp:droplet>
                </div>

                <div class="client-data">
                    <div class="text">
                        <dspel:input iclass="requiredField move-label" id="firstName" name="firstName" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.firstName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.firstName">
                        </dspel:input>
                        <label for="firstName">First Name</label>
                    </div>
                    <div class="text">
                        <dspel:input iclass="requiredField move-label" id="lastName" name="lastName" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.lastName" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.lastName">
                        </dspel:input>
                        <label for="lastName">Last Name</label>
                    </div>
                    <div class="text">
                        <dsp:input iclass="move-label" id="homePhone1" name="homePhone1" type="tel" beanvalue="CatalogOrderFormHandler.profileValueMap.phoneNumber" maxlength="30" bean="CatalogOrderFormHandler.profileValueMap.phoneNumber" />
                        <label for="homePhone1">Phone Number (optional)</label>
                    </div>
                    <div class="text">
                        <dspel:input iclass="requiredField move-label" id="emailAddress" name="emailAddress" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.emailAddress" maxlength="64" bean="CatalogOrderFormHandler.profileValueMap.emailAddress">
                        </dspel:input>
                        <label for="emailAddress">Email</label>
                    </div>
                    <div class="text">
                        <dspel:input iclass="requiredField move-label" id="address1" name="address1" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.street" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.street">
                        </dspel:input>
                        <label for="address1">Street Address</label>
                    </div>
                    <div class="text">
                        <dspel:input iclass="move-label" id="address2" name="address2" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.aptNo" maxlength="100" bean="CatalogOrderFormHandler.profileValueMap.aptNo">
                        </dspel:input>
                        <label for="address2">Address line 2 (optional)</label>
                    </div>
                    <div class="text">
                        <dspel:input iclass="requiredField move-label" id="city" name="city" type="text" beanvalue="CatalogOrderFormHandler.profileValueMap.city" maxlength="40" bean="CatalogOrderFormHandler.profileValueMap.city">
                        </dspel:input>
                        <label for="city">City</label>
                    </div>
                    <div class="text">
                        <dsp:getvalueof var="statePicker" vartype="java.lang.String" value="atg_store_stateSelect" />
                        <dsp:getvalueof var="country" bean="CatalogOrderFormHandler.profileValueMap.country" />
                        <dsp:param name="statePicker" bean="CatalogOrderFormHandler.profileValueMap.state" />
                        <label class="hiddenLabel"><fmt:message key="freeSwatches.stateProv"/></label>
                        <dsp:select iclass="requiredField move-label" name="atg_store_stateSelect" id="atg_store_stateSelect" bean="CatalogOrderFormHandler.profileValueMap.state" nodefault="true">
                            <%@include file="/includes/global/countryStateOrProvince.jsp" %>
                        </dsp:select>
                    </div>
                    <div class="text">
                        <dsp:input iclass="requiredField move-label" type="text" id="zipPostal" name="postalCode" beanvalue="CatalogOrderFormHandler.profileValueMap.zipCode" maxlength="50" bean="CatalogOrderFormHandler.profileValueMap.zipCode" /><br/>
                        <label><fmt:message key="freeSwatches.postalCode"/></label>
                    </div>
                    <div class="checkbox">
                        <dsp:input type="checkbox" id="emailOptIn1" name="reciveEmail" bean="CatalogOrderFormHandler.checkedPromotionalEmail" />
                        <label><fmt:message key="freeSwatches.emailOptInMsg"/></label>
                    </div>

                    <div class="submit">
                        <dsp:input type="hidden" bean="CatalogOrderFormHandler.successURL" value="/mobile${freeSwatchContextPath}/thank-you" />
                        <dsp:input type="hidden" bean="CatalogOrderFormHandler.errorURL" value="/mobile${freeSwatchContextPath}/?error=true" />
                        <fmt:message key="freeSwatches.submit" var="freeSwatchesSubmitText" />
                        <dsp:input type="submit" iclass="hiddenSubmitter" value="${freeSwatchesSubmitText}" bean="CatalogOrderFormHandler.freeSwatchesRequest" name="formSubmitter" />
                        <input type="button" class="button primary-btn" value="${freeSwatchesSubmitText}" name="sendSwatches" id="sendSwatches" />
                    </div>
                </div>

                <!-- I Replaced the hidden inputs with the ones from Eloqua - TT -->

                <!-- <input value="form80" type="hidden" name="elqFormName" />
                <input value="20103530" type="hidden" name="elqSiteId" />
                <input name="elqCampaignId" type="hidden" /> -->
                <input type="hidden" name="elqFormName" value="freeswatch">
                <input type="hidden" name="elqSiteID" value="20103530">
                <input type="hidden" name="elqCustomerGUID" value="">
                <input type="hidden" name="elqCookieWrite" value="0">

            </dsp:form>
        </section>
    </section>
</dsp:page>