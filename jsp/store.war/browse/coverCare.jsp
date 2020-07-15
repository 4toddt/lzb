<dsp:importbean bean="/com/lzb/commerce/droplet/LZBCoverCareDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>

<dsp:page>

<dsp:droplet name="LZBCoverCareDroplet">
	<dsp:param name="coverId" param="coverId" />
	<dsp:oparam name="output">	    
	    <h3>Description : <dsp:valueof param="coverCareInfo.description" /></h3>
	    <dsp:droplet name="ForEach">
			<dsp:param name="array" param="coverCareInfo.coverCares" />
			<dsp:param name="elementName" value="coverCare" />
			<dsp:oparam name="output">
				<h4>Name : <dsp:valueof param="coverCare.careText" /></h4>
				<h4>Image : <dsp:valueof param="coverCare.imageName" /></h4>
				<h4>Performance : <dsp:valueof param="coverCare.isPerformance" /></h4>
				<h4>CleaningCodes : 
				    <dsp:droplet name="ForEach">
				  	<dsp:param name="array" param="coverCare.cleaningCodes" />
					<dsp:param name="elementName" value="cleaningCode" />
						<dsp:oparam name="output">
							<dsp:valueof param="cleaningCode" /><br/>
						</dsp:oparam>
					</dsp:droplet>
				</h4>
				<h4>WearabilityCodes : 
				    <dsp:droplet name="ForEach">
				  	<dsp:param name="array" param="coverCare.wearabilityCodes" />
					<dsp:param name="elementName" value="wearabilityCode" />
						<dsp:oparam name="output">
							<dsp:valueof param="wearabilityCode" /><br/>
						</dsp:oparam>
					</dsp:droplet>
				</h4>
				
			</dsp:oparam>
		</dsp:droplet>
	</dsp:oparam>
	<dsp:oparam name="empty">
	    No Cover Associated
	</dsp:oparam>
</dsp:droplet>




</dsp:page>