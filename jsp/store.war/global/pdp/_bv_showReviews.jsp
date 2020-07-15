<dsp:page>
	<dsp:importbean bean="/com/lzb/common/LZBBVConfiguration" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="reviewUrl" bean="LZBBVConfiguration.reviewUrl" />
	<dsp:getvalueof var="productId" param="productId"/>

	<script type="text/javascript" src="https://${reviewUrl}"></script>
	<script type="text/javascript">
		$BV.configure("global", {
			submissionContainerUrl: "${hostName}/global/pdp/bvSubmissionPage.jsp"
		});
	</script>
	<script type="text/javascript">
		$BV.ui("rr", "show_reviews", {
			productId : "${productId}",
		});
	</script>
	<div id="BVRRSummaryContainer"></div>
	<div id="BVRRContainer">
	<!-- include contents of 4276-en_us/reviews/product/1/001122.htm if it exists -->
		<%--If it is from cloud , remove this droplet --%>
		<dsp:droplet name="/com/lzb/droplet/BazaarVoiceSEODroplet">
		      <dsp:param name="productId" value="${productId}"/>
	    </dsp:droplet>
	</div>

</dsp:page>