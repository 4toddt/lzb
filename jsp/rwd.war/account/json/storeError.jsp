<%@ include file="/sitewide/fragments/content-type-json.jspf" %>
<dsp:page>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	
 	<dsp:param name="formHandler" bean="LZBStoreLocatorFormHandler" />
  	<json:object>
    	<%@ include file="/account/includes/errors/jsonErrors.jspf" %>
  	</json:object>
</dsp:page>
