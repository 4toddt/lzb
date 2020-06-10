<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />

	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
	<dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
	<dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
	<dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
	<dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
	<dsp:getvalueof var="transient" bean="Profile.transient" />

	<dsp:getvalueof param="lowestSalePrice" var="lowestSalePrice" />
	<dsp:getvalueof param="lowestPrice" var="lowestPrice" />
	<dsp:getvalueof param="formatLowestSalePrice" var="formatLowestSalePrice" />
	<dsp:getvalueof param="lowestPriceDecimal" var="lowestPriceDecimal" />
	<dsp:getvalueof param="formatLowestPrice" var="formatLowestPrice" />
	<dsp:getvalueof var="digitalBuyFinancingMonths" value="${storeConfig.digitalBuyFinancingMonths}" />

	<dsp:getvalueof var="productSkuId" value="${productRecord['sku.repositoryId']}" />
	
	<dsp:getvalueof var="country" bean="Profile.currentStore.country" />

	<%-- JIRA DMI-1763 Hide Wishlist UI, removed data-module="cdp-wishlist --%>
	<div class="pdp-title-row">
			
		<c:if test="${content['@type'] eq 'ProductDetail'}">
			<c:if test="${not empty productRecord['sku.displayName']}">
				<div class="pdp-title">
					<h1>${productRecord['sku.displayName']}</h1>
				</div>
			</c:if>
		</c:if>

		<meta itemprop="availability" content="http://schema.org/InStock" />
		<meta itemprop="priceCurrency" content="${currencyCodeForOGTag}" />
		
		<div class="pdp-price-rating-container">
				

			<div class="pdp-price">
				<c:choose>
          <c:when test="${discontinued eq 'true'}">
			<%-- JIRA DMI-1712: hiding initial page load price display and replacing with static message --%>
			<div class="configure-for-pricing">
				<fmt:message key="price.configureForPricing"/>
		  	</div>

			<div id="pdp-price-info" class="hide" data-module="tool-tips">
              <c:if test="${not empty productRecord['sku.cover']}">
		            <c:choose>
		              <c:when test="${onSale}">
		                <fmt:parseNumber var="saveAmount123" value="${saveAmount}"/>
		                <fmt:formatNumber var="formattedSaveAmount" value="${saveAmount123}" type="currency" />
		                <fmt:formatNumber var="saveAmountDecimal" value="${saveAmount123}" type="number" minFractionDigits="2" maxFractionDigits="2" />

		                <span aria-label="Original price: ${formatLowestPrice} Price is now: ${formatLowestSalePrice}">
			                <div class="pdp-pricing-amount">
			                	<div class="pdp-pricing-title" aria-hidden="true">
			                		<fmt:message key="price.startingAt"/>
			                	</div>
			                  <div class="amount">
			                    <span aria-hidden="true" id="pdp-price">${formatLowestSalePrice}</span>
			                  </div>
			                </div>

			                <div class="pdp-pricing-amount">
			                	<div class="pdp-pricing-title" aria-hidden="true">
			                		<fmt:message key="price.was"/>
			                	</div>
			                	<div class="pdp-pricing-was strike">
			                		<span data-price="${lowestPrice}" aria-hidden="true">${formatLowestPrice}</span>
			                	</div>
			                </div>
		                </span>


                    <meta itemprop="price" content="${lowestPriceDecimal}" />
                    <div class="pdp-save-amount-info">
	                    <c:if test="${not empty saveAmount}">
	                      <c:if test="${not empty endDate}">
	                       	<span aria-label="Sale ends: ${endDate}">
		                        <div id="pdp-price-sale-enddate" class="pdp-sale-enddate" aria-hidden="true">Sale Ends&nbsp;${endDate}</div>
	                        </span>
	                      </c:if>
	                      <span aria-label="You are saving: ${formattedSaveAmount}">
	                        <div class="pdp-sale-price" id="pdp-price-save-amount" aria-hidden="true">Save&nbsp;${formattedSaveAmount}</div>
	                      </span>
	                    </c:if>
                    </div>
                  </c:when>

                  <c:otherwise>
										<span aria-label="Original price: ${formatLowestPrice}">
			                <div class="pdp-pricing-amount">
			                	<div class="pdp-pricing-title" aria-hidden="true">
			                		<fmt:message key="price.startingAt"/>
			                	</div>
			                  <div class="amount">
			                    <span aria-hidden="true" id="pdp-price">${formatLowestPrice}</span>
			                  </div>
			                </div>
							
			                <div class="pdp-pricing-amount">
			                	<div class="pdp-pricing-title" aria-hidden="true" style="display: none;">
			                		<fmt:message key="price.was"/>
			                	</div>
			                	<div class="pdp-pricing-was strike">
			                		<span data-price="${lowestPrice}" aria-hidden="true"></span>
			                	</div>
			                </div>
		                </span>

                    <meta itemprop="price" content="${lowestPriceDecimal}" />
                    <div class="pdp-save-amount-info">
                     	<span aria-label="Sale ends:">
                        <div id="pdp-price-sale-enddate" class="pdp-sale-enddate" aria-hidden="true"></div>
                      </span>
                    <span aria-label="You are saving:">
                      <div class="pdp-sale-price" id="pdp-price-save-amount" aria-hidden="true"></div>
                    </span>
                    </div>
                  </c:otherwise>

	              </c:choose>
              </c:if>
            </div>
          </c:when>
          <c:otherwise>
          	<div class="discontinued">
              <div>Discontinued</div>
          	</div>
          </c:otherwise>
	      </c:choose>
      </div>

			<dsp:include src="${pageContext.request.contextPath}/browse/pdp/starRatingSummary.jsp">
				<dsp:param name="productSkuId" value="${productSkuId}" />
			</dsp:include>
			<c:if test="${country != 'CA'}">
				<div class="pdp-monthly-pricing hide" data-financingmonths="${digitalBuyFinancingMonths}">
					<dsp:getvalueof var="monthlyPriceRaw" value="${lowestPrice/digitalBuyFinancingMonths}" />
					<fmt:formatNumber value="${monthlyPriceRaw+0.5-((monthlyPriceRaw+0.5)%1)}" var="monthlyPrice" maxFractionDigits="0" />
									
					<a href="/content/financing-disclosures" target="_blank">or $<span class="monthly-price">${monthlyPrice}</span>/<fmt:message key="price.month"/> for <span class="financing-months">${digitalBuyFinancingMonths}</span> months<span class="question-icon">?</span></a>
				</div>
			</c:if>
		</div>
	</div>
</dsp:page>