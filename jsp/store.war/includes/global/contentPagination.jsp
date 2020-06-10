<%--  
  This page is a global page for handling pagination.
  
  Required parameters
    arraySplitSize
      number of items to show on each page.
    start
      index (1 based) of first element to show on this page.
    size
      size of the product listing to be displayed
    top
      true if this is the top set of links, false if it is the bottom set
      
  Optional parameters:
    viewAll
      set to true if viewAll has been requested.      
--%>
<dsp:page>

	<dsp:getvalueof var="paramName" vartype="java.lang.String" param="paramName" />
	<dsp:getvalueof var="paramValue" vartype="java.lang.String" param="paramValue" />
	
	<dsp:getvalueof var="searchParamName" vartype="java.lang.String" param="searchParamName" />
	<dsp:getvalueof var="searchParamValue" vartype="java.lang.String" param="searchParamValue" />
	
  <dsp:getvalueof var="size" vartype="java.lang.Integer" param="size"/>
  <dsp:getvalueof var="arraySplitSize" vartype="java.lang.Integer" param="arraySplitSize"/>
  
  <%-- This line is added as weblogic 10.0 converting Integer parameter as Long --%>
  <c:set var="arraySplitSize" value="${arraySplitSize}"/>
  
  <dsp:getvalueof id="start" idtype="java.lang.String" param="start"/>
  <dsp:getvalueof id="viewAll" param="viewAll"/>
  <dsp:getvalueof id="top" param="top"/>

  <c:if test="${size > arraySplitSize}">
  
    <%-- 
      No need to show the pagination when the number of items is less or equal
      to the defined number of items per page
     --%>
    <lzb:pagination size="${size}" arraySplitSize="${arraySplitSize}" start="${start}"
                    viewAll="${viewAll}" top="${top}">
					
	<jsp:attribute name="prevPageLinkRenderer">
		&nbsp;
			<dsp:a href="${requestScope['javax.servlet.forward.request_uri']}" title="Prev">
              <dsp:param name="start" value="${prevStart}"/>
			  <dsp:param name="howMany" value="${arraySplitSize}"/>
			  <c:if test="${not empty paramName and not empty paramValue}">
				 <dsp:param name="${paramName}" value="${paramValue}"/>
			  </c:if>
			  <c:if test="${not empty searchParamName and not empty searchParamValue}">
				 <dsp:param name="${searchParamName}" value="${searchParamValue}"/>
			  </c:if>
				Prev<br />
            </dsp:a>
	  </jsp:attribute>

	  
      <jsp:attribute name="pageLinkRenderer">
        <c:choose>
          <c:when test="${selected && !viewAll}">
            <c:out value="${linkText}"/>
          </c:when>
          <c:otherwise>
            <dsp:a href="${requestScope['javax.servlet.forward.request_uri']}" title="${linkTitle}">
              <dsp:param name="start" value="${startValue}"/>
			  <dsp:param name="howMany" value="${arraySplitSize}"/>
			  <c:if test="${not empty paramName and not empty paramValue}">
				 <dsp:param name="${paramName}" value="${paramValue}"/>
			  </c:if>
			  <c:if test="${not empty searchParamName and not empty searchParamValue}">
				 <dsp:param name="${searchParamName}" value="${searchParamValue}"/>
			  </c:if>
              ${linkText}
            </dsp:a>
          </c:otherwise>
        </c:choose>
      </jsp:attribute>
	  
	  <jsp:attribute name="nextPageLinkRenderer">
			&nbsp;
			 <dsp:a href="${requestScope['javax.servlet.forward.request_uri']}" title="Next">
              <dsp:param name="start" value="${nextStart}"/>
			  <dsp:param name="howMany" value="${arraySplitSize}"/>
			  <c:if test="${not empty paramName and not empty paramValue}">
				 <dsp:param name="${paramName}" value="${paramValue}"/>
			  </c:if>
			  <c:if test="${not empty searchParamName and not empty searchParamValue}">
				 <dsp:param name="${searchParamName}" value="${searchParamValue}"/>
			  </c:if>
				Next
            </dsp:a>
	  </jsp:attribute>
	  
      <jsp:attribute name="viewAllLinkRenderer">
        <c:choose>
          <c:when test="${viewAll}">
            <c:out value="${linkText}"/>
          </c:when>
          <c:otherwise>
            <dsp:a href="${requestScope['javax.servlet.forward.request_uri']}" title="${linkTitle}"
               iclass="${viewAllLinkClass}">
               <dsp:param name="viewAll" value="true"/>
               <dsp:param name="howMany" param="size"/>
              ${linkText}
            </dsp:a>
          </c:otherwise>
        </c:choose>
      </jsp:attribute>
    </lzb:pagination>
  </c:if>  

</dsp:page>