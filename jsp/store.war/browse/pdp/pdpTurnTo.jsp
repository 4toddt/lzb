<dsp:page>
    <!-- TURN TO REVIEWS AND QA -->
    <!--
    is configurable = ${isConfigurable}
    <br/>
    is sectional = ${isSectional}
    <br/>
    is simple = ${isSimple}
    <br/>
    is discontinued configurable = ${isDiscontinuedConfigurable}
    <br/>
    is discontinued sectional = ${isDiscontinuedSectional}
    <br/>
    is discontinued simple = ${isDiscontinuedSimple}
    <br/>
    -->
    <div id="customerFeedback" class="turnto-container pdp-block-container" data-anchor="productReviews">
        <h3 class="section-heading">
          <fmt:message key="pdp.reviews.heading"/>
        </h3>
        <div class="tabs-white-blue" >
            <div>
                <ul class="tabs" data-module="tabs" data-focus-selector="li > a">
                    <li data-rel="ttReviews">
                        <a href="#" data-rel="ttReviews" class="active" >
                          <fmt:message key="pdp.reviews.reviewsTab"/>
                        </a>
                    </li> 

                    <li>
                        <a href="#" data-rel="ttQA">
                          <fmt:message key="pdp.reviews.qaTab"/>
                        </a>
                    </li>
                </ul>
            </div>	
            <div id="ttReviews" class="turnto-customer-feedback pdp-block tab-content active">
                <dsp:include src="${pageContext.request.contextPath}/includes/productRatingsAndReviews.jsp"></dsp:include>
            </div>

            <div id="ttQA" class="turnto-qa pdp-block tab-content">
                <dsp:include src="${pageContext.request.contextPath}/includes/productQuestionAndAnswer.jsp"></dsp:include>
            </div>
        </div> 
    </div>
</dsp:page>