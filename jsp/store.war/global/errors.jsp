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
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" param="formHandler.formExceptions" />
						<dsp:oparam name="outputStart">
		
						</dsp:oparam>
						<dsp:oparam name="output">
		
		
						<p class="message-txt"><dsp:valueof param="message" valueishtml="true" />
							<a href="#" class="hide-message">Hide</a>
							<a href="#" class="close-message">X</a>
						</p>
						</dsp:oparam>
		
					</dsp:droplet>
					
		
				</dsp:oparam>
			</dsp:droplet>
		</c:otherwise>
	</c:choose>
	
</dsp:page>
