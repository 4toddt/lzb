<%--
    - File Name: optionsContentCoverSwatches.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the option cover swatches in the options & upgrades accordion content on the product page.
    - Required Parameters:
		- optionCoverItems,
		- optionName,
		- configOptionName,
		- defaultCoverSkuId: default seclected cover sku
    - Optional Parameters:
		- swatchSet,
		- isProductCoverAvailabe
		- filterOptionSelectedCover: option cover selected,
		- filterOptionCoverColor: option cover color filter,
        - filterOptionCoverPattern: option cover pattern filter
--%>

<dsp:page>
    <%-- Imports --%>
	<dsp:importbean bean="/com/lzb/droplet/LZBSKUOptionSeparator" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>

	<%-- Page Variables --%>
	<dsp:getvalueof var="swatchSet" param="swatchSet" />
	<dsp:getvalueof var="optionName" param="optionName" />
	<dsp:getvalueof var="optionCoverItems" param="optionCoverItems"/>
	<dsp:getvalueof var="configOptionName" param="configOptionName"/>
	<dsp:getvalueof var="isProductCoverAvailabe" param="isProductCoverAvailabe" />
	<%-- NOTE: filterOptionSelectedCover, filterOptionCoverColor and filterOptionCoverPattern params are used for an AJAX request with option cover filtering --%>
	<dsp:getvalueof var="filterOptionSelectedCover" param="filterOptionSelectedCover" />
	<dsp:getvalueof var="filterOptionCoverColor" param="filterOptionCoverColor" />
    <dsp:getvalueof var="filterOptionCoverPattern" param="filterOptionCoverPattern" />
    <dsp:getvalueof var="defaultCoverSkuId" param="defaultCoverSkuId" />
	<c:set var="contentHostName" value="//${storeConfig.contentHostName}"/>

	<%-- Render Option Cover Swatches --%>
	<c:if test="${not empty optionCoverItems}">
		<dsp:droplet name="LZBSKUOptionSeparator">
			<dsp:param name="skuOptionCover" value="${optionCoverItems}" />
			<dsp:param name="optionCovers" value="true" />

			<dsp:oparam name="output">
				<dsp:getvalueof var="coverColor" param="coverColor" />
				<dsp:getvalueof var="coverPattern" param="coverPattern" />
				<dsp:getvalueof var="coverOptionListMaps" param="coverOptionList" />

				<c:forEach items="${coverOptionListMaps}" var="firstCoverOptionListMap" varStatus="metaCount">
					<c:set var="numberOfCover" value="${fn:length(firstCoverOptionListMap.value)}" />
				</c:forEach>

				<div class="clearfix"></div>
				<div class="option-swatches option-cover-swatches" data-optionname="" style="display:none">
					<div class="instructions">
						<p>Select a contrasting fabric below</p>
					</div>
					<c:if test="${not empty numberOfCover}">
						<p>${numberOfCover}&nbsp;${configOptionName}&nbsp;available</p>
					</c:if>

					<c:set var="optionNameNoSpace" value="${fn:replace(optionName,' ','-')}" />
					<form id="${optionNameNoSpace}${swatchSet}-filter-form" class="cover-swatch-filter-form" name="${optionNameNoSpace}${swatchSet}-filter-form" autocomplete="off" action="${requestScope['javax.servlet.forward.request_uri']}" data-swatchlist-id="${optionNameNoSpace}${swatchSet}-swatch-list">
						<div class="field">
							<label for="${optionNameNoSpace}${swatchSet}-filter-color"><fmt:message key="pdp.color" /></label>
							<div class="custom-select">
								<select id="${optionNameNoSpace}${swatchSet}-filter-color" name="filterOptionCoverColor">
									<option value=""><fmt:message key="pdp.all" /></option>
									<c:forEach items="${coverColor}" var="color">
			                            <c:set var="colorNameCleaned" value="${fn:replace(fn:replace(fn:toLowerCase(color),'/',''),' ','')}" />
										<option value="${colorNameCleaned}">${color}</option>
									</c:forEach>
								</select>
								<span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
							</div>
						</div>
						<div class="field">
							<label for="${optionNameNoSpace}${swatchSet}-filter-pattern"><fmt:message key="pdp.pattern" /></label>
							<div class="custom-select">
								<select id="${optionNameNoSpace}${swatchSet}-filter-pattern" name="filterOptionCoverPattern">
									<option value=""><fmt:message key="pdp.all" /></option>
									<c:forEach items="${coverPattern}" var="pattern">
										<c:set var="patternNameCleaned" value="${fn:replace(fn:replace(fn:toLowerCase(pattern),'/',''),' ','')}" />
										<option value="${patternNameCleaned}">${pattern}</option>
									</c:forEach>
								</select>
								<span class="icon icon-dropdown-arrow" aria-hidden="true"></span>
							</div>
						</div>
						<%-- keeps an updated value of the selected cover since the AJAX call replaces the swatch list html. value set on pageload using javascript --%>
						<input type="hidden" class="filter-form-selected-swatch-cover" name="filterOptionSelectedCover" value="" />
					</form>

					<div id="${optionNameNoSpace}${swatchSet}-swatch-list" class="swatch-list">
						<c:forEach items="${coverOptionListMaps}" var="coverOptionListMap" varStatus="metaCount">
							<c:forEach items="${coverOptionListMap.value}" var="optionCover" varStatus="i">
								<dsp:param name="swatchIndex" param="count" />

								<%-- Welt does not get a base radio checked by default on page load render because the javascript will render it as a selected option --%>
								<c:set var="baseCheckedWelt" value="" />

								<%-- Sets the default checked radio for Pillow Cover Swatch Options --%>
								<c:if test="${optionName eq 'Pillow Options'}">
									<c:set var="optionCoverID" value="${fn:split(optionCover,'~')[0]}" />
									<c:set var="baseChecked" value="" />
									<c:choose>
										<c:when test="${optionCoverID eq defaultCoverSkuId}">
											<c:set var="baseChecked" value="checked" />
										</c:when>
										<c:otherwise>
											<%-- If color is not available set the first Pillow Cover Swatch as default checked --%>
											<c:if test="${isProductCoverAvailabe eq false && i.index eq 0}">
												<c:set var="baseChecked" value="checked" />
											</c:if>
										</c:otherwise>
									</c:choose>
								</c:if>

								<%-- variables used to clean the color and pattern data --%>
								<c:set var="optionCoverArr" value="${fn:split(optionCover,'~')}" />
								<c:set var="optionCoverCoverId" value="${fn:split(optionCover,'~')[0]}" />
								<c:set var="colorFamilyCleaned" value="${fn:replace(fn:replace(fn:replace(optionCoverArr[1],'(',''),')',''),' ','')}" />
	                            <c:set var="colorFamilyData" value="${fn:toLowerCase(colorFamilyCleaned)}" />
								<c:set var="colorFamilyName" value="${fn:replace(fn:replace(fn:toLowerCase(optionCoverArr[1]),'/',''),' ','')}" />
								<c:set var="coverPatternCleaned" value="${fn:replace(fn:replace(fn:replace(optionCoverArr[4],'(',''),')',''),' ','')}" />
	                            <c:set var="coverPatternData" value="${fn:toLowerCase(coverPatternCleaned)}" />
	                            <c:set var="coverPatternName" value="${fn:toLowerCase(optionCoverArr[4])}" />
								<c:set var="filteredSelectedClass" value="" />

								<c:choose>
									<c:when test="${not empty filterOptionCoverColor || not empty filterOptionCoverPattern}">
										<c:choose>
											<c:when test="${not empty filterOptionSelectedCover && filterOptionSelectedCover eq optionCoverCoverId}">
												<%-- renders and tags the default or user selected swatch so that is not rendered in the filtered results, but remains in the DOM after the AJAX filters the HTML. --%>
												<c:set var="filteredSelectedClass" value="pre-filter-selected" />
												<c:set var="baseChecked" value="checked" />
												<c:set var="baseCheckedWelt" value="checked" />
												<%@ include file="/browse/fragments/optionCoverSwatch.jspf" %>
											</c:when>
											<c:when test="${
												filterOptionCoverColor eq colorFamilyName && empty filterOptionCoverPattern ||
												filterOptionCoverPattern eq coverPatternName && empty filterOptionCoverColor ||
												filterOptionCoverColor eq colorFamilyName && filterOptionCoverPattern eq coverPatternName
											}">
												<%@ include file="/browse/fragments/optionCoverSwatch.jspf" %>
											</c:when>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:if test="${not empty filterOptionSelectedCover && filterOptionSelectedCover eq optionCoverCoverId}">
											<%-- sets the user selected swatch to checked --%>
											<c:set var="baseChecked" value="checked" />
										</c:if>
										<%-- render all covers --%>
										<%@ include file="/browse/fragments/optionCoverSwatch.jspf" %>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:forEach>
					</div>
				</div>
			</dsp:oparam>
			<dsp:oparam name="empty">
				Empty
			</dsp:oparam>
		</dsp:droplet>
	</c:if>
</dsp:page>