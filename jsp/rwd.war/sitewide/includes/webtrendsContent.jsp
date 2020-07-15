
<dsp:droplet name="/com/lzb/common/droplet/LZBWebTrendContentDroplet">
	<dsp:param name="page" param="page" />
	<dsp:param name="label" param="label" />
	<dsp:oparam name="output">
		<dsp:getvalueof var="cg_n" scope="request" param="WT.cg_n" />
		<dsp:getvalueof var="cg_s" scope="request" param="WT.cg_s" />
	</dsp:oparam>
</dsp:droplet>