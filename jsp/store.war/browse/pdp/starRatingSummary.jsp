<dsp:page>

  <%-- Page Variables --%>
  <dsp:getvalueof var="turnToSiteKey" bean="/com/lzb/common/LZBTurnToConfiguration.turnToSiteKey" />
  <dsp:getvalueof param="productSkuId" var="productSkuId"/>

  <div class="pdp-item-rating scroll-click" data-scroll="productReviews" data-module="star-ratings">
    <!-- Mini star rating -->
    <div class="turnto-star-rating" tabindex="0">
      <div class="tt-reviews-count">
        <a href="#customerFeedback">
          <span class="numOfReviews">0</span> Reviews
        </a>
      </div>
      <div class="tt-stars">
        <div class="TTratingBox"></div>
      </div>
    </div>
  </div>

  <script>
    window.turnToCountsEndpoint = 'https://cdn-ws.turnto.com/v5/sitedata/${turnToSiteKey}/${productSkuId}/d/ugc/counts/en';
  </script>
</dsp:page>