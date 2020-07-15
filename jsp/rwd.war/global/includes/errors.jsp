<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
	
	<dsp:droplet name="Switch">
	<dsp:param name="value" param="formHandler.formError" />
	<dsp:oparam name="true">
		<dsp:getvalueof var="numOfExceptions" param="formHandler.formExceptions" />
		
		<div class="error-box alert-box error">
			<div class="error-message">
				<span class="icon icon-error"></span>
				<c:choose>
					<c:when test="${fn:length(numOfExceptions) == 1}">
						<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" param="formHandler.formExceptions" />
						<dsp:oparam name="output">
							<p><dsp:valueof param="message" valueishtml="true" /></p>
						</dsp:oparam>
						</dsp:droplet>
					</c:when>
					<c:otherwise>
						<dsp:droplet name="ErrorMessageForEach">
						<dsp:param name="exceptions" param="formHandler.formExceptions" />
						<dsp:oparam name="outputStart">
							<ul>
						</dsp:oparam>
						<dsp:oparam name="output">
							<li><dsp:valueof param="message" valueishtml="true" /></li>
						</dsp:oparam>
						<dsp:oparam name="outputStart">
							</ul>
						</dsp:oparam>
						</dsp:droplet>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
	</dsp:oparam>
	</dsp:droplet>
</dsp:page>