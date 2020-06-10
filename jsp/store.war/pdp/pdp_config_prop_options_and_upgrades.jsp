<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
<dsp:getvalueof var="parentOptionName" param="optionTitle" />
<dsp:getvalueof var="subOptionGroupName" param="subOptionGroupName" />
<dsp:getvalueof var="pdpType" param="pdpType"/>
<dsp:getvalueof var="h3ClassName" param="h3ClassName" />
<dsp:getvalueof var="pillowSet" param="pillowSet" />
<c:set var="contentHostName" value="//content.la-z-boy.com"/>
<div class="swatch-options custom ${h3ClassName}">
	<div class="wrapper">
		<dsp:droplet name="ForEach">
			<dsp:param name="indexLevel" param="index" />
			<dsp:param name="array" param="configOptions" />
			<dsp:param name="elementName" value="configOption" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="configOptionName" param="configOption.configOptionName" />
				 <%-- :: configOptionName :: ${configOptionName} --%>
				<dsp:getvalueof var="optionItemSubSkuIdMap" param="configOption.optionItemSubSkuIdMap" />
				<dsp:getvalueof var="indexLevel" param="indexLevel" />
				<dsp:getvalueof var="optionCoverItems" param="configOption.optionCoverItems" />
				<dsp:getvalueof var="showOnline" param="configOption.showOnline" />
				<c:set var="coverOptionClass" value="" />
				<c:set var="initialChecked" value="" />
				<c:set var="initialName" value="${parentOptionName}-${indexLevel}" />

				<c:if test="${showOnline == null || showOnline == true}">
					<c:choose>
						<c:when test="${not empty optionItemSubSkuIdMap}">
							<c:forEach var="map" items="${optionItemSubSkuIdMap}">
								<c:set var="listOfValues" value="${map.value}" />
								<dsp:droplet name="LZBSectionalPDPPriceDroplet">
									<dsp:param name="subSkuId" value="${listOfValues[0]}" />
									<dsp:param name="dealerId" bean="ProfileTools.priceListId" />
									<dsp:param name="isSectionalOptionItem" value="true" />
									<dsp:getvalueof var="lPriceBase" param="listPrice" />
									<dsp:getvalueof var="sPriceBase" param="salePrice" />
									<dsp:getvalueof var="subSkuID" param="subSkuId" />
									<dsp:oparam name="output">
										<figure class="options">
											<!-- main loop -->
											<fmt:parseNumber var="listPriceParse" value="${lPriceBase}" />
											<fmt:parseNumber var="salePriceFormat" value="${sPriceBase}" />
											<fmt:formatNumber var="listPriceFormat" value="${listPriceParse}" type="currency" />
											<fmt:formatNumber var="salePriceFormat" value="${salePriceFormat}" type="currency" />
											<dsp:getvalueof var="optionFinishes" param="configOption.finishes" />
											<c:set var="finishStandardImageSet" value="false"/>
											<c:set var="subskuOptions" value="false" />
											<c:if test="${parentOptionName eq 'Welt Options'}">
												<c:set var="coverOptionClass" value="coverOptionRadio" />
											</c:if>
											<c:if test="${fn:contains(configOptionName, 'Standard')}">
												<c:set var="initialChecked" value="checked" />
											</c:if>
											<c:if test="${configOptionName eq 'None'}">
												<c:set var="initialChecked" value="checked" />
											</c:if>
											<%-- <c:if test="${pillowSet eq 'yes'}">
												<c:set var="subskuOptions" value="true" />
											</c:if> --%>
											<c:if test="${not empty optionCoverItems}">
												<c:set var="subskuOptions" value="true" />
											</c:if>
											<c:if test="${listPriceFormat ne null and listPriceFormat ne '$0.00'}">
												<c:set var="priceToUse" value="${listPriceFormat}"/>
											</c:if>
											<c:if test="${salePriceFormat ne null and salePriceFormat ne '$0.00'}">
												<c:set var="priceToUse" value="${salePriceFormat}"/>
											</c:if>
											<c:if test="${empty priceToUse}">
												<c:set var="priceToUse" value=""/>
											</c:if>
											<c:if test="${not empty optionFinishes and fn:contains(configOptionName, 'Standard')}">
												<dsp:droplet name="ForEach">
													<dsp:param name="array" value="${optionFinishes}" />
													<dsp:param name="elementName" value="finish" />
													<dsp:oparam name="output">
														<c:set var="finishStandardImageSet" value="true"/>
														<dsp:getvalueof var="finishImgPath" param="finish.imagePath" />
														<dsp:getvalueof var="finishDisplayName" param="finish.displayName" />
														<dsp:getvalueof var="finishCode" param="finish.id" />
														<dsp:getvalueof var="finish" param="finish.finishCode" />
													</dsp:oparam>
												</dsp:droplet>
											</c:if>
											<dsp:getvalueof var="configOptionImage" param="configOption.defaultImagePath" />
											<div class="option-tile tooltip-options" tabindex="0"
												title="
												<div class='option-tip'>
														<div class='lg-swatch'>
															<c:choose>
																<c:when test='${not empty optionFinishes and fn:contains(configOptionName, "Standard")}'>
																	<img src='${finishImgPath}' alt='${finishDisplayName}' />
																</c:when>
																<c:when test='${not empty map.key and not empty map.key.imagePath}'>
																	<img src='${contentHostName}${map.key.imagePath}' alt='${map.key.OptionCode}' />
																</c:when>
																<c:otherwise>
																	<c:if test='${not empty configOptionImage and finishStandardImageSet eq false }'>
																		<img src='${configOptionImage}' alt='${configOptionName}' />
																	</c:if>
																</c:otherwise>
															</c:choose>
														</div>
														<div class='details'>
															<c:if test='${not empty configOptionName}'>
																<p class='title'>${configOptionName}<p>
															</c:if>
															<c:if test='${not empty priceToUse}'>
																<p class='price'>+${priceToUse}</p>
															</c:if>
														</div>
													</div>
												">
												<c:choose>
													<c:when test="${not empty optionFinishes and fn:contains(configOptionName, 'Standard')}">
														<img src="${finishImgPath}" data-displayname="${finishDisplayName}" data-optiontype='optionFinish' data-finish="${finish}" data-finishCode="${finishCode}" data-recliner-name="${initialName}" alt="${finishDisplayName}" class="" />
													</c:when>
													<c:when test="${not empty map.key and not empty map.key.imagePath}">
														<img src="${contentHostName}${map.key.imagePath}" alt="${map.key.OptionCode}" />
													</c:when>
													<c:otherwise>
														<c:if test="${not empty configOptionImage and finishStandardImageSet eq false }">
															<img src="${configOptionImage}" alt="${configOptionName}" />
														</c:if>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${not empty pdpType and pdpType eq pdp}">
														<%--<!-- not empty pdpType and pdpType eq pdp -->--%>
														<input type="radio" name="${initialName}" data-rel="${subOptionGroupName}" data-config="${configOptionName}"
															class="option ${coverOptionClass}" data-price="${listOfValues[0]}" 
															data-price-formatted="${priceToUse}" data-subOptions="${subskuOptions}" 
															data-type="option" data-optioncode="${map.key.OptionCode}" data-value="${subSkuID}" value="${subSkuID}" id="radio${subSkuID}"
															aria-label="${configOptionName} radio button for ${subOptionGroupName}" ${initialChecked} />
													</c:when>
													<c:otherwise>
														<%--<!-- not empty pdpType and pdpType eq pdp -> OTHERWISE-->--%>
														<input type="radio" name="${initialName}" data-rel="${subOptionGroupName}" data-config="${configOptionName}"
															class="option ${coverOptionClass}" data-price="${listOfValues}" 
															data-price-formatted="${priceToUse}" data-subOptions="${subskuOptions}" 
															data-type="option" data-optioncode="${map.key.OptionCode}" data-value="${subSkuID}" value="${subSkuID}" id="radio${subSkuID}"
															aria-label="${configOptionName} radio button for ${subOptionGroupName}" ${initialChecked} /> 
													</c:otherwise>
												</c:choose>
												<label for="radio${subSkuID}"
															class="options-label-button" role="button"
														aria-label="hit enter to select ${configOptionName}"
														>
													<strong>${configOptionName}</strong>
													<c:if test="${not empty finishDisplayName and fn:contains(configOptionName, 'Standard')}">
														<br/>
														${finishDisplayName}
													</c:if>
													<c:if test="${not empty priceToUse}">
														<br/>
														<span class="option-price">+${priceToUse}</span>
													</c:if>
												</label>
											</div>
										</figure><%-- .options --%>
									</dsp:oparam>
								</dsp:droplet>
								<%-- LZBSectionalPDPPriceDroplet --%>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<figure class="options">
								<%--<!-- otherwise -->--%>
								<div class="option-tile" tabindex="0">
									<c:if test="${not empty configOptionName and configOptionName eq 'None'}">
										<dsp:getvalueof var="configOptionImage" param="configOption.defaultImagePath" />
										<c:if test="${not empty configOptionImage}">
											<img src="${configOptionImage}" alt="${configOptionName}" />
										</c:if>
										<c:set var="initialChecked" value="checked" />
										<input type="radio" name="${initialName}" class="option ${coverOptionClass}" 
												data-rel="${subOptionGroupName}" data-config="${configOptionName}" 
												data-price="${listOfValues}" 
												data-type="optionFinish" 
												data-value="${subSkuID}" 
												value="${subSkuID}" ${initialChecked} 
												data-price-formatted="" />
										<label>
											${configOptionName}
										</label>
									</c:if>
								</div>
							</figure>
						</c:otherwise>
					</c:choose>
					<dsp:getvalueof var="optionCoverItems" param="configOption.optionCoverItems" />
					<c:if test="${not empty optionCoverItems}">
						<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
							<dsp:param name="skuOptionCover" value="${optionCoverItems}" />
							<dsp:param name="optionCovers" value="true" />
							<dsp:oparam name="output">
								<dsp:getvalueof param="coverColor" var="coverColor" />
								<dsp:getvalueof param="coverPattern" var="coverPattern" />
								<dsp:getvalueof param="coverOptionList" var="coverOptionListMaps" />
								<c:forEach items="${coverOptionListMaps}" var="firstCoverOptionListMap" varStatus="metaCount">
									<c:set var="numberOfCover" value="${fn:length(firstCoverOptionListMap.value)}" />
								</c:forEach>
								<div class="custom-swatch-options option-cover-items-div" data-optionname="" style="display:none">
									<div class="instructions">
										<p>Select a contrasting fabric below</p>
									</div>
									<c:if test="${ not empty numberOfCover}">
										<p>${numberOfCover}&nbsp;${configOptionName}&nbsp;available</p>
									</c:if>
									<form action="#">
										<select name="color">
											<option value="color"><fmt:message key="pdp.color" /></option>
											<c:forEach items="${coverColor }" var="color">
												<option value="${color }">${color }</option>
											</c:forEach>
										</select> <select name="pattern">
											<option value="pattern"><fmt:message key="pdp.pattern" /></option>
											<c:forEach items="${coverPattern }" var="pattern">
												<option value="${pattern}">${pattern }</option>
											</c:forEach>
										</select>
									</form>
									<div class="swatch-options custom" tabindex="-1">
										<div class="wrapper2 color-swatch-option-div" tabindex="-1">

											<c:forEach items="${coverOptionListMaps}" var="coverOptionListMap" varStatus="metaCount">
												<c:forEach items="${coverOptionListMap.value}" var="optionCover" varStatus="i">
													<dsp:param name="swatchIndex" param="count" />
													<c:if test="${i.index eq 0 }">
														<section class="swatches options" style="width: 400px; height: 500px">
													</c:if>
													<div style="width: 100px; float: left;">
														<input type="radio" class="option" data-type="optionCover" name="Welt" 
																data-value="${fn:split(optionCover,'~')[0]}" value="${fn:split(optionCover,'~')[0]}"
																id="welt${fn:split(optionCover,'~')[0]}">
														<label for="welt${fn:split(optionCover,'~')[0]}" 
															role="button" aria-label="click to select ${fn:split(optionCover,'~')[2]} welt option"
															class="options-label-button">
															<img class="swatch-image" src="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${fn:split(optionCover,'~')[0]}.jpg"
																height="50" width="50" alt="${fn:split(optionCover,'~')[2]}" tabindex="0" />
														</label>
													</div>
													<c:if test="${i.index ne 0 and (i.index%30 eq 0 )}">
														</section>
														<section class="swatches options" style="width: 400px; height: 500px">
													</c:if>
												</c:forEach>
												</section>
											</c:forEach>
										</div><%-- .wrapper --%>
									</div><%-- .swatch-options custom --%>
								</div><%-- .custom-swatch-options --%>
							</dsp:oparam>
							<dsp:oparam name="empty">
								Empty
							</dsp:oparam>
						</dsp:droplet>
					</c:if>

					<c:if test="${not empty optionFinishes and not fn:contains(configOptionName, 'Standard')}">
						<div class="optionFinishesSection" style="display:none;">
							<dsp:droplet name="ForEach">
								<dsp:param name="array" value="${optionFinishes}" />
								<dsp:param name="elementName" value="finish" />
								<dsp:oparam name="output">
									<dsp:getvalueof var="finishImgPath" param="finish.imagePath"/>
									<dsp:getvalueof var="finishDisplayName" param="finish.displayName"/>
									<dsp:getvalueof var="finish" param="finish.finishCode"/>
									<dsp:getvalueof var="finishCode" param="finish.id"/>
									<dsp:getvalueof var="forCount" param="count"/>
										<c:choose>
											<c:when test="${forCount eq 1}">
												<p>
													<span class="option-text-left">Select a finish below</span>
													<span class="option-text-right">Selected: <span class="option-selected-color">${finishDisplayName}</span></span>
												</p>
												<p><strong><dsp:valueof param="count"/> finish options available</strong></p>
												<ul>
												<c:set var="selectedClass" value="selected"/>
											</c:when>
											<c:otherwise>
												<c:set var="selectedClass" value=""/>
											</c:otherwise>
										</c:choose>
									<li>
										<img src="${finishImgPath}" data-displayname="${finishDisplayName}" 
										data-optiontype='optionFinish' data-finish="${finish}" data-finishCode="${finishCode}" 
										data-recliner-name="${initialName}" class="option-finish-img ${selectedClass}" role="button" tabindex="0" 
										aria-label="Click to choose ${finishDisplayName} finish" />
									</li>
								</dsp:oparam>
								<dsp:oparam name="outputEnd">
									<dsp:getvalueof var="arraySize" param="size"/>
									<c:if test="${arraySize != 0}">
										</ul>
									</c:if>
								</dsp:oparam>
							</dsp:droplet>
						</div><%-- .optionFinishesSection --%>
					</c:if>
				</c:if>
			</dsp:oparam>
		</dsp:droplet>
		<input type="hidden" class="option-radio-val" data-rel="${subOptionGroupName}" value="1" />
	</div><%-- .wrapper --%>
</div> <!-- .swatch-options custom ${h3ClassName} -->