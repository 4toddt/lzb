<%--
    - File Name: productTitleBar.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product title bar section on the product page.
    - Required Parameters:
        - pdpRecordType: pdp record type is a request scope variable,
        - isPurchaseable: purchaseable boolean,
        - showPrice: display price boolean,
        - onSale: sale boolean,
        - lowestSalePrice,
        - lowestSalePriceDecimal,
        - formatLowestSalePrice,
        - lowestPrice,
        - lowestPriceDecimal,
        - formatLowestPrice,
    - Optional Parameters:
        - productSkuId: product sku id,
        - productName: name of the product,
        - productReviewCount: number of product reviews,
        - productRating: product reviews rating,
        - saveAmount,
        - endDate
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/com/lzb/service/SessionBean" />
    <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
    <dsp:importbean bean="/atg/userprofiling/Profile" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="productSkuId" param="productSkuId" />
    <dsp:getvalueof var="productName" param="productName" />
    <dsp:getvalueof var="productReviewCount" param="productReviewCount" />
    <dsp:getvalueof var="productRating" param="productRating" />
    <dsp:getvalueof var="isPurchaseable" param="isPurchaseable" />
    <dsp:getvalueof var="showPrice" param="showPrice" />
    <dsp:getvalueof var="onSale" param="onSale" />
    <dsp:getvalueof var="lowestSalePrice" param="lowestSalePrice" />
    <dsp:getvalueof var="lowestSalePriceDecimal" param="lowestSalePriceDecimal" />
    <dsp:getvalueof var="formatLowestSalePrice" param="formatLowestSalePrice" />
	<dsp:getvalueof var="lowestPrice" param="lowestPrice" />
	<dsp:getvalueof var="lowestPriceDecimal" param="lowestPriceDecimal" />
	<dsp:getvalueof var="formatLowestPrice" param="formatLowestPrice" />
	<dsp:getvalueof var="saveAmount" param="saveAmount" />
	<dsp:getvalueof var="endDate" param="endDate" />
    <dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
    <c:set var="currentPriceID" value="pdp-price" />
    <c:set var="hideClass" value="hide" />
    <c:set var="showStartingAtLabel" value="false" />
    <dsp:getvalueof var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />
    
    <dsp:getvalueof var="country" bean="Profile.currentStore.country" />
    
    <fmt:parseNumber var="saveAmount123" value="${saveAmount}"/>
    <fmt:formatNumber var="formattedSaveAmount" value="${saveAmount123}" type="currency" />
    <fmt:message key="price.ariaLabel.salePrice" var="labelSalePrice"/>
    <fmt:message key="price.ariaLabel.originalPrice" var="labelOriginalPrice"/>
    <fmt:message key="price.ariaLabel.startingPrice" var="labelStartingPrice"/>
    <fmt:message key="price.ariaLabel.saleEnds" var="labelSaleEnds"/>
    <fmt:message key="price.ariaLabel.save" var="labelSave"/>

    <%-- Defines if pricing will be shown --%>
    <c:if test="${showPrice}">
        <%-- Define current price ID --%>
        <c:choose>
            <c:when test="${onSale}">
                <c:set var="regularPriceID" value="" />
                <c:set var="salePriceID" value="${currentPriceID}" />
            </c:when>
            <c:otherwise>
                <c:set var="regularPriceID" value="${currentPriceID}" />
                <c:set var="salePriceID" value="" />
            </c:otherwise>
        </c:choose>

        <%-- Define which pricing to display by default on page load --%>
        <%-- NOTE: for configurable products pricing will be updated via JS using AJAX --%>
        <c:choose>
            <c:when test="${pdpRecordType eq 'configurable'}">
                <%-- Hides pricing display and shows configurable message --%>
                <c:set var="configurePriceHideClass" value="" />
                <c:set var="showStartingAtLabel" value="true" />
                <c:set var="regularPriceHideClass" value="${hideClass}" />
                <c:set var="salePriceHideClass" value="${hideClass}" />
                <c:set var="saveAmountContainerHideClass" value="${hideClass}" />
            </c:when>
            <c:when test="${onSale}">
                <%-- shows sale price display --%>
                <c:set var="configurePriceHideClass" value="${hideClass}" />
                <c:set var="regularPriceHideClass" value="${hideClass}" />
                <c:set var="salePriceHideClass" value="" />
                <c:set var="saveAmountContainerHideClass" value="" />
            </c:when>
            <c:otherwise>
                <%-- shows regular price display --%>
                <c:set var="configurePriceHideClass" value="${hideClass}" />
                <c:set var="regularPriceHideClass" value="" />
                <c:set var="salePriceHideClass" value="${hideClass}" />
                <c:set var="saveAmountContainerHideClass" value="${hideClass}" />
            </c:otherwise>
        </c:choose>

        <%-- Define Sale End Date display by default on page load --%>
        <c:choose>
            <c:when test="${not empty endDate}">
                <c:set var="saleEndDateHideClass" value="" />
            </c:when>
            <c:otherwise>
                <c:set var="saleEndDateHideClass" value="${hideClass}" />
            </c:otherwise>
        </c:choose>

        <%-- Define Sale Save Amount display by default on page load --%>
        <c:choose>
            <c:when test="${not empty saveAmount}">
                <c:set var="saveAmountHideClass" value="" />
            </c:when>
            <c:otherwise>
                <c:set var="saveAmountHideClass" value="${hideClass}" />
            </c:otherwise>
        </c:choose>

        <%-- Define currency code fallback --%>
    	<c:if test="${empty currencyCode}">
            <c:set var="currencyCode" value="USD" />
    	</c:if>
    </c:if>

    <%-- Render Product Title Row --%>
    <div class="product-title-row section-row" itemprop="sku" content="${productSkuId}">
        <%-- Display Product Name --%>
        <c:if test="${not empty productName}">
            <h1 class="product-name" itemprop="name" content="${productName}">${productName}</h1>
        </c:if>

        <%-- Display Product Price and Rating --%>
        <div class="product-price-rating-container">
            <%-- START: Product Price --%>
            <%-- NOTE: Product Price is only rendered for product specific pdpRecordType --%>
            <div class="product-price" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                <c:choose>
                    <c:when test="${pdpRecordType eq 'discontinuedConfigurable' || pdpRecordType eq 'discontinuedSectional' || pdpRecordType eq 'discontinuedSimple' || pdpRecordType eq 'discontinuedLicensed'}">
                        <div class="discontinued"><fmt:message key="price.discontinued" /></div>
                        <link itemprop="availability" href="http://schema.org/OutOfStock" />
                    </c:when>
                    <c:when test="${showPrice}">
                        <link itemprop="availability" href="http://schema.org/InStock" />
						
                        <%-- JIRA DMI-1712: hiding initial page load price display and replacing with static message --%>
                        <div class="configure-for-pricing ${configurePriceHideClass}">
            				<fmt:message key="price.configureForPricing" />
            		  	</div>

                        <%-- Display Starting Price --%>
                        <div class="regular-price-container price ${regularPriceHideClass}" itemprop="priceCurrency" content="${currencyCode}">
                            <c:if test="${showStartingAtLabel}">
                                <div class="regular-label">
                                    <fmt:message key="price.startingAt" />
                                </div>
                            </c:if>
                            <div id="${regularPriceID}" class="regular-price" aria-label="${labelStartingPrice} ${formatLowestPrice}" itemprop="price" content="${lowestPriceDecimal}">
                                ${formatLowestPrice}
                            </div>
                        </div>
                        <%-- Display Sale Price --%>
                        <div class="sale-price-container price ${salePriceHideClass}" itemprop="priceCurrency" content="${currencyCode}">
                            <div class="side-by-side">
                                <div class="right">
                                    <c:if test="${showStartingAtLabel}">
                                        <div class="sale-label">
                                            <fmt:message key="price.startingAt" />
                                        </div>
                                    </c:if>
                                    <div id="${salePriceID}" class="sale-price" aria-label="${labelSalePrice} ${formatLowestSalePrice}" itemprop="price" content="${lowestSalePriceDecimal}">
                                        ${formatLowestSalePrice}
                                    </div>
                                </div>
                            </div>
                            <div class="side-by-side">
                                <div class="left">
                                    <div class="original-label">
                                        <fmt:message key="price.was" />
                                    </div>
                                    <div class="original-price" aria-label="${labelOriginalPrice} ${formatLowestPrice}">
                                        ${formatLowestPrice}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Display Sale End Date & Save Amount --%>
                        <div class="save-amount-container ${saveAmountContainerHideClass}">
                            <div class="sale-end-date ${saleEndDateHideClass}" aria-label="${labelSaleEnds} ${endDate}">
                                <fmt:message key="price.saleEnds" /> <span class="end-date-text">${endDate}</span>
                            </div>
                            <div class="save-amount ${saveAmountHideClass}" aria-label="${labelSave} ${formattedSaveAmount}">
                                 <span class="savings-label"><fmt:message key="price.save" /></span> <span class="savings-text">${formattedSaveAmount}</span>
                            </div>
                        </div>
                        
                        <c:if test="${country != 'CA'}">
	                        <div class="pdp-monthly-pricing hide" data-financingmonths="${digitalBuyFinancingMonths}">
		                        <c:choose>
		                        	<c:when test="${not empty lowestSalePrice}">
		                        		<dsp:getvalueof var="monthlyPriceRaw" value="${lowestSalePrice/digitalBuyFinancingMonths}" />
		                        	</c:when>
		                        	<c:otherwise>
		                        		<dsp:getvalueof var="monthlyPriceRaw" value="${lowestPrice/digitalBuyFinancingMonths}" />
		                        	</c:otherwise>
		                        </c:choose>
		                        
								<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
								
								<a href="/content/financing-disclosures" target="_blank">or <span class="currency-sign">$</span><span class="monthly-amt">${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
							</div>
						</c:if>
                   	</c:when>
                    <c:otherwise>
                        <%-- Don't render anything --%>
                    </c:otherwise>
                </c:choose>
            </div>
            <%-- END: Product Price --%>

            <%-- Render Product Rating Summary --%>
            <div class="product-rating-container">
                <%-- Include Product Rating Summary --%>
                <dsp:include src="/browse/includes/pdp/reviews/productRating.jsp">
                    <dsp:param name="productSkuId" value="${productSkuId}" />
                </dsp:include>
                <%-- Product Details anchor link --%>
                <div class="product-details-link"><a href="#productDetails"><fmt:message key="pdp.productDetails.heading"/></a></div>
            </div>
        </div>
    </div>

</dsp:page>