<%--
This page lays out the elements that make up the PriceSlider.
Required Parameters:
contentItem
The content parameter represents an unselected dimension refinement.
Optional Parameters:
--%>

<dsp:page>

	<dsp:getvalueof var="contextPath" vartype="java.lang.String"  bean="/OriginatingRequest.contextPath"/>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest"/>
	<dsp:getvalueof var="contentItem" vartype="com.endeca.infront.assembler.ContentItem" bean="/OriginatingRequest.contentItem"/>
	<%--
	The slider is a range filter not an Endeca dimension refinement so we need
	to use a custom method.
	--%>
	<c:set var="enabled" value="${contentItem.enabled}"/>
	<fmt:message var="facetName" key="facet.priceProperty" />

	<c:if test="${enabled}">
		<dsp:param name="price" value="${contentItem.sliderMin}"/>
		<c:set var="maxprice" value="${contentItem.sliderMax}"/>
		<c:set var="minprice" value="${contentItem.sliderMin}"/>
		<c:set var="maxpriceSelected" value="${maxprice}"/>
		<c:set var="minpriceSelected" value="${minprice}"/>
		<c:if test="${not empty contentItem.filterCrumb.upperBound}">
			<c:set var="maxpriceSelected" value="${contentItem.filterCrumb.upperBound}"/>
		</c:if>
		<c:if test="${not empty contentItem.filterCrumb.lowerBound}">
			<c:set var="minpriceSelected" value="${contentItem.filterCrumb.lowerBound}"/>
		</c:if>
		<input type="hidden" id="pricemax" value="${maxprice}"/>
		<input type="hidden" id="pricemin" value="${minprice}"/>
		<input type="hidden" id="pricemaxSelected" value="${maxpriceSelected}"/>
		<input type="hidden" id="priceminSelected" value="${minpriceSelected}"/>

		<!-- start PriceSlider -->
		<div class="cdp-subtitle toggle-menu" tabindex="0">
			<span title="${facetName}">${facetName }</span><span class="icon-arrow-down"></span>
		</div>
		<div class="dropdown-container">
			<ul class="guided-nav-dropdown">
				<div class="price-slider-section">
					<p class="price-slider-title">Starting Price</p>
					<div class="noUi-slider-wrapper">
						<div id="slider-snap" class="noUi-target noUi-rtl noUi-horizontal">
							<div class="noUi-base">
								<div class="noUi-origin" style="right: 50%;">
									<div id="slider-snap-value-lower" class="noUi-handle noUi-handle-lower" data-handle="0" style="z-index: 5;"></div>
									<div class="noUi-connect" style="right: 50%; left: 28.5714%;"></div>
									<div class="noUi-origin" style="right: 71.4286%;">
										<div id="slider-snap-value-upper" class="noUi-handle noUi-handle-upper" data-handle="1" style="z-index: 4;"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="noUi-numerical-inputs">
						$<input type="text" class="slider-min" id="input-with-keypress-0"> <span>to</span>
						$<input type="text" class="slider-max" id="input-with-keypress-1">
					</div>
					<div class="numerical-input-labels"><span>Min</span><span>Max</span></div>
				</div>
			</ul>
		</div>
		<!-- end PriceSlider -->
	</c:if>
</dsp:page>
