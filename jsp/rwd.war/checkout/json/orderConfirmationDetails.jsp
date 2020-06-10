<%--
    - File Name: orderConfirmationDetails.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders the order details json for all orders and related orders on the order confirmation page for analytics and 3rd party tags.
    - Required Parameters:
        - order
    - Optional Parameters:
--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>

<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
    <dsp:importbean bean="/atg/userprofiling/Profile"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBGetRelatedOrdersDroplet" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="order" param="order"/>

    <dsp:droplet name="LZBGetRelatedOrdersDroplet" >
        <dsp:param name="order" param="order"/>
        <dsp:oparam name="output">
            <dsp:getvalueof var="relatedOrders" param="relatedOrders" />
        </dsp:oparam>
    </dsp:droplet>

    <%-- JSON Structure --%>
    <json:object>
        <json:array name="orders">
            <%-- START: regular order --%>
            <dsp:include page="/checkout/json/orderConfirmationDetailsOrder.jsp">
                <dsp:param name="order" param="order"/>
            </dsp:include>
            <%-- END: regular order --%>

            <%-- START: related orders --%>
            <c:if test="${not empty relatedOrders}">
                <dsp:droplet name="ForEach">
                    <dsp:param name="array" value="${relatedOrders}"/>
                    <dsp:param name="elementName" value="relOrder"/>
                    <dsp:oparam name="output">
                        <dsp:getvalueof var="rOrder" param="relOrder"/>

                        <dsp:include page="/checkout/json/orderConfirmationDetailsOrder.jsp">
                            <dsp:param name="order" param="relOrder"/>
                        </dsp:include>

                    </dsp:oparam>
                </dsp:droplet>
            </c:if>
            <%-- END: related orders --%>

        </json:array>
    </json:object>
</dsp:page>
