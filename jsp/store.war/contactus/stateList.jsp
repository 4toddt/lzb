<dsp:page>
	<dsp:importbean bean="/com/lzb/service/CountryStateMapper" />
	
	<dsp:getvalueof var="selectedCountry" param="selectedCountry" />
	<dsp:getvalueof var="countryStateMap" bean="CountryStateMapper.countryStateView" />
	
	<option value=""></option>
	<c:forEach items="${countryStateMap}" var="entry">
		<c:forEach items="${entry.value}" var="state">
			<c:if test="${entry.key == selectedCountry}">
				<option value="${state}"><fmt:message key="state.${state}"/></option>
			</c:if>
		</c:forEach>
	</c:forEach>
</dsp:page>