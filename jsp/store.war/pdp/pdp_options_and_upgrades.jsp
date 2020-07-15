 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<dsp:importbean bean="/com/lzb/droplet/LZBOptionsAndUpgradesDroplet" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/droplet/LZBPillowCoverDataLoaderDroplet"/>
<dsp:getvalueof var="coverID" param="coverID" />
<dsp:getvalueof var="pdpType" param="pdpType"/>
<dsp:getvalueof param="defaultSelectOptionSkuIds" var="defaultSelectOptionSkuIds"/>
<dsp:getvalueof var="isPillowOptions" param="isPillowOptions"/>

<dsp:page>
	<%--
	<c:if test="${empty pdpType || pdpType ne 'pdp'}">
		<p class="disclaimer"><strong>Price listed per sectional piece.</strong></p>
	</c:if>
	--%>

	<%--
		here is some psuedo-code to show the overall structure of the file below:
		
		foreach (main loop)
			if(isSelectExceptionOption) {
				print out : parentOptionName
			} else {
				if(main item is pillows options)
					<section>
						<header>
							{some custom smart header thing here}
						</header>
						<content>
							for each(option item) {
								if pillow set 1
									<some html>
								if pillow set 2
									<some html>
							}
						</content>
					</section>
				endif
				foreach option item
					if(option item is non-pillow)
						<section>
							<header>
								{smart header}
							</header>
							<content>
								std stuff
							</content>
						</section>
					/if
				/foreach
				if(none of the previous output rendered) {
					<section>
						<header>
							{smart header}
						</header>
						<content>
							std stuff
						</content>
					</section>
				}
			}
		/foreach
	--%>

	<dsp:droplet name="LZBOptionsAndUpgradesDroplet">
		<dsp:param name="subSkuId" param="skuId"  />
		<dsp:param name="optionAndUpgradesJson" param="optionAndUpgradesJson"/>
		<dsp:oparam name="output">		
		<dsp:getvalueof param="sectionalOptionsConfigProperties" var="sectionalOptionsConfigProperties"/>
		<dsp:getvalueof param="listOfSelectOptionIds" var="listOfSelectOptionIds"/>
		<span class="sr-only">pillowOptions: ${isPillowOptions} and array length ${fn:length(sectionalOptionsConfigProperties)}</span>
			
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="sectionalOptionsConfigProperties" />
				<dsp:param name="elementName" value="parentOption" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="parentOptionName" param="parentOption.optionName"/>
					<dsp:getvalueof var="isSelectExceptionOption" param="parentOption.selectExceptionOption"/>
					<c:choose> <%-- h3 or content --%>
						<c:when test="${isSelectExceptionOption}">
							<h3>${parentOptionName}</h3>
						</c:when>
						<c:otherwise>  <%-- !isSelectExceptionOption --%>
							<%-- 
								this SHOULD be a data-module="accordion-group"
								however we are doing side load with ajax,
								instead of rendering this inline with real jsp.
								therefore, this content is loaded AFTER document
								ready, and will never be setup by require.js.

								Thus the original author of this simulated the
								accordion behavior by hand in pdp-options-upgrades.js
								which is the data-module which loads this file via
								$.ajax.

								Look around line ~808 in pdp-options-upgrades.js
							--%>
							<c:set var="p1PillowEdgeTrtmt" value=""/>
							<c:set var="p2PillowEdgeTrtmt" value=""/>
							<c:set var="pillowSet" value="no" />
							<c:set var="foundOption" value="${false}"/>
							<c:set var="addPillowSet1" value="no"/>
							<c:set var="addPillowSet2" value="no"/>
							
							<%-- only display Pillow Option section if the flag is enabled in BCC --%>
							<c:if test="${parentOptionName eq 'Pillow Options' and isPillowOptions}">
								<!-- parentOptionName = ${parentOptionName} -->
								<div class="accordion-section">
									<div class="section-header material-details new-ui"
										data-sub-option-name="${parentOptionName}"
                    data-optionname="${parentOptionName}"
										>
									</div>
									<div class="section-content">
										<dsp:droplet name="ForEach">
											<dsp:param name="array" param="parentOption.optionGroups" />
											<dsp:param name="elementName" value="subOption" />
											<dsp:param name="index" param="count" />
											<dsp:oparam name="outputStart">
												<c:if test="${parentOptionName eq 'Pillow Options'}">
													<p>Your product will come with matching pillows, but if you're going for a bold look choose additional pillows in one of our great contrasting covers that will set your furniture apart!</p>
												</c:if>
											</dsp:oparam>
											<dsp:oparam name="output">
												<c:set var="addPillowSet1" value="no"/>
												<c:set var="addPillowSet2" value="no"/>
												<c:set var="p1EdgeTreatmentItem" value=""/>
												<c:set var="p2EdgeTreatmentItem" value=""/>
												<dsp:getvalueof param="subOption.optionGroupName" var="subOptionName" />
												<!-- ForEach parentOption.optionGroups -->
												<c:if test="${parentOptionName eq 'Pillow Options'}">
													<dsp:getvalueof param="subOption.defaultPillows" var="defaultPillows"/>
													<dsp:getvalueof param="subOption.additionalPillows" var="additionalPillows"/>

												</c:if>
												<dsp:getvalueof var="pdpType" param="pdpType"/>
												<c:if test="${not empty defaultPillows}">
													<c:if test="${fn:containsIgnoreCase(subOptionName, 'P1')}">
														<dsp:getvalueof param="subOption.optionGroupName" var="subOptionName" />
														<dsp:getvalueof param="subOption.defaultPillows" var="defaultPillows"/>
														<dsp:getvalueof param="subOption.additionalPillows" var="additionalPillows"/>
														<c:choose>
															<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
																<input type="radio" class="option" id="defaultPillowsOptions" value="${defaultPillows[0].id}" style="display:none" checked />
															</c:when>
															<c:otherwise>
																<c:forEach var="defaultPillow" items="${defaultPillows}">
																	<input type="radio" class="option" id="defaultPillowsOptions" value="${defaultPillow.id}" style="display:none" checked />
																</c:forEach>
															</c:otherwise>
														</c:choose>
													</c:if>
												</c:if>
												<c:set var="h3ClassName" value="" />
												<%--  xxxx${indexCount}xxxx ${parentOptionName} xxxx --%>
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
														<dsp:param name="coverID" param="coverID"  />
														<dsp:oparam name="output">
															<dsp:getvalueof var="optionCoverItems" param="pillowCovers"/>
															<dsp:getvalueof var="isProductCoverAvailabe" param="isProductCoverAvailabe"/>
														</dsp:oparam>
													</dsp:droplet>
													<c:if test="${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1')}">
														<c:set var="foundOption" value="${true}"/>
														<!-- if parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1') == ${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 1')} -->
														<c:set var="addPillowSet1" value="yes"/>
														<c:set var="pillowSet" value="yes" />
														<c:set var="h3ClassName" value="h3-pillowset-1" />
														<c:if test="${not empty additionalPillows }">
															<c:choose>
																<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
																	<input type="radio" class="option hidden-option" data-rel="p1" value="${additionalPillows[0].id}" data-pillowset="set1" data-pillowType="P1" style="display:none" checked />
																</c:when>
																<c:otherwise>
																	<c:forEach var="additionalPillow" items="${additionalPillows}">
																		<input type="radio" class="option hidden-option" data-rel="p1" value="${additionalPillow.id}" data-pillowset="set1" data-pillowType="P1" style="display:none" checked />
																	</c:forEach>
																</c:otherwise>
															</c:choose>
															<div class="h3-pillowset-1-colorswatch">
																<%-- do something here to make this section have real content --%>
																<div>
																	<span>
																		Choose how many additional pillow sets(2) you want here:
																	</span>
																</div>
																<select class="pillowQuantitySelect" id="pillowQuantitySelect_${additionalPillows[0].id}" data-rel='${p1PillowEdgeTrtmt.optionGroupName}'>
																	<option name="">Quantity</option>
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
																<hr />

                                <div style="display:none">
                                  <input class="option-checkbox same-as-coverfabric option-checkbox-P1" name="same-as-coverfabric" data-h3="h3-pillowset-1" type="checkbox" value="true" checked />
                                  <label for="same-as-coverfabric">Same as the selected cover fabric</label>
                                </div>

																<section class="pillow-fabric-selection pillow-fabric-selection-P1" style="display:none">
																	<dsp:include page="pdp_pillow_covers_loader.jsp">
																		<dsp:param name="optionCoverItems" value="${optionCoverItems}" />
																		<dsp:param name="swatchSet" value="set1" />
																		<dsp:param name="isProductCoverAvailabe" value="${isProductCoverAvailabe}" />
																	</dsp:include>
																</section>
															</div><%-- .h3-pillowset-1-colorswatch --%>
															<c:if test="${not empty p1PillowEdgeTrtmt}">
                                <h5 class="suboptH3 option-group-name" class="${h3ClassName}" data-optionitem="${p1PillowEdgeTrtmt.optionGroupName}">
                                  ${p1PillowEdgeTrtmt.optionGroupName}
													      </h5>
																<dsp:include page="pdp_config_prop_options_and_upgrades.jsp"><%-- layer 1 through layer 3 --%>
																	<dsp:param name="configOptions" value="${p1PillowEdgeTrtmt.configOptions}" />
																	<dsp:param name="optionTitle" value="${p1PillowEdgeTrtmt.optionGroupName}" />
																	<dsp:param name="subOptionGroupName" value="${p1PillowEdgeTrtmt.optionGroupName}" />
																	<dsp:param name="pdpType" param="pdpType"/>
																	<dsp:param name="h3ClassName" value="${h3ClassName}" />
																	<dsp:param name="pillowSet" value="${pillowSet}" />
																</dsp:include>
															</c:if>
														</c:if>
													</c:if><%-- 'Pillow Options' and indexCount eq 0 --%>
													<c:if test="${parentOptionName eq 'Pillow Options' and fn:containsIgnoreCase(subOptionName, 'Set 2')}">
														<!-- set 2 -->
														<c:set var="foundOption" value="${true}"/>
														<c:set var="addPillowSet2" value="yes"/>
														<c:set var="pillowSet" value="yes" />
														<c:set var="h3ClassName" value="h3-pillowset-2" />
														<div class="set-section">
															<p class="set-section-p set" data-set="set2"><strong>SET 2</strong><span class="symbol plus"></span></p>
															<div class="set-subset" style="display:none">
																<h4><strong>PILLOW FABRIC</strong></h4>
																<c:if test="${not empty additionalPillows }">
																	<c:choose>
																		<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
																			<input type="radio" class="option hidden-option" data-rel="p2" value="${additionalPillows[0].id}" data-pillowset="set2" data-pillowType="P2" style="display:none" checked />
																		</c:when>
																		<c:otherwise>
																			<c:forEach var="additionalPillow" items="${additionalPillows}">
																				<input type="radio" class="option hidden-option" data-rel="p2" value="${additionalPillow.id}" data-pillowset="set2" data-pillowType="P2" style="display:none" checked />
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>
																</c:if>
																<div class="h3-pillowset-2-colorswatch">
																	<select class="pillowQuantitySelect" id="pillowQuantitySelect_${additionalPillows[0].id}" data-rel='${p2PillowEdgeTrtmt.optionGroupName}'>
																		<option name="">Quantity</option>
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
																	<hr />

                                  <div style="display:none">
                                    <input class="option-checkbox same-as-coverfabric option-checkbox-P2" name="same-as-coverfabric" data-h3="h3-pillowset-2" type="checkbox" value="true" checked />
                                    <label for="same-as-coverfabric">Same as the selected cover fabric</label>
                                  </div>

																	<c:if test="${isProductCoverAvailabe eq false}">
																		<section class="pillow-fabric-selection pillow-fabric-selection-P2" style="display:none">
																			<dsp:include page="pdp_pillow_covers_loader.jsp">
																				<dsp:param name="optionCoverItems" value="${optionCoverItems}" />
																				<dsp:param name="swatchSet" value="set2" />
																				<dsp:param name="isProductCoverAvailabe" value="${isProductCoverAvailabe}" />
																			</dsp:include>
																		</section>
																	</c:if>
																</div><%-- .h3-pillowset-2-colorswatch --%>
																<c:if test="${not empty p2PillowEdgeTrtmt}">
                                  <h5 class="suboptH3 option-group-name" class="${h3ClassName}" data-optionitem="${p2PillowEdgeTrtmt.optionGroupName}">
                                    ${p2PillowEdgeTrtmt.optionGroupName}
                                  </h5>
																	<dsp:include page="pdp_config_prop_options_and_upgrades.jsp"><%-- layer 1 through layer 3 --%>
																		<dsp:param name="configOptions" value="${p2PillowEdgeTrtmt.configOptions}" />
																		<dsp:param name="optionTitle" value="${p2PillowEdgeTrtmt.optionGroupName}" />
																		<dsp:param name="subOptionGroupName" value="${p2PillowEdgeTrtmt.optionGroupName}" />
																		<dsp:param name="pdpType" param="pdpType"/>
																		<dsp:param name="h3ClassName" value="${h3ClassName}" />
																		<dsp:param name="pillowSet" value="${pillowSet}" />
																	</dsp:include>
																</c:if>
															</div>
														</div>
													</c:if>
                          <%-- START Display Pillow Comfort --%>
                          <c:if test="${addPillowSet1 eq 'no' and addPillowSet2 eq 'no'}">
                            <c:if test="${empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem}">
                              <h5 class="suboptH3 ${h3ClassName}" data-optionitem="${subOptionName}">
                                ${subOptionName}
                              </h5>
                            </c:if>
                          </c:if>
                          <c:if test="${empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem}">
                          <dsp:include page="pdp_config_prop_options_and_upgrades.jsp"><%-- layer 1 through layer 3 --%>
                            <dsp:param name="configOptions" param="subOption.configOptions" />
                            <dsp:param name="optionTitle" value="${parentOptionName}" />
                            <dsp:param name="subOptionGroupName" value="${subOptionName}" />
                            <dsp:param name="pdpType" param="pdpType"/>
                            <dsp:param name="h3ClassName" value="${h3ClassName}" />
                            <dsp:param name="pillowSet" value="${pillowSet}" />
                          </dsp:include>
                          </c:if>
                          <%-- END Display Pillow Comfort --%>
                        </c:if>
											</dsp:oparam>
										</dsp:droplet> <%-- ForEach --%>
									</div> <%-- .section-content --%>
								</div> <%-- .accordion-section --%>
							</c:if> <%-- if is pillows --%>

							<%-- process non-pillow option sections --%>
							<c:if test="${foundOption eq false}">
