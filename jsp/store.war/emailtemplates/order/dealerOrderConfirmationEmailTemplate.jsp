<%@ taglib prefix="dsp"	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	<dsp:importbean bean="/atg/commerce/order/OrderLookup"/>
	<dsp:getvalueof var="order" param="lastOrder"/>
	<dsp:getvalueof var="dealer" param="dealer"/>
	
	
	<dsp:droplet name="OrderLookup">
       <dsp:param name="orderId" param="lastOrder"/>
       <dsp:oparam name="output">
			<dsp:getvalueof var="order" param="result"/>
			<dsp:getvalueof var="shippingGroup" param="result.shippingGroups[0]"/>
			<dsp:getvalueof var="paymentGroup" param="result.paymentGroups[0]"/>
			<dsp:getvalueof var="commerceItems" param="result.commerceItems"/>
		</dsp:oparam>
	</dsp:droplet>
	
	
	<table>
		<tr>
			<td>
				${dealer.dealerName},
			</td>
		</tr>
		<tr>
			<td>
				Below are the details for customer order ${order.id}. <br> Your order (PO) number is ${order.PONumber}.
			</td>
		</tr>
		<tr>
			<td>
				ORDER INFORMATION
			</td>
		</tr>
		<tr>
			<td>
				Order #:${order.id}
			</td>
		</tr>
		<tr>
			<td>
				Order Date:<dsp:getvalueof var="submittedDate" vartype="java.util.Date" value="${order.submittedDate}" /><fmt:formatDate type="date" value="${submittedDate}" />
			</td>
		</tr>
		<tr>
			<th>SOLD TO:</th>
		</tr>
		<tr>
			<td>
							${paymentGroup.billingAddress.firstName}&nbsp;
							${paymentGroup.billingAddress.lastName}<br/>
							${paymentGroup.billingAddress.address1}&nbsp;
							${paymentGroup.billingAddress.address2}<br/>
							${paymentGroup.billingAddress.city}&nbsp;
							${paymentGroup.billingAddress.state}&nbsp;
							${paymentGroup.billingAddress.postalCode}<br/>
							${paymentGroup.billingAddress.country}<br/>							
			</td>
		</tr>
		<tr>
			<th>ITEMS DELIVERING TO:</th>
		</tr>
		<tr>
			<td>
							${shippingGroup.shippingAddress.firstName}&nbsp;
							${shippingGroup.shippingAddress.lastName}<br/>
							${shippingGroup.shippingAddress.address1}&nbsp;
							${shippingGroup.shippingAddress.address2}<br/>
							${shippingGroup.shippingAddress.city}&nbsp;
							${shippingGroup.shippingAddress.state}&nbsp;
							${shippingGroup.shippingAddress.postalCode}&nbsp;
							${shippingGroup.shippingAddress.country}<br/>
							<dsp:getvalueof var="shipMethod" value="${shippingGroup.shippingMethod}"/>						
			</td>
		</tr>
		<dsp:droplet name="ForEach">
			<dsp:param name="array" value="${commerceItems}" />
			<dsp:param name="elementName" value="commerceItem" />
			<dsp:oparam name="output">
				<tr>
					<td>Qty:</td>
					<td><dsp:valueof param="commerceItem.quantity"/></td>
				</tr>
				<tr>
					<td>Description:</td>
					<td><dsp:valueof param="commerceItem.auxiliaryData.catalogRef.displayName"/></td>
				</tr>
				<tr>
					<td>Item #:</td>
					<td><dsp:valueof param="commerceItem.catalogRefId" /></td>
				</tr>
				<tr>
					<td>Unit Price:</td>
					<td>
						<dsp:include page="../../global/includes/formattedPrice.jsp">
							<dsp:param name="price" param="commerceItem.priceInfo.listPrice" />
						</dsp:include>
					</td>
				</tr>
				<tr>
					<td>Item Total:</td>
					<td>
						<dsp:getvalueof var="amount" param="commerceItem.priceInfo.rawTotalPrice" /> 
						<dsp:include page="../../global/includes/formattedPrice.jsp">
							<dsp:param name="price" value="${amount}" />
						</dsp:include>
					</td>
				</tr>
				<tr>
					<td>Delivery Method:</td>
					<td>${shipMethod}</td>
				</tr>
			</dsp:oparam>
		</dsp:droplet>
		<tr>
			<dsp:getvalueof var="shipCharge" value="${order.priceInfo.shipping}"/>
			<td>Home Delivery from Local Store Charge: <dsp:valueof value="${shipCharge}" converter="currency" /></td>
		</tr>
		<tr>
			<td>Thank You</td>
		</tr>
	</table>
</dsp:page>