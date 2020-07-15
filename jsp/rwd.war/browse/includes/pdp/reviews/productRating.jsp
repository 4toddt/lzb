<%--
    - File Name: productRating.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product rating summary section on the product page.
    - Required Parameters:
        - productReviewCount: number of product reviews,
        - productRating: product reviews rating
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>

    <%-- Page Variables --%>
    <dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
    <dsp:getvalueof param="productSkuId" var="productSkuId"/>
    
    <div class="product-rating">
        <!-- Mini star rating -->
        <div class="turnto-star-rating" tabindex="0">
            <div class="tt-reviews-count">
                <a href="#customerFeedback">
                    <span class="numOfReviews">0</span> Reviews
                </a>
            </div>
            <div class="tt-stars">
                <fmt:parseNumber var="rating" value="${productRating}" type="NUMBER"/>
                <a href="#customerFeedback">
                    <div class="TTratingBox"></div>
                </a>
            </div>
        </div>
    </div>

    <script>
        window.turnToCountsEndpoint = 'https://cdn-ws.turnto.com/v5/sitedata/${turnToSiteKey}/${productSkuId}/d/ugc/counts/en';
    </script>
</dsp:page>