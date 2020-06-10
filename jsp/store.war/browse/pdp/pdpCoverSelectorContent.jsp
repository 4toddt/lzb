<dsp:page>
    <dsp:importbean bean="/atg/userprofiling/Profile" scope="request" />
    <dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
    <dsp:importbean bean="/com/lzb/commerce/droplet/LZBStockCheckDroplet"/>

    <dsp:getvalueof var="defaultCoverSkuForImgCover" value="${productRecord['sku.defaultCover']}" />
    <dsp:getvalueof var="defaultCoverSkuForImg" value="${fn:split(defaultCoverSkuForImgCover,'~')[0]}" />
    <dsp:getvalueof var="dealerId" param="dealerId" />

    <dsp:droplet name="/com/lzb/commerce/droplet/LZBStockCheckDroplet">
        <dsp:param name="sku" value="${productRecord['sku.repositoryId']}"/>
        <dsp:param name="profile" bean="Profile"/>
        <dsp:oparam name="output">
            <dsp:getvalueof param="hasStock" var="hasStock" />
        </dsp:oparam>
    </dsp:droplet>

    <div id="pdpCoverSelection" data-module="filterCoverSelection">
        <c:if test="${not empty productRecord['sku.cover']}">
            <section data-module="favorite-cover">
            	<c:if test="${not storeConfig.showCoverDetails}">
					<p class="order-free-swatches-copy">
						<fmt:message key="pdp.productConfiguration.orderFreeSwatchesLabel" />
		                <a href="${pageContext.request.contextPath}/content/free-swatches"><fmt:message key="pdp.productConfiguration.orderFreeSwatchesCopy" /></a>
		            </p>
		        </c:if>
                <%-- <p class="disclaimer small"><fmt:message key="pdp.coversDisclaimer1" /></p>
                <p class="disclaimer small"><fmt:message key="pdp.coversDisclaimer2" /></p> --%>
                <%--<h3><strong>${productRecord['sku.noOfCovers']}</strong> <fmt:message key="pdp.coversAvailable" /></h3>--%>
                <dsp:setvalue beanvalue="Profile.savedCovers" param="savedCovers" />
                <dsp:setvalue paramvalue="savedCovers.giftlistItems" param="savedCoversItem" />
                <dsp:droplet name="IsEmpty">
                    <dsp:param name="value" param="savedCoversItem" />
                    <dsp:oparam name="false">
                        <dsp:droplet name="ForEach">
                            <dsp:param name="array" param="savedCoversItem" />
                            <dsp:param name="elementName" value="savedCoverelement" />
                            <dsp:oparam name="outputStart">
                                <script>
                                    var savedCoverId = [];
                                    </dsp:oparam>
                                    <dsp:oparam name="output">
                                        <dsp:getvalueof var="savedCoverId" param="savedCoverelement.catalogRefId" />
                                            var coverId = '${savedCoverId}';
                                            savedCoverId.push(coverId.toLowerCase());
                                    </dsp:oparam>
                                    <dsp:oparam name="outputEnd">
                                </script>
                            </dsp:oparam>
                        </dsp:droplet>
                    </dsp:oparam>
                    <dsp:oparam name="true">
                        <script>var savedCoverId = [];</script>
                    </dsp:oparam>
                </dsp:droplet>
                <c:if test="${ transient eq 'false' }">
                    <div id="savedCovers" data-module="tool-tips">
                        <input type="checkbox" value="false" name="showSavedCovers" id="showSavedCovers" />
                        <label for="showSavedCovers"><fmt:message key="pdp.showFavouriteCovers" /></label>
                        <a title="<fmt:message key="pdp.coverSelectionTip" />" class="tooltipster" href="#" data-tip="Show Saved Covers">
                            <div class="triangle-with-shadow"></div>
                            <div title="" class="tooltip-img"></div>
                        </a>
                    </div>
                </c:if>

                <dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
                    <dsp:param name="skuCoverList" value="${productRecord['sku.cover'] }" />
                    <dsp:param name="profileSaveCoverRequest" value="true" />
					<dsp:param name="profile" bean="Profile"/>
                    <dsp:param name="sku" value="${productRecord['styleNumber']}" />
                    <dsp:oparam name="output">
                        <dsp:getvalueof param="coverType" var="coverType" />
                        <dsp:getvalueof param="isSaveCoverAvailbale" var="isSaveCoverAvailbale" />
                        <dsp:getvalueof param="coverColor" var="coverColor" />
                        <dsp:getvalueof param="coverPattern" var="coverPattern" />
                        <dsp:getvalueof param="colorName" var="colorName" />
                        
                        <form class="filterform" action="#">
                            <fieldset> <!-- ${hasStock} - -->
                                <div class="buttons-container">
                                    <div class="swatches-button">
                                        <a href="/content/free-swatches" target="_blank">
                                            <div>See it! Feel it! Order <strong>FREE</strong> swatches!</div>
                                        </a>
                                    </div>
                            <c:if test="${hasStock}">
                                    <div class="in-stock-filter">
                                        <label class="switch" id="inStockToggle">
                                            <input type="checkbox" name="in-stock" id="inStock">
                                            <span class="toggle"></span>
                                        </label>
                                        <span>
                                            In-stock,
                                            ready-to-ship
                                        </span>
                                    </div>
                            </c:if>
                                </div>
                                <div class="filters">
                                    <div class="styled-select">
                                        <select class="coverFilter" name="cover-type" id="coverType">
                                            <option value="unfilter">
                                                <fmt:message key="pdp.allMaterials" />
                                            </option>

                                            <c:forEach items="${coverType}" var="type">
                                                <c:set var="typeCleaned" value="${fn:replace(fn:replace(fn:replace(type,'(',''),')',''),' ','')}"/>
                                                <c:set var="typeLower" value="${fn:toLowerCase(typeCleaned)}" />
                                                <option value="${typeLower}" data-cover-type="${typeLower}">${type}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="styled-select">
                                        <select class="coverFilter" name="color-family" id="colorFamily">
                                            <option value="unfilter">
                                                <fmt:message key="pdp.allColors" />
                                            </option>
                                            <c:forEach items="${coverColor}" var="color">
                                                <c:set var="colorCleaned" value="${fn:replace(fn:replace(fn:replace(color,'(',''),')',''),' ','')}"/>
                                                <c:set var="colorLower" value="${fn:toLowerCase(colorCleaned)}" />
                                                <option value="${colorLower}" data-cover-color-family="${colorLower}">${color}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="styled-select">
                                        <select class="coverFilter" name="cover-pattern" id="coverPattern">
                                            <option value="unfilter">
                                                <fmt:message key="pdp.allPatterns" />
                                            </option>
                                            <c:forEach items="${coverPattern}" var="pattern">
                                                <c:set var="patternCleaned" value="${fn:replace(fn:replace(fn:replace(pattern,'(',''),')',''),' ','')}"/>
                                                <c:set var="patternLower" value="${fn:toLowerCase(patternCleaned)}" />
                                                <c:if test="${not empty patternLower}" >
                                                	<option value="${patternLower}" data-cover-pattern="${patternLower}">${pattern}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                <div class="search-toggle btn-search" tabindex="0"></div>
                                </div>
                                <div class="search-bar">
                                    <input id="cover-filter-input" type="text" placeholder="Search cover SKU" name="searchCover" value="" class="filterinput" />
                                    <button type="submit" class="search-submit btn-search">Search</button>
                                    <span class="icon-close-x" tabindex="0"></span>
                                </div>
                            </fieldset>
                        </form>
                        <div id="search-term-covers" style="display:none;">
                          <p><strong>Search Results for: <span id="covers-search-keyword"></span></strong></p>
                        </div>
                        <div id="no-saved-covers" class="error red" style="display:none;">
                            <p><strong>We didn't find any covers to display</strong></p>
                            <p>To add a cover to your favorite simply hover on a cover swatch and select the "Add to My Favorites" link on the preview panel.</p>
                            <p>You can also use the "Cover Search" tool located under the "Customize It" header menu to save your favorites.</p>
                            <p>If you have already saved your favorite covers and are wondering why one didn't display, it is because it is not available on this particular product.</p>
                            <p>Uncheck the "Show My Favorite" covers only checkbox to show the covers available.</p>
                        </div>
                        <div id="no-searched-covers" class="error red" style="display:none;">
                            <p><strong>We didn't find any covers to display</strong></p>
                        </div>
                        <div class="spinner"></div>
                        <dsp:getvalueof param="coverOptionList" var="coverOptionList" />
                        <c:forEach items="${coverOptionList}" var="priceGrade" varStatus="count">
                            <dsp:getvalueof var="customCoverClass" value="" />
                            <dsp:getvalueof var="hideCustomCover" value="" />
                            <c:if test="${priceGrade.key ne 'Custom Order'}">
                              <fmt:parseNumber var="coverOptionPrice" value="${priceGrade.key }"/>
                              <fmt:formatNumber var="formatCoverOptionPrice" value="${coverOptionPrice}" type="currency" />
                            </c:if>
                            <c:if test="${storeConfig.showPDPCustomCovers eq false && priceGrade.key eq 'Custom Order'}">
                                <dsp:getvalueof var="customCoverClass" value="hide" />
                                <dsp:getvalueof var="hideCustomCover" value="true" />
                            </c:if>
                            <div data-module="customOrderSelection" data-hide-row="${hideCustomCover}" class="cover-selection-swatches carousel ${customCoverClass}">
                                <div class="swatch-left-col">
                                    <c:choose>
                                        <c:when test="${priceGrade.key ne 'Custom Order'}">
                                            <h4>
                                              <%-- Do not display cover price for sectional swatches --%>
                                              <c:if test="${isSectional ne 'true'}">
                                                ${formatCoverOptionPrice}
                                              </c:if>
                                            </h4>
                                        </c:when>
                                        <c:when test="${priceGrade.key eq 'Custom Order'}">
                                            <h4>Custom</h4>
                                        </c:when>
                                        <c:otherwise>
                                            <h4>${priceGrade.key }</h4>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="swatch-options" data-module="pdp-carousel" data-slides-to-show="5" data-slides-to-scroll="5">
                                    <div class="wrapper swatch-carousel${count.index}" data-module="tool-tips" data-offset-x="0">
                                        <c:forEach var="colorSwatch" items="${priceGrade.value}" varStatus="count">
                                            <c:set var="contentHostName" value="//content.la-z-boy.com"/>
                                            <c:set var="coverArr" value="${colorSwatch}"/>
                                            <c:set var="map" value="${coverArr[1]}"/>
                                            <c:set var="coverId" value="${fn:toLowerCase(coverArr[0])}" />
                                            <c:set var="colorFamilyCleaned" value="${fn:replace(fn:replace(fn:replace(coverArr[1],'(',''),')',''),' ','')}"/>
                                            <c:set var="colorFamilyData" value="${fn:toLowerCase(colorFamilyCleaned)}" />
                                            <c:set var="colorFamily" value="${fn:toLowerCase(coverArr[1])}" />
                                            <c:set var="colorName" value="${fn:toLowerCase(coverArr[2])}" />
                                            <c:set var="coverTypeCleaned" value="${fn:replace(fn:replace(fn:replace(fn:replace(coverArr[3],'(',''),')',''),' ',''),':',' ')}"/>
                                            <c:set var="coverTypeData" value="${fn:toLowerCase(coverTypeCleaned)}" />
                                            <c:set var="coverType" value="${fn:toLowerCase(coverArr[3])}" />
                                            <c:set var="coverPatternCleaned" value="${fn:replace(fn:replace(fn:replace(coverArr[4],'(',''),')',''),' ','')}"/>
                                            <c:set var="coverPatternData" value="${fn:toLowerCase(coverPatternCleaned)}" />
                                            <c:set var="coverPattern" value="${fn:toLowerCase(coverArr[4])}" />
                                            <c:set var="wishlistFlag" value="${coverArr[5]}" />
                                            <c:set var="giftItemId" value="${coverArr[6]}" />
                                            <c:set var="capCode" value="${fn:toLowerCase(coverArr[7])}" />
                                            <c:set var="coverInStock" value="${coverArr[8]}" />
                                            
                                            <c:set var="coverClasses" value="${coverTypeData} ${colorFamilyData} ${coverPatternData}" />
                                            <c:set var="giftItemId" value="${coverArr[6]}" />
                                            <c:set var="capCode" value="${fn:toLowerCase(coverArr[7])}" />
                                            <c:set var="inStockClass" value="${fn:toLowerCase(coverInStock)}" />
                                            <c:set var="coverClasses" value="${coverTypeData} ${colorFamilyData} ${coverPatternData} ${inStockClass}" />
                                            <div class="cover-selection-details ${coverClasses} " 
                                                data-color-name="${colorName }" 
                                                data-color-family="${colorFamilyData}" 
                                                data-cover-type="${coverTypeData}" 
                                                data-cover-instock="${coverInStock}" 
                                                data-coverid="${coverId}" 
                                                data-cover-cap-code="${capCode}" 
                                                data-cover-pattern="${coverPatternData}"
                                                >
                                                <fmt:message var="addToWishList" key="pdp.addToWishList" />
                                                <c:set var="largeImageTemp" value="${fn:replace(largeImage, defaultCoverSkuForImg, coverArr[0]) }" />
                                                <c:set var="skuRepositoryId" value="${productRecord['sku.repositoryId']}" />
                                                <c:set var="defaultCoverSku" value="${productRecord['defaultCoverSku']}" />
                                                <c:set var="customClass" value="" />
                                                <c:if test="${priceGrade.key == 'Custom Order'}">
                                                    <c:set var="customClass" value="custom" />
                                                    <c:set var="formatCoverOptionPrice" value="Custom Price" />
                                                </c:if>
                                                <c:set var="sectionalClass" value=""/>
                                                <c:if test="${isSectional eq 'true'}">
                                                    <c:set var="sectionalClass" value="sectional-cover-swatch-a"/>
                                                </c:if>
                                                <!-- 
                                                    isSectional    : ${isSectional} 
                                                    sectionalClass : ${sectionalClass}
                                                -->
                                                <a href="#"
                                                    data-color-name="${colorName}" 
                                                    data-color-family="${colorFamilyData}" 
                                                    data-color-pattern="${coverPatternData}" 
                                                    data-price-formated="${formatCoverOptionPrice}" 
                                                    data-price="${priceGrade.key}" 
                                                    data-covername="${coverArr[1]}" 
                                                    data-coverid="${coverArr[0]}" 
                                                    data-cover-type="${coverTypeData}"
                                                    data-cover-instock="${coverInStock}"
                                                    data-skuid="${productRecord['sku.repositoryId']}" 
                                                    data-dealerid="${dealerId }"
                                                    data-vnt="${productRecord['product.vnt']}" 
                                                    data-giftItemId='${giftItemId}' 
                                                    data-wishlist='${wishlistFlag}' 
                                                    data-type="cover" 
                                                    data-cover-cap-code="${capCode}" 
                                                    data-swatch="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg"
                                                    class="cover ${sectionalClass} tooltipster ${customClass}"
                                                    title="
                                                        <div class='lg-swatch'>
                                                            <img src='${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg' alt='${coverArr[1]}'/>
                                                        </div>
                                                        <div class='details'>
                                                          <c:if test="${coverType != ''}">
                                                              <p>${fn:split(coverType,":")[0]}</p>
                                                          </c:if>
                                                            <c:if test="${colorName != ''}">
                                                                <p>${colorName}&nbsp;${coverId}</p>
                                                            </c:if>
                                                            <c:if test="${coverPattern != ''}">
                                                                <p>${coverPattern}&nbsp${coverId}</p>
                                                            </c:if>
                                                            <%-- Do not display cover price for sectional swatches --%>
                                                            <c:if test="${isSectional ne 'true'}">
                                                              <div>
                                                                  <p class='price'>${formatCoverOptionPrice}</p>
                                                              </div>
                                                            </c:if>
                                                            <p class='favorite'>
                                                                <c:choose>
                                                                    <c:when test="${wishlistFlag eq 'true' && not empty giftItemId}">
                                                                        <a href='#' class='pdp save-cover active-wishlist' data-skuid='${coverArr[0]}'
                                                                        data-productid='${skuRepositoryId }' data-coverid='${defaultCoverSku }'
                                                                            data-dealerid='${dealerId}' data-giftItemId='${giftItemId}' data-wishlist='${wishlistFlag}'>
                                                                        <img src='/img/heartred.png' class='heart' alt='heart icon'  tabindex='0'/>
                                                                        Add to favorites
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href='#' class='pdp save-cover' data-skuid='${coverArr[0]}'
                                                                        data-productid='${skuRepositoryId }' data-coverid='${defaultCoverSku }'
                                                                            data-dealerid='${dealerId}' data-giftItemId='${giftItemId}' data-wishlist='${wishlistFlag}'>
                                                                        <img src='/img/heart.png' class='heart' alt='heart icon'  tabindex='0'/>
                                                                        Add to favorites
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                    "
                                                >
                                                    <span style="display:none;">${coverArr[0]}</span>
                                                    <img data-lazy="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg" alt="cover color: ${colorName}"/>
                                                </a>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="swatch-right-col">
                                    <h4 class="swatch-count"></h4>
                                </div>
                            </div>
                        </c:forEach>
                    </dsp:oparam>
                    <dsp:oparam name="empty">
                        Empty
                    </dsp:oparam>
                </dsp:droplet>
            </section>
        </c:if>
    </div>
</dsp:page>