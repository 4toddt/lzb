<dsp:page>
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
<dsp:getvalueof var="contextP" value="${originatingRequest.requestURI}"/>
<dsp:getvalueof var="scheme" value="${originatingRequest.scheme}"/>
<dsp:getvalueof var="serverName" value="${originatingRequest.serverName}"/>
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
<c:set var="endecaUrl" value="${requestScope['javax.servlet.forward.request_uri']}" />
	<c:choose>
		<c:when test="${not empty endecaUrl}">
			<c:set var="url" value="${scheme}://${serverName}${endecaUrl}" />
		</c:when>
		<c:otherwise>
			<c:set var="url" value="${pageContext.request.requestURI}" />
			<c:choose>
				<c:when test="${url eq 'index.jsp'}">
					<c:set var="url" value="${scheme}://${serverName}/${url}" />
				</c:when>
				<c:otherwise>
					<c:if test="${scheme eq 'https'}">
						<c:set var="url" value="${scheme}://${serverName}${pageContext.request.requestURI}" />
					</c:if>
					<c:if test="${scheme eq 'http'}">
						<c:set var="url" value="${scheme}://${serverName}${pageContext.request.requestURI}" />
					</c:if>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
	<dsp:getvalueof var="successMessage" bean="ProfileFormHandler.successMessage"/>
	<dsp:getvalueof var="errorMessage" bean="ProfileFormHandler.errorMessage"/>
	<dsp:valueof value="${errorMessage}"/>
	<dsp:getvalueof param="signUpCheck" var="signUpValue"/>
	<!-- to display error messages -->
	<c:if test="${signUpValue eq 'true'}">
		<dsp:getvalueof bean="ProfileFormHandler.formError" var="formError" />
	
		<c:if test="${formError eq 'true'}">
			<h3><fmt:message key="error.msg"/></h3>
			<dsp:include page="/global/includes/errors.jsp">
				<dsp:param name="formHandler" bean="ProfileFormHandler" />
			</dsp:include>
		</c:if>
	</c:if>
	<div class="footer-form-wrapper">

		<h3 class="email-signup-header"><fmt:message key="signupEmail.reciveOffers"/></h3>

		<dsp:form data-js-submit-form data-eloqua-submit method="post" name="signup" id="emailSignUpForm" formid="emailSignUpForm" action="/home/actions/sign_up_email_action.jsp" data-validate>

			<section class='main-form'>
				<span class="signup-input-group">
					<label for="emailSignUpEmail"><fmt:message key="signupEmail.emailAddr"/></label>
					<dsp:input type="email" bean="ProfileFormHandler.profileValueMap.email" maxlength="50" name="email" id="emailSignUpEmail">
						<dsp:tagAttribute name="data-validation" value="required email"/>
		                <dsp:tagAttribute name="autocomplete" value="off"/>
		                <dsp:tagAttribute name="data-fieldName" value="Email"/>
						<dsp:tagAttribute name="placeholder" value="Enter your email address"/>
					</dsp:input>
				</span>
				<span class="signup-input-group">
					<label for="emailSignUpZip"><fmt:message key="signupEmail.zipPostal"/></label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.postalCode" maxlength="15" name="account_postalCode" id="emailSignUpZip">
						<dsp:tagAttribute name="placeholder" value="Enter your zip/postal code"/>
						<dsp:tagAttribute name="data-validation" value="required usorcapostal"/>
                		<dsp:tagAttribute name="autocomplete" value="off"/>
					</dsp:input>
				</span>
				<dsp:input type="hidden" bean="ProfileFormHandler.signUpEmailSuccessURL" value="/home/actions/sign_up_email_action.jsp" />
				<dsp:input type="hidden" bean="ProfileFormHandler.signUpEmailErrorURL" value="/home/actions/sign_up_email_action.jsp" />
				<button id="emailSignup" type="button" class="button tertiary medium">Sign up</button>
			</section>
			<span id="email-signup-success-message" class="success-message hide"></span>
			<span id="email-signup-error-message" class="error-message hide"></span>
			<input type="hidden" name="elqFormName" value="emailSignUpForm">
			<input type="hidden" name="elqSiteID" value="20103530">
			<input type="hidden" name="elqCustomerGUID" value="">
			<input type="hidden" name="elqCookieWrite" value="0">
			<input id="field3" type="hidden" name="lead_source_original_hidden" value="Website - Account Creation" />
		</dsp:form>

		<ul class="social-links">
			<li>Connect with us on: </li>
			<li><a href="https://www.facebook.com/lazboy" target="_blank" rel="external" title="Connect with us on Facebook"><span class="icon social-icon-square facebook-square"></span></a></li>
			<li><a href="https://twitter.com/lazboy" target="_blank" rel="external" title="Connect with us on Twitter"><span class="icon social-icon-square twitter-square"></span></a></li>
			<li><a href="https://www.pinterest.com/lazboy/" target="_blank" rel="external" title="Connect with us on Pinterest"><span class="icon social-icon-square pinterest-square"></span></a></li>
			<li><a href="https://www.instagram.com/lazboy/" target="_blank" rel="external" title="Connect with us on Instagram"><span class="icon social-icon-square instagram-square"></span></a></li>
			<%-- JIRA DMI-2016: Remove Houzz Social Icon
			<li><a href="https://www.houzz.com/pro/lazboy/la-z-boy" target="_blank" rel="external" title="Connect with us on Houzz"><span class="icon social-icon-square houzz-square"></span></a></li>
			--%>
			<li><a href="http://www.youtube.com/user/lazboy" target="_blank" rel="external" title="Connect with us on YouTube"><span class="icon social-icon-square youtube-square"></span></a></li>
		</ul>
	</div>

	<%-- Eloqua Script start --%>
		<script type='text/javascript'>
			var timerId = null, timeout = 5;
		</script>
		<script type='text/javascript'>
			function WaitUntilCustomerGUIDIsRetrieved() {
				if (!!(timerId)) {
					if (timeout == 0) {
				return;
				}
				if (typeof this.GetElqCustomerGUID === 'function') {
						document.forms["emailSignUpForm"].elements["elqCustomerGUID"].value = GetElqCustomerGUID();
				return;
				}
				timeout -= 1;
				}
				timerId = setTimeout("WaitUntilCustomerGUIDIsRetrieved()", 500);
				return;
			}
			window.onload = WaitUntilCustomerGUIDIsRetrieved;
			var _elqQ = _elqQ || [];
			_elqQ.push(['elqGetCustomerGUID']);

		</script>
		<%-- Eloqua Script end --%>
</dsp:page>
