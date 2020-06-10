<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
  <c:set var="navajax" scope="request"><dsp:valueof param="navajax"/></c:set>
  <c:set var="rlistonlyajax" scope="request"><dsp:valueof param="rlistonlyajax"/></c:set>

   <c:if test="${not empty contentItem.contents }">
    <c:forEach var="element" items="${contentItem.contents}">
      <c:if test ="${not empty element}">
      	<dsp:renderContentItem contentItem="${element}"/>
      </c:if>
    </c:forEach>
   </c:if>   

</dsp:page>