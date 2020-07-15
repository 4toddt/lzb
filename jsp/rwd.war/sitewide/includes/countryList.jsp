<%--
	- File Name: contryList.jsp
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
	
	<c:if test="${empty countryVal}">
		<dsp:getvalueof var="countryVal" value="US" />
	</c:if>

	<c:forEach items="${countryStateMap}" var="entry">
		<dsp:option value="${entry.key}" selected="${entry.key == countryVal}"><fmt:message key="country.${entry.key}"/></dsp:option>
	</c:forEach>
	
</dsp:page>