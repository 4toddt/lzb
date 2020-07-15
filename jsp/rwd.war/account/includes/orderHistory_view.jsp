<%--
	- File Name: orderHistory_view.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: Order history page that contains all a users orders
	- Parameters:
	-
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/OrderLookup" />

	<%-- Page Variables --%>

	<%-- Render Order History Records --%>
	<section role="region" class="order-history-container">
	
		<%-- <div class="section-title hide-for-small">
			<h1><fmt:message key="orderHistory.Header"/></h1>
		</div> --%>
		
		<div class="account-content standard-border">
			 <dsp:droplet name="OrderLookup">
			 	<dsp:param name="userId" bean="Profile.id" />
				<dsp:param name="sortBy" value="submittedDate" />
				<dsp:param name="state" value="open" />
				<!-- change this accordingly, to change the no of orders to display -->
				<c:set var="howManyToDisplay" value="10" />
				<dsp:param name="numOrders" value="${howManyToDisplay}" />
				<dsp:param name="startIndex" value="${start-1}" />
				<dsp:getvalueof var="orders" param="result" />
				<dsp:getvalueof var="size" param="totalCount" />
				<dsp:oparam name="empty">
					<%-- no orders message --%>
					<div class="order-messages">
						<div class="order-message">
							<p><fmt:message key="orderHistory.noOrder"/></p>
							<a href="${contextPath}/" class="button primary"><fmt:message key="orderHistory.shopNow"/></a>
						</div>
					</div>
				</dsp:oparam>
			 	<dsp:oparam name="output">
			 		<!-- order history instructions -->
					<%-- order messages --%>
					<div class="order-messages">
						<div class="order-message">
							<p><fmt:message key="orderHistory.info1"/></p>
							<p><fmt:message key="orderHistory.info2"/></p>
							<p><fmt:message key="orderHistory.info3"/></p>
						</div>
					</div>
					
					<%-- orders header --%>
					<c:choose>
						<c:when test="${size eq 1}">
					  		<div class="order-history-headers">
					    		<h2><fmt:message key="orderHistory.size1"/>&nbsp;${size}&nbsp;<fmt:message key="orderHistory.size2"/></h2>
					    	</div><%-- .order-history-details --%>
					  	</c:when>
					  	<c:otherwise>
					  		<div class="order-history-headers">
					    		<h2><fmt:message key="orderHistory.size1"/>&nbsp;${size}&nbsp;<fmt:message key="orderHistory.size3"/></h2>
					    	</div><%-- .order-history-details --%>
					  	</c:otherwise>
				  	</c:choose>
				  	
					<div class="order-items order-history-details">
						<%-- order history items --%>
						<dsp:droplet name="/atg/dynamo/droplet/ForEach">
							<dsp:param name="array" param="result"/>
							<dsp:param name="elementName" value="order" />
							<dsp:oparam name="output">
								<dsp:include page="/account/includes/orderHistoryItem.jsp">
									<dsp:param name="order" param="order" />
								</dsp:include>
							</dsp:oparam>
						</dsp:droplet>
					</div>
			 	</dsp:oparam>
			</dsp:droplet>
		</div>
		
	</section>
</dsp:page>