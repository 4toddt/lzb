<dsp:page>

<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
<dsp:getvalueof var="countryVal" param="countryCode" />
<c:if test="${empty countryVal}">
	<dsp:getvalueof var="countryVal" value="US" />
</c:if>

<dsp:layerBundle basename="com.lzb.common.WebAppResources" locale="en_US"/>
	<c:forEach items="${countryStateMap}" var="entry">
		<dsp:option value="${entry.key}" selected="${entry.key == countryVal}"><fmt:message key="country.${entry.key}"/></dsp:option>
	</c:forEach>
</dsp:page>