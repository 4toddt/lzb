<%--
	This page outputs a json string representing the user's logged-in status.  Any user !tranient is considered logged in.

	Parameters: none
--%>
<dsp:page>

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