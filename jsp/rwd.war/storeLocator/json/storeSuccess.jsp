<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>

	<dsp:getvalueof param="type" var="type" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<c:choose>
		<c:when test="${not empty type}">
			<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
				<dsp:param name="inUrl" value="${contextPath}/account/preferredStore.jsp"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="redirectUrl" scope="request" param="secureUrl"/>
				</dsp:oparam>
			</dsp:droplet>
		</c:when>
		<c:otherwise>
			<dsp:droplet name="/atg/dynamo/droplet/ProtocolChange">
				<dsp:param name="inUrl" value="${contextPath}/storeLocator/storeLocator.jsp"/>
				<dsp:oparam name="output">
					<dsp:getvalueof var="redirectUrl" scope="request" param="secureUrl"/>
				</dsp:oparam>
			</dsp:droplet>
		</c:otherwise>
	</c:choose>

	<json:object>
		<json:property name="success">true</json:property>
		<json:property name="url">${redirectUrl}</json:property>
	</json:object>

</dsp:page>
