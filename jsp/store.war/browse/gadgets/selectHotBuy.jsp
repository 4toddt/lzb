<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/droplet/LZBSelectHotBuyDroplet"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>



<dsp:page>
	
	
	<dsp:droplet name="LZBSelectHotBuyDroplet">
		<dsp:param name="dealerId" value="1179039"  />
		<dsp:param name="configSkuId" value="40A420"/>
		<dsp:param name="profile" bean="Profile"/>
		<dsp:oparam name="select">
		    <h2>Selects</h2>
			<dsp:droplet name="ForEach">
			<dsp:param name="array" param="selects" />
			<dsp:param name="elementName" value="select" />
				<dsp:oparam name="output">
				  	Config Sku - <dsp:valueof param="select.configSku.displayName"/>:::
				  	Cover - <dsp:valueof param="select.cover.displayName"/>:::options{
				    <dsp:droplet name="ForEach">
					<dsp:param name="array" param="select.options" />
					<dsp:param name="elementName" value="option" />
						<dsp:oparam name="output">
						  	<dsp:valueof param="option.optionCode"/>-
						</dsp:oparam>
					</dsp:droplet>
					}<br/>
				    List Price : <dsp:valueof param="select.listPrice"/>  <br/>
				    Sale Price : <dsp:valueof param="select.salePrice"/>  <br/>
				    Exception Id : <dsp:valueof param="select.exceptionId"/>  <br/>
				    
				</dsp:oparam>
			</dsp:droplet>
			<br/>
		</dsp:oparam>
		<dsp:oparam name="hotBuy">
		    <br/><h2>Hot Buys</h2>
			<dsp:droplet name="ForEach">
			<dsp:param name="array" param="hotBuys" />
			<dsp:param name="elementName" value="hotBuy" />
				<dsp:oparam name="output">
				    Config Sku - <dsp:valueof param="hotBuy.configSku.displayName"/>:::
				  	Cover - <dsp:valueof param="hotBuy.cover.displayName"/>:::options{
				    <dsp:droplet name="ForEach">
					<dsp:param name="array" param="hotBuy.options" />
					<dsp:param name="elementName" value="option" />
						<dsp:oparam name="output">
						  	<dsp:valueof param="option.optionCode"/>-
						</dsp:oparam>
					</dsp:droplet>
					}<br/>
				    List Price : <dsp:valueof param="hotBuy.listPrice"/>  <br/>
				    Sale Price : <dsp:valueof param="hotBuy.salePrice"/>  <br/>
				    Exception Id : <dsp:valueof param="hotBuy.exceptionId"/>  <br/>
				</dsp:oparam>
			</dsp:droplet>
		    <br/>	
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>