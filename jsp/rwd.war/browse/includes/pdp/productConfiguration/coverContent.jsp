<%--
    - File Name: coverContent.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product configuration accordion cover content on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - productSkuId: product sku id,
        - defaultCoverSkuId: default cover sku,
        - productCoverList: cover SKU data,
        - dealerId,
        - productVNT
    - Optional Parameters:
        - filterCoverType: option cover selected,
        - filterCoverColor: option cover color filter,
        - filterCoverPattern: option cover pattern filter,
        - filterCoverSearch: option cover pattern filter,
        - filterSelectedCover: cover selected,
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/com/lzb/droplet/LZBSKUOptionSeparator" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/userprofiling/Profile" scope="request" />
    <dsp:importbean bean="/com/lzb/commerce/droplet/LZBStockCheckDroplet"/>

    <%-- Page Variables --%>
    <dsp:getvalueof var="productSkuId" param="productSkuId" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
    <dsp:getvalueof var="productCoverList" param="productCoverList" />
    <dsp:getvalueof var="dealerId" param="dealerId" />
    <dsp:getvalueof var="productVNT" param="productVNT" />
    <%-- NOTE: filterCoverType, filterCoverColor, filterCoverPattern, filterCoverSearch, and filterSelectedCover params are used for an AJAX request with option cover filtering --%>
    <dsp:getvalueof var="filterCoverType" param="filterCoverType" />
	<dsp:getvalueof var="filterCoverColor" param="filterCoverColor" />
	<dsp:getvalueof var="filterCoverPattern" param="filterCoverPattern" />
	<dsp:getvalueof var="filterCoverSearch" param="filterCoverSearch" />
	<dsp:getvalueof var="filterSelectedCover" param="filterSelectedCover" />
    <dsp:getvalueof var="inStockFilter" param="inStockFilter" />
    <fmt:message var="selectMaterialsLabel" key="productConfiguration.coverFilters.selectMaterialsLabel" />
    <fmt:message var="selectAllMaterials" key="productConfiguration.coverFilters.selectAllMaterials" />
    <fmt:message var="selectColorsLabel" key="productConfiguration.coverFilters.selectColorsLabel" />
    <fmt:message var="selectAllColors" key="productConfiguration.coverFilters.selectAllColors" />
    <fmt:message var="selectPatternsLabel" key="productConfiguration.coverFilters.selectPatternsLabel" />
    <fmt:message var="selectAllPatterns" key="productConfiguration.coverFilters.selectAllPatterns" />
    <fmt:message var="searchLabel" key="productConfiguration.coverFilters.searchLabel" />
    <fmt:message var="searchPlaceholder" key="productConfiguration.coverFilters.searchPlaceholder" />
    <fmt:message var="coverSwatchesCountTitle" key="productConfiguration.coverSwatches.countTitle" />
    <fmt:message var="customTooltipContent" key="productConfiguration.coverSwatches.customTooltip" />

    <dsp:droplet name="/com/lzb/commerce/droplet/LZBStockCheckDroplet">
        <dsp:param name="sku" value="${productSkuId}"/>
        <dsp:param name="profile" bean="Profile"/>
        <dsp:oparam name="output">
            <dsp:getvalueof param="hasStock" var="hasStock" />
        </dsp:oparam>
    </dsp:droplet>

    <c:choose>
        <c:when test="${not empty productCoverList}">
            <%-- Droplet: Separate Cover SKU Options --%>
            <dsp:droplet name="LZBSKUOptionSeparator">
                <dsp:param name="skuCoverList" value="${productCoverList}" />
                <dsp:param name="profileSaveCoverRequest" value="true" />
				<dsp:param name="profile" bean="Profile"/>
                <dsp:param name="sku" value="${productSkuId}" />
                <dsp:oparam name="output">
                    <dsp:getvalueof var="coverType" param="coverType" />
                    <dsp:getvalueof var="isSaveCoverAvailbale" param="isSaveCoverAvailbale" />
                    <dsp:getvalueof var="coverColor" param="coverColor" />
                    <dsp:getvalueof var="coverPattern" param="coverPattern" />
                    <dsp:getvalueof var="colorName" param="colorName" />
                    <dsp:getvalueof var="coverInStock" param="coverInStock" />
                    <dsp:getvalueof var="coverOptionList" param="coverOptionList" />
                </dsp:oparam>
                <dsp:oparam name="empty"></dsp:oparam>
            </dsp:droplet>

            <%-- Render Product Cover Configuration Content--%>

            <%-- START: Cover Filter & Search Content--%>
            <div class="accordion" data-accordion aria-multiselectable="false" role="tablist">
                <div class="accordion-container">
                    <div class="accordion-title" role="tab" aria-controls="cover-filters" id="cover-filters-title" tabindex="0">
                        <h5><fmt:message key="productConfiguration.coverFilters.title" /></h5>
                        <span class="icon icon-arrow-down" aria-hidden="true"></span>
                    </div>
                    <div class="accordion-body" aria-labeledby="cover-filters-title" role="tabpanel" id="cover-filters">
                        <div class="accordion-body-content">
                            <%-- Filter Search Form --%>
                            <form id="cover-filter-form" class="cover-filter-form" name="cover-filter-form" autocomplete="off" action="${requestScope['javax.servlet.forward.request_uri']}" data-swatchgroup-id="base-cover-swatch-groups">
                                <div class="field-group">
                                
                                    <%-- Materials Select --%>
                                    <div class="field">
                        				<label class="sr-only" for="cover-type">${selectMaterialsLabel}</label>
                        				<div class="custom-select">
                                            <select class="form-control" name="filterCoverType" id="cover-type">
                            					<option value="unfilter">${selectAllMaterials}</option>
                                                <c:forEach var="type" items="${coverType}" >
                                                    <c:set var="typeCleaned" value="${fn:replace(fn:replace(fn:replace(type,'(',''),')',''),' ','')}"/>
                                                    <c:set var="typeLower" value="${fn:toLowerCase(typeCleaned)}" />
                                                    <option value="${typeLower}" data-cover-type="${typeLower}">${type}</option>
                                                </c:forEach>
                            				</select>
                                            <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                                        </div>
                                    </div>

                                    <%-- Colors Select --%>
                                    <div class="field">
                        				<label class="sr-only" for="color-family">${selectColorsLabel}</label>
                                        <div class="custom-select">
                            				<select class="form-control" name="filterCoverColor" id="color-family">
                            					<option value="unfilter">${selectAllColors}</option>
                                                <c:forEach var="color" items="${coverColor}">
                                                    <c:set var="colorCleaned" value="${fn:replace(fn:replace(fn:replace(color,'(',''),')',''),' ','')}"/>
                                                    <c:set var="colorLower" value="${fn:toLowerCase(colorCleaned)}" />
                                                    <option value="${colorLower}" data-cover-color-family="${colorLower}">${color}</option>
                                                </c:forEach>
                            				</select>
                                            <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                                        </div>
                                    </div>

                                    <%-- Pattern Select --%>
                                    <div class="field">
                        				<label class="sr-only" for="cover-pattern">${selectPatternsLabel}</label>
                                        <div class="custom-select">
                            				<select class="form-control" name="filterCoverPattern" id="cover-pattern">
                            					<option value="unfilter">${selectAllPatterns}</option>
                                                <c:forEach var="pattern" items="${coverPattern}">
                                                    <c:set var="patternCleaned" value="${fn:replace(fn:replace(fn:replace(pattern,'(',''),')',''),' ','')}"/>
                                                    <c:set var="patternLower" value="${fn:toLowerCase(patternCleaned)}" />
                                                    <option value="${patternLower}" data-cover-pattern="${patternLower}">${pattern}</option>
                                                </c:forEach>
                            				</select>
                                            <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                                        </div>
                                    </div>
                    			</div>

                                <%-- Search Input --%>
                                <div class="field-group inline-form">
                                    <div class="field search-field">
                                        <label class="sr-only" for="cover-search">${searchLabel}</label>
                                        <input id="cover-search" class="keyword-field" type="text" name="filterCoverSearch" placeholder="${searchPlaceholder}" autocorrect="off" autocapitalize="off" />
                                    </div>
                                    <div class="action-field">
                                        <button id="cover-search-submit" type="submit" class="button" aria-label="Search">
                                            <span class="icon icon-search" aria-hidden="true"></span>
                                        </button>
                                    </div>
                    			</div>
                                <button id="cover-search-clear" type="button" class="button secondary small hide" aria-label="Clear Search">
                                    Clear Search <span class="icon icon-cross" aria-hidden="true"></span>
                                </button>
                                <%-- keeps an updated value of the selected cover since the AJAX call replaces the swatch list html. value set on pageload using javascript --%>
        						<input type="hidden" class="filter-form-selected-base-swatch-cover" name="filterSelectedCover" value="" />
                                
                            <c:if test="${hasStock}">
                                <div class="field-group in-stock-filter">
                                    <label class="switch" id="inStockToggle">
                                        <input type="checkbox" name="inStockFilter" id="inStock" value="inStock">
                                        <span class="toggle"></span>
                                    </label>
                                    <span>
                                        In-stock, ready-to-ship
                                    </span>
                                </div>
                            </c:if>

                    		</form>

                            <%-- Filter Search Results --%>
                            <div id="search-term-covers" class="hide">
                                <p><strong><fmt:message key="productConfiguration.coverFilters.searchTermResults" /> <span id="covers-search-keyword"></span></strong></p>
                            </div>

                            <%-- Filter No Search Results --%>
                            <div id="no-searched-covers" class="hide">
                                <p><strong><fmt:message key="productConfiguration.noCoversToDisplay" /></strong></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%-- END: Cover Filter & Search Content--%>

            <%-- START: Selectable Cover Configuration Options Content--%>
            <div id="base-cover-swatch-groups">
                <c:forEach var="priceGrade" items="${coverOptionList}" varStatus="priceGradeCount">
                    <dsp:getvalueof var="customCoverClass" value="" />
                    <dsp:getvalueof var="hideCustomCover" value="" />
                    <c:if test="${priceGrade.key ne 'Custom Order'}">
                        <fmt:parseNumber var="coverOptionPrice" value="${priceGrade.key}" />
                        <fmt:formatNumber var="formatCoverOptionPrice" value="${coverOptionPrice}" type="currency" />
                    </c:if>

                    <%-- Set Cover Group Title Variable --%>
                    <c:choose>
                        <c:when test="${priceGrade.key ne 'Custom Order'}">
                            <c:set var="coverGroupTitle" value="${formatCoverOptionPrice}" />
                        </c:when>
                        <c:when test="${priceGrade.key eq 'Custom Order'}">
                            <c:set var="coverGroupTitle" value="Custom" />
                            <c:if test="${storeConfig.showPDPCustomCovers eq false}">
                                <dsp:getvalueof var="customCoverClass" value="hide" />
                                <dsp:getvalueof var="hideCustomCover" value="true" />
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <c:set var="coverGroupTitle" value="${priceGrade.key}" />
                        </c:otherwise>
                    </c:choose>

                    <div class="cover-selection-swatches ${customCoverClass}" data-hide-row="${hideCustomCover}">
                        <%-- Cover Group Title --%>
                        <div class="cover-group-title">
                            <c:if test="${not empty coverGroupTitle}">
                                <c:forEach items="${priceGrade.value}" varStatus="loop" begin="0">
                                    <c:set var="swatchCount" value="${loop.count}" />
                                </c:forEach>
                                <h4>
                                    <%-- Do not display cover price grade group tile for sectional swatches --%>
                                    <c:if test="${pdpRecordType ne 'sectional'}">
                                        ${coverGroupTitle}
                                    </c:if>

                                    (<span class="group-count">${swatchCount}</span> ${coverSwatchesCountTitle})

                                    <%-- Render tooltip for Custom Swatch Group --%>
                                    <c:if test="${priceGrade.key eq 'Custom Order'}">
                                        <span data-tooltip class="has-tip tip-bottom round icon icon-info" title="${customTooltipContent}">
                                            <span class="sr-only">${customTooltipContent}</span>
                                        </span>
                                    </c:if>
                                </h4>
                            </c:if>
                            <%-- NOTE: selected cover content is set in init.browse.js --%>
                            <div class="selected-cover">
                                <div class="cover-name"></div>
                                <div class="cover-sku"></div>
                            </div>
                        </div>

                        <%-- Cover Swatche List --%>
                        <div class="swatch-list">
                            <c:forEach var="colorSwatch" items="${priceGrade.value}">
                                <c:set var="contentHostName" value="//${storeConfig.contentHostName}" />
                                <c:set var="coverArr" value="${colorSwatch}" />
                                <c:set var="map" value="${coverArr[1]}"/>
                                <c:set var="coverId" value="${fn:toLowerCase(coverArr[0])}" />
                                <c:set var="colorFamilyCleaned" value="${fn:replace(fn:replace(fn:replace(coverArr[1],'(',''),')',''),' ','')}" />
                                <c:set var="colorFamilyData" value="${fn:toLowerCase(colorFamilyCleaned)}" />
                                <c:set var="colorFamily" value="${fn:toLowerCase(coverArr[1])}" />
                                <c:set var="colorName" value="${fn:toLowerCase(coverArr[2])}" />
                                <c:set var="coverTypeCleaned" value="${fn:replace(fn:replace(fn:replace(fn:replace(coverArr[3],'(',''),')',''),' ',''),':',' ')}" />
                                <c:set var="coverTypeData" value="${fn:toLowerCase(coverTypeCleaned)}" />
                                <c:set var="coverType" value="${fn:toLowerCase(coverArr[3])}" />
                                <c:set var="coverPatternCleaned" value="${fn:replace(fn:replace(fn:replace(coverArr[4],'(',''),')',''),' ','')}" />
                                <c:set var="coverPatternData" value="${fn:toLowerCase(coverPatternCleaned)}" />
                                <c:set var="coverPattern" value="${fn:toLowerCase(coverArr[4])}" />
                                <c:set var="wishlistFlag" value="${coverArr[5]}" />
                                <c:set var="giftItemId" value="${coverArr[6]}" />
                                <c:set var="capCode" value="${fn:toLowerCase(coverArr[7])}" />
                                <c:set var="coverInStock" value="${coverArr[8]}" />

                                <%-- Set custom swatch group class --%>
                                <c:set var="customClass" value="" />
                                <c:if test="${priceGrade.key == 'Custom Order'}">
                                    <c:set var="customClass" value="custom" />
                                    <c:set var="formatCoverOptionPrice" value="Custom Price" />
                                </c:if>
                                <%-- Set selected class to default cover sku --%>
                                <c:set var="selectedClass" value="" />
                                <c:set var="filteredSelectedClass" value="" />
                                <c:choose>
                                    <c:when test="${not empty filterSelectedCover && filterSelectedCover eq coverArr[0]}">
                                        <c:set var="selectedClass" value="selected" />
                                    </c:when>
                                    <c:when test="${empty filterSelectedCover && coverArr[0] eq defaultCoverSkuId}">
                                        <c:set var="selectedClass" value="selected" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="selectedClass" value="" />
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${(not empty filterCoverType && filterCoverType ne 'unfilter') || (not empty filterCoverColor && filterCoverColor ne 'unfilter') || (not empty filterCoverPattern && filterCoverPattern ne 'unfilter') || (not empty filterCoverSearch) || (not empty inStockFilter)}">
                                        <c:choose>
                                            <c:when test="${not empty filterSelectedCover && filterSelectedCover eq coverArr[0]}">
                                                <%-- renders and tags the default or user selected swatch so that is not rendered in the filtered results, but remains in the DOM after the AJAX filters the HTML. --%>
                                                <c:set var="filteredSelectedClass" value="pre-filter-selected" />
                                                <c:set var="selectedClass" value="selected" />
                                                <%@ include file="/browse/fragments/baseCoverSwatch.jspf" %>
                                            </c:when>
                                            <c:when test="${not empty filterCoverSearch && fn:toUpperCase(filterCoverSearch) eq coverArr[0]}">
                                                <%-- render single cover match for search keyword --%>
                                                <%@ include file="/browse/fragments/baseCoverSwatch.jspf" %>
                                            </c:when>
                                            <c:when test="${(fn:contains(coverTypeData, filterCoverType) || filterCoverColor eq colorFamilyData || filterCoverPattern eq coverPatternData || inStockFilter eq coverInStock) && (empty filterCoverSearch)}">
                                                <%-- renders select form matches --%>
                                                <%@ include file="/browse/fragments/baseCoverSwatch.jspf" %>
                                            </c:when>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- render all covers --%>
                                        <%@ include file="/browse/fragments/baseCoverSwatch.jspf" %>
                                    </c:otherwise>
                                </c:choose>

                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <%-- END: Selectable Cover Configuration Options Content--%>
        </c:when>
        <c:otherwise>
            <%-- Render No Covers Content--%>
            <div class="no-covers-content">
                <p><fmt:message key="productConfiguration.noCoversToDisplay" /></p>
            </div>
        </c:otherwise>
    </c:choose>
</dsp:page>