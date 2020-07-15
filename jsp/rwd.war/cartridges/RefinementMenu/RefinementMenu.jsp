<%--
  - Cartridge: RefinementMenu
  - File Name: RefinementMenu.jsp
  - Author(s): DMI UX Team
  - Copyright Notice: Copyright 2001, 2012, Oracle and/or its affiliates. All rights reserved.
  	Oracle and Java are registered trademarks of Oracle and/or its
  	affiliates. Other names may be trademarks of their respective owners.
  	UNIX is a registered trademark of The Open Group.
  - Description: This page lays out the elements that make up the Refinement Menu.
  - Required Parameters: contentItem
  - Optional Parameters:
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />

	<c:if test="${not empty(contentItem.refinements)}">
		<%-- Define facetName --%>
		<c:choose>
			<c:when test="${not empty contentItem.name}">
				<c:set var="facetName" value="${contentItem.name}" />
			</c:when>
			<c:otherwise>
	    		<fmt:message var="facetName" key="${contentItem.dimensionName}" />
	  		</c:otherwise>
		</c:choose>

		<%-- Render Content --%>
		<%-- START: Facet Menu Accordion --%>
		<div class="accordion-container">
			<%-- Define Dimension Name Variables --%>
			<c:set var="dimensionNameID" value="${fn:replace(contentItem.dimensionName,'.','_')}" />
    		<c:set var="dimensionNameID" value="${fn:replace(dimensionNameID,' ','_')}" />
			<%-- Render Facet Accordion Title --%>
			<div class="facet-title accordion-title" role="tab" aria-controls="${dimensionNameID}-facet-body" id="${dimensionNameID}-facet-title" tabindex="0">
				<div class="facet-title-label">
					<div class="facet-title-name">${facetName}</div>
					<div class="selected-facets"></div>
				</div>
				<span class="icon icon-arrow-down" aria-hidden="true"></span>
			</div>
			<div class="facet-body accordion-body" aria-labeledby="${dimensionNameID}-facet-title" role="tabpanel" id="${dimensionNameID}-facet-body">
				<div class="accordion-body-content">
					<div class="facet-list" data-dim="${dimensionNameID}">
						<%-- Loop through Each Facet --%>
						<c:forEach var="refinement" items="${contentItem.refinements}">
							<%-- Define Facet Variables --%>
							<c:set var="contentPath" value="${fn:replace(refinement.contentPath ,'//', '/')}" />
							<c:set var="dataId" value="${contentItem.dimensionName}-${fn:replace(refinement.label, ' ', '-')}" />
							<%-- Render Facet Checkbox --%>
							<div class="facet custom-checkbox" data-id="${dataId}" data-nstate="${contextPath}${contentPath}${refinement.navigationState}" data-cat="${fn:replace(contentItem.dimensionName,'.','_')}" >
								<input id="${dataId}" type="checkbox" name="style" value="${contextPath}${contentPath}${refinement.navigationState}"/>
								<label for="${dataId}">${refinement.label} <span class="ref-count">(${refinement.count})</span></label>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<%-- END: Facet Menu --%>
	</c:if>

</dsp:page>
