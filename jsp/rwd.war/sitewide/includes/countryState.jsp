<%--
	- File Name: contryState.jsp
	- Author(s): DMI UX Team
	- Copyright Notice:
	- Description: This is the 
	- Parameters:
	-
--%>

<dsp:page>

	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	
	<%-- Page Variables --%>
	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
	<dsp:getvalueof var="countryVal" param="countryCode" />
	<dsp:getvalueof var="selState" param="statePicker" />

	<c:if test="${empty countryVal}">
		<dsp:getvalueof var="countryVal" value="US" />
	</c:if>
	<%-- Need to use this to get country specific states --- ${countryStateMap[countryVal]} --%>

	<dsp:option value=""><fmt:message key="common.selectState"/></dsp:option>
	<c:forEach items="${countryStateMap}" var="entry">
		<c:if test="${entry.key==countryVal}">
			<c:forEach items="${entry.value}" var="state">
				<dsp:option value="${state}" selected="${selState eq state}"><fmt:message key="state.${state}"/></dsp:option>
			</c:forEach>
		</c:if>
	</c:forEach>

</dsp:page>