<%--
Creates the json for digitalData.user. Populate the following page variables for this:
	id - user profile id
	loginStatus - logged in or logged out
	userType -  member or guest
--%>
<json:object>
	<json:property name="id" value="${profileID}"/>
	<json:property name="loginStatus" value="${loginStatus}"/>
	<json:property name="userType" value="${userType}"/>
</json:object>