<!--  foundOption false -->
								<dsp:droplet name="ForEach">
									<dsp:param name="array" param="parentOption.optionGroups" />
									<dsp:param name="elementName" value="subOption" />
									<dsp:param name="index" param="count" />
									<dsp:oparam name="output">
										<dsp:getvalueof param="subOption.optionGroupName" var="subOptionName" />
										<dsp:getvalueof param="subOption.configOptions" var="configOptions" />

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

										<!-- ForEach parentOption.optionGroups non-pillow -->
										<%--<!-- addPillowSet1 = ${addPillowSet1} -->--%>
										<%--<!-- addPillowSet2 = ${addPillowSet2} -->--%>
										<c:if test="${(parentOptionName ne 'Pillow Options') and (addPillowSet1 eq 'no' and addPillowSet2 eq 'no') and (empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem)}">
											<%--<!-- not set 1 && not set 2 and not pillow edge treatment-->--%>
											<%--<!-- !addPillowSet1 && !addPillowSet2 -->--%>
											<%--<!-- empty p1EdgeTreatmentItem and empty p2EdgeTreatmentItem -->--%>
											<c:set var="foundOption" value="${true}"/>
											<c:if test="${ optionsLength > 1 }" >
											<div class="accordion-section">
												<div class="section-header pillow-section material-details new-ui" 
													data-sub-option-name="${subOptionName}"
													data-class-name="${h3ClassName}"
													data-optionitem="${subOptionName}"
	                            					data-optionname="${parentOptionName}">
												</div>
												<div class="section-content">
													<dsp:include page="pdp_config_prop_options_and_upgrades.jsp"><%-- layer 1 through layer 3 --%>
														<dsp:param name="configOptions" param="subOption.configOptions" />
														<dsp:param name="optionTitle" value="${parentOptionName}" />
														<dsp:param name="subOptionGroupName" value="${subOptionName}" />
														<dsp:param name="pdpType" param="pdpType"/>
														<dsp:param name="h3ClassName" value="${h3ClassName}" />
														<dsp:param name="pillowSet" value="${pillowSet}" />
													</dsp:include>
												</div><%-- .section-content .pdp-block options-upgrades --%>
											</div><%-- .pdp-block-container accordion-section --%>
											</c:if>
										</c:if>
									</dsp:oparam>
								</dsp:droplet> <%-- ForEach --%>
							</c:if>
							<%-- 
								need to change this logic...
								choose
									when for each list is !len 0
										do the foreach above
									/when
									otherwise
										do this alternative below
									/otherwise
								/choose

								the reason for this is that there is always an empty section here at the end, 
								and now we will have a problem.

								update:
								problem is fixed, for now.  ${foundOption} is used to only do this section if
								the previous logic didn't choose one of the options available there.

								update:
								still need to change things but it makes more sense now.
								see main logic now detailed at top of file

							--%>
							<!-- ${parentOption.configOptions} -->
							<c:if test="${foundOption eq false and parentOptionName ne 'Pillow Options'}">
