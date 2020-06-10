<%--
  - Cartridge: Why-LaZB-Tile
  - File Name: Why-LaZB-Tile.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up a Why LZB section tile for the ProductDetail-Why-LaZB cartridge.
  - Required Parameters:
        - contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}"/>

	<div class="tile-image">
		<img src="${contentItem.imageURL}" alt="${contentItem.imageAlt}"/>
	</div>

	<div class="tile-content">
		<h4>${contentItem.heading}</h4>
		<p>${contentItem.description}<p>
	</div>
</dsp:page>

