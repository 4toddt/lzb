<%--
  - Cartridge: TransactionSuccessfulIntroContent
  - File Name: TransactionSuccessfulIntroContent.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page displays banner image and order instructions on Transaction Successful page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/ShoppingCart" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
	
	
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem}">
		<c:if test="${not empty contentItem.mediaUrl}">
			<img class="header-image" src="${contentItem.mediaUrl}" alt="${contentItem.imageAlt}">
		</c:if>	
		<c:if test="${not empty contentItem.heading}">
			<div class="heading-text">${contentItem.heading}</div>
		</c:if>
			
		<div class="order-info">
			<c:if test="${not empty contentItem.instructions}">
				${contentItem.instructions}
			</c:if>
		</div>
	</c:if>
</dsp:page>