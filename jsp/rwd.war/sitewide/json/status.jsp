<%--
    - File Name: status.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page returns a json data response with current profile status.
    - Required Parameters:
    - Optional Parameters:
--%>
<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/userprofiling/Profile" var="Profile"/>
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="firstName" bean="Profile.firstName" />
	<dsp:getvalueof var="lastName" bean="Profile.lastName" />
	<dsp:getvalueof var="profile" bean="Profile"/>

	<json:object>

		<json:property name="cartCount" escapeXml="false">
			<dsp:valueof bean="ShoppingCart.current.TotalCommerceItemCount" />
		</json:property>

		<dsp:droplet name="Switch">
			<dsp:param bean="Profile.transient" name="value" />
			<dsp:oparam name="true">
				<dsp:getvalueof var="loginStatus" value="2" />
			</dsp:oparam>
			<dsp:oparam name="false">
				<dsp:getvalueof var="loginStatus" value="4" />
			</dsp:oparam>
		</dsp:droplet>

		<json:property name="statusValue" escapeXml="false">
			<c:out value="${loginStatus}" />
		</json:property>

		<json:property name="firstname" escapeXml="false">
			<c:out value="${firstName}" />
		</json:property>

		<json:property name="lastname" escapeXml="false">
			<c:out value="${lastName}" />
		</json:property>

		<json:property name="greeting" escapeXml="false">
			<fmt:message key="profile.greeting">
				<fmt:param>${firstName}</fmt:param>
			</fmt:message>
		</json:property>

	</json:object>

</dsp:page>
