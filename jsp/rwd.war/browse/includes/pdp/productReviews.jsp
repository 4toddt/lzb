<%--
    - File Name: productReviews.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the customer reviews for the product record.
    - Required Parameters:
		- TurnToProductSku: the turnTo product record id
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>

    <%-- Page Variables --%>
    <dsp:getvalueof var="TurnToProductSku" param="TurnToProductSku" />

    <%-- Render Customer Reviews --%>
    <div id="customerFeedback" class="turnto-container section-row">
        <div class="section-title">
            <h2><fmt:message key="pdp.reviews.heading"/></h2>
        </div>
        <div class="section-content tabs" data-tabs="">
            <div>
                <ul class="tabs-container" role="tablist" data-focus-selector="li > a">
                    <li role="presentation">
                        <a href="#" class="tab-title active" aria-selected="true" aria-controls="ttReviews" role="tab">
                          <fmt:message key="pdp.reviews.reviewsTab"/>
                        </a>
                    </li>
                    <li>
                        <a href="#" class="tab-title" aria-selected="false" aria-controls="ttQA" role="tab">
                          <fmt:message key="pdp.reviews.qaTab"/>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="tabs-content">
                <div id="ttReviews" class="tab-body active turnto-customer-feedback pdp-block tab-content active">
                    <dsp:include src="/browse/includes/pdp/reviews/productRatingsAndReviews.jsp"></dsp:include>
                </div>

                <div id="ttQA" class="tab-body turnto-qa pdp-block tab-content">
                    <dsp:include src="/browse/includes/pdp/reviews/productQuestionAndAnswer.jsp"></dsp:include>
                </div>
            </div>
        </div>
    </div>
</dsp:page>