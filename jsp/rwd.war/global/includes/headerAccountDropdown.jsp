<dsp:page>
  <dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />

  <dsp:getvalueof var="firstName" bean="Profile.firstName" />

    <c:choose>
      <c:when test="${firstName != null }">
        <c:choose>
          <c:when test="${fn:length(firstName) > 12 }">
            <c:set var="fName" value="${fn:substring(firstName,0, 12)}" />
            <%-- Hello,${fName}.. --%>
            <c:set var="loginName" value="Hi, ${fName}!" />
          </c:when>
          <c:otherwise>
            <!-- need to display first name -->
            <%-- Hello,${firstName} --%>
            <c:set var="loginName" value="Hi, ${firstName}!" />
          </c:otherwise>
        </c:choose>
      </c:when>
      <c:otherwise>
        <%-- Welcome, View Account --%>
        <c:set var="loginName" value="Welcome, View Account" />
      </c:otherwise>
    </c:choose>

    <a href="#" class="utility menu-pointer sub-nav-button" tabindex="0">${loginName} <span class="icon-arrow-down"></span></a>

    <div class="account-menu sub-nav-menu">
        <ul class="account-list">
            <dsp:include src="/account/includes/headerAccountMenu.jsp">
                <dsp:param name="loginName" value="${loginName}" />
            </dsp:include>
        </ul>
    </div>

</dsp:page>