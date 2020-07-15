<%--
    - File Name: turnToLoginStatus.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page outputs a json string representing the user's logged-in status.  Any user !tranient is considered logged in.
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
			{"loginStatus" : false}
		</c:when>
		<c:otherwise>
			<dsp:getvalueof var="profileId" bean="/atg/userprofiling/Profile.id"/>
			{"loginStatus" : true, "profileId" : "${profileId}"}
		</c:otherwise>
	</c:choose>
</dsp:page>