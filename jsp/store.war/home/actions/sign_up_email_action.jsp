<%@ page contentType="application/json" %>
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
	
	<dsp:setvalue bean="ProfileFormHandler.signUpEmail" value=""/>
		
	<dsp:getvalueof var="successMessage" bean="ProfileFormHandler.successMessage"/>
	<dsp:getvalueof var="errorMessage" bean="ProfileFormHandler.errorMessage"/>
	
	<json:object prettyPrint="true" escapeXml="false">
		<dsp:droplet name="Switch">
			<dsp:param name="value" bean="ProfileFormHandler.formError" />
			<dsp:oparam name="true">
				<json:property name="success" value="${false}" />
				<json:array name="errors">
					<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" bean="ProfileFormHandler.formExceptions"/>
						<dsp:oparam name="output">
							<json:object>
								<json:property name="successMessage">
									<dsp:valueof param="message" valueishtml="true"/>
								</json:property>
							</json:object>
						</dsp:oparam>
					</dsp:droplet>
				</json:array>
			</dsp:oparam>
			<dsp:oparam name="false">
				<json:property name="success" value="${true}" />
				<json:property name="successMessage">
					<dsp:valueof bean="ProfileFormHandler.successMessage" valueishtml="true"/>
				</json:property>
			</dsp:oparam>
		</dsp:droplet>
	</json:object>
</dsp:page>