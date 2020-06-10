<json:object>
	<json:property name="id" value="${productId}" />
	<json:property name="name" value="${productName}" escapeXml="false"/>
	<json:property name="brand" value="${productBrand}" escapeXml="false"/>
	<json:property name="category" value="${category}" />
	<json:property name="list" value="${list}" />
	<c:if test="${!empty position}">
		<json:property name="position" value="${position}" />
	</c:if>
</json:object>