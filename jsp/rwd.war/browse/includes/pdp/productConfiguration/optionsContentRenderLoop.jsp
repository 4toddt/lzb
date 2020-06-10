<%--
    - File Name: optionsContentRenderLoop.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page renders each of the accordions options within the options & upgrades content on the product page.
    - Required Parameters:
		- optionName,
		- subOptionGroupName,
		- configOptions
		- pdpType,
		- defaultCoverSkuId: default seclected cover sku
    - Optional Parameters:
		- h3ClassName
--%>
<dsp:page>
    <%-- Imports --%>
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/userprofiling/ProfileTools" />
	<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="optionName" param="optionName" />
	<dsp:getvalueof var="subOptionGroupName" param="subOptionGroupName" />
	<dsp:getvalueof var="configOptions" param="configOptions" />
	<dsp:getvalueof var="pdpType" param="pdpType"/>
	<dsp:getvalueof var="h3ClassName" param="h3ClassName" />
	<dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>

	<%-- Render Product Options & Upgrades Configuration Content--%>

	<div class="option-container ${h3ClassName}">
		<dsp:droplet name="ForEach">
			<dsp:param name="indexLevel" param="index" />
			<dsp:param name="array" value="${configOptions}" />
			<dsp:param name="elementName" value="configOption" />
			<dsp:oparam name="output">
				<dsp:getvalueof var="configOptionName" param="configOption.configOptionName" />
				<dsp:getvalueof var="optionItemSubSkuIdMap" param="configOption.optionItemSubSkuIdMap" />
				<dsp:getvalueof var="indexLevel" param="indexLevel" />
				<dsp:getvalueof var="optionCoverItems" param="configOption.optionCoverItems" />
				<dsp:getvalueof var="showOnline" param="configOption.showOnline" />
				<c:set var="coverOptionClass" value="" />
				<c:set var="initialChecked" value="" />
				<c:set var="initialCheckedActiveClass" value="" />
				<c:set var="initialName" value="${optionName}-${indexLevel}" />

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
										<%-- Render Option List Loop --%>
										<fmt:parseNumber var="listPriceParse" value="${lPriceBase}" />
										<fmt:parseNumber var="salePriceFormat" value="${sPriceBase}" />
										<fmt:formatNumber var="listPriceFormat" value="${listPriceParse}" type="currency" />
										<fmt:formatNumber var="salePriceFormat" value="${salePriceFormat}" type="currency" />
										<dsp:getvalueof var="optionFinishes" param="configOption.finishes" />
										<c:set var="finishStandardImageSet" value="false"/>
										<c:set var="subskuOptions" value="false" />
										<c:if test="${optionName eq 'Welt Options'}">
											<c:set var="coverOptionClass" value="coverOptionRadio" />
										</c:if>
										<c:if test="${fn:contains(configOptionName, 'Standard')}">
											<c:set var="initialChecked" value="checked" />
											<c:set var="initialCheckedActiveClass" value="active" />
										</c:if>
										<c:if test="${configOptionName eq 'None'}">
											<c:set var="initialChecked" value="checked" />
											<c:set var="initialCheckedActiveClass" value="active" />
										</c:if>
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
											<c:set var="priceToUse" value="$0.00"/>
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

										<div class="option-tile ${initialCheckedActiveClass}" title="${configOptionName}" tabindex="0">
											<c:choose>
												<c:when test="${not empty optionFinishes and fn:contains(configOptionName, 'Standard')}">
													<img src="${contentHostName}${finishImgPath}" data-displayname="${finishDisplayName}" data-optiontype='optionFinish' data-finish="${finish}" data-finishCode="${finishCode}" data-recliner-name="${initialName}" alt="${finishDisplayName}" class="" />
												</c:when>
												<c:when test="${not empty map.key and not empty map.key.imagePath}">
													<img src="${contentHostName}${map.key.imagePath}" alt="${map.key.OptionCode}" />
												</c:when>
												<c:otherwise>
													<c:if test="${not empty configOptionImage and finishStandardImageSet eq false}">
														<img src="${contentHostName}${configOptionImage}" alt="${configOptionName}" />
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
														aria-label="${configOptionName} radio button for ${subOptionGroupName}" autocomplete="off" ${initialChecked} />
												</c:when>
												<c:otherwise>
													<%--<!-- not empty pdpType and pdpType eq pdp -> OTHERWISE-->--%>
													<input type="radio" name="${initialName}" data-rel="${subOptionGroupName}" data-config="${configOptionName}"
														class="option ${coverOptionClass}" data-price="${listOfValues}" 
														data-price-formatted="${priceToUse}" data-subOptions="${subskuOptions}" 
														data-type="option" data-optioncode="${map.key.OptionCode}" data-value="${subSkuID}" value="${subSkuID}" id="radio${subSkuID}"
														aria-label="${configOptionName} radio button for ${subOptionGroupName}" autocomplete="off" ${initialChecked} /> 
												</c:otherwise>
											</c:choose>
											<label for="radio${subSkuID}" class="options-label-button" role="button" aria-label="hit enter to select ${configOptionName}">
												<strong>${configOptionName}</strong>
												<c:if test="${not empty finishDisplayName and fn:contains(configOptionName, 'Standard')}">
													<br/>
													${finishDisplayName}
												</c:if>
												<span class="option-price">+${priceToUse}</span>
											</label>
										</div>
									</dsp:oparam>
								</dsp:droplet>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="initialCheckedActiveClass" value="active" />
							<div class="option-tile ${initialCheckedActiveClass}" tabindex="0">
								<c:if test="${not empty configOptionName and configOptionName eq 'None'}">
									<dsp:getvalueof var="configOptionImage" param="configOption.defaultImagePath" />
									<c:if test="${not empty configOptionImage}">
										<img src="${contentHostName}${configOptionImage}" alt="${configOptionName}" />
									</c:if>
									<c:set var="initialChecked" value="checked" />
									<input type="radio" name="${initialName}" class="option ${coverOptionClass}" 
											data-rel="${subOptionGroupName}" data-config="${configOptionName}" 
											data-price="${listOfValues}" 
											data-type="optionFinish" 
											data-value="${subSkuID}" 
											value="${subSkuID}" autocomplete="off" ${initialChecked} 
											data-price-formatted="$0.00" />
									<label for="radio${subSkuID}" class="options-label-button" role="button" aria-label="hit enter to select ${configOptionName}">
										<strong>${configOptionName}</strong>
										<span class="option-price">+$0.00</span>
									</label>
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
					<dsp:getvalueof var="optionCoverItems" param="configOption.optionCoverItems" />
					<%-- Include Option Cover Swatches --%>
					<dsp:include page="/browse/includes/pdp/productConfiguration/optionsContentCoverSwatches.jsp">
						<dsp:param name="optionCoverItems" value="${optionCoverItems}" />
						<dsp:param name="optionName" value="${optionName}" />
						<dsp:param name="configOptionName" value="${configOptionName}" />
									<dsp:param name="defaultCoverSkuId" value="${defaultCoverSkuId}" />
					</dsp:include>

					<c:if test="${not empty optionFinishes and not fn:contains(configOptionName, 'Standard')}">
						<div class="clearfix"></div>
						<div class="option-swatches option-finish-swatches" style="display:none;">
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
											<p class="instructions">
												<span class="option-text-left">Select a finish below</span>
												<span class="option-text-right">Selected: <span class="option-selected-color">${finishDisplayName}</span></span>
											</p>
											<p><strong>${fn:length(optionFinishes)} finish options available</strong></p>
											<ul>
												<c:set var="selectedClass" value="selected"/>
										</c:when>
										<c:otherwise>
											<c:set var="selectedClass" value=""/>
										</c:otherwise>
									</c:choose>
									<li>
													<img src="${contentHostName}${finishImgPath}" data-displayname="${finishDisplayName}" alt="${finishDisplayName}" 
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
						</div>
					</c:if>
				</c:if>
			</dsp:oparam>
		</dsp:droplet>
		<input type="hidden" class="option-radio-val" data-rel="${subOptionGroupName}" autocomplete="off" value="1" />
	</div>
</dsp:page>