<%--
  - File Name: language.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This page lays out the language menu in the Utility Navigation.
  - Required Parameters:
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration"/>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="siteHostName" param="siteHostName"/>
	<dsp:getvalueof var="languageSiteMap" bean="LZBStoreConfiguration.homePage"/>

	<%-- Render Language Menu --%>
	<li data-subarea="Language" data-lang="en" class="OneLinkKeepLinks"><a href="${siteHostName}" tabindex="0">English</a></li>

	<c:forEach items="${languageSiteMap}" var="entry">
		<c:choose>
			<c:when test="${fn:contains(entry.key, 'InFrench')}">
				<li data-subarea="Language" data-lang="fr" class="OneLinkKeepLinks">
			</c:when>
			<c:when test="${fn:contains(entry.key, 'InSpanish')}">
				<li data-subarea="Language" data-lang="es" class="OneLinkKeepLinks">
			</c:when>
			<c:when test="${fn:contains(entry.key, 'InEnglish')}">
				<li data-subarea="Language" data-lang="en" class="OneLinkKeepLinks">
			</c:when>
			<c:otherwise>
				<li data-subarea="Language" data-lang="en" class="OneLinkKeepLinks">
			</c:otherwise>
		</c:choose>
					<a title="${entry.key}" href="${entry.value }" tabindex="0"><fmt:message key="header.${ entry.key }" /></a>
				</li>
	</c:forEach>

</dsp:page>
