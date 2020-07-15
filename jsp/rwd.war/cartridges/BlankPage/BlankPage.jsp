<%--
  - Cartridge: BlankPage
  - File Name: BlankPage.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up a blank page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<%-- START: LZB Blank Page --%>

	<%-- Render the mainContent section --%>
	<c:if test="${not empty contentItem.headerContent}">
		<c:forEach var="element" items="${contentItem.headerContent}">
			<dsp:renderContentItem contentItem="${element}" />
		</c:forEach>
	</c:if>

	<%-- Render the mainContent section --%>
	<c:if test="${not empty contentItem.mainContent}">
		<c:forEach var="element" items="${contentItem.mainContent}">
			<dsp:renderContentItem contentItem="${element}" />
		 </c:forEach>
	</c:if>

	<%-- Render the mainContent section --%>
	<c:if test="${not empty contentItem.footerContent}">
		<c:forEach var="element" items="${contentItem.footerContent}">
			<dsp:renderContentItem contentItem="${element}" />
		</c:forEach>
	</c:if>

	<%-- END: LZB Blank Page --%>
</dsp:page>