<dsp:page>
	<dsp:getvalueof var="defaultCover" param="defaultCover" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<div class="ico">
		<span class="plus"></span>
	</div>
	<c:set var="length" value="${fn:length(defaultCoverAttr)}"/>
	<div class="opt-upg-header">
		<div class="top-part">
			<h4>Add Options &amp; Upgrades</h4>
		</div>
		<div class="items-added-list"></div>
		<div class="price swatch-price"></div>
	</div>
	<span class="accordion-state icon-arrow-down"></span>
</dsp:page>
