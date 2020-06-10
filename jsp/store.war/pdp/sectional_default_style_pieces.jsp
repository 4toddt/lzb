<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
<dsp:page>
	<dsp:droplet name="LZBSectionalDisplayDroplet">
	<dsp:param name="skuId" param="styleSkuId"  />
	<dsp:param name="isJsonOutput" value="true"/>
		<dsp:oparam name="output">
		<dsp:valueof param="defaultSectionalStyleSkuPiecesJson"/>
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>