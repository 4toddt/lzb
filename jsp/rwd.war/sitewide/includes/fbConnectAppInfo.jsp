<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="globalFBAppID" value="${storeConfig.fbAppId}"/>

	<form method="post" action="#">
		<input type="hidden" id="globalFBAppID" value="${globalFBAppID}" />
	</form>
</dsp:page>