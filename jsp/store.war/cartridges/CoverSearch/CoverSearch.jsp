<dsp:page>
    <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />


    <div data-module="cover-search">
        <h1 class="coverSearch__pageTitle">Cover Search</h1>
        <c:if test="${not empty contentItem.CoverSearchRefinementContainer}">
            <dsp:renderContentItem contentItem="${contentItem.CoverSearchRefinementContainer}" />
        </c:if>
        <c:if test="${not empty contentItem.FabricSelectorResultsList}">
            <dsp:renderContentItem contentItem="${contentItem.FabricSelectorResultsList}" />
        </c:if>
        <c:if test="${not empty contentItem.Disclaimer}">
            <dsp:renderContentItem contentItem="${contentItem.Disclaimer}" />
        </c:if>
    </div>

</dsp:page>