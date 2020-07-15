<%--
  - Cartridge: SEOContentMain
  - File Name: SEOContentMain.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This cartridge is used to add SEO rich text content to the section: mainContent.
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
	<!-- RichTextMain :  ${contentItem.name } : ${hideCDPSEOContent} -->
	<c:choose>
		<%--
		   Below condition added to display SEO content on the bottom of the browse page if there is no
			filter applied. If there is a filter applied then don't show SEO Content
		 --%>
		<c:when test="${not empty contentItem.name and fn:startsWith(contentItem.name,'CDP_SEO_CONTENT')}">
			<c:if test="${empty hideCDPSEOContent}" >
				<div class="seo-content">
			 		<c:if test="${not empty contentItem.content}">
						${contentItem.content}
					</c:if>
				</div>
		 	</c:if>
		</c:when>
		<c:otherwise>
				<div class="seo-content">
					<c:if test="${not empty contentItem.content}">
						${contentItem.content}
					</c:if>
				</div>
		</c:otherwise>
	</c:choose>
</dsp:page>