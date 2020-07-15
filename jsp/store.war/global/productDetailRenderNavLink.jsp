<%--
  Renders navigation links. navAction is an endeca NavigationAction.
--%>
<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>

  <dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${originatingRequest.contextPath}"/>
  <dsp:getvalueof var="navAction" vartype="com.endeca.infront.cartridge.model.NavigationAction" param="navAction"/>
  <dsp:getvalueof var="linkText" param="text"/>
  <dsp:getvalueof var="showRemoveLink" vartype="java.lang.Boolean" param="showRemoveLink"/>
  <dsp:getvalueof var="titleText" vartype="java.lang.String" param="titleText"/>
  <dsp:getvalueof param="contextPath" var="contextPath" />
    <c:choose>
      <c:when test="${(not empty navAction.contentPath) && (not empty titleText)}">
		<li>
        <a href="${contextPath}/b${fn:escapeXml(navAction.navigationState)}" class="${showRemoveLink == true ? 'curnt' : ''}" title="${titleText}" itemprop="url">
          	<span  itemprop="title">${linkText}</span>
          </a></li>
      </c:when>
      <c:when test="${(not empty navAction.contentPath) && (empty titleText)}">
        <li>
        <a href="${contextPath}/b${fn:escapeXml(navAction.navigationState)}" class="${showRemoveLink == true ? 'curnt' : ''}" itemprop="url">
        	<span  itemprop="title">${linkText}</span>
        </a></li>
      </c:when>
      <c:when test="${(empty navAction.contentPath) && (not empty titleText)}">
        <li>
        <a href="${contextPath}/b${fn:escapeXml(navAction.navigationState)}" class="${showRemoveLink == true ? 'curnt' : ''}" title="${titleText}" itemprop="url">
        	<span  itemprop="title">${linkText}</span>
       </a> </li>
      </c:when>
      <c:otherwise>
        <li>
        <a href="${contextPath}/b${fn:escapeXml(navAction.navigationState)}" class="${showRemoveLink == true ? 'curnt' : ''}" itemprop="url">
        	<span  itemprop="title">${linkText}</span>
        </a> </li>
      </c:otherwise>
    </c:choose>

</dsp:page>