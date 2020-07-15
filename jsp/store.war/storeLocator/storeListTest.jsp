<dsp:page>
<dsp:importbean bean="/atg/commerce/locations/LocationRepository"/>

	<dsp:importbean bean="/atg/dynamo/droplet/RQLQueryForEach" />

<dsp:droplet name="RQLQueryForEach">
		<dsp:param name="queryRQL" value="ALL" />
		<dsp:param name="externalLocationId" value="123456" />
		<dsp:param name="repository" value="/atg/commerce/locations/LocationRepository" />
		<dsp:param name="itemDescriptor" value="location" />
		<dsp:param name="elementName" value="locationStore" />
		<dsp:oparam name="output">
<dsp:getvalueof var="storeId" param="locationStore.repositoryId"/>
		<dsp:valueof param="locationStore"/>
		<dsp:valueof param="locationStore.repositoryId"/>
		</dsp:oparam>
	</dsp:droplet>


<dsp:form name="preferredStore" id="test">
<dsp:input type="hidden" bean="/atg/userprofiling/ProfileFormHandler.setPreferredLocationSuccessURL" value="${pageContext.request.contextPath}/account/dashboard.jsp" />
		<dsp:input type="hidden" bean="/atg/userprofiling/ProfileFormHandler.setPreferredLocationErrorURL" value="${pageContext.request.contextPath}/account/register.jsp" />
			<input type="text" name="storeId" value="${storeId}"/>
<dsp:input type="submit" value="Make This My Store" bean="/atg/userprofiling/ProfileFormHandler.setPreferredLocation"/>
</dsp:form>
</dsp:page>