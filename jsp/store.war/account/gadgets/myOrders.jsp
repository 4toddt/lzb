<%--
  This page displays list of orders available for the current profile

  Required parameters:
    None

  Optional parameters:
    howMany defines how many orders display on page
    start  start index of the order to display
    viewAll if true, display all available orders on a single page
 --%>
<dsp:page>
	<!-- All component imports goes here -->
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBOrderSummaryDroplet" />
	<jsp:body>
      <%-- List of orders --%>
      <div>

        <%--
          Retrieve orders for the Profile

          Input parameters:
            userId
              Profile Id
            sortBy
              property to sort by, we pass in 'submittedDate' to sort orders by date
            state
              one of the two 'virtual' states, could be 'open' or 'closed'. Real states
              are controlled via 'closedStates' and 'openStates' which are comma-separated
              list of 'real' states. In this case we want to return only 'closed' orders
              (i.e. submitted, processing, and so on). See /atg/commerce/order/OrderLookup
              configuration settings for details
            numOrders
              number of orders to return

          Output parameters:
            result
              array of Order objects
            totalCount
              total number of order objects
            count
              size of the array of order objects
        --%>
        <dsp:getvalueof var="arrStrt" param="arrayStarts"/>
        <dsp:droplet name="OrderLookup">
        	<dsp:param name="userId" bean="Profile.id" />
			<dsp:param name="sortBy" value="submittedDate" />
			<dsp:param name="state" value="open" />
			<!-- change this accordingly, to change the no of orders to display -->
			<c:set var="howManyToDisplay" value="10" />
			<dsp:param name="numOrders" value="${howManyToDisplay}" />
			<dsp:param name="startIndex" value="${arrStrt-1}" />
			<dsp:getvalueof var="orders" param="result" />
			<dsp:getvalueof var="size" param="totalCount" />

	          <dsp:oparam name="output">

	              <div>
	              	<!-- order history instructions -->
					<fmt:message key="orderHistory.info1"/>
					<fmt:message key="orderHistory.info2"/>
				  </div>
	            <table border="0" summary="profile_orders" cellspacing="0" cellpadding="0">
	              <%-- Top pagination controls --%>
					<dsp:include page="paginationControl.jsp">
						<dsp:param name="numOrders" value="${howManyToDisplay}"/>
						<dsp:param name="totalCount" value="${size}"/>
					</dsp:include>

	              <%-- Table header --%>
	              <thead >
	                <tr>
		                <th scope="col"><fmt:message key="orderHistory.tableHead1"/></th>
		                <th scope="col"><fmt:message key="orderHistory.tableHead2"/></th>
		                <th scope="col"><fmt:message key="orderHistory.tableHead3"/></th>
		                <th scope="col"><fmt:message key="orderHistory.tableHead4"/></th>
		                <th scope="col"><fmt:message key="orderHistory.tableHead5"/></th>
	                </tr>
	              </thead>

	              <tbody>
	                <%--
	                  Iterate over the collection of orders and display order information:
	                  order #, site information, order status, and number of items in order
	                  --%>
	                <c:forEach var="order" items="${orders}" varStatus="status">
						<dsp:param name="order" value="${order}" />
						<dsp:droplet name="LZBOrderSummaryDroplet">
							<dsp:param name="order" value="${order}"/>
							<dsp:param name="profile" bean="Profile"/>
					        <dsp:oparam name="output">
			       				<dsp:getvalueof var="commerceItemCount" param="totalNumberOfItems" />
			         			<dsp:getvalueof var="shippingCurrency" param="shippingCharge"/>
			         			<dsp:getvalueof var="taxCost" param="tax"/>
			         			<dsp:getvalueof var="totalItemCosts" param="totalItemCost"/>
			         			<dsp:getvalueof var="coverPlanItems" param="planItems"/>
			         			<dsp:getvalueof var="totalPrice" param="total"/>
			         			<dsp:getvalueof var="surCharge" param="surCharge"/>
			         			<dsp:getvalueof var="promoAmount" param="promoAmount"/>
								<dsp:getvalueof var="orderCombination" param="orderCombination"/>
					        </dsp:oparam>
					    </dsp:droplet>
	                  
	                  <tr>

	                     <%-- Link to 'Order Details' page --%>
	                    <td scope="row">
						   <dsp:getvalueof var="orderId" param="order.id"/>
	                       <dsp:a href="${pageContext.request.contextPath}/global/gadgets/orderSummary.jsp" title="${orderNumberLinkTitle}">
		                       <dsp:param name="orderId" value="${orderId }"/>
		                       ${orderId}
	                      </dsp:a>
	                    </td>

	                    <%--Order submitted date--%>
	                    <td>
	                      <dsp:getvalueof var="submittedDate" vartype="java.util.Date" param="order.submittedDate" />
	                       <fmt:formatDate pattern="yyyy-MM-dd"	value="${submittedDate}" />
	                    </td>

	    				<%-- Order total--%>
	    				<td>
	    					<dsp:valueof converter="currency" value="${totalPrice}" format="#.00"  />
	    				</td>

	    				<td>
	    					<dsp:getvalueof param="order.shippingGroups" var="shippingGroups"/>
	    					<c:choose>
		    					<c:when test="${ not empty shippingGroups }" >
		    						<dsp:valueof param="order.shippingGroups[0].shippingAddress.firstName"/>&nbsp;
		    						<dsp:valueof param="order.shippingGroups[0].shippingAddress.lastName"/>
		    					</c:when>
		    					<c:otherwise>
		    						<fmt:message key="orderDetail.delivery"/>
		    					</c:otherwise>
	    					</c:choose>
	                    </td>
	                     <%-- Order status --%>
	                     <td>
	                        <dsp:include page="${pageContext.request.contextPath}/global/util/orderState.jsp">
								<dsp:param name="orderCombination" value="${orderCombination}"/>
							</dsp:include>
	                     </td>
	                  </tr>
	                </c:forEach>
	              </tbody>
	            </table>
	          </dsp:oparam>
	          <%-- Display message if user does not have orders --%>
	          <dsp:oparam name="empty">
	           	<fmt:message key="orderHistory.noOrder"/><dsp:a href="${pageContext.request.contextPath}/index.jsp"><fmt:message key="orderHistory.shopNow"/></dsp:a>
	          </dsp:oparam>
        </dsp:droplet>
      </div>
    </jsp:body>
</dsp:page>