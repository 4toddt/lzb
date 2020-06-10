<%--
    - File Name: productConfiguration.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product configuration section on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - productId: product id,
        - productSkuId: product sku id,
        - defaultCoverSkuId: default seclected cover sku,
        - productCoverList: cover SKU data,
        - productConfigurableOptionNames: configurable product option names,
        - dealerId,
        - productVNT,
        - isPurchaseable: purchaseable boolean,
        - onSale: sale boolean,
        - lowestSalePrice,
        - formatLowestSalePrice,
        - formatLowestPrice,
        - lowestPrice
    - Optional Parameters:
        - editCommerceItemId: edit ID if product came from cart
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig" />
    <dsp:importbean bean="/com/lzb/droplet/LZBSKUOptionSeparator" />
    <dsp:importbean bean="/atg/userprofiling/Profile" scope="request" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="productId" param="productId" />
    <dsp:getvalueof var="productSkuId" param="productSkuId" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
    <dsp:getvalueof var="productCoverList" param="productCoverList" />
    <dsp:getvalueof var="productConfigurableOptionNames" param="productConfigurableOptionNames" />
    <dsp:getvalueof var="dealerId" param="dealerId" />
    <dsp:getvalueof var="productVNT" param="productVNT" />
    <dsp:getvalueof var="isPurchaseable" param="isPurchaseable" />
    <dsp:getvalueof var="onSale" param="onSale" />
    <dsp:getvalueof var="stockMsg" param="stockMsg" />
    <dsp:getvalueof var="lowestSalePrice" param="lowestSalePrice" />
    <dsp:getvalueof var="formatLowestSalePrice" param="formatLowestSalePrice" />
    <dsp:getvalueof var="formatLowestPrice" param="formatLowestPrice" />
    <dsp:getvalueof var="lowestPrice" param="lowestPrice" />
    <dsp:getvalueof var="editCommerceItemId" param="editCommerceItemId" />
    <dsp:getvalueof var="isPillowOptions" param="isPillowOptions" />
    <fmt:message var="coverTitle" key="productConfiguration.coverTitle" />
    <fmt:message var="sectionalTitle" key="productConfiguration.sectionalTitle" />
    <fmt:message var="optionsTitle" key="productConfiguration.optionsTitle" />
    <fmt:message var="noDefaultCoverMessage" key="productConfiguration.noDefaultCover" />
    <c:set var="defaultCoverPriceDisplay" value="" />

    <%-- Set Default Cover Variables --%>
    <c:choose>
        <c:when test="${not empty defaultCoverSkuId && not empty productCoverList}">
            <%-- Droplet: Separate Cover SKU Options --%>
            <dsp:droplet name="LZBSKUOptionSeparator">
                <dsp:param name="skuCoverList" value="${productCoverList}" />
                <dsp:param name="profileSaveCoverRequest" value="true" />
				<dsp:param name="profile" bean="Profile"/>
                <dsp:param name="sku" value="${productSkuId}" />
                <dsp:oparam name="output">
                    <dsp:getvalueof var="coverOptionList" param="coverOptionList" />
                </dsp:oparam>
                <dsp:oparam name="empty"></dsp:oparam>
            </dsp:droplet>

            <c:forEach items="${coverOptionList}" var="priceGrade" varStatus="i">
                <c:forEach items="${priceGrade.value}" var="colorSwatch" varStatus="loop">
                    <c:set var="defaultCoverArray" value="${fn:split(colorSwatch,'~')}" />
                    <c:set var="coverSkuId" value="${defaultCoverArray[0]}" />

                    <c:if test="${coverSkuId eq defaultCoverSkuId}">
                        <c:set var="defaultCoverType" value="${defaultCoverArray[3]}" />
                        <fmt:parseNumber var="defaultCoverPrice" value="${priceGrade.key}" />
                        <fmt:formatNumber var="formattedDefaultCoverPrice" value="${defaultCoverPrice}" type="currency" />
                        <c:set var="defaultCoverPriceDisplay" value="${formattedDefaultCoverPrice}" />
                    </c:if>
                </c:forEach>
            </c:forEach>

            <c:choose>
                <c:when test="${not empty defaultCoverType}">
                    <c:set var="defaultCoverThumbnailImageURL" value="//${storeConfig.contentHostName}${storeConfig.coverThumbnailBaseUrl}${defaultCoverSkuId}.jpg" />
                    <c:set var="defaultCoverSummaryDetails" value="${defaultCoverSkuId}" />
                    <c:set var="defaultCoverSummaryDetails2" value="${defaultCoverType}" />
                </c:when>
                <c:otherwise>
                    <c:set var="defaultCoverThumbnailImageURL" value="//${storeConfig.contentHostName}${storeConfig.coverThumbnailBaseUrl}${defaultCoverSkuId}.jpg" />
                    <c:set var="defaultCoverSummaryDetails" value="${defaultCoverSkuId}" />
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="defaultCoverThumbnailImageURL" value="" />
            <c:set var="defaultCoverSummaryDetails" value="${noDefaultCoverMessage}" />
        </c:otherwise>
    </c:choose>

    <%-- Do not render a price for pdpRecordType sectional --%>
    <%-- NOTE: Price display is only rendered for product specific pdpRecordType --%>
    <c:if test="${pdpRecordType eq 'sectional'}">
        <c:set var="defaultCoverPriceDisplay" value="none" />
    </c:if>

    <%-- Set hasCovers Variable --%>
    <c:choose>
        <c:when test="${not empty productCoverList}">
            <c:set var="hasCovers" value="${true}" />
        </c:when>
        <c:otherwise>
            <c:set var="hasCovers" value="${false}" />
        </c:otherwise>
    </c:choose>

    <%-- Set hasOptions Variable --%>
    <c:choose>
        <c:when test="${not empty productConfigurableOptionNames}">
            <c:set var="optionArray" value="${fn:split(productConfigurableOptionNames, '|')}" />
            <c:set var="optionArrayLength" value="${fn:length(optionArray)}" />
            <c:choose>
                <c:when test="${optionArrayLength gt 1 and hasCovers eq true}">
                    <c:set var="hasOptions" value="${true}" />
                </c:when>
                <c:otherwise>
                    <c:set var="hasOptions" value="${false}" />
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="hasOptions" value="${false}" />
        </c:otherwise>
    </c:choose>

    <%-- Render Product Configuration --%>
    <div class="product-configuration">
        <%-- NOTE: Configurable Selections are only rendered for specific pdpRecordType --%>
        <c:if test="${hasCovers eq true && (pdpRecordType eq 'configurable' || pdpRecordType eq 'sectional')}">
        	<c:if test="${not storeConfig.showCoverDetails}">
        		<p class="order-free-swatches-copy">
                	<a href="${contextPath}/content/free-swatches"><fmt:message key="productConfiguration.orderFreeSwatchesCopy" /></a>
				</p>
			</c:if>
            <div class="product-accordions accordion" data-accordion aria-multiselectable="true" role="tablist">
            	<%-- START: Cover Selection Accordion Content--%>
                <div class="accordion-container" id="accordion-cover-selection">
            		<div class="accordion-title" role="tab" aria-controls="cover-selection" aria-expanded="false" id="cover-selection-title" tabindex="0" data-default-cover-id="${defaultCoverSkuId}">
                        <%-- Include Product Configuration Title --%>
                        <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                            <dsp:param name="type" value="cover" />
                            <dsp:param name="swatchImgPath" value="${defaultCoverThumbnailImageURL}" />
                            <dsp:param name="title" value="${coverTitle}" />
                            <dsp:param name="summaryDetails" value="${defaultCoverSummaryDetails}" />
                            <dsp:param name="summaryDetails2" value="${defaultCoverSummaryDetails2}" />
                            <dsp:param name="optionsTotal" value="${defaultCoverPriceDisplay}" />
                            <dsp:param name="stockMsg" value="${stockMsg}" />
                        </dsp:include>
                    </div>
            		<div class="accordion-body" aria-labeledby="cover-selection-title" role="tabpanel" id="cover-selection">
            			<div class="accordion-body-content">
                            <%-- Include Product Configuration Cover Content --%>
                            <dsp:include page="/browse/includes/pdp/productConfiguration/coverContent.jsp">
                                <dsp:param name="productSkuId" value="${productSkuId}" />
                                <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                                <dsp:param name="productCoverList" value="${productCoverList}" />
                                <dsp:param name="dealerId" value="${dealerId}" />
                                <dsp:param name="productVNT" value="${productVNT}" />
                            </dsp:include>
            			</div>
            		</div>
            	</div>
                <%-- END: Cover Selection Accordion Content--%>

                <%-- START: Sectional Selection Accordion Content--%>
                <%--
                    NOTE: Sectional Configuration is out of scope for Mobile Redesign Project.
                    Adding this placeholder structure here for future integration.

                <c:if test="${pdpRecordType eq 'sectional'}">
                    <div class="accordion-container" id="accordion-sectional-selection">
                		<div class="accordion-title" role="tab" aria-controls="sectional-selection" aria-expanded="false" id="sectional-selection-title" tabindex="0">
                            Include Product Configuration Title
                            <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                <dsp:param name="swatchImgPath" value="" />
                                <dsp:param name="title" value="${sectionalTitle}" />
                                <dsp:param name="summaryDetails" value="" />
                            </dsp:include>
                        </div>
                		<div class="accordion-body" aria-labeledby="sectional-selection-title" role="tabpanel" id="sectional-selection">
                			<div class="accordion-body-content">
                                Include Product Configuration Cover Content
                                <dsp:include page="/browse/includes/pdp/productConfiguration/sectionalContent.jsp">
                                </dsp:include>
                			</div>
                		</div>
                	</div>
                </c:if>
                --%>
                <%-- END: Sectional Selection Accordion Content--%>

                <%-- START: Options Selection Accordion Content--%>
                <c:if test="${hasOptions eq true && pdpRecordType eq 'configurable'}">
                    <%-- NOTE: We can not render the Options Selection Accordion Content for Sectionals unless the Droplet is re-written or
                        we include the Sectional Configuration Accordion as it currently requires optionAndUpgradesJson data for sectionals.
                    --%>
                    <div class="accordion-container" id="accordion-options-selection">
                		<div class="accordion-title" role="tab" aria-controls="options-selection" aria-expanded="false" id="options-selection-title" tabindex="0">
                            <%-- Include Product Configuration Title --%>
                            <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                <dsp:param name="title" value="${optionsTitle}" />
                                <%-- NOTE: Not able to set summaryDetails on JSP page render. This is done within the javascript product init --%>
                                <dsp:param name="summaryDetails" value="" />
                            </dsp:include>
                        </div>
                		<div class="accordion-body" aria-labeledby="options-selection-title" role="tabpanel" id="options-selection">
                			<div id="options-and-upgrades-content" class="accordion-body-content">
                                <%-- Include Product Configuration Options and Upgrades Content --%>
                                <dsp:include page="/browse/includes/pdp/productConfiguration/optionsContent.jsp">
                                    <dsp:param name="skuId" value="${productSkuId}" />
                                    <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                                    <dsp:param name="pdpType" value="pdp" />
                                    <dsp:param name="isPillowOptions" value="${isPillowOptions}" />
                                </dsp:include>
                			</div>
                		</div>
                	</div>
                </c:if>
                <%-- END: Options Selection Accordion Content--%>
            </div>
        </c:if>

        <%-- Render Product Add To Cart --%>
        <dsp:include page="/browse/includes/pdp/productConfiguration/productAddToCart.jsp">
            <dsp:param name="productId" value="${productId}" />
            <dsp:param name="productSkuId" value="${productSkuId}" />
            <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
            <dsp:param name="dealerId" value="${dealerId}" />
            <dsp:param name="productCoverList" value="${productCoverList}" />
            <dsp:param name="isPurchaseable" value="${isPurchaseable}" />
            <dsp:param name="onSale" value="${onSale}" />
            <dsp:param name="lowestSalePrice" value="${lowestSalePrice}" />
            <dsp:param name="formatLowestSalePrice" value="${formatLowestSalePrice}" />
            <dsp:param name="formatLowestPrice" value="${formatLowestPrice}" />
            <dsp:param name="lowestPrice" value="${lowestPrice}" />
            <dsp:param name="editCommerceItemId" value="${editCommerceItemId}" />
            <dsp:param name="productVNT" value="${productVNT}" />
        </dsp:include>
    </div>

</dsp:page>