<!--  foundOption false again -->
								<c:set var="optionsLength" value="${0}" />
								<dsp:getvalueof param="parentOption.configOptions" var="configOptions" />
								<c:forEach var="configOption" items="${configOptions}">
									<c:if test="${configOption.showOnline == null || configOption.showOnline == true}">
										<c:set var="optionsLength" value="${optionsLength + 1}" />
									</c:if>
								</c:forEach>

								<c:if test="${optionsLength > 1}" >
								<!-- foundOption eq false -->
								<div class="accordion-section">
									<div class="section-header material-details new-ui" 
											data-sub-option-name="${parentOptionName}"
											data-class-name="${h3ClassName}"
											data-optionitem="${parentOptionName}"
                      data-optionname="${parentOptionName}"
											>
									</div>
									<div class="section-content">
										<dsp:include page="pdp_config_prop_options_and_upgrades.jsp"><%-- layer 1 to layer 3 --%>
											<dsp:param name="configOptions" param="parentOption.configOptions" />
											<dsp:param name="optionTitle" value="${parentOptionName}" />
											<dsp:param name="subOptionGroupName" value=" " />
											<dsp:param name="pdpType" param="pdpType"/>
										</dsp:include>
									</div>
								</div>
								</c:if>
							</c:if>
						</c:otherwise>	<%-- !isSelectExceptionOption --%>
					</c:choose>	<%-- h3 or content --%>
				</dsp:oparam> <%-- ForEach:oparam:output --%>
			</dsp:droplet><%-- ForEach --%>
			<c:if test="${not empty defaultSelectOptionSkuIds and fn:length(defaultSelectOptionSkuIds)>0 }">
				<c:choose>
					<c:when test="${not empty pdpType and pdpType eq 'pdp'}">
					<c:set var="selectOptionId" value="${fn:substring(defaultSelectOptionSkuIds, 1, fn:length(defaultSelectOptionSkuIds)-1)}"/>
						<input type="radio" name="${initialName}"
							data-rel="${parentOptionName}"
							data-config="${configOptionName}"
							class="option ${coverOptionClass}"
							data-price="${selectOptionId}"
							data-subOptions="${subskuOptions}" data-type="option"
							data-value="${defaultSelectOptionSkuIds}" value="${selectOptionId}" checked style="display:none"/>
					</c:when>
					<c:otherwise>
						<input type="radio" name="${initialName}"
							data-rel="${parentOptionName}"
							data-config="${configOptionName}"
							class="option ${coverOptionClass}"
							data-price="${defaultSelectOptionSkuIds}"
							data-subOptions="${subskuOptions}" data-type="option"
							data-value="${defaultSelectOptionSkuIds}" value="${defaultSelectOptionSkuIds}" checked style="display:none"/>
					</c:otherwise>
				</c:choose>
			</c:if>
		</dsp:oparam> <%-- LZBOptionsAndUpgradesDroplet:oparam:output --%>
	</dsp:droplet><%-- LZBOptionsAndUpgradesDroplet --%>
</dsp:page>
