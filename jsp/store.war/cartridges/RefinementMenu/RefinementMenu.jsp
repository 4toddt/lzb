<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:importbean bean="/atg/commerce/endeca/cache/DimensionValueCacheDroplet" />
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="contextPath" vartype="java.lang.String" value="${storeConfig.hostName}" />
	<fmt:message var="facetSelection" key="facetSelection" />
	<c:if test="${not empty(contentItem.refinements)}">
	<c:set var="numRefinements" value="${fn:length(contentItem.refinements)}" />
	<c:set var="allDescriptions" value="${contentItem.description1}||${contentItem.description2}||${contentItem.description3}||${contentItem.description4}||${contentItem.description5}||${contentItem.description6}" />
	<c:set var="description" value="${fn:split(allDescriptions, '||')}" />
	<c:set var="imgUrls" value="${contentItem.imageUrl1}||${contentItem.imageUrl2}||${contentItem.imageUrl3}||${contentItem.imageUrl4}||${contentItem.imageUrl5}||${contentItem.imageUrl6}" />
	<c:set var="imgUrl" value="${fn:split(imgUrls, '||')}" />
	<c:set var="imgAltTexts" value="${contentItem.imageAltText1}||${contentItem.imageAltText2}||${contentItem.imageAltText3}||${contentItem.imageAltText4}||${contentItem.imageAltText5}||${contentItem.imageAltText6}" />
	<c:set var="imgAltText" value="${fn:split(imgAltTexts, '||')}" />
		<%-- START: HELPER TO MAP PARAM VALUES, 'param' attrubute can be changed to 'bean' --%>
		<dsp:tomap param="contentItem" var="paramVar"/>
							<c:forEach var="entry" items="${paramVar}">
				<c:if test="${contentItem.name eq 'SALE'}">
				<strong><c:out value="${entry.key}"/></strong>:  <c:out value="${entry.value}"/> <br/>
				</c:if>
				</c:forEach>
		<%-- END: HELPER TO MAP PARAM VALUES --%>
	<c:choose>
		<c:when test="${not empty contentItem.name}">
			<c:set var="facetName" value="${contentItem.name}" />
		</c:when>
		<c:otherwise>
    		<fmt:message var="facetName" key="facet.${contentItem.dimensionName}" />
  		</c:otherwise>
	</c:choose>

	<c:choose>
  		<c:when test="${numRefinements lt contentItem.numVisualLinks}">
    		<c:set var="numVisualLinks" value="${numRefinements -1}" />
  		</c:when>
  	<c:otherwise>
    	<c:set var="numVisualLinks" value="${contentItem.numVisualLinks -1}" />
  	</c:otherwise>
	</c:choose>

		<div class="cdp-subtitle toggle-menu" tabindex="0">
			<span title="${facetName}">${facetName }</span><span class="icon-arrow-down"></span>
		</div>
		<div class="dropdown-container">
		<ul class="guided-nav-dropdown facet-list" data-dim="${contentItem.dimensionName}">

			<c:choose>
				<c:when test="${contentItem.useVisualLinks}">
					<div class="mega-nav featured">
						<div class="content">
							<div class="visual-sidebar">
								<ul class="row col-3">
									<c:forEach begin="0" end="${numVisualLinks}" varStatus="loop">
										<!--  Remove double slash from url -->
										<c:set var="cPath" value="${fn:replace(contentItem.refinements[loop.index].contentPath ,'//', '/')}" />
										<c:set var="inputID" value="${contentItem.dimensionName}-${fn:replace(contentItem.refinements[loop.index].label, ' ', '-')}" />
										<li class="visual-link facet" data-cat="${fn:replace(contentItem.dimensionName,'.','_')}" data-nstate="${cPath}${contentItem.refinements[loop.index].navigationState}" data-id="${inputID}">
											<img src="${imgUrl[loop.index]}" alt="${imgAltText[loop.index]}" width="160" height="115" />
											<p class="small">${description[loop.index]}</p>
											<div class="custom-checkbox">
												<input type="checkbox" class="visual-filter-value-checkbox cdp-refinement-checkbox" id="${inputID}" data-searchname="${facetName}" tabindex="0" />
												<label for="${inputID}">
													<span class="refinement-label">${contentItem.refinements[loop.index].label}</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${contentItem.refinements[loop.index].count})</span><span class="offscreen">${contentItem.refinements[loop.index].count} items</span>
												</label>
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
							<div class="content-selections">
								<c:choose>
									<c:when test="${contentItem.dimensionName ne 'sku.colorFamily'}">
										<c:forEach begin="${numVisualLinks +1}" end="${numRefinements -1}" varStatus="loop">
											<c:set var="cPath" value="${fn:replace(contentItem.refinements[loop.index].contentPath ,'//', '/')}" />
											<c:set var="inputID" value="${contentItem.dimensionName}-${fn:replace(contentItem.refinements[loop.index].label, ' ', '-')}" />
											<li class="list-facet-item facet" data-cat="${fn:replace(contentItem.dimensionName,'.','_')}" data-nstate="${cPath}${contentItem.refinements[loop.index].navigationState}" data-id="${inputID}">
												<div class="custom-checkbox">
													<input type="checkbox" class="cdp-refinement-checkbox" id="${inputID}" data-searchname="${facetName }" tabindex="0" />
													<label for="${inputID}">
													<!--  Remove double slash from url -->
													<c:choose>
														<c:when test="${contentItem.dimensionName eq 'product.overall_width'}">
															<c:set var="refLabel" value="${fn:replace(contentItem.refinements[loop.index].label ,'in', 'inches')}" />
															<span class="refinement-label" aria-hidden="true">${refLabel}</span>
															<c:set var="refLabel" value="${fn:replace(refLabel ,'>', '')}" />
															<c:set var="refLabel" value="${fn:replace(refLabel ,'inches', '')}" />
															<span class="offscreen refinement-label">greater than ${refLabel } inches</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${contentItem.refinements[loop.index].count})</span><span class="offscreen">${contentItem.refinements[loop.index].count} items</span>
														</c:when>
														<c:otherwise>
															<!-- logic in use -->
															<span class="refinement-label">
															${contentItem.refinements[loop.index].label}</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${contentItem.refinements[loop.index].count})</span><span class="offscreen">${contentItem.refinements[loop.index].count} items</span>
														</c:otherwise>
													</c:choose>
													</label>
												</div>
											</li>
										</c:forEach>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
				</c:when>

				<c:otherwise>
					<c:forEach var="refinement" items="${contentItem.refinements}" varStatus="theCount">
						<c:set var="cPath" value="${fn:replace(refinement.contentPath ,'//', '/')}" />
						<c:set var="inputID" value="${contentItem.dimensionName}-${fn:replace(refinement.label, ' ', '-')}" />
						<li class="list-facet-item facet" data-cat="${fn:replace(contentItem.dimensionName,'.','_')}" data-nstate="${cPath}${refinement.navigationState}" data-id="${inputID}">
							<div class="custom-checkbox">
								<input type="checkbox" class="cdp-refinement-checkbox" id="${inputID}" data-searchname="${facetName }" tabindex="0" />
								<label for="${inputID}">
									<c:choose>
										<c:when test ="${refinement.contentPath eq '/s'}">
											<c:choose>
												<c:when test ="${originatingRequest.isFacet}">
												  <c:choose>
														<c:when test="${contentItem.dimensionName eq 'product.overall_width'}">
															<c:set var="refLabel" value="${fn:replace(refinement.label ,'in', 'inches')}" />
															<span aria-hidden="true">${refLabel}</span>
															<c:set var="refLabel" value="${fn:replace(refLabel ,'>', '')}" />
															<c:set var="refLabel" value="${fn:replace(refLabel ,'inches', '')}" />
																<span class="offscreen refinement-label">greater than ${refLabel } inches</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
														</c:when>
														<c:otherwise>
															<span class="refinement-label">${refinement.label}</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${contentItem.dimensionName eq 'product.overall_width'}">
															<c:set var="refLabel" value="${fn:replace(refinement.label ,'in', 'inches')}" />
															<span aria-hidden="true">${refLabel }</span>
															<c:set var="refLabel" value="${fn:replace(refLabel ,'>', '')}" />
															<c:set var="refLabel" value="${fn:replace(refLabel ,'inches', '')}" />
															<span class="offscreen refinement-label">greater than ${refLabel } inches</span>&nbsp;<span class="refinement-count">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
														</c:when>
														<c:otherwise>
															<span class="refinement-label">${refinement.label}</span><span class="refinement-count" aria-hidden="true">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
									  </c:when>
									  <c:otherwise>
											<c:choose>
												<%-- greater than facet item --%>
												<c:when test="${contentItem.dimensionName eq 'product.overall_width'}">
													<c:set var="refLabel" value="${fn:replace(refinement.label ,'in', 'inches')}" />
													<span aria-hidden="true" class="refinement-label">${refLabel}</span>
													<c:set var="refLabel" value="${fn:replace(refLabel ,'>', '')}" />
													<c:set var="refLabel" value="${fn:replace(refLabel ,'inches', '')}" />
													<span class="offscreen refinement-text">greater than ${refLabel } inches</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
												</c:when>
												<c:otherwise>
													<!-- normal list facet item -->
													<span class="refinement-label">
													${refinement.label}</span>&nbsp;<span class="refinement-count" aria-hidden="true">(${refinement.count})</span><span class="offscreen">${refinement.count} items</span>
												</c:otherwise>
											</c:choose>
									  </c:otherwise>
									</c:choose>
								</label>
							</div>
						</li>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	</c:if>
</dsp:page>
