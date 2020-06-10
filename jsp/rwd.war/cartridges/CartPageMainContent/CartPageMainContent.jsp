<%--
  - Cartridge: FourColumnsContainer
  - File Name: FourColumnsContainer.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out a maximum of 4 columns section at the bottom of a page.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<dsp:importbean bean="/com/lzb/endeca/EndecaContentAssemblerDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty contentItem}">
		<c:choose>
			<c:when test="${isMobile}">
				<c:set var="customUrl1" value="${contentItem.customUrl1Mobile}" />
				<c:set var="customUrl2" value="${contentItem.customUrl2Mobile}" />
				<c:set var="customUrl3" value="${contentItem.customUrl3Mobile}" />
			</c:when>
			<c:otherwise>
				<c:set var="customUrl1" value="${contentItem.customUrl1Desktop}" />
				<c:set var="customUrl2" value="${contentItem.customUrl2Desktop}" />
				<c:set var="customUrl3" value="${contentItem.customUrl3Desktop}" />
			</c:otherwise>
		</c:choose>
		
		<p class="empty-cart-description">${contentItem.heading}</p>
		
		<c:if test="${not empty contentItem.maxNumColumns}">
			<div class="top-content">
				<div class="content-grid-row">
					<c:if test="${not empty contentItem.textDesc1 || not empty contentItem.buttonText1}">
						<div class="content-grid-container col${contentItem.maxNumColumns}">
							<p class="grid-title">${contentItem.textDesc1}</p>
							
							<c:choose>
								<c:when test="${not empty contentItem.linkOption1 && contentItem.linkOption1 == 'signin'}">
									<a href="${contextPath}/account/ajax/loginModal.jsp?pageType=cart" class="modal-trigger button tertiary" data-target="login-modal" data-size="small" aria-label="${contentItem.buttonText1}" tabindex="0">${contentItem.buttonText1}</a>
								</c:when>
								<c:when test="${not empty contentItem.linkOption1 && contentItem.linkOption1 == 'signup'}">
									<a href="${contextPath}/account/ajax/createRegisterModal.jsp" class="modal-trigger button tertiary" data-target="create-account-modal" data-size="small" aria-label="${contentItem.buttonText1}" tabindex="0">${contentItem.buttonText1}</a>
								</c:when>
								<c:otherwise>
									<a href="${customUrl1}" class="button tertiary">${contentItem.buttonText1}</a>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
					<c:if test="${not empty contentItem.textDesc2 || not empty contentItem.buttonText2}">
						<div class="content-grid-container col${contentItem.maxNumColumns}">
							<p class="grid-title">${contentItem.textDesc2}</p>
							
							<c:choose>
								<c:when test="${not empty contentItem.linkOption2 && contentItem.linkOption2 == 'signin'}">
									<a href="${contextPath}/account/ajax/loginModal.jsp?pageType=cart" class="modal-trigger button tertiary" data-target="login-modal" data-size="small" aria-label="${contentItem.buttonText2}" tabindex="0">${contentItem.buttonText2}</a>
								</c:when>
								<c:when test="${not empty contentItem.linkOption2 && contentItem.linkOption2 == 'signup'}">
									<a href="${contextPath}/account/ajax/createRegisterModal.jsp" class="modal-trigger button tertiary" data-target="create-account-modal" data-size="small" aria-label="${contentItem.buttonText2}" tabindex="0">${contentItem.buttonText2}</a>
								</c:when>
								<c:otherwise>
									<a href="${customUrl2}" class="button tertiary">${contentItem.buttonText2}</a>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
					<c:if test="${not empty contentItem.textDesc3 || not empty contentItem.buttonText3}">
						<div class="content-grid-container col${contentItem.maxNumColumns}">
							<p class="grid-title">${contentItem.textDesc3}</p>
							
							<c:choose>
								<c:when test="${not empty contentItem.linkOption3 && contentItem.linkOption3 == 'signin'}">
									<a href="${contextPath}/account/ajax/loginModal.jsp?pageType=cart" class="modal-trigger button tertiary" data-target="login-modal" data-size="small" aria-label="${contentItem.buttonText3}" tabindex="0">${contentItem.buttonText3}</a>
								</c:when>
								<c:when test="${not empty contentItem.linkOption3 && contentItem.linkOption3 == 'signup'}">
									<a href="${contextPath}/account/ajax/createRegisterModal.jsp" class="modal-trigger button tertiary" data-target="create-account-modal" data-size="small" aria-label="${contentItem.buttonText3}" tabindex="0">${contentItem.buttonText3}</a>
								</c:when>
								<c:otherwise>
									<a href="${customUrl3}" class="button tertiary">${contentItem.buttonText3}</a>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
	</c:if>
		
</dsp:page>