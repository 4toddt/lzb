<dsp:page>

<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler"/>

<dsp:getvalueof var="email" param="email"/>


"Welcome,<dsp:valueof param="fName"/>
<dsp:valueof param="lName"/>"

<dsp:include page="/account/login.jsp">
<dsp:param name="isFb" value="true"/>
</dsp:include>
<dsp:include page="/account/registerForm.jsp">
<dsp:param name="fromFb" value="true"/>
<dsp:param name="fName" param="fName"/>
<dsp:param name="lName" param="lName"/>
<dsp:param name="fbEmail" param="email"/>
</dsp:include>


</dsp:page>