<dsp:page>
	<dsp:importbean bean="/com/lzb/commerce/storeLocator/handler/LZBStoreLocatorFormHandler" />
	
	<dsp:form id="storeLocator" formid="storeLocator" name="storeLocator" action="#" method="post" data-validate>
		<div class="field-group store-content">
			<h2><fmt:message key="store.find"/></h2>
			<fmt:message var="zipCode" key="store.label"/>
			<label for="locator"><fmt:message key="store.label"/><span class="sr-only"><fmt:message key="store.label"/></span></label>
			<dsp:input type="text" name="locator" id="locator" bean="LZBStoreLocatorFormHandler.valueMap.state" maxlength="25" data-validation="required alphanumericspacecomma" aria-required="true" autocapitalize="off" placeholder="${zipCode}"/>
			<dsp:input type="hidden" name="locatorSucccess"  bean="LZBStoreLocatorFormHandler.locateSuccessURL" value="${contextPath}/storeLocator/json/storeLocatorSuccess.jsp" />
			<dsp:input type="hidden" name="locatorError"  bean="LZBStoreLocatorFormHandler.locateErrorURL" value="${contextPath}/storeLocator/json/storeLocatorError.jsp"/>
			<dsp:input type="hidden" name="La-Z-Boy Home Furnishings & D&‌eacute;cor" bean="LZBStoreLocatorFormHandler.valueMap.homeFurnishings" value="false" />
			<dsp:input type="hidden" name="La-Z-Boy Furniture Galleries" bean="LZBStoreLocatorFormHandler.valueMap.furnitureGalleries" value="false" />
			<dsp:input type="hidden" name="La-Z-Boy Comfort Studio"  bean="LZBStoreLocatorFormHandler.valueMap.comfortStudio" value="false" />
			<dsp:input type="hidden" name="Other La-Z-Boy Retailers"  bean="LZBStoreLocatorFormHandler.valueMap.retailers" value="false" />
			<input type="hidden" name="currentLocationZip" value="">
			<input type="hidden" name="currentLocationLat" value="">
			<input type="hidden" name="currentLocationLng" value="">
			<dsp:input type="submit" value="Search" name="findStore" id="findStore" iclass="button primary" bean="LZBStoreLocatorFormHandler.locate" />
		</div>
		<div class="field-group actions">
			<a href="#" class="locator"><span class="icon icon-locator"></span><fmt:message key="store.current"/></a>
			<div id="geolocation_msg"></div>
		</div>
	</dsp:form>
</dsp:page>