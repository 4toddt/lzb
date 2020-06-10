<dsp:page>
  <dsp:getvalueof param="skuId" var="skuId" />
  <dsp:getvalueof param="lowestSalePrice" var="lowestSalePrice" />
  <dsp:getvalueof param="lowestPrice" var="lowestPrice" />

  <fmt:message key="pdp.productMenu.whatToExpect" var="whatToExpect"/>
  <fmt:message key="pdp.link.estimateShippingCost" var="estimateShippingCost"/>
  <fmt:message key="pdp.link.seeItInStore" var="seeItInStore"/>

  <div class="add-to-cart-links">
    <ul>
      <li>
        <a href="#" class="scroll-click" data-scroll="whatToExpect" aria-label="${whatToExpect}" tabindex="0">${whatToExpect}</a>
      </li>
      <c:if test="${isSimple eq 'false'}">
        <li data-module="estimated-shipping-cost">
          <c:choose>
            <c:when test="${onSale}">
              <c:set var="linkPrice" value="${lowestSalePrice}" />
            </c:when>
            <c:otherwise>
              <c:set var="linkPrice" value="${lowestPrice}" />
            </c:otherwise>
          </c:choose>
          <a id="estimated-shipping-link" href="${contextPath}/modals/estimate-shipping-cost.jsp?sku=${skuId}&price=${linkPrice}" class="estimate-shipping-click" aria-label="${estimateShippingCost}" tabindex="0">${estimateShippingCost}</a>
        </li>
      </c:if>
      <li>
        <a href="${contextPath}/storeLocator/storeLocator.jsp" aria-label="${seeItInStore}" tabindex="0">${seeItInStore}</a>
      </li>
    </ul>
  </div>
</dsp:page>