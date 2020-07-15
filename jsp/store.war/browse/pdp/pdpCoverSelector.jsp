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

    <div id="pdpCustomization" data-module="tabs">
        <div class="tab-wrapper">
            <ul class="tabs">
                <c:if test="${ coverTap eq true}">
                    <li data-rel="pdpCoverSelection" class="active" tabindex="0">
                        <fmt:message key="pdp.coverSelection" />
                    </li>
                </c:if>
                <c:if test="${ optionTap eq true}">
                    <li data-rel="optionsUpgrades" name="optionsUpgradesPDPtab" data-activation="false" tabindex="0" >
                        <fmt:message key="pdp.optionsAndUpgrades"/>
                    </li>
                </c:if>
            </ul>
        </div>
        <dsp:getvalueof var="defaultCoverSkuForImgCover" value="${productRecord['sku.defaultCover']}" />
        <dsp:getvalueof var="defaultCoverSkuForImg" value="${fn:split(defaultCoverSkuForImgCover,'~')[0]}" />

        <div id="pdpCoverSelection" class="tab-content active"  data-module="filterCoverSelection">
            <c:if test="${not empty productRecord['sku.cover']}">
                <section data-module="favorite-cover">

                    <p class="disclaimer">The appearance of actual covers may differ from what you see on La-Z-Boy.com.</p>
                    <p class="disclaimer">For Renew covers the leather fiber content  varies by pattern. See store for details.</p>
                    <h3><strong>${productRecord['sku.noOfCovers']}</strong> <fmt:message key="pdp.coversAvailable" /></h3>
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
                        <dsp:oparam name="output">
                            <dsp:getvalueof param="coverType" var="coverType" />
                            <dsp:getvalueof param="isSaveCoverAvailbale" var="isSaveCoverAvailbale" />
                            <dsp:getvalueof param="coverColor" var="coverColor" />
                            <dsp:getvalueof param="coverPattern" var="coverPattern" />
                            <dsp:getvalueof param="colorName" var="colorName" />
                            <form class="filterform" action="#">
                                <fieldset>
                                    <select name="cover-type" id="coverType">
                                        <option value="unfilter">
                                            <fmt:message key="pdp.coverType" />
                                        </option>

                                        <c:forEach items="${coverType}" var="type">
                                            <c:set var="typeLower" value="${fn:toLowerCase(type)}" />
                                            <option value="${type}" data-cover-type="${typeLower}">${type}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="color-family" id="colorFamily">
                                        <option value="unfilter">
                                            <fmt:message key="pdp.color" />
                                        </option>
                                        <c:forEach items="${coverColor}" var="color">
                                            <c:set var="colorLower" value="${fn:toLowerCase(color)}" />
                                            <option value="${color}" data-cover-color-family="${colorLower}">${color}</option>
                                        </c:forEach>
                                    </select>
                                    <select name="cover-pattern" id="coverPattern">
                                        <option value="unfilter">
                                            <fmt:message key="pdp.pattern" />
                                        </option>
                                        <c:forEach items="${coverPattern}" var="pattern">
                                            <c:set var="patternLower" value="${fn:toLowerCase(pattern)}" />
                                            <option value="${pattern}" data-cover-pattern="${pattern}">${pattern}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="text" placeholder="Search cover SKU" name="searchCover" value="" class="filterinput" />
                                    <button type="submit" class="btn-search">Search</button>
                                </fieldset>
                            </form>
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
                                <c:if test="${priceGrade.key ne 'Custom Order'}">
                                    <fmt:parseNumber var="coverOptionPrice" value="${priceGrade.key }"/>
                                    <fmt:formatNumber var="formatCoverOptionPrice" value="${coverOptionPrice}" type="currency" />
                                </c:if>
                                <div data-module="customOrderSelection" class="cover-selection-swatches carousel">
                                    <c:choose>
                                        <c:when test="${priceGrade.key ne 'Custom Order'}">
                                            <h4>${formatCoverOptionPrice}</h4>
                                        </c:when>
                                        <c:otherwise>
                                            <h4>${priceGrade.key }</h4>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="swatch-options" data-module="pdp-carousel">
                                        <div class="wrapper swatch-carousel${count.index}" data-module="tool-tips" data-offset-x="20">
                                            <c:forEach var="colorSwatch" items="${priceGrade.value}" varStatus="count">
                                                <c:set var="coverArr" value="${fn:split(colorSwatch,'~')}"/>
                                                <c:set var="map" value="${coverArr[1]}"/>
                                                <c:set var="coverId" value="${fn:toLowerCase(coverArr[0])}" />
                                                <c:set var="colorFamily" value="${fn:toLowerCase(coverArr[1])}" />
                                                <c:set var="colorName" value="${fn:toLowerCase(coverArr[2])}" />
                                                <c:set var="coverType" value="${fn:toLowerCase(coverArr[3])}" />
                                                <c:set var="coverPattern" value="${fn:toLowerCase(coverArr[4])}" />
                                                <c:set var="wishlistFlag" value="${coverArr[5]}" />
                                                <c:set var="giftItemId" value="${coverArr[6]}" />
                                                <c:set var="capCode" value="${fn:toLowerCase(coverArr[7])}" />
                                                <div class="cover-selection-details ${colorFamily} ${coverType} ${coverPattern}" data-color-name="${colorName }" data-color-family="${colorFamily}" data-cover-type="${coverType}" data-coverid="${coverId}" data-cover-pattern="${coverPattern}">
                                                    <fmt:message var="addToWishList" key="pdp.addToWishList" />
                                                    <c:set var="largeImageTemp" value="${fn:replace(largeImage, defaultCoverSkuForImg, coverArr[0]) }" />
                                                    <c:set var="skuRepositoryId" value="${productRecord['sku.repositoryId']}" />
                                                    <c:set var="defaultCoverSku" value="${productRecord['defaultCoverSku']}" />
                                                    <a href="#"
                                                            data-color-name="${colorName}" data-color-family="${colorFamily}" data-color-pattern="${coverPattern}" data-price="${priceGrade.key}"
                                                        data-covername="${coverArr[1]}" data-coverid="${coverArr[0]}" data-cover-type="${coverType}"
                                                        data-skuid="${productRecord['sku.repositoryId']}" data-dealerid="${dealerId }"
                                                        data-vnt="${productRecord['product.vnt']}" data-giftItemId='${giftItemId}' data-wishlist='${wishlistFlag}' data-type="cover" data-cover-cap-code="${capCode}" data-swatch="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg"
                                                        class="cover tooltipster
                                                        <c:if test="${priceGrade.key == 'Custom Order'}">custom</c:if>"
                                                            title="
                                                            <div class='lg-swatch'>
                                                                <img src='${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg' height='80' width='80' alt='${coverArr[1]}'/>
                                                            </div>
                                                            <div class='details'>
                                                                <b>COVER DETAILS</b>
                                                                <c:if test="${coverType != ''}">
                                                                    <div><strong>Type:</strong> <span>${coverType }</span></div>
                                                                </c:if>
                                                                <c:if test="${colorName != ''}">
                                                                    <div><strong>Color:</strong> <span>${colorName}&nbsp;${coverId}</span></div>
                                                                </c:if>
                                                                <c:if test="${coverPattern != ''}">
                                                                    <div><strong>Pattern:</strong> <span>${coverPattern}&nbsp${coverId}</span></div>
                                                                </c:if>
                                                                <p>
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
                                                        <img data-lazy="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${coverArr[0]}.jpg" height="42" width="42" alt="${coverArr[1]}"/>
                                                    </a>
                                                </div>
                                            </c:forEach>
                                        </div>
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
        <div class="loading-gif" style="display:none;" data-module="pdp-options-upgrades">
            <img src="/img/loading.gif" />
        </div>

        <div id="optionsUpgrades" class="tab-content" data-module="showPDPOptionSwatches">

        </div>
    </div>
</dsp:page>