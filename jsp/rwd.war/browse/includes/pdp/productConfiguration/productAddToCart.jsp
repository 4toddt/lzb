<%--
    - File Name: productAddToCart.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product add to cart section on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - canShip: product can ship boolean is a request scope variable,
        - productId: product id,
        - productSkuId: product sku id,
        - defaultCoverSkuId: default cover sku,
        - dealerId,
        - productCoverList: cover SKU data,
        - isPurchaseable: purchaseable boolean,
        - onSale: sale boolean,
        - lowestSalePrice,
        - formatLowestSalePrice,
        - formatLowestPrice,
        - lowestPrice,
        - productVNT
    - Optional Parameters:
        - editCommerceItemId: edit ID if product came from cart
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/userprofiling/Profile" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
    <dsp:importbean bean="/atg/commerce/inventory/InventoryManager" />
    <%-- Page Variables --%>
    <dsp:getvalueof var="productId" param="productId" />
    <dsp:getvalueof var="productSkuId" param="productSkuId" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
    <dsp:getvalueof var="dealerId" param="dealerId" />
    <dsp:getvalueof var="productCoverList" param="productCoverList" />
    <dsp:getvalueof var="isPurchaseable" param="isPurchaseable" />
    <dsp:getvalueof var="onSale" param="onSale" />
    <dsp:getvalueof var="lowestSalePrice" param="lowestSalePrice" />
    <dsp:getvalueof var="formatLowestSalePrice" param="formatLowestSalePrice" />
    <dsp:getvalueof var="formatLowestPrice" param="formatLowestPrice" />
    <dsp:getvalueof var="lowestPrice" param="lowestPrice" />
    <dsp:getvalueof var="editCommerceItemId" param="editCommerceItemId" />
    <dsp:getvalueof var="productVNT" param="productVNT" />
    <c:set var="defaultUSDealer" value="${storeConfig.defaultUSDealer}" />
    <c:set var="defaultCANDealer" value="${storeConfig.defaultCANDealer}" />
    <fmt:message var="contactStoreButtonText" key='pdp.button.contactStore' />
    <fmt:message var="addToCartButtonText" key="pdp.button.addToCart" />
    <fmt:message key="pdp.link.estimateShippingCost" var="estimateShippingCostText"/>
    <fmt:message key="pdp.link.seeItInStore" var="seeItInStoreText"/>

    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />
    <c:choose>
        <c:when test="${country eq 'US'}">
            <dsp:getvalueof var="stockMsg" bean="InventoryManager.inStockMsgUS"/>
        </c:when>
        <c:otherwise>
            <dsp:getvalueof var="stockMsg" bean="InventoryManager.inStockMsgCA"/>
        </c:otherwise>
    </c:choose>

    <%-- Set Pricing Text Variables for Add To Cart Button & Estimated Shipping Link --%>
    <c:choose>
        <c:when test="${onSale}">
            <c:set var="buttonPrice" value="${formatLowestSalePrice}" />
            <c:set var="linkPrice" value="${lowestSalePrice}" />
        </c:when>
        <c:otherwise>
            <c:set var="buttonPrice" value="${formatLowestPrice}" />
            <c:set var="linkPrice" value="${lowestPrice}" />
        </c:otherwise>
    </c:choose>

    <c:if test="${canShip eq 'true'}">
        <%-- Render Product Add To Cart --%>
        <div class="product-add-to-cart">
            <c:choose>
                <c:when test="${pdpRecordType eq 'discontinuedConfigurable' || pdpRecordType eq 'discontinuedSectional' || pdpRecordType eq 'discontinuedSimple' || pdpRecordType eq 'discontinuedLicensed'}">
                    <%-- Don't render anything  --%>
                </c:when>
                <c:when test="${(isPurchaseable eq 'true' && pdpRecordType ne 'sectional') && (not empty currentDealerId || (currentDealerId ne defaultUSDealer || currentDealerId ne defaultCANDealer))}">
                    <%-- Render Contact Store Button in DOM for product configruations that may not be available for online purchase. hidden by default --%>
                    <c:if test="${pdpRecordType eq 'simple' || pdpRecordType eq 'licensed'}">
                        <div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
                    </c:if>

                    <div id="in-store-only" class="hide">
                        <a href="${contextPath}/storeLocator/storeLocator.jsp" class="button secondary in-store-only-button" aria-label="${contactStoreButtonText}">
                            ${contactStoreButtonText}<span class="asterisk hide">*</span>
                        </a>
                    </div>

                    <%-- Render Add to Cart Form. Shown by default --%>
                    <dsp:form id="add-to-cart-form" formid="add-to-cart-form" name="addToCart" method="post" autocomplete="off" action="${requestScope['javax.servlet.forward.request_uri']}">
                        <input id="dealerid" type="hidden" name="dealer" value="${dealerId}" />
                        <dsp:input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productId}" />
                        <dsp:input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productSkuId}" />
                        <input id="exceptionid" type="hidden" name="exceptionid" value="" />
                        <input id="iteminfo" type="hidden" name="iteminfo" value="" />
                        <input id="addToCartModalJSON" type="hidden" name="addToCartModalJSON" value="" />
                        <input id="isSelectPrice" type="hidden" name="isSelectPrice" value="" />
                        <input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />
                        <input id="coverId" type="hidden" name="coverId" value="${defaultCoverSkuId}" />
                        <input id="editCommerceItemId" type="hidden" name="editCommerceItemId" value="${editCommerceItemId}" />
                        <input id="datavnt" type="hidden" name="datavnt" value="${productVNT}" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${contextPath}/sitewide/json/addToCart.jsp" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${contextPath}/sitewide/json/addToCart.jsp" />

                        <%-- Quantity Select --%>
                        <div class="field-quantity">
                            <label for="quantity"><fmt:message key="pdp.quantity" /></label>
                            <div class="custom-select">
                                <dsp:select id="quantity" iclass="form-control" bean="CartModifierFormHandler.quantity">
                                    <c:forEach var="qtyValue" begin="1" end="20">
                                        <dsp:option value="${qtyValue}">${qtyValue}</dsp:option>
                                    </c:forEach>
                                </dsp:select>
                                <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                            </div>
                        </div>

                        <%-- Product Specific pdpRecordType Fields --%>
                        <c:choose>
                            <c:when test="${pdpRecordType eq 'simple' || pdpRecordType eq 'licensed'}">
                                <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrder" value="true" />
                            </c:when>
                            <c:otherwise>
                                <dsp:input type="hidden" bean="CartModifierFormHandler.addConfigurableItemToOrder" value="true" />
                            </c:otherwise>
                        </c:choose>

                        <%-- Add to Cart Button --%>
                        <div class="field-add-to-cart">
                            <label class="sr-only" for="add-to-cart">${addToCartButtonText}</label>
                            <input id="add-to-cart-submit" type="submit" class="button primary add-to-cart-submit" aria-label="${addToCartButtonText}" value="${addToCartButtonText}&nbsp;&nbsp;|&nbsp;&nbsp;${buttonPrice}" />
                        </div>
                    </dsp:form>

                    <%-- Add Warrenty Protection Plan form handler. Posted from button click in add to cart modal. --%>
                    <dsp:form id="addPlan" action="/rwd/checkout/cart.jsp" method="post" formid="addPlan" name="addPlan" autocomplete="off">
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="/rwd/checkout/cart.jsp" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="/rwd/checkout/cart.jsp" />
                        <dsp:input type="hidden" id="confId" bean="CartModifierFormHandler.configurableCommerceItemId" value="" />
                        <dsp:input type="hidden" id="planQuantity" bean="CartModifierFormHandler.planQuantity" value="1" />
                        <dsp:input type="hidden" id="removePlan" bean="CartModifierFormHandler.removePlan" value="false" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addTreatmentPlanToOrder" value="true" />
                    </dsp:form>
                </c:when>
                <c:otherwise>
                    <%-- Render Contact Store Button if product is NOT available for online purchase --%>

                    <div id="in-store-only">
                    <c:if test="${pdpRecordType ne 'sectional'}">
                        <div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
                    </c:if>
                        <a href="${contextPath}/storeLocator/storeLocator.jsp" class="button secondary in-store-only-button" aria-label="${contactStoreButtonText}">
                            ${contactStoreButtonText}<span class="asterisk hide">*</span>
                        </a>
                    </div>

                    <input id="dealerid" type="hidden" name="dealer" value="${dealerId}" />
                    <input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="${productId}" />
                    <input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="${productSkuId}" />
                    <input id="exceptionid" type="hidden" name="exceptionid" value="" />
                    <input id="iteminfo" type="hidden" name="iteminfo" value="" />
                    <input id="isSelectPrice" type="hidden" name="isSelectPrice" value="" />
                    <input id="selectExceptionOptions" type="hidden" name="selectExceptionOptions" value="" />
                    <input id="coverId" type="hidden" name="coverId" value="${defaultCoverSkuId}" />
                    <input id="datavnt" type="hidden" name="datavnt" value="${productVNT}" />
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Render Product Add To Cart Links --%>
        <%-- NOTE: Links are only rendered for specific pdpRecordType --%>
        <c:if test="${pdpRecordType ne 'licensed' && (pdpRecordType eq 'configurable' || pdpRecordType eq 'sectional' || pdpRecordType eq 'simple')}">
            <div class="add-to-cart-links">
                <ul>
                    <%-- NOTE: Estimated Shipping Cost Modal is only rendered for specific pdpRecordType and must be a purchaseable product --%>
                    <c:if test="${pdpRecordType eq 'configurable' && isPurchaseable eq 'true'}">
                        <li>
                            <a href="${contextPath}/browse/ajax/estimateShippingCostModal.jsp?productSkuId=${productSkuId}&price=${linkPrice}" id="estimated-shipping-link" class="modal-trigger" data-size="small" data-target="estimated-shipping" aria-label="${estimateShippingCostText}">
                                ${estimateShippingCostText}
                            </a>
                        </li>
                    </c:if>
                    <li>
                        <a href="${contextPath}/storeLocator/storeLocator.jsp" aria-label="${seeItInStoreText}">
                            ${seeItInStoreText}
                        </a>
                    </li>
                </ul>
            </div>
        </c:if>

        <%-- Render Custom Order Notice --%>
        <c:if test="${not empty productCoverList}">
            <div class="custom-order-notice hide">
                <p class="small"><fmt:message key="pdp.customOrderNotice" /></p>
            </div>
        </c:if>
    </c:if>

</dsp:page>