<dsp:page>
    <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
    <dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
    <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
    <dsp:importbean bean="/atg/userprofiling/Profile" scope="request" />
    <dsp:importbean bean="/atg/userprofiling/ProfileTools" scope="request" />
    <dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
    <dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
    <dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
    <dsp:importbean bean="/com/lzb/service/SessionBean"/>
    <dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" />

    <dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
    <dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}"  scope="request"/>
    <dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer" scope="request"/>
    <dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer" scope="request"/>
    <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
    <dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" scope="request"/>
    <dsp:getvalueof var="transient" bean="Profile.transient" />
    <dsp:getvalueof param="coverId" var="coverId" scope="request"/>
    
    <!-- price display -->
    <meta itemprop="sku" content="${productRecord['product.displayName']}">
    <fmt:parseNumber var="lowestSalePrice" value="${salePrice}"/>
    <fmt:formatNumber var="formatLowestSalePrice" value="${lowestSalePrice}" type="currency" />
    <fmt:parseNumber var="lowestPrice" value="${listPrice}"/>
    <fmt:formatNumber var="lowestPriceDecimal" value="${lowestPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
    <fmt:formatNumber var="formatLowestPrice" value="${lowestPrice}" type="currency" />

    <%-- START: HELPER TO MAP PARAM VALUES, 'param' attrubute can be changed to 'bean' --%>
<dsp:tomap param="productRecord" var="paramVar"/>
<c:forEach var="entry" items="${paramVar}">
  <strong><c:out value="${entry.key}"/></strong>:  <c:out value="${entry.value}"/> <br/>
</c:forEach>
<%-- END: HELPER TO MAP PARAM VALUES --%>

    <c:choose>
        <c:when test ="${empty coverId}">
            <dsp:getvalueof var="defaultCoverSkuId" value="${fn:split(productRecord['sku.defaultCover'],'~')[0]}" scope="request"/>
        </c:when>
        <c:otherwise>
            <dsp:getvalueof var="defaultCoverSkuId" value="${coverId}" scope="request"/>
        </c:otherwise>
    </c:choose>

    <dsp:getvalueof var="hostName" bean="LZBStoreConfiguration.hostName" />
    <%--
        <c:if test="${empty storeConfigHostName}">
            <c:set var="storeConfigHostName" value="${hostName}" />
        </c:if>
    --%>
    <c:set var="contentHostName" value="//content.la-z-boy.com" scope="request"/>

    <%-- </jsp:attribute> --%>

    <input type="hidden" class="pdpPageType" value="configurable" />

    <dsp:getvalueof var="jsonreq" value="${jsonRequestValue}" scope="request" />
    <dsp:getvalueof var="item_qty" param="${itemQtyValue}" scope="request" />
    <%--<dsp:getvalueof var="discontinued" value="${productRecord['sku.isPurchaseable']}" />--%>

    <input type="hidden" id="jsonReqInput" name="jsonReqInput" value='${jsonreq}' />

    <!-- START Product Title/Price row -->
    <dsp:include page="${pageContext.request.contextPath}/browse/pdp/productTitleBar.jsp">
        <dsp:param name="skuId" value="${productRecord['sku.repositoryId']}" />
        <dsp:param name="page" value="pdp"/>
        <dsp:param name="lowestSalePrice" value="${lowestSalePrice}"/>
        <dsp:param name="lowestPrice" value="${lowestPrice}"/>
        <dsp:param name="formatLowestSalePrice" value="${formatLowestSalePrice}" />
        <dsp:param name="lowestPriceDecimal" value="${lowestPriceDecimal}"/>
        <dsp:param name="formatLowestPrice" value="${formatLowestPrice}"/>
    </dsp:include>
    <!-- END Product Title/Price row -->

    <%-- Display Product Images --%>
    <dsp:include page="${pageContext.request.contextPath}/browse/pdp/productImages.jsp">
			<dsp:param name="defaultCover" value="${defaultCoverSkuId}" />
		</dsp:include>

    <%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
    <section role="region" itemprop="offers" itemscope itemtype="http://schema.org/Offer">

        <c:choose>
            <c:when test ="${empty coverId}">
                <dsp:getvalueof var="defaultCover" value="${productRecord['sku.defaultCover']}" scope="request"/>
            </c:when>
            <c:otherwise>
                <dsp:droplet name="LZBSKUCoverParserDroplet">
                    <dsp:param name="skuCoverList" value="${productRecord['sku.cover'] }" />
                    <dsp:param name="coverId" value="${coverId}" />
                    <dsp:oparam name="output">
                        <dsp:getvalueof var="defaultCover" param="coverDetails" scope="request"/>
                    </dsp:oparam>
                </dsp:droplet>
            </c:otherwise>
        </c:choose>
        <!-- configurablesku.jsp defaultCover = ${defaultCover} -->
        <dsp:getvalueof var="productId" value="${productRecord['product.repositoryId']}" />
        <dsp:getvalueof var="prodDisplayName" value="${productRecord['product.displayName']}"/>
        <dsp:getvalueof var="skuId" param="sku.id" />
        <dsp:getvalueof var="editCommerceItemId" param="commid" />
        <dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" />
        <dsp:getvalueof var="productid" value="${productRecord['product.repositoryId'] }" />
        <dsp:droplet name="LZBPDPURLDroplet">
            <dsp:param name="productId" value="${productid}" />
            <dsp:param name="elementName" value="url" />
            <dsp:oparam name="output">
                <dsp:getvalueof var="pdpurl" param="url" scope="request"/>
            </dsp:oparam>
        </dsp:droplet>
        <div style="display:none;">
            <div id="addedToCartModal" data-module="cbox"></div>
        </div>
        <div id="addToCartModalLink" data-module="cbox" data-transition="elastic" data-speed="350" data-initial-height="640" data-inline="true">
            <a href="#addedToCartModal" type="button" class="modal"></a>
        </div>
        <div id="addToCartError"></div>
        <dsp:getvalueof var="currentDealerId" bean="ProfileTools.priceListId" scope="request" />
        <dsp:getvalueof var="dealer" bean="PriceListManager.tempDealer" scope="request" />

         <dsp:include page="${pageContext.request.contextPath}/includes/styleCollectionsByItem.jsp">
            <dsp:param name="skuId" value="${productRecord['sku.repositoryId']}" />
            <dsp:param name="page" value="pdp"/>
        </dsp:include>

        <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpProductOptions.jsp"/>


        <%-- START Add to Cart --%>
        <dsp:include page="${pageContext.request.contextPath}/browse/pdp/productAddToCart.jsp">
            <dsp:param name="skuId" value="${productRecord['sku.repositoryId']}" />
            <dsp:param name="prodId" value="${productId}" />
            <dsp:param name="ProdName" value="${prodDisplayName}" />
            <dsp:param name="page" value="pdp"/>
            <dsp:param name="lowestSalePrice" value="${lowestSalePrice}"/>
            <dsp:param name="lowestPrice" value="${lowestPrice}"/>
            <dsp:param name="formatLowestSalePrice" value="${formatLowestSalePrice}" />
            <dsp:param name="lowestPriceDecimal" value="${lowestPriceDecimal}"/>
            <dsp:param name="formatLowestPrice" value="${formatLowestPrice}"/>
            <dsp:param name="editCommerceItemId" value="${editCommerceItemId}" />
        </dsp:include>
        <%-- END Add to Cart --%>

    </section>

    <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpInfo.jsp"/>

</dsp:page>