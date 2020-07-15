<dsp:page>
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean bean="/com/lzb/common/LZBBVConfiguration" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
	<dsp:getvalueof var="hostName"value="${storeConfig.hostName}"/>
	<dsp:getvalueof var="securityStatus" bean="/atg/userprofiling/Profile.securityStatus" />
	<dsp:getvalueof var="reviewUrl" bean="LZBBVConfiguration.reviewUrl" />
	<dsp:getvalueof var="requestUrl" bean="/OriginatingRequest.requestURIWithQueryString" scope="page" />
		
	<script type="text/javascript" src="https://${reviewUrl}"></script>	
	<c:set var="encodedRequestUrl" scope="page">
		<lzb:encode value="${requestUrl}" />
	</c:set>
	
	<c:choose>
		<c:when test="${securityStatus < 4}">
			<dsp:getvalueof var="redirectUrl" value="${hostName}/account/login.jsp?Url=${hostName}${encodedRequestUrl}" scope="page" />
			<dsp:droplet name="/atg/dynamo/droplet/Redirect">
				<dsp:param name="url" value="${redirectUrl}" />
			</dsp:droplet>
		</c:when>
		<c:otherwise>	
	
			<dsp:droplet name="/com/lzb/droplet/LZBBazaarVoiceDroplet">
				<dsp:param name="profileId" bean="/atg/userprofiling/Profile.id" />
				<dsp:oparam name="output">
					<dsp:getvalueof var="bvUser" param="bvUser" scope="request" />
					<script type="text/javascript">
						$BV.ui("submission_container", {
							userToken: "${bvUser}"
						});
					</script>
				</dsp:oparam>
			</dsp:droplet>	
			<div id="BVSubmissionContainer"></div>	
			<div id="errormsg"></div>		
		</c:otherwise>
	</c:choose>
</dsp:page>