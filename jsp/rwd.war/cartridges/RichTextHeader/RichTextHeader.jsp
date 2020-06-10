<%--
  - Cartridge: RichTextHeader
  - File Name: RichTextHeader.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This cartridge is used to add rich text to the section: headerContent.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />

	<%-- Page Variables --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<%-- Render Cartridge --%>
	<c:if test="${not empty contentItem.content}">
		${contentItem.content}
	</c:if>
</dsp:page>