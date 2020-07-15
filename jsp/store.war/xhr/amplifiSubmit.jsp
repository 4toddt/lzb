<dsp:page>
	<dsp:getvalueof var="amplifiBean" param="amplifiBean" />
	<dsp:getvalueof var="amplifiGetData" param="amplifiGetData" />
	<dsp:getvalueof var="amplifiSuccessUrl" param="amplifiSuccessUrl" />
	
	
	<c:catch var="Exc">
		<dsp:droplet name="/com/xhr/AmplifiXhrHandler">
			<dsp:param name="amplifiSessionToken" bean="/com/xhr/AmplifiSessionToken" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="beanName" param="beanName" />
				<dsp:getvalueof var="beanValue" param="beanValue" />
				<c:catch var="format">
					<dsp:setvalue bean="${amplifiBean}${beanName}" value="${beanValue}" />
				</c:catch>
				<c:if test="${not empty format}">
					<dsp:setvalue bean="${amplifiBean}${beanName}" value="${fn:split(beanValue,'')}" />
				</c:if>
				<c:set var="format" value="" />
			</dsp:oparam>
			<dsp:oparam name="sessionInvalid">
				<c:set var="invalidSession" value="true" />
			</dsp:oparam>
		</dsp:droplet>
		
		<c:if test="${!invalidSession}">
		
			<c:if test="${not empty param.amplifiHandler}">
				<dsp:setvalue bean="${amplifiBean}${param.amplifiHandler}" value="true" />
			</c:if>
			
			<c:choose>
				<c:when test="${not empty param.amplifiGetHtml}">
					<c:catch var="notFound">
						<dsp:include page="${amplifiGetHtml}" />
					</c:catch>
				</c:when>
				<c:otherwise>
					{"amplifiResponse" :
						<json:object prettyPrint="true" escapeXml="false">
							<dsp:getvalueof var="formExceptions" bean="${amplifiBean}.formExceptions" vartype="java.lang.Object" />
							<c:choose>
								<c:when test="${not empty formExceptions}">
									<json:property name="success" value="${false}" />
									<json:object name="errors">
										<json:array name="items">
											<dsp:getvalueof var="formExceptions" bean="${amplifiBean}.formExceptions" vartype="java.lang.Object" />
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
							
							<c:if test="${not empty amplifiSuccessUrl}">
								<json:property name="redirect" value="${amplifiSuccessUrl}" />
							</c:if>
							
							<c:catch var="null">
								<%-- put redirect here if from the backend --%>
								<dsp:getvalueof var="ab" bean="${amplifiBean}.amplifiResponseMap" />
								<c:forEach var="responseProperties" items="${ab}">
									<json:property name="${responseProperties.key}" value="${responseProperties.value}" />
								</c:forEach>
							</c:catch>
						</json:object>
						
						<c:if test="${not empty amplifiGetData}">
							<c:catch var="notFound">
								,
								"amplifiGetData" :
								<dsp:include page="${amplifiGetData}" />
							</c:catch>
							<c:if test="${not empty notFound}">
								""
							</c:if>
						</c:if>
						<c:catch var="nullException">
							<dsp:getvalueof var="abJson" bean="${amplifiBean}.handlerJsonResponse" />
							,
							"amplifiHandlerResponse" : ${abJson}
						</c:catch>
					}
				</c:otherwise>
			</c:choose>
		</c:if>
	</c:catch>
	<c:if test="${not empty Exc}">
		{"amplifiResponse" : { "success": false, "errors": {"items": [ "${Exc}" ]}}}
	</c:if>
</dsp:page>