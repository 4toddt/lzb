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
		<dsp:droplet name="Switch">
			<dsp:param name="value" bean="ProfileFormHandler.formError" />
			<dsp:oparam name="true">

				<!-- <h3><fmt:message key="error.msg"/></h3> -->
				<dsp:droplet name="ErrorMessageForEach">
					<dsp:param name="exceptions"
						bean="ProfileFormHandler.formExceptions" />
					<dsp:oparam name="outputStart">
						<ul>
					</dsp:oparam>
					<dsp:oparam name="output">
						<li><label style="color: #ff0000;"><dsp:valueof param="message" /></label></li>
					</dsp:oparam>
					<dsp:oparam name="outputEnd">
						</ul>
					</dsp:oparam>
				</dsp:droplet>
				</div>
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
	<div data-module="eloqua-submit form-validate">

		<dsp:form method="post" name="signup" id="emailSignUpForm" action="/home/actions/sign_up_email_action.jsp">

			<fieldset data-module="sign-up-email">
				<legend>Email Sign-up</legend>

				<span id="email-signup-section" class="email-signup-section">
					<label for="emailSignUpEmail">ENTER YOUR EMAIL</label>
					<dsp:input type="email" bean="ProfileFormHandler.profileValueMap.email" maxlength="50" name="email" id="emailSignUpEmail" required="required">
						<dsp:tagAttribute name="placeholder" value="Enter your email address"/>
					</dsp:input>
					<%-- <span>AND</span> --%>
				</span>
				<span id="email-signup-section" class="email-signup-section">
					<label for="emailSignUpZip">ENTER YOUR ZIP/POSTAL CODE</label>
					<dsp:input type="text" bean="ProfileFormHandler.profileValueMap.postalCode" maxlength="15" name="account_postalCode" id="emailSignUpZip" required="required">
						<dsp:tagAttribute name="placeholder" value="Enter your zip/postal code"/>
					</dsp:input>
				</span>
				<dsp:input type="hidden" bean="ProfileFormHandler.signUpEmailSuccessURL" value="/home/actions/sign_up_email_action.jsp" />
				<dsp:input type="hidden" bean="ProfileFormHandler.signUpEmailErrorURL" value="/home/actions/sign_up_email_action.jsp" />
				<%-- <dsp:input type="hidden" bean="ProfileFormHandler.signUpEmail" value="true" />  --%>
				<input id="emailSignup" type="button" class="btn-primary modal" value="Sign up" />
				<span id="email-signup-success-message" style="display:none"></span>
				<span id="email-signup-error-message" style="display:none;"></span>
				<input type="hidden" name="elqFormName" value="emailSignUpForm">
				<input type="hidden" name="elqSiteID" value="20103530">
				<input type="hidden" name="elqCustomerGUID" value="">
				<input type="hidden" name="elqCookieWrite" value="0">
				<input id="field3" type="hidden" name="lead_source_original_hidden" value="Website - Account Creation" />
			</fieldset>
		</dsp:form>

		<ul class="share">
			<li>Connect with us on:</li>
			<li><a href="https://www.facebook.com/lazboy" target="_blank" rel="external" title="Connect with us on Facebook" class="svg-icon svg-icon-facebook">Facebook</a></li>
			<li><a href="https://twitter.com/lazboy" target="_blank" rel="external" title="Connect with us on Twitter" class="svg-icon svg-icon-twitter">Twitter</a></li>
			<li><a href="https://www.pinterest.com/lazboy/" target="_blank" rel="external" title="Connect with us on Pinterest" class="svg-icon svg-icon-pinterest">Pinterest</a></li>
			<li><a href="https://www.instagram.com/lazboy/" target="_blank" rel="external" title="Connect with us on Instagram" class="svg-icon svg-icon-instagram"></a></li>
			<%-- JIRA DMI-2016: Remove Houzz Social Icon
			<li><a href="https://www.houzz.com/pro/lazboy/la-z-boy" target="_blank" rel="external" title="Connect with us on Houzz" class="svg-icon svg-icon-houzz"></a></li>
			--%>
			<li><a href="http://www.youtube.com/user/lazboy" target="_blank" rel="external" title="Connect with us on YouTube" class="svg-icon svg-icon-youtube">YouTube</a></li>
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
