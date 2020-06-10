<dsp:page>
    <dsp:importbean bean="/atg/userprofiling/Profile" scope="request" />
    <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <c:choose>
        <c:when test="${not empty productRecord['sku.cover']}">
            <c:set var="coverTap" value="${true}" />
            <!--coverTap = true-->
        </c:when>
        <c:otherwise>
            <c:set var="coverTap" value="${false}" />
            <!--coverTap = false-->
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${not empty productRecord['sku.configurableOptionNames']}">
           <!--not empty productRecord['sku.configurableOptionNames'] = true-->
           <!-- option names = ${productRecord['sku.configurableOptionNames']}-->
            <c:set var="optionArray" value="${fn:split(productRecord['sku.configurableOptionNames'], '|')}" />
            <c:set var="optionArrayLength" value="${fn:length(optionArray)}" />
            <!-- optionArrayLength = ${optionArrayLength} -->
            <c:choose>
                <c:when test="${optionArrayLength gt 1 and coverTap eq true}">
                    <c:set var="optionTap" value="${true}" />
                    <!--optionTap = true-->
                </c:when>
                <c:otherwise>
                    <c:set var="optionTap" value="${false}" />
                    <!--optionTap = false-->
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <!--not empty productRecord['sku.configurableOptionNames'] = false-->
            <c:set var="optionTap" value="${false}" />
            <!--optionTap = false-->
        </c:otherwise>
    </c:choose>
    <dsp:getvalueof var="defaultCoverSkuForImgCover" value="${productRecord['sku.defaultCover']}" scope="request" />
    <dsp:getvalueof var="defaultCoverSkuForImg" value="${fn:split(defaultCoverSkuForImgCover,'~')[0]}" scope="request" />

    <div id="pdpCustomizationOptions">
        <div class="accordion-group" data-module="accordion-group" data-group="cover-main">
            <c:if test="${ coverTap eq true}">
                <div class="accordion-section cover-selector active">
                    <div class="section-header">
                        <!-- defaultCover = ${defaultCover} -->
                        <dsp:include page="coverSelectorHeader.jsp" >
                            <dsp:param name="defaultCover" value="${defaultCover}"/>
                        </dsp:include>
                    </div>
                    <div class="section-content">
                        <dsp:include src="${pageContext.request.contextPath}/browse/pdp/pdpCoverSelectorContent.jsp"/>
                    </div>
                </div>
            </c:if> <%-- if cover tab --%>
            <c:if test="${ optionTap eq true}">
                <div class="accordion-section opts" data-module="opt-upg-section">
                    <div class="section-header">
                        <dsp:include src="${pageContext.request.contextPath}/browse/pdp/optionsAndUpgradesHeader.jsp"/>
                    </div>
                    <div class="section-content">
                        <div class="loading-gif" style="display:none;" data-module="pdp-options-upgrades">
                            <img src="/img/loading.gif" />
                        </div>
                        <div class="accordion-group pdp-opt-upg" id="optionsUpgrades" data-module="showPDPOptionSwatches"></div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</dsp:page>