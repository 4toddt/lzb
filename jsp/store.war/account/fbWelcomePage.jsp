<dsp:page>

	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

"Welcome,<dsp:valueof param="fName" /><dsp:valueof param="lName" />"

	<dsp:include page="/account/login.jsp">
		<dsp:param name="fromFb" value="true" />
		<dsp:param name="userID" param="userID" />
	</dsp:include>
	
	<dsp:include page="/account/register.jsp">
		<dsp:param name="fromFb" value="true" />
		<dsp:param name="fName" param="fName" />
		<dsp:param name="lName" param="lName" />
		<dsp:param name="userID" param="userID" />
	</dsp:include>


</dsp:page>