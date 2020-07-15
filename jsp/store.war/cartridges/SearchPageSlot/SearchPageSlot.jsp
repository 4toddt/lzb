<%--
  ~ Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  ~ Oracle and Java are registered trademarks of Oracle and/or its
  ~ affiliates. Other names may be trademarks of their respective owners.
  ~ UNIX is a registered trademark of The Open Group.  

 
  This renderer calls the renderContentItem for it's contents.
    
  Required Parameters:
    contentItem
      The page slot content item to render.
   
  Optional Parameters:

--%>
<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
  <dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>
<c:set var="searchScope" value="${contentItem.searchScope}" scope ="request"/>
<c:set var="isPDPUrl" value="${contentItem.isPdpUrl}" scope ="request"/>

  <%--<endeca:includeSlot contentItem="${contentItem}">--%>
   <c:if test="${not empty contentItem.contents }">

    <c:forEach var="element" items="${contentItem.contents}">
      <dsp:renderContentItem contentItem="${element}"/>
    </c:forEach>

   </c:if>
  <%--</endeca:includeSlot>--%>

</dsp:page>