<dsp:page>
<dsp:importbean bean="/com/lzb/droplet/SectionalOption"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />

version 1.0
<br/>
debug=<dsp:valueof param="productId"/><br/>
debug=<dsp:valueof param="skuId"/><br/>
<br/>
<br/>
<dsp:droplet name="SectionalOption">
<dsp:param name="productId" param="productId"/>
<dsp:oparam name="output">
   <dsp:droplet name="ForEach">
   <dsp:param name="array" param="Left"/>
   <dsp:param name="elementName" value="leftOption"/>
   <dsp:oparam name="output">
        <dsp:valueof param="leftOption.placement"/>
        skuId=<dsp:valueof param="leftOption.skuId"/>

        <dsp:droplet name="SKULookup">
        <dsp:param name="id" param="leftOption.skuId" />
        <dsp:param name="elementName" value="sku" />
        <dsp:oparam name="output">
            <dsp:getvalueof var="skuThumbImg" param="sku.thumbnailImage" />
              ${skuThumbImg}
              <dsp:valueof param="sku.displayName"/>
        </dsp:oparam>
        </dsp:droplet>
        qty=<dsp:valueof param="leftOption.quantity"/><br/>
   </dsp:oparam>
   </dsp:droplet>
   <br/>
   <br/>
   <dsp:droplet name="ForEach">
   <dsp:param name="array" param="Middle"/>
   <dsp:param name="elementName" value="middleOption"/>
   <dsp:oparam name="output">
        <dsp:valueof param="middleOption.placement"/>
        skuId=<dsp:valueof param="middleOption.skuId"/>
        qty=<dsp:valueof param="middleOption.quantity"/><br/>
   </dsp:oparam>
   </dsp:droplet>
   <br/>
   <br/>
   <dsp:droplet name="ForEach">
   <dsp:param name="array" param="Right"/>
   <dsp:param name="elementName" value="rightOption"/>
   <dsp:oparam name="output">
        <dsp:valueof param="rightOption.placement"/>
        skuId=<dsp:valueof param="rightOption.skuId"/>
        qty=<dsp:valueof param="rightOption.quantity"/><br/>
   </dsp:oparam>
   </dsp:droplet>
</dsp:oparam>
<dsp:oparam name="empty">
   Check productId and skuId parameters <br/>
</dsp:oparam>
</dsp:droplet>
</dsp:page>
