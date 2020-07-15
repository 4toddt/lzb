<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
  <dsp:importbean bean="/com/lzb/endeca/CoverSearchActionURLDroplet" />
  <dsp:importbean bean="/atg/userprofiling/Profile" />
  <dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
  <dsp:droplet name="/com/lzb/droplet/LZBProfileSaveCoverMapDroplet">
    <dsp:oparam name="output">
      <dsp:getvalueof var="coverGiftIdMap" param="coverGiftIdMap" />
    </dsp:oparam>
    <dsp:oparam name="empty"></dsp:oparam>
  </dsp:droplet>

  <script id="CoverData" type="application/json">
    <json:array>
      <c:forEach items="${contentItem.records}" var="element">
        <c:set var="product" value="${element.records[0].attributes}" />
        <c:if test="${fn:contains(product['record.type'], 'Cover Sku')}">

          <%-- Get all required variables from XM --%>
          <c:set var="cover" value="${element.attributes}" />
          <c:set var="coverId">${element.attributes['sku.repositoryId']}</c:set>
          <dsp:getvalueof var="wishlistId" value="${coverGiftIdMap[coverId]}"/>
          <c:set var="coverTitle" value="${cover['sku.displayName']}" />
          <c:set var="coverColor" value="${cover['colorFamliy']}" />
          <c:set var="coverMaterial" value="${cover['coverType']}" />
          <c:set var="coverPattern" value="${cover['patternName']}" />

          <%-- build the JSON object --%>
          <json:object prettyPrint="true" escapeXml="false">
            <json:property name="sku" value="${coverId}" />
            <json:property name="title" value="${coverTitle}" />
            <json:property name="material" value="${coverMaterial}" />
            <json:property name="color" value="${coverColor}" />
            <json:property name="pattern" value="${coverPattern}" />
            <json:property name="wishlistId" value="${wishlistId}" />
          </json:object>

        </c:if>
      </c:forEach>
    </json:array>
  </script>

  <div class="coverSearch__covers coverSearch__covers-js">
    <%-- Search results are displayed dynamically by the client side.
    Check coverSearch.js to view the template for search results --%>
  </div>

  <div class="coverPagination coverPagination-js">
    <a href="#" class="coverPagination__prev coverPagination__prev-js">PREV</a>
    <div class="coverPagination__numbers coverPagination__numbers-js">
      <%-- Pagination is displayed dynamically by the client side.
      Check coverSearch.js to view the template for coverPagination --%>
    </div>
    <a href="#" class="coverPagination__next coverPagination__next-js">NEXT</a>
  </div>

</dsp:page>
