<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%><%-- JSON Rendering Taglib --%>
    <dsp:getvalueof var="firstName" param="firstName" />
	<dsp:getvalueof var="lastName" param="lastName" />

<dsp:page>
	<h3>
		Hi <dsp:valueof param="firstName" /> !!! <br />
		A New Address has been added in your address book.
	</h3>
</dsp:page>