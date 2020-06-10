<dsp:page>
  <div class="product-menu tabs-white-blue">
    <div>
      <ul class="tabs">
        <fmt:message key="pdp.productMenu.productDetails" var="productDetails"/>
        <fmt:message key="pdp.productMenu.whatToExpect" var="whatToExpect"/>
        <fmt:message key="pdp.productMenu.whyLZB" var="whyLZB"/>
        <fmt:message key="pdp.productMenu.productReviews" var="productReviews"/>
        <li><a href="#" class="scroll-click active" data-scroll="productDetails" aria-label="${productDetails}" tabindex="0">${productDetails}</a></li>
        <li><a href="#" class="scroll-click" data-scroll="whatToExpect" aria-label="${whatToExpect}" tabindex="0">${whatToExpect}</a></li>
        <c:if test="${isLicensed ne 'true'}">
            <li><a href="#" class="scroll-click" data-scroll="whyLZB" aria-label="${whyLZB}" tabindex="0">${whyLZB}</a></li>
        </c:if>
        <li><a href="#" class="scroll-click" data-scroll="productReviews" aria-label="${productReviews}" tabindex="0">${productReviews}</a></li>
      </ul>
    </div>
  </div>
</dsp:page>