<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>
	<dsp:getvalueof var="signUp" bean="ProfileFormHandler.signUpEmail" vartype="boolean"/>

	<!-- check the condition to handle the error message from footer signupemail  -->
	<c:choose >
		<c:when test="${signUp eq 'true'}">
		</c:when>
		<c:otherwise>
			<dsp:droplet name="Switch">
				<dsp:param name="value" param="formHandler.formError" />
				<dsp:oparam name="true">
					<div class="error-msg noform-msg">
						<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" param="formHandler.formExceptions" />
						<dsp:oparam name="output">
						<dsp:getvalueof var="errorMessage" param="message" />
						<%-- The below if check is added to change the OOB message (Reason - Unable to find the resource) --%>
						<c:if test="${errorMessage eq 'The entered username or password is invalid'}">
							<dsp:param name="message" value="Please enter a valid email address and password"/>
						</c:if>
						<c:if test="${errorMessage eq 'There was an error committing the order.'}">
							 <dsp:param name="message" value="There was an error submitting the order."/>
						</c:if>
						<p class="message-txt" style="margin-left:0;"><dsp:valueof param="message" valueishtml="true" />
						</p>
						</dsp:oparam>
						</dsp:droplet>
					</div>
				</dsp:oparam>
			</dsp:droplet>
		</c:otherwise>
	</c:choose>

</dsp:page>