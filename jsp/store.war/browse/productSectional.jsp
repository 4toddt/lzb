<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />

version 1.1<br />
debug=<dsp:valueof param="productId" />
	<br />
For Cover selection please see browse/pdp/configurableSkuPdp.jsp, line 230 using LZBSkuOptionSeparator<br />
And doing the Cover on the styleSku configurableSku <br />
	<dsp:droplet name="LZBSectionalPDPPriceDroplet">
		<dsp:param name="sectionalProductId" param="productId" />
		<dsp:param name="coverId" param="coverId" />
		<dsp:param name="dealerId" param="dealerId" />
		<dsp:oparam name="output">
   		ListPrice:<dsp:valueof param="listPrice" converter="currency" />&nbsp;
   		Sale Price: <dsp:valueof param="salePrice" converter="currency" />
		</dsp:oparam>
	</dsp:droplet>
	</br>
	<hr />
	<dsp:droplet name="LZBSectionalDisplayDroplet">
		<dsp:param name="productId" param="productId" />
		<dsp:oparam name="output">
			<hr>
			<dsp:droplet name="Switch">
				<dsp:param name="value" param="LZBStoreConfiguration.jsonOutput" />
				<dsp:oparam name="true">
				json output=<dsp:valueof param="productSectional" />
				</dsp:oparam>
				<dsp:oparam name="false">
				json is not turn on see /atg/store/LZBStoreConfiguration.jsonOutput value <br />
				</dsp:oparam>
			</dsp:droplet>
			<hr>	
         Drawing style options <br />
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="styleSkus" />
				<dsp:param name="elementName" value="stylesku" />
				<dsp:oparam name="output">style skuId=<dsp:valueof	param="stylesku.id" />&nbsp;|
                   defaultStyle=<dsp:valueof param="stylesku.isDfltStyle" />&nbsp;|
                   name=<dsp:valueof param="stylesku.displayName" />&nbsp;|
                   desc=<dsp:valueof param="stylesku.description" />&nbsp;|
                   imagePath=<dsp:valueof param="stylesku.imagePath" />&nbsp;|
                   cdpDefaultImage=<dsp:valueof	param="stylesku.cdpDefaultImage" />&nbsp;|
                   cdpMouseOverImage=<dsp:valueof param="stylesku.cdpMouseOverImage" />&nbsp;|
					<br />
				</dsp:oparam>
			</dsp:droplet>
			<hr>
         Drawing left <br />
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="leftUnits" />
				<dsp:param name="elementName" value="left" />
				<dsp:oparam name="output">      
                   left skuId=<dsp:valueof param="left.id" />&nbsp;|
                   name=<dsp:valueof param="left.displayName" />&nbsp;|
                   desc=<dsp:valueof param="left.description" />&nbsp;|
                   imagePath=<dsp:valueof param="left.imagePath" />&nbsp;|
                   cdpDefaultImage=<dsp:valueof	param="left.cdpDefaultImage" />&nbsp;|
                   cdpMouseOverImage=<dsp:valueof param="left.cdpMouseOverImage" />&nbsp;|
              <dsp:droplet name="LZBSectionalPDPPriceDroplet">
						<dsp:param name="subSkuId" param="left.id" />
						<dsp:param name="dealerId" param="dealerId" />
						<dsp:param name="coverId" param="coverId" />
						<dsp:oparam name="output">
   		ListPrice:<dsp:valueof param="listPrice" converter="currency" />&nbsp;
   		Sale Price: <dsp:valueof param="salePrice" converter="currency" />
						</dsp:oparam>
					</dsp:droplet>
					<br />
				</dsp:oparam>
			</dsp:droplet>
			<hr>			
			
			
        Drawing middle <br />
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="middleUnits" />
				<dsp:param name="elementName" value="middle" />
				<dsp:oparam name="output">     
                  middle skuId=<dsp:valueof param="middle.id" />&nbsp;|
                   name=<dsp:valueof param="middle.displayName" />&nbsp;|
                   desc=<dsp:valueof param="middle.description" />&nbsp;|
                   imagePath=<dsp:valueof param="middle.imagePath" />&nbsp;|
                   cdpDefaultImage=<dsp:valueof	param="middle.cdpDefaultImage" />&nbsp;|
                   cdpMouseOverImage=<dsp:valueof param="middle.cdpMouseOverImage" />&nbsp;|

              <dsp:droplet name="LZBSectionalPDPPriceDroplet">
						<dsp:param name="subSkuId" param="middle.id" />
						<dsp:param name="dealerId" param="dealerId" />
						<dsp:param name="coverId" param="coverId" />
						<dsp:oparam name="output">
   		ListPrice:<dsp:valueof param="listPrice" converter="currency" />&nbsp;
   		Sale Price: <dsp:valueof param="salePrice" converter="currency" />
						</dsp:oparam>
					</dsp:droplet>
					<br />
				</dsp:oparam>
			</dsp:droplet>
			<hr>
			
        Drawing right <br />
			<dsp:droplet name="ForEach">
				<dsp:param name="array" param="rightUnits" />
				<dsp:param name="elementName" value="right" />
				<dsp:oparam name="output">     
                   right skuId=<dsp:valueof param="right.id" />&nbsp;|
                   name=<dsp:valueof param="right.displayName" />&nbsp;|
                   desc=<dsp:valueof param="right.description" />&nbsp;|
                   imagePath=<dsp:valueof param="right.imagePath" />&nbsp;|
                   cdpDefaultImage=<dsp:valueof	param="right.cdpDefaultImage" />&nbsp;|
                   cdpMouseOverImage=<dsp:valueof param="right.cdpMouseOverImage" />&nbsp;|

              <dsp:droplet name="LZBSectionalPDPPriceDroplet">
						<dsp:param name="subSkuId" param="right.id" />
						<dsp:param name="dealerId" param="dealerId" />
						<dsp:param name="coverId" param="coverId" />
						<dsp:oparam name="output">
   		ListPrice:<dsp:valueof param="listPrice" converter="currency" />&nbsp;
   		Sale Price: <dsp:valueof param="salePrice" converter="currency" />
						</dsp:oparam>
					</dsp:droplet>
					<br />
				</dsp:oparam>
			</dsp:droplet>
		</dsp:oparam>
		<hr>
		Drawing Options<br />
		<dsp:droplet name="ForEach">
			<dsp:param name="array" param="productOptions" />
			<dsp:param name="elementName" value="option" />
			<dsp:oparam name="output">
				<hr>
				<p style="bgcolor: yellow">
					option=
					<dsp:valueof param="key" />
				</p>
				<br />
				<dsp:droplet name="ForEach">
					<dsp:param name="array" param="option" />
					<dsp:param name="elementName" value="optionSku" />
					<dsp:oparam name="output"> 
				        Option id=<dsp:valueof param="optionSku.id" />&nbsp;
				                     <dsp:valueof param="optionSku.displayName" />&nbsp;
						<dsp:droplet name="LZBSectionalPDPPriceDroplet">
							<dsp:param name="subSkuId" param="optionSku.id" />
							<dsp:param name="dealerId" param="dealerId" />
							<dsp:param name="coverId" param="coverId" />
							<dsp:param name="isSectionalOptionItem" value="true" />
							<dsp:oparam name="output">
   		ListPrice:<dsp:valueof param="listPrice" converter="currency" />&nbsp;
   		Sale Price: <dsp:valueof param="salePrice" converter="currency" />
							</dsp:oparam>
						</dsp:droplet>
						<br />
					</dsp:oparam>
				</dsp:droplet>
				<hr>

			</dsp:oparam>
		</dsp:droplet>
		<hr>
		<dsp:oparam name="empty">
   Check productId parameter, or product is not found <br />
		</dsp:oparam>
		<dsp:oparam name="error">
   Find error in droplet LZBSectionalDisplayDroplet <br />
		</dsp:oparam>
	</dsp:droplet>
</dsp:page>
