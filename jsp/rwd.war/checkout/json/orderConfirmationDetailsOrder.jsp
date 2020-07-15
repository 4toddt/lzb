<%--
    - File Name: orderConfirmationDetailsOrder.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the order detail json for a speciic order.
    - Required Parameters:
        - order
    - Optional Parameters:
--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>

<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
    <dsp:importbean bean="/atg/userprofiling/Profile"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBDisplayCartItemsDroplet"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="order" param="order"/>

    <dsp:droplet name="LZBOrderSummaryDroplet">
        <dsp:param name="order" param="order"/>
        <dsp:param name="profile" bean="Profile"/>
        <dsp:param name="page" value="orderConfirmation"/>
        <dsp:oparam name="output">
            <dsp:getvalueof var="totalItemCost" param="totalItemCost"/>
            <dsp:getvalueof var="shippingCharge" param="shippingCharge"/>
            <dsp:getvalueof var="tax" param="tax"/>
            <dsp:getvalueof var="total" param="total"/>
        </dsp:oparam>
    </dsp:droplet>

    <%-- JSON Structure --%>
    <json:object>
        <json:property name="order">${order.id}</json:property>

        <json:property name="subTotal">
            <fmt:formatNumber value="${totalItemCost}" minFractionDigits="2" maxFractionDigits="2"/>
        </json:property>

        <json:property name="delivery">
            <fmt:formatNumber value="${shippingCharge}" minFractionDigits="2" maxFractionDigits="2"/>
        </json:property>

        <json:property name="tax">
            <fmt:formatNumber value="${tax}" minFractionDigits="2" maxFractionDigits="2"/>
        </json:property>

        <json:property name="total">
            <fmt:formatNumber value="${total}" minFractionDigits="2" maxFractionDigits="2"/>
        </json:property>

        <json:array name="items">
            <dsp:droplet name="LZBDisplayCartItemsDroplet">
                <dsp:param name="profile" bean="Profile"/>
                <dsp:param name="order" param="order"/>
                <dsp:oparam name="output">
                    <dsp:getvalueof var="cartItems" param="cartItems"/>

                    <%-- generates the json object for each item in the array --%>
                    <dsp:droplet name="ForEach">
                        <dsp:param name="array" value="${cartItems}"/>
                        <dsp:param name="elementName" value="cartItem"/>
                        <dsp:oparam name="output">
                            <dsp:getvalueof var="protectionPlan" param="cartItem.protectionPlan"/>

                            <json:object>
                                <json:property name="name">
                                    <dsp:valueof param="cartItem.commerceItem.auxiliaryData.catalogRef.displayName"/>
                                </json:property>

                                <json:property name="category">
                                    <dsp:droplet name="ForEach">
                                        <dsp:param name="array"  param="cartItem.commerceItem.auxiliaryData.productRef.parentCategories"/>
                                        <dsp:param name="elementName" value="category"/>
                                        <dsp:oparam name="output">
                                            <dsp:valueof param="category.displayName"/>
                                        </dsp:oparam>
                                    </dsp:droplet>
                                </json:property>

                                <json:property name="qty">
                                    <dsp:valueof param="cartItem.commerceItem.quantity"/>
                                </json:property>

                                <json:property name="price">
                                    <dsp:getvalueof var="listPrice" param="cartItem.listPrice"/>
                                    <dsp:getvalueof var="salePrice" param="cartItem.salePrice"/>
                                    <c:choose>
                                        <c:when test="${empty salePrice || salePrice <= 0.0}">
                                            <fmt:formatNumber value="${listPrice}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${salePrice}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </c:otherwise>
                                    </c:choose>
                                </json:property>

                                <c:if test="${not empty protectionPlan}">
                                    <json:property name="protectionPlanPrice">
                                        <dsp:getvalueof var="planSalePrice" param='cartItem.protectionPlan.priceInfo.salePrice'/>
                                        <dsp:getvalueof var="planListPrice" param='cartItem.protectionPlan.priceInfo.listPrice'/>

                                        <c:choose>
                                            <c:when test="${planSalePrice gt 0 }">
                                                ${planSalePrice}
                                            </c:when>
                                            <c:otherwise>
                                                ${planListPrice}
                                            </c:otherwise>
                                        </c:choose>
                                    </json:property>
                                </c:if>
                            </json:object>

                        </dsp:oparam>
                    </dsp:droplet>
                </dsp:oparam>
            </dsp:droplet>
        </json:array>
    </json:object>
</dsp:page>
