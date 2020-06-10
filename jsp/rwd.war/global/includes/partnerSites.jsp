<dsp:page>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="englandURL"value="${storeConfig.englandURL}"/>
	<dsp:getvalueof var="americanDrewURL"value="${storeConfig.americanDrewURL}"/>
	<dsp:getvalueof var="hammaryURL"value="${storeConfig.hammaryURL}"/>
	<dsp:getvalueof var="kincaidFurnitureURL"value="${storeConfig.kincaidFurnitureURL}"/>
	<dsp:getvalueof var="lzbSpasURL"value="${storeConfig.lzbSpasURL}"/>
	<dsp:getvalueof var="lzbOutdoorURL"value="${storeConfig.lzbOutdoorURL}"/>
	<dsp:getvalueof var="lzbHospitalityURL"value="${storeConfig.lzbHospitalityURL}"/>
	
	<li class="partners">
		<p class="title"><fmt:message key="partnerSites.partnerSiteText"/></p>
		<ul>
			<li><a href="${englandURL}" target="_blank"><fmt:message key="partnerSites.englandUpholstery"/></a></li>
			<li><a href="${americanDrewURL}" target="_blank"><fmt:message key="partnerSites.americanCaseGoods"/></a></li>
			<li><a href="${hammaryURL}" target="_blank"><fmt:message key="partnerSites.hammaryCaseGoods"/></a></li>
			<li><a href="${kincaidFurnitureURL}" target="_blank"><fmt:message key="partnerSites.kincaidSolidWood"/></a></li>
			<%-- Removed as per Gail's email
			<li><a href="${lzbHospitalityURL}" target="_blank"><fmt:message key="partnerSites.lazBoyHospitality"/></a></li>--%>
			<li><a href="${lzbSpasURL}" target="_blank"><fmt:message key="partnerSites.lazBoySpas"/></a></li>
			<li><a href="${lzbOutdoorURL}" target="_blank"><fmt:message key="partnerSites.lazBoyOutdoor"/></a></li>
		</ul>
	</li>
</dsp:page>