<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>

<dsp:page>

	<dsp:getvalueof var="firstName" param="firstName" />
	<dsp:getvalueof var="lastName" param="lastName" />
	<dsp:getvalueof var="regId" param="regId" />
	<h3>
		Your Product detail has been registered. Reference Id : &nbsp;
		<dsp:valueof param="regId" />
		</h3>

	
</dsp:page>