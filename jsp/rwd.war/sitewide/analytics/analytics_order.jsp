<%--
Creates the json for digitalData.order. Populate the following page variables for this:
	orderId  - order Id
	orderAffiliation - affiliation entity for order (google Analytics)
	subtotal - order subtotal
	shipping  - order shipping cost
	shippingMethod - selected shipping method. empty string if not set.
	tax - order tax. set to 0 if not calculated
	total - order total
	discountMap:
		type - type of discount (coupon, promotion, shipping promotion)
		id - coupon code
		name - coupon or promotion name ("$20 off $100")
		amount - discount amount, no currency symbol
	commerceItems
		id - product Id
		name  - product name
		brand - product brand
		sku - sku
		analyticsCategory - category user found the product in (not the default parent category)
		price - unit price of the item
		quantity - number of this sku in the cart
--%>
<json:object>
	<json:property name="id" value="${orderId}"/>
	<json:property name="affiliation" value="${orderAffiliation}"/>
	<json:property name="subtotal" value="${subtotal}"/>
	<json:property name="shipping" value="${shipping}"/>
	<json:property name="shippingMethod" value="${shippingMethod}"/>
	<json:property name="tax" value="${tax}"/>
	<json:property name="total" value="${total}"/>
	<json:array name="discounts">
		<c:forEach var="discount" items="${discountMap}">
			<json:object>
				<json:property name="type" value="${discount.type}"/>
				<json:property name="id"  value="${discount.id}"/>
				<json:property name="name" value="${discount.name}"/>
				<json:property name="amount">
					<fmt:formatNumber value="${discount.amount}" type="currency"/>
				</json:property>
			</json:object>
		</c:forEach>
	</json:array>
	<json:array name="products">
		<c:forEach var="commerceItem" items="${commerceItems}">
			<json:property name="id" value="${commerceItem.auxiliaryData.productRef.id}"/>
			<json:property name="name" value="${commerceItem.auxiliaryData.productRef.displayName}"/>
			<json:property name="brand" value="${commerceItem.auxiliaryData.productRef.brandName}"/>
			<json:property name="sku" value="${commerceItem.catalogRefId}"/>
			<json:property name="category" value="${commerceItem.analyticsCategory}"/>
			<json:property name="price">
				<fmt:formatNumber var="unitPrice"  value="${commerceItem.priceInfo.amount/commerceItem.quantity}" type="number" minFractionDigits="2"  maxFractionDigits="2" pattern="#####.##"/>
			</json:property>
			<json:property name="quantity" value="${commerceItem.quantity}"/>
		</c:forEach>
	</json:array>
</json:object>
