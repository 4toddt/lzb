<dsp:page>
  <dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
  <dsp:importbean var="originatingRequest" bean="/OriginatingRequest"/>
  <dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
  <dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
  <dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>

  <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
    <dsp:param name="inUrl" value="/"/>
    <dsp:oparam name="output">
      <dsp:getvalueof id="updatedProtocolURL" param="secureUrl" idtype="java.lang.String" scope="request" />
    </dsp:oparam>
  </dsp:droplet>

  <c:set var="headerUrl">${header.referer}</c:set>
	<c:set var="strPositionOfPort" value=".com"/>
	<c:set var="intPositionOfPort">${fn:indexOf(headerUrl, strPositionOfPort)}</c:set>
	<c:set var="url">${fn:substring(headerUrl, 0, (intPositionOfPort + 4))}</c:set>

  <div class="signin-menu">
    <div class="signin-dropdown" data-module="modal-jquery-validation" data-domain="${updatedProtocolURL}" data-destination="${url}">

      <dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
        <dsp:param name="inUrl" value="${hostName}/xhr/amplifiSubmit.jsp"/>
        <dsp:oparam name="output">
          <dsp:getvalueof id="submitURL" param="secureUrl" idtype="java.lang.String" scope="request" />
        </dsp:oparam>
      </dsp:droplet>

      <div id="signInError" class="amp-error"></div>
      <div class="signin">
        <h4><fmt:message key="header.signInHeading"/></h4>
        <%-- START Sign-in Form --%>
        <form action="${submitURL}" method="post" id="signInForm" class="modal-jquery-validation sign-in-form amplifi-form" data-error-messaging="#signInError" autocomplete="off">
          <fieldset>
            <legend><fmt:message key="login.signInLegend"/></legend>
            <fieldset>
              <legend><fmt:message key="login.signInEmailLegend"/></legend>
              <fmt:message key="common.loginEmailAddress" var="loginEmailAddress"/>
              <label for="email">${loginEmailAddress}:</label>
              <input type="email" id="email" name=".value.login" class="amplifi-input" maxlength="50" required="true" placeholder="${loginEmailAddress}" />
            </fieldset>
            <fieldset>
              <legend><fmt:message key="login.signInPasswordLegend"/></legend>
              <fmt:message key="common.loginPassword" var="loginPassword"/>
              <label for="password">${loginPassword}:</label>
              <input type="password" id="password" name=".value.password" maxlength="16" value="" class="amplifi-input pwAlphaNumeric" required="true" placeholder="${loginPassword}" />
            </fieldset>
            <fieldset>
              <legend><fmt:message key="login.signInSubmitLegend"/></legend>
              <div class="custom-checkbox">
                <input type="checkbox" id="remember" name=".value.rememberMe" name="remember" class="amplifi-input" checked="true"/>
                <fmt:message key="remember.me" var="rememberMe"/>
                <fmt:message key="remember.tooltip" var="rememberMeTooltip"/>
                <label for="remember" class="checkout checkout1">${rememberMe}
                  <a title="${rememberMeTooltip}" class="tooltip" href="#" data-tip="Remember Me">
                              <div class="triangle-with-shadow"></div>
                              <div title="" class="tooltip-img"></div>
                  </a>
                </label>
              </div>
              <fmt:message key="login.signInButton" var="signInButton"/>
              <input type="submit" value="${signInButton}" class="button primary-btn submitBtn amplifi-submitter" data-error-messaging="#signInError" />
              <input type="hidden" name="amplifiHandler" value=".login" class="amplifi-input" />
              <input type="hidden" name="amplifiBean" value="/atg/userprofiling/ProfileFormHandler" class="amplifi-input" />
              <input type="hidden" id="amplifiSuccessUrl" name="amplifiSuccessUrl" value="" />
              <input type="hidden" id="hostName" name="hostName" value="${updatedProtocolURL}" />
            </fieldset>
          </fieldset>
          <dsp:include page="${pageContext.request.contextPath}/xhr/getAmplifiToken.jsp">
            <dsp:param name="class" value="amplifi-input" />
          </dsp:include>
        </form>
        <%-- END Sign-in Form --%>
      </div>
    </div>

    <div class="content">
      <fmt:message key="forgot.password" var="forgotPassword"/>
      <a href="${pageContext.request.contextPath}/modals/forgot-password.jsp" class="forgotpw forgot-password-click" ariaLabel="${forgotPassword}" tabindex="0">${forgotPassword}</a>

      <%-- START Social Sign-in --%>
      <div class="fb-signin-section">
        <jsp:include page="${pageContext.request.contextPath}/account/fbConnect.jsp" />
      </div>
      <%-- END Social Sign-in --%>

      <%-- START Create Account --%>
      <div class="create-account">
        <h4><fmt:message key="login.createAccountHeading"/></h4>
        <p class="small"><fmt:message key="login.createAccountDescription"/></p>
        <fmt:message key="login.createAccountButton" var="createAccountButton"/>
        <a href="${pageContext.request.contextPath}/modals/create-account.jsp" class="button secondary-btn create-account-click" aria-label="${createAccountButton}" tabindex="0">${createAccountButton}</a>
      </div>
      <%-- END Create Account --%>
    </div>
  </div>
</dsp:page>