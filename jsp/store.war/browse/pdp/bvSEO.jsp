
<dsp:page>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfiguration" />
<dsp:importbean bean="/com/lzb/droplet/LZBBazaarVoiceSEOServiceDroplet"/>
<dsp:getvalueof var="prodId" param="productId"/>
<dsp:droplet name="/com/lzb/droplet/LZBBazaarVoiceSEOServiceDroplet">
	<dsp:param name="productId" value="${prodId}"/>
		<dsp:oparam name="output">
			<dsp:getvalueof param="sBvOutputSummary" var="sBvOutputSummary"/>
			<dsp:getvalueof param="sBvOutputReviews" var="sBvOutputReviews"/>
		</dsp:oparam>
</dsp:droplet>

<section id="ratings-reviews">
	<div id="BVRRSummaryContainer">
		${sBvOutputSummary}
	</div>
	<div id="BVRRContainer">
		${sBvOutputReviews}
	</div>
</section>

<script src="${storeConfiguration.baazarVoiceDomain}${storeConfiguration.baazarVoiceJsPath}"></script>
<script type="text/javascript">
		$BV.configure("global", {
			submissionContainerUrl: "${storeConfiguration.hostName}/global/pdp/bvSubmissionPage.jsp"
		});
	</script> 
<script>
	var prodID = "${prodId}";
	$BV.ui("rr","show_reviews",{
		"productId": prodID
	});
	// load questions and answers
	$BV.ui( 'qa', 'show_questions', {
		"productId": prodID // optional if call above has already provided productId
	});
</script>

</dsp:page>
