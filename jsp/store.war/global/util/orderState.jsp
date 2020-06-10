<%--
  This gadget displays order state.
  
  Required parameters:
    order
      The order to display state for.
      
  Optional parameters:
    None.
 --%>
<dsp:page>

  <dsp:importbean bean="/atg/commerce/order/OrderStatesDetailed"/>
    
  <%--
    Translates an order's state value into it's description.
    
    Input parameters:
      state
        The state value of order.
      elementName
        The optional parameter that should be used for the name of the description value 
        which is bound into the scope of the output oparam.
        
    Output parameters:
      element or specified in the <elementName> parameter
        Localized state description.
   --%>
   <dsp:getvalueof var="stateInt" param="order.state"/>
   <dsp:getvalueof var="submittedDate" vartype="java.util.Date" param="order.submittedDate" />
   <dsp:getvalueof var="orderCombination" param="orderCombination" />

  <dsp:droplet name="OrderStatesDetailed">
    <dsp:param name="state" param="order.stateAsString"/>
    <dsp:param name="elementName" value="orderStateDescription"/>
    <dsp:oparam name="output">
      <dsp:getvalueof var="stateDesc" param="orderStateDescription"/>
	      <c:choose>
            <c:when test="${not empty orderCombination && orderCombination ne 'onlyConfigurable'}" >
  	  			For delivery and tracking information, view
                <dsp:a href="${pageContext.request.contextPath}/global/gadgets/orderSummary.jsp">
                    <dsp:param name="orderId" param="order.id"/>
                    Order Detail.
               </dsp:a>
  	      	</c:when>
            <c:when test="${stateInt eq 201 }" >
	  			Order Confirmed, Deposit Charged
	      	</c:when>
	      	<c:when test="${stateInt eq 202 }" >
	      		<!-- 202=Delivery Scheduled xx/xx,\ -->
	      		Delivery Scheduled <fmt:formatDate pattern='MM/YY' value='${submittedDate}' /> 
	      	</c:when>
	      	<c:when test="${stateInt eq 204 }" >
	      		<!-- 204=Delivery Scheduled xx/xx, Balance Charged,\ -->
	      		Delivery Scheduled <fmt:formatDate pattern='MM/YY' value='${submittedDate}' />, Balance Charged 
	      	</c:when>
	      	<c:when test="${stateInt eq 208 }" >
	      		<!-- 208=Delivered xx/xx, Order Complete,\ -->
	      		Delivered <fmt:formatDate pattern='MM/YY' value='${submittedDate}' />, Order Complete 
	      	</c:when>
	      	<c:otherwise>
	      		${stateDesc}
	      	</c:otherwise>
	      </c:choose>
    </dsp:oparam>
    <dsp:oparam name="error"><fmt:message key="common.orderProcessing"/></dsp:oparam>
  </dsp:droplet>

</dsp:page>
<%-- @version $Id: //hosting-blueprint/B2CBlueprint/version/11.1/Storefront/j2ee/store.war/global/util/orderState.jsp#1 $$Change: 875535 $--%>
