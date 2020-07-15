<%--
    - File Name: turnToUserInfo.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page outputs some info requested by TurnTo if the user is logged in.
    - Required Parameters:
    - Optional Parameters:
--%>
<dsp:page>
    <%-- Imports --%>

    <%-- Page Variables --%>
	<%-- Any user not transient is considered logged in --%>
	<dsp:getvalueof var="transient" bean="/atg/userprofiling/Profile.transient"/>

	<c:choose>
		<c:when test="${transient}">
			{"user_auth_token" : null}
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="firstName" bean="/atg/userprofiling/Profile.firstName"/>
			<dsp:getvalueof var="lastName" bean="/atg/userprofiling/Profile.lastName"/>
			<dsp:getvalueof var="email" bean="/atg/userprofiling/Profile.email"/>
			{
				"user_auth_token" : "<dsp:valueof bean="/atg/userprofiling/Profile.id"/>",
				"first_name" : "${fn:replace(firstName, "'", "\\'")}",
				"last_name" : "${fn:replace(lastName, "'", "\\'")}",
				"email" : "${fn:replace(email, "'", "\\'")}",
				"email_confirmed" : "true"
			}
		</c:otherwise>
	</c:choose>
</dsp:page>