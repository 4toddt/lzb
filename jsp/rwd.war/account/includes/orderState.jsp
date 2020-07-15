 <%--
	- File Name: oderState.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This page displays order state.
	- Parameters: order
	- Optional parameters:
--%>
<dsp:page>

	<%-- Imports --%>
  	<dsp:importbean bean="/atg/commerce/order/OrderStatesDetailed"/>

    <%-- Page Variables --%>
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
      	  			<div class="generic-status">
                        For delivery and tracking information, view
                        <dsp:a href="${contextPath}/account/orderDetails.jsp">
                            <dsp:param name="orderId" param="order.id"/>
                            Order Detail.
                       </dsp:a>
                   </div>
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
