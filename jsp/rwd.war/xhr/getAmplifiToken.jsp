<dsp:page>
	<dsp:getvalueof var="class" param="class" />
	<dsp:getvalueof var="ampToken" bean="/com/xhr/AmplifiSessionToken.amplifiToken" />
	<input type="hidden" name="ampFormToken" value="${ampToken}" class="${class}" />
</dsp:page>