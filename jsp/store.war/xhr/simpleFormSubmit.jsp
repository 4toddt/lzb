<dsp:page>
	<dsp:getvalueof var="formBean" param="formBean" />
	<dsp:getvalueof var="formSuccessUrl" param="formSuccessUrl" />
	
	<c:catch var="Exc">
		<dsp:droplet name="/com/xhr/AmplifiXhrHandler">
			<dsp:param name="amplifiSessionToken" bean="/com/xhr/AmplifiSessionToken" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="beanName" param="beanName" />
				<dsp:getvalueof var="beanValue" param="beanValue" />
				<c:catch var="format">
					<dsp:setvalue bean="${formBean}${beanName}" value="${beanValue}" />
				</c:catch>
				<c:if test="${not empty format}">
					<dsp:setvalue bean="${formBean}${beanName}" value="${fn:split(beanValue,'')}" />
				</c:if>
				<c:set var="format" value="" />
			</dsp:oparam>
			<dsp:oparam name="sessionInvalid">
				<c:set var="invalidSession" value="true" />
			</dsp:oparam>
		</dsp:droplet>
		
		<c:if test="${!invalidSession}">
			<c:if test="${not empty param.formHandler}">
				<dsp:setvalue bean="${formBean}${param.formHandler}" value="true" />
			</c:if>
			<json:object prettyPrint="true" escapeXml="false">
				<dsp:getvalueof var="formExceptions" bean="${formBean}.formExceptions" vartype="java.lang.Object" />
				<c:choose>
					<c:when test="${not empty formExceptions}">
						<json:property name="success" value="${false}" />
						<json:object name="errors">
							<json:array name="items">
								<dsp:getvalueof var="formExceptions" bean="${formBean}.formExceptions" vartype="java.lang.Object" />
								<c:forEach var="formException" items="${formExceptions}">
									<dsp:param name="formException" value="${formException}" />
									<dsp:getvalueof var="message" param="formException.message" />
									<json:property value="${message}" escapeXml="false" />
								</c:forEach>
							</json:array>
						</json:object>
					</c:when>
					<c:otherwise>
						<json:property name="success" value="${true}" />
					</c:otherwise>
				</c:choose>
				
				<c:if test="${not empty formSuccessUrl}">
					<json:property name="redirect" value="${formSuccessUrl}" />
				</c:if>
				
				<c:catch var="null">
					<%-- response objects --%>
					<dsp:getvalueof var="ab" bean="${formBean}.formResponseMap" />
					<c:forEach var="responseProperties" items="${ab}">
						<json:property name="${responseProperties.key}" value="${responseProperties.value}" />
					</c:forEach>
				</c:catch>
			</json:object>
		</c:if>
	</c:catch>
	<c:if test="${not empty Exc}">
		{"success": false, "errors": {"items": [ "${Exc}" ]}}
	</c:if>
</dsp:page>