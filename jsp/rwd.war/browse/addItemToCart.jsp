<%--
    - File Name: addItemToCart.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page adds an item to the cart on page load. Currently used for Augmented Reality(AR) mobile app.
    - Required Parameters:
        - iteminfo: base64 encoded json string
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="iteminfo" param="iteminfo" />

    <layout:default>
        <jsp:attribute name="section">browse</jsp:attribute>
        <jsp:attribute name="pageType">addItemToCart</jsp:attribute>
        <jsp:attribute name="analyticsPageType">addItemToCartPage</jsp:attribute>

        <jsp:body>
            <div class="section-row">
				<div class="section-content">
                    <%-- Base64 encoded JSON String --%>
                    <input id="encodedIteminfo" type="hidden" name="encodedIteminfo" value="${iteminfo}" />

                    <%-- Render Add to Cart Form. Shown by default --%>
                    <dsp:form id="add-item-to-cart-form" formid="add-item-to-cart-form" name="addToCart" method="post" autocomplete="off" action="${requestScope['javax.servlet.forward.request_uri']}">
                        <input id="dealerid" type="hidden" name="dealer" value="" />
                        <dsp:input id="productid" type="hidden" bean="CartModifierFormHandler.productId" value="" />
                        <dsp:input id="catalogrefid" type="hidden" bean="CartModifierFormHandler.catalogRefIds" value="" />
                        <input id="iteminfo" type="hidden" name="iteminfo" value="" />
                        <input id="quantity" type="hidden" name="quantity" value="1" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderErrorURL" value="${contextPath}/sitewide/json/addToCart.jsp" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addItemToOrderSuccessURL" value="${contextPath}/sitewide/json/addToCart.jsp" />
                        <dsp:input type="hidden" bean="CartModifierFormHandler.addConfigurableItemToOrder" value="true" />
                    </dsp:form>

                    <div id="action-content" class="align-center hide">
                        <div class="pdp-action hide">
                            <%-- NOTE: pdp url is populated in the javascript from the json response --%>
                            <p><a href="#" class="pdp-link">Back to Product Page</a></p>
                            <p><fmt:message key="common.or"/></p>
                        </div>
                        <p><a href="${contextPath}" class="button primary"><fmt:message key="common.continueShopping"/></a></p>
                    </div>
                </div>
            </div>
        </jsp:body>
    </layout:default>

</dsp:page>