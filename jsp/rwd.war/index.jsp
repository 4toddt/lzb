<%--
  - File Name: index.jsp
  - Author(s): DMI UX Team
  - Copyright Notice:
  - Description: This is the home page
  --%>

<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/atg/endeca/assembler/droplet/InvokeAssembler" />

	<%-- Page Variables --%>
	<c:set var="isHomePage" value="${true}" scope="request" />

	<dsp:droplet name="InvokeAssembler">
		<dsp:param name="includePath" value="/pages/mHome" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" param="contentItem" />
		</dsp:oparam>
	</dsp:droplet>

	<c:choose>
		<c:when test="${not empty contentItem}">
			<dsp:renderContentItem contentItem="${contentItem}" />
		</c:when>
		<c:otherwise>
			<b>Content Empty</b>
		</c:otherwise>
	</c:choose>
</dsp:page>