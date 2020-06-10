<%--
    - File Name: accordionTitleBar.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product configuration accordion title on the product page.
    - Required Parameters:
        - title: display heading text for accordion title
    - Optional Parameters:
        - type: type of title bar used for logic markup targeting,
        - swatchImgPath: selected swatch image path,
        - summaryDetails: summary details of selected options,
        - summaryDetails2: second line summary details of selected options,
        - optionsTotal: total price for all selected options
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="type" param="type" />
    <dsp:getvalueof var="swatchImgPath" param="swatchImgPath" />
    <dsp:getvalueof var="title" param="title" />
    <dsp:getvalueof var="summaryDetails" param="summaryDetails" />
    <dsp:getvalueof var="summaryDetails2" param="summaryDetails2" />
    <dsp:getvalueof var="optionsTotal" param="optionsTotal" />
    <dsp:getvalueof var="stockMsg" param="stockMsg" />
    <fmt:message var="coverType" key="productConfiguration.coverType" />
    <fmt:message var="selectedPreview" key="productConfiguration.selectedPreview" />
    <fmt:message var="viewCoverDetails" key="pdp.viewCoverDetails"/>
    <c:set var="bottomNoPriceClass" value="" />

    <%-- set specific class if no price is displayed so we can adjust the width of the elements in css --%>
    <c:if test="${optionsTotal eq 'none'}">
        <c:set var="bottomNoPriceClass" value="no-price" />
    </c:if>

    <%-- Render Product Configuration Title--%>

    <%-- Selected Swatch --%>
    <c:if test="${not empty swatchImgPath}">
        <div class="selected-swatch">
    		<img src="${swatchImgPath}" alt="${selectedPreview}" />
    	</div>
    </c:if>

    <%-- Selected Details --%>
    <div class="selected-details">
        <div class="top">
            <h4>${title}</h4>
        </div>
        <div class="bottom ${bottomNoPriceClass}">
            <div class="selected-summary">
                <c:choose>
                    <c:when test="${type eq 'cover'}">
                        <span class="cover-sku">${summaryDetails}</span>
                        <c:if test="${storeConfig.showCoverDetails}">
                        	<a href="#" class="modal-trigger" id="view-cover-details-link" data-target="view-cover-details" aria-label="${viewCoverDetails}">${viewCoverDetails}</a>
      					</c:if>
      				</c:when>
                    <c:otherwise>
                        <c:if test="${not empty summaryDetails}">
                            ${summaryDetails}
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="selected-options-total">
                <c:choose>
                    <c:when test="${optionsTotal eq 'none'}">
                        <%-- display no value --%>
                    </c:when>
                    <c:when test="${not empty optionsTotal}">
                        ${optionsTotal}
                    </c:when>
                    <c:otherwise>
                        +$0.00
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <c:if test="${type eq 'cover' && isDealerRMS eq true}">
        <div class="stock-message"><span class="stock-message-text">${stockMsg}</span></div>
    </c:if>

    <%-- Accordion Icon --%>
    <span class="icon icon-arrow-down" aria-hidden="true"></span>
</dsp:page>