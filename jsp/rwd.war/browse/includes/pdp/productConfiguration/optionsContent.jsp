<%--
    - File Name: optionsContent.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the product configuration accordion options & upgrades content on the product page.
    - Required Parameters:
        - skuId: product sku id,
        - defaultCoverSkuId: default seclected cover sku,
        - defaultSelectOptionSkuIds,
        - pdpType
    - Optional Parameters:
        - optionAndUpgradesJson
--%>
<dsp:page>
    <%-- Imports --%>
    <dsp:importbean bean="/com/lzb/droplet/LZBOptionsAndUpgradesDroplet" />
    <dsp:importbean bean="/com/lzb/droplet/LZBPillowCoverDataLoaderDroplet"/>
    <dsp:importbean bean="/atg/dynamo/droplet/ForEach" />

    <%-- Page Variables --%>
    <dsp:getvalueof var="skuId" param="skuId" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
    <dsp:getvalueof var="defaultSelectOptionSkuIds" param="defaultSelectOptionSkuIds" />
    <dsp:getvalueof var="pdpType" param="pdpType" />
    <dsp:getvalueof var="optionAndUpgradesJson" param="optionAndUpgradesJson" />
    <dsp:getvalueof var="isPillowOptions" param="isPillowOptions"/>
    <fmt:message var="pillowSet2AccordionTitle" key="productConfiguration.options.pillowSet2AccordionTitle"/>

    <%-- Render Product Options & Upgrades Configuration Content--%>
    <dsp:droplet name="LZBOptionsAndUpgradesDroplet">
		<dsp:param name="subSkuId" value="${skuId}"  />
		<dsp:param name="optionAndUpgradesJson" value="${optionAndUpgradesJson}"/>
		<dsp:oparam name="output">
			<dsp:getvalueof param="listOfSelectOptionIds" var="listOfSelectOptionIds"/>			
            
            <%-- START: Content Loop Rendering --%>
            <dsp:droplet name="ForEach">
				<dsp:param name="array" param="sectionalOptionsConfigProperties" />
				<dsp:param name="elementName" value="parentOption" />
				<dsp:oparam name="outputStart">
                    <div class="accordion" data-accordion aria-multiselectable="true" role="tablist">
                </dsp:oparam>
                <dsp:oparam name="output">
					<dsp:getvalueof var="parentOptionName" param="parentOption.optionName"/>
					<dsp:getvalueof var="isSelectExceptionOption" param="parentOption.selectExceptionOption"/>

                    <c:choose>
						<c:when test="${isSelectExceptionOption}">
                            <h3>${parentOptionName}</h3>
						</c:when>
						<c:otherwise>
                            <c:set var="p1PillowEdgeTrtmt" value=""/>
							<c:set var="p2PillowEdgeTrtmt" value=""/>
							<c:set var="pillowSet" value="no" />
							<c:set var="foundOption" value="${false}"/>
							<c:set var="addPillowSet1" value="no"/>
							<c:set var="addPillowSet2" value="no"/>
                            <c:set var="parentOptionNameID" value="${fn:replace(parentOptionName,' ','-')}" />

                            <%-- Render Pillow Options Accordion only if the flag is enabled in BCC --%>
                            <c:if test="${parentOptionName eq 'Pillow Options' and isPillowOptions}">
                                <div class="accordion-container" id="accordion-${parentOptionNameID}">
                                    <div class="accordion-title" role="tab" aria-controls="${parentOptionNameID}" id="${parentOptionNameID}-title" tabindex="0">
                                        <%-- Include Product Configuration Title --%>
                                        <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                            <dsp:param name="title" value="${parentOptionName}" />
                                        </dsp:include>
                                    </div>
                                    <div class="accordion-body" aria-labeledby="${parentOptionNameID}-title" role="tabpanel" id="${parentOptionNameID}">
                                        <div class="accordion-body-content">
                                            <div class="option-container">
                                                <dsp:droplet name="ForEach">
                                                    <dsp:param name="array" param="parentOption.optionGroups" />
        											<dsp:param name="elementName" value="subOption" />
        											<dsp:param name="index" param="count" />
        											<dsp:oparam name="outputStart">
                                                        <c:if test="${parentOptionName eq 'Pillow Options'}">
                                                            <p><fmt:message key="productConfiguration.options.pillowIntroDescription"/></p>
                                                        </c:if>
        											</dsp:oparam>
                                                    <dsp:oparam name="output">
                                                        <c:set var="addPillowSet1" value="no"/>
        												<c:set var="addPillowSet2" value="no"/>
        												<c:set var="p1EdgeTreatmentItem" value=""/>
        												<c:set var="p2EdgeTreatmentItem" value=""/>
        												<dsp:getvalueof param="subOption.optionGroupName" var="subOptionName" />

        												<c:if test="${parentOptionName eq 'Pillow Options'}">
        													<dsp:getvalueof param="subOption.defaultPillows" var="defaultPillows"/>
        													<dsp:getvalueof param="subOption.additionalPillows" var="additionalPillows"/>
        												</c:if>

                                                        <c:if test="${not empty defaultPillows}">
        													<c:if test="${fn:containsIgnoreCase(subOptionName, 'P1')}">
        														<dsp:getvalueof param="subOption.optionGroupName" var="subOptionName" />
        														<dsp:getvalueof param="subOption.defaultPillows" var="defaultPillows"/>
        														<dsp:getvalueof param="subOption.additionalPillows" var="additionalPillows"/>
        														<c:choose>
        															<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
        																<input type="radio" class="option hidden-option" id="defaultPillowsOptions" value="${defaultPillows[0].id}" autocomplete="off" checked />
        															</c:when>
        															<c:otherwise>
        																<c:forEach var="defaultPillow" items="${defaultPillows}">
        																	<input type="radio" class="option hidden-option" id="defaultPillowsOptions" value="${defaultPillow.id}" autocomplete="off" checked />
        																</c:forEach>
        															</c:otherwise>
        														</c:choose>
        													</c:if>
        												</c:if>

                                                        <c:set var="h3ClassName" value="" />

                                                        <c:if test="${parentOptionName eq 'Pillow Options'}">
        													<c:if test="${fn:containsIgnoreCase(subOptionName, 'P1')}">
        														<dsp:getvalueof var="p1EdgeTreatmentItem" param="subOption"/>
        														<c:set var="p1PillowEdgeTrtmt" value="${p1EdgeTreatmentItem}"/>
        													</c:if>
        													<c:if test="${fn:containsIgnoreCase(subOptionName, 'P2')}">
        														<dsp:getvalueof var="p2EdgeTreatmentItem" param="subOption"/>
        														<c:set var="p2PillowEdgeTrtmt" value="${p2EdgeTreatmentItem}"/>
        													</c:if>

        													<dsp:droplet name="LZBPillowCoverDataLoaderDroplet">
        														<dsp:param name="coverID" value="${defaultCoverSkuId}" />
        														<dsp:oparam name="output">
        															<dsp:getvalueof var="optionCoverItems" param="pillowCovers"/>
        															<dsp:getvalueof var="isProductCoverAvailabe" param="isProductCoverAvailabe"/>
        														</dsp:oparam>
        													</dsp:droplet>

        													<c:if test="${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1')}">
        														<c:set var="foundOption" value="${true}"/>
        														<%-- <!-- if parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1') == ${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1')} --> --%>
        														<c:set var="addPillowSet1" value="yes"/>
        														<c:set var="pillowSet" value="yes" />
        														<c:set var="h3ClassName" value="h3-pillowset-1" />
        														<c:if test="${not empty additionalPillows}">
        															<c:choose>
        																<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
        																	<input type="radio" class="option hidden-option" data-rel="p1" value="${additionalPillows[0].id}" data-pillowset="set1" data-pillowType="P1" autocomplete="off" checked />
        																</c:when>
        																<c:otherwise>
        																	<c:forEach var="additionalPillow" items="${additionalPillows}">
        																		<input type="radio" class="option hidden-option" data-rel="p1" value="${additionalPillow.id}" data-pillowset="set1" data-pillowType="P1" autocomplete="off" checked />
        																	</c:forEach>
        																</c:otherwise>
        															</c:choose>
        															<div class="h3-pillowset-1-colorswatch pillow-set-color-swatch-group">
                                                                        <form action="" id="pillowQuantityForm_${additionalPillows[0].id}" name="pillowQuantityForm_${additionalPillows[0].id}" autocomplete="off">
                                                                            <label for="pillowQuantitySelect_${additionalPillows[0].id}"><fmt:message key="productConfiguration.options.pillowQtyLabel"/></label>
            																<div class="custom-select pillow-qty">
                                                                                <select class="pillow-quantity-select" id="pillowQuantitySelect_${additionalPillows[0].id}" data-rel="${p1PillowEdgeTrtmt.optionGroupName}">
                																	<option name=""><fmt:message key="productConfiguration.options.pillowQtySelectDefault"/></option>
                																	<option name="1">1</option>
                																	<option name="2">2</option>
                																	<option name="3">3</option>
                																	<option name="4">4</option>
                																	<option name="5">5</option>
                																	<option name="6">6</option>
                																	<option name="7">7</option>
                																	<option name="8">8</option>
                																	<option name="9">9</option>
                																	<option name="10">10</option>
                																</select>
                                                                                <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                                                                            </div>
                                                                        </form>
        																<hr />

                                                                        <div class="custom-checkbox" style="display:none">
                                                                          <input id="same-as-coverfabric-set1" class="option-checkbox same-as-coverfabric option-checkbox-P1" name="same-as-coverfabric" data-h3="h3-pillowset-1" type="checkbox" value="true" autocomplete="off" checked />
                                                                          <label for="same-as-coverfabric-set1"><fmt:message key="productConfiguration.options.sameFabricCheckboxLabel"/></label>
                                                                        </div>

        																<section class="pillow-fabric-selection pillow-fabric-selection-P1" style="display:none">
                                                                            <%-- Include Pillow Cover Swatches Set 1 --%>
        																	<dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentCoverSwatches.jsp">
        																		<dsp:param name="optionCoverItems" value="${optionCoverItems}" />
        																		<dsp:param name="swatchSet" value="set1" />
                                                                                <dsp:param name="optionName" value="${parentOptionName}" />
        																		<dsp:param name="isProductCoverAvailabe" value="${isProductCoverAvailabe}" />
                                                                                <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
        																	</dsp:include>
        																</section>
        															</div>
        															<c:if test="${not empty p1PillowEdgeTrtmt}">
                                                                        <h5 class="option-group-name" class="${h3ClassName}" data-optionitem="${p1PillowEdgeTrtmt.optionGroupName}">
                                                                            ${p1PillowEdgeTrtmt.optionGroupName}
                                                                        </h5>
        																<dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentRenderLoop.jsp">
        																	<dsp:param name="configOptions" value="${p1PillowEdgeTrtmt.configOptions}" />
        																	<dsp:param name="optionName" value="${p1PillowEdgeTrtmt.optionGroupName}" />
        																	<dsp:param name="subOptionGroupName" value="${p1PillowEdgeTrtmt.optionGroupName}" />
        																	<dsp:param name="pdpType" value="${pdpType}" />
        																	<dsp:param name="h3ClassName" value="${h3ClassName}" />
        																	<dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
        																</dsp:include>
        															</c:if>
        														</c:if>
        													</c:if>
        													<c:if test="${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 2')}">
        														<c:set var="foundOption" value="${true}"/>
        														<c:set var="addPillowSet2" value="yes"/>
        														<c:set var="pillowSet" value="yes" />
        														<c:set var="h3ClassName" value="h3-pillowset-2" />

                                                                <%-- START: Pillow Option Set 2 Accordion Content--%>
                                                                <div class="accordion" data-accordion aria-multiselectable="true">
                                                                    <div class="accordion-container" id="accordion-pillow-set-2">
                                                                		<div class="accordion-title" role="tab" aria-controls="pillow-set-2" aria-expanded="false" id="pillow-set-2-title" tabindex="0">
                                                                            <%-- Include Product Configuration Title --%>
                                                                            <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                                                                <dsp:param name="title" value="${pillowSet2AccordionTitle}" />
                                                                            </dsp:include>
                                                                        </div>
                                                                		<div class="accordion-body" aria-labeledby="pillow-set-2-title" role="tabpanel" id="pillow-set-2">
                                                                			<div class="accordion-body-content">
                                                                                <div class="option-container">
                                                                                    <h4><strong><fmt:message key="productConfiguration.options.headingPillowFabric"/></strong></h4>
                    																<c:if test="${not empty additionalPillows}">
                    																	<c:choose>
                    																		<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
                    																			<input type="radio" class="option hidden-option" data-rel="p2" value="${additionalPillows[0].id}" data-pillowset="set2" data-pillowType="P2" autocomplete="off" checked />
                    																		</c:when>
                    																		<c:otherwise>
                    																			<c:forEach var="additionalPillow" items="${additionalPillows}">
                    																				<input type="radio" class="option hidden-option" data-rel="p2" value="${additionalPillow.id}" data-pillowset="set2" data-pillowType="P2" autocomplete="off" checked />
                    																			</c:forEach>
                    																		</c:otherwise>
                    																	</c:choose>
                    																</c:if>
                    																<div class="h3-pillowset-2-colorswatch pillow-set-color-swatch-group">
                                                                                        <form action="" id="pillowQuantityForm_${additionalPillows[0].id}" name="pillowQuantityForm_${additionalPillows[0].id}" autocomplete="off">
                                                                                            <div class="custom-select pillow-qty">
                            																	<select class="pillow-quantity-select" id="pillowQuantitySelect_${additionalPillows[0].id}" data-rel="${p2PillowEdgeTrtmt.optionGroupName}">
                            																		<option name=""><fmt:message key="productConfiguration.options.pillowQtySelectDefault"/></option>
                            																		<option name="1">1</option>
                            																		<option name="2">2</option>
                            																		<option name="3">3</option>
                            																		<option name="4">4</option>
                            																		<option name="5">5</option>
                            																		<option name="6">6</option>
                            																		<option name="7">7</option>
                            																		<option name="8">8</option>
                            																		<option name="9">9</option>
                            																		<option name="10">10</option>
                            																	</select>
                                                                                                <span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
                                                                                            </div>
                                                                                        </form>
                    																	<hr />

                                                                                        <div class="custom-checkbox" style="display:none">
                                                                                          <input id="same-as-coverfabric-set2" class="option-checkbox same-as-coverfabric option-checkbox-P2" name="same-as-coverfabric" data-h3="h3-pillowset-2" type="checkbox" value="true" autocomplete="off" checked />
                                                                                          <label for="same-as-coverfabric-set2"><fmt:message key="productConfiguration.options.sameFabricCheckboxLabel"/></label>
                                                                                        </div>

                    																	<c:if test="${isProductCoverAvailabe eq true}">
                    																		<section class="pillow-fabric-selection pillow-fabric-selection-P2" style="display:none">
                                                                                                <%-- Include Pillow Cover Swatches Set 2 --%>
                    																			<dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentCoverSwatches.jsp">
                    																				<dsp:param name="optionCoverItems" value="${optionCoverItems}" />
                    																				<dsp:param name="swatchSet" value="set2" />
                    																				<dsp:param name="optionName" value="${parentOptionName}" />
                    																				<dsp:param name="isProductCoverAvailabe" value="${isProductCoverAvailabe}" />
                                                                                                    <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                    																			</dsp:include>
                    																		</section>
                    																	</c:if>
                    																</div>
                    																<c:if test="${not empty p2PillowEdgeTrtmt}">
                                                                                        <h5 class="option-group-name" class="${h3ClassName}" data-optionitem="${p2PillowEdgeTrtmt.optionGroupName}">
                                                                                            ${p2PillowEdgeTrtmt.optionGroupName}
                                                                                        </h5>
                    																	<dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentRenderLoop.jsp">
                    																		<dsp:param name="configOptions" value="${p2PillowEdgeTrtmt.configOptions}" />
                    																		<dsp:param name="optionName" value="${p2PillowEdgeTrtmt.optionGroupName}" />
                    																		<dsp:param name="subOptionGroupName" value="${p2PillowEdgeTrtmt.optionGroupName}" />
                    																		<dsp:param name="pdpType" value="${pdpType}" />
                    																		<dsp:param name="h3ClassName" value="${h3ClassName}" />
                    																		<dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                    																	</dsp:include>
                    																</c:if>
                                                                			    </div>
                                                                			</div>
                                                                		</div>
                                                                	</div>
                                                                </div>
                                                                <%-- END: Pillow Option Set 2 Accordion Content--%>
        													</c:if>

                                                            <%-- START Display Pillow Comfort --%>
                                                            <c:if test="${addPillowSet1 eq 'no' and addPillowSet2 eq 'no'}">
                                                                <c:if test="${empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem}">
                                                                    <h5 class="${h3ClassName}" data-optionitem="${subOptionName}">
                                                                        ${subOptionName}
                                                                    </h5>
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem}">
                                                                <dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentRenderLoop.jsp">
                                                                    <dsp:param name="configOptions" param="subOption.configOptions" />
                                                                    <dsp:param name="optionName" value="${parentOptionName}" />
                                                                    <dsp:param name="subOptionGroupName" value="${subOptionName}" />
                                                                    <dsp:param name="pdpType" value="${pdpType}" />
                                                                    <dsp:param name="h3ClassName" value="${h3ClassName}" />
                                                                    <dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                                                                </dsp:include>
                                                            </c:if>
                                                            <%-- END Display Pillow Comfort --%>
                                                        </c:if>
                                                    </dsp:oparam>
                                                </dsp:droplet>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <%-- Render Accordions Containing Option Groups Associated with a Parent Level Option --%>
							<c:if test="${foundOption eq false}">
                                <dsp:droplet name="ForEach">
									<dsp:param name="array" param="parentOption.optionGroups" />
									<dsp:param name="elementName" value="subOption" />
									<dsp:param name="index" param="count" />
									<dsp:oparam name="output">
										<dsp:getvalueof var="subOptionName" param="subOption.optionGroupName" />
										<dsp:getvalueof var="configOptions" param="subOption.configOptions" />

										<%--
											This determines the length of configOptions by first filtering out
											every option that should NOT be visible.  The entire group should
											be hidden if there's only one visible option.
										--%>
										<c:set var="optionsLength" value="${0}" />
										<c:forEach var="configOption" items="${configOptions}">
											<c:if test="${configOption.showOnline == null || configOption.showOnline == true}">
												<c:set var="optionsLength" value="${optionsLength + 1}" />
											</c:if>
										</c:forEach>

										<c:set var="subOptionNameID" value="${fn:replace(subOptionName,' ','-')}" />

										<c:if test="${(parentOptionName ne 'Pillow Options') and (addPillowSet1 eq 'no' and addPillowSet2 eq 'no') and (empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem)}">
											<c:set var="foundOption" value="${true}"/>
											<c:if test="${optionsLength > 1}">
                                            <div class="accordion-container" id="accordion-${subOptionNameID}">
                                                <div class="accordion-title" role="tab" aria-controls="${subOptionNameID}" id="${subOptionNameID}-title" tabindex="0">
                                                    <%-- Include Product Configuration Title --%>
                                                    <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                                        <dsp:param name="title" value="${subOptionName}" />
                                                    </dsp:include>
                                                </div>
                                                <div class="accordion-body" aria-labeledby="${subOptionNameID}-title" role="tabpanel" id="${subOptionNameID}">
                                                    <div class="accordion-body-content">
                                                        <%-- Content include --%>
                                                        <dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentRenderLoop.jsp">
    														<dsp:param name="configOptions" param="subOption.configOptions" />
    														<dsp:param name="optionName" value="${parentOptionName}" />
    														<dsp:param name="subOptionGroupName" value="${subOptionName}" />
    														<dsp:param name="pdpType" value="${pdpType}" />
    														<dsp:param name="h3ClassName" value="${h3ClassName}" />
    														<dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
    													</dsp:include>
                                                    </div>
                                                </div>
                                            </div>
                                            </c:if>
										</c:if>
									</dsp:oparam>
								</dsp:droplet>
                            </c:if>
                            <%-- Render Parent Level Option Accordions --%>
                            <c:if test="${foundOption eq false and parentOptionName ne 'Pillow Options'}">
                            	<c:set var="optionsLength" value="${0}" />
								<dsp:getvalueof param="parentOption.configOptions" var="configOptions" />
								<c:forEach var="configOption" items="${configOptions}">
									<c:if test="${configOption.showOnline == null || configOption.showOnline == true}">
										<c:set var="optionsLength" value="${optionsLength + 1}" />
									</c:if>
								</c:forEach>

								<c:if test="${optionsLength > 1}" >
                                <div class="accordion-container" id="accordion-${parentOptionNameID}">
                                    <div class="accordion-title" role="tab" aria-controls="${parentOptionNameID}" id="${parentOptionNameID}-title" tabindex="0">
                                        <%-- Include Product Configuration Title --%>
                                        <dsp:include page="/browse/includes/pdp/productConfiguration/accordionTitleBar.jsp">
                                            <dsp:param name="title" value="${parentOptionName}" />
                                        </dsp:include>
                                    </div>
                                    <div class="accordion-body" aria-labeledby="${parentOptionNameID}-title" role="tabpanel" id="${parentOptionNameID}">
                                        <div class="accordion-body-content">
                                            <%-- Content include --%>
                                            <dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentRenderLoop.jsp">
                                                <dsp:param name="configOptions" param="parentOption.configOptions" />
    											<dsp:param name="optionName" value="${parentOptionName}" />
    											<dsp:param name="subOptionGroupName" value=" " />
    											<dsp:param name="pdpType" value="${pdpType}" />
    											<dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
                                            </dsp:include>
                                        </div>
                                    </div>
                                </div>
                                </c:if>
							</c:if>
						</c:otherwise>
                    </c:choose>
				</dsp:oparam>
                <dsp:oparam name="outputEnd">
                    </div><%-- /.accordion --%>
                </dsp:oparam>
			</dsp:droplet>
            <%-- END: Content Loop Rendering --%>

            <%-- TODO: Find out what this is? --%>
            <c:if test="${not empty defaultSelectOptionSkuIds and fn:length(defaultSelectOptionSkuIds)>0}">
				<c:choose>
					<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
                        <c:set var="selectOptionId" value="${fn:substring(defaultSelectOptionSkuIds, 1, fn:length(defaultSelectOptionSkuIds)-1)}"/>
						<input type="radio" name="${initialName}"
							data-rel="${parentOptionName}"
							data-config="${configOptionName}"
							class="option ${coverOptionClass}"
							data-price="${selectOptionId}"
							data-subOptions="${subskuOptions}" data-type="option"
							data-value="${defaultSelectOptionSkuIds}" value="${selectOptionId}" autocomplete="off" checked style="display:none"/>
					</c:when>
					<c:otherwise>
						<input type="radio" name="${initialName}"
							data-rel="${parentOptionName}"
							data-config="${configOptionName}"
							class="option ${coverOptionClass}"
							data-price="${defaultSelectOptionSkuIds}"
							data-subOptions="${subskuOptions}" data-type="option"
							data-value="${defaultSelectOptionSkuIds}" value="${defaultSelectOptionSkuIds}" autocomplete="off" checked style="display:none"/>
					</c:otherwise>
				</c:choose>
			</c:if>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>