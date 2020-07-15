<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="transient" bean="Profile.transient" />

	<c:choose>
		<c:when test="${transient eq 'false'}">
			<%-- logged in: redirect to checkout page --%>
			<dsp:getvalueof var="checkoutUrl" value="/rwd/checkout/checkout.jsp" />
		</c:when>
		<c:otherwise>
			<%-- not logged in: redirect to checkout page --%>
			<dsp:getvalueof var="checkoutUrl" value="/rwd/checkout/login.jsp" />
		</c:otherwise>
	</c:choose>

	<json:object>
		<json:property name="success">true</json:property>
		<json:property name="redirectURL">${checkoutUrl}</json:property>
	</json:object>

</dsp:page>
