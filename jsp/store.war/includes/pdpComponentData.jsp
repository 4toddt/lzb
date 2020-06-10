<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" scope="request"/>
	<dsp:getvalueof var="productRecord" value="${content.record.attributes}" scope="request"/>
    <c:set var="isConfigurable" value="false" scope="request"/>
    <c:set var="isSectional" value="false" scope="request"/>
    <c:set var="isSimple" value="false" scope="request"/>
	<c:set var="isLicensed" value="false" scope="request" />
    <c:set var="isDiscontinuedConfigurable" value="false" scope="request"/>
    <c:set var="isDiscontinuedSectional" value="false" scope="request"/>
    <c:set var="isDiscontinuedSimple" value="false" scope="request"/>
    <c:set var="isActive" value="A" scope="request"/>
    <c:set var="isPurchasable" value="true" scope="request"/>
    <c:set var="discontinued" value="${productRecord['sku.isPurchaseable']}" scope="request" />
    <dsp:getvalueof var="prodId" value="${productRecord['sku.repositoryId']}" scope="request"/>
    <c:choose>
        <c:when test="${empty productRecord['sku.isPurchaseable']}">
            <c:set var="isPurchasable" value="false" scope="request" />
        </c:when>
        <c:otherwise>
            <c:set var="isPurchasable" value="${productRecord['sku.isPurchaseable']}" scope="request" />
        </c:otherwise>
    </c:choose>
    <c:choose>
        <c:when test="${empty productRecord['sku.status']}">
            <c:set var="isActive" value="D" scope="request" />
        </c:when>
        <c:otherwise>
            <c:set var="isActive" value="${productRecord['sku.status']}" scope="request" />
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${productRecord['record.type'] eq 'Configurable SKU' && isPurchasable eq 'true' && isActive eq 'A'}">
            <!-- Purchasable Configurable Products -->
            <c:set var="isConfigurable" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Configurable SKU' && isPurchasable eq 'true' && isActive eq 'D' }">
            <!-- Purchasable Configurable Products - Discontinued -->
            <c:set var="isDiscontinuedConfigurable" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Configurable SKU' && isPurchasable eq 'false' && isActive eq 'A'}">
            <!-- Non-Purchasable Configurable Products -->
            <c:set var="isSimple" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Configurable SKU' && isPurchasable eq 'false' && isActive eq 'D' }">
            <!-- Non-Purchasable Configurable Products - Discontinued -->
            <c:set var="isDiscontinuedSimple" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'sectional' &&  empty productRecord['sku.cover']}">
        <!-- Sectionals Products - No Covers -->
            <c:set var="isSimple" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'sectional' && isActive eq 'A' }">
            <!-- Sectionals Products - Active -->
            <c:set var="isSectional" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'sectional' && isActive eq 'D' }">
            <!-- Sectionals Products - Discontinued -->
            <c:set var="isDiscontinuedSectional" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Licensed Sku' && isActive eq 'A' }">
            <!-- Licensed Products -->
			<c:set var="isSimple" value="true" scope="request" />
			<c:set var="isLicensed" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Standard Sku' && isActive eq 'A' }">
            <!-- Standard Sku Products -->
			<c:set var="isSimple" value="true" scope="request" />
        </c:when>
        <c:when test="${isPurchasable eq 'false' && isActive eq 'A' }">
            <!-- Non-Purchasable Products -->
            <c:set var="isSimple" value="true" scope="request" />
        </c:when>
        <c:when test="${productRecord['record.type'] eq 'Licensed Sku' && isActive eq 'D'}">
            <!-- Licensed Products - Discontinued -->
            <c:set var="isDiscontinuedSimple" value="true" scope="request" />
			<c:set var="isLicensed" value="true" scope="request" />
        </c:when>
        <c:when test="${isPurchasable eq 'false' && isActive eq 'D'}">
            <!-- Non-Purchasable Discontinued -->
            <c:set var="isDiscontinuedSimple" value="true" scope="request" />
        </c:when>
	</c:choose>
</dsp:page>