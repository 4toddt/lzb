<%--
  - Cartridge: ImageWithTextLinkGroup
  - File Name: ImageWithTextLinkGroup.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up a grouping of images with text links.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />


	<%-- Render Image With Text Link Group --%>
	<div class="image-with-text-link-group">
		<c:if test="${not empty contentItem.heading}">
			<h2>${contentItem.heading}</h2>
		</c:if>

		<c:if test="${not empty contentItem.links}">
			<ul>
				<c:forEach var="links" items="${contentItem.links}">
					<li>
						<dsp:renderContentItem contentItem="${links}"/>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>

</dsp:page>
