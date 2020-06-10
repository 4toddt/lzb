<dsp:importbean bean="/com/lzb/commerce/droplet/LZBImagePathDroplet"/>

<dsp:page>

<dsp:droplet name="/com/lzb/commerce/droplet/LZBImagePathDroplet">
	<dsp:param name="imPath" param="imPath" />
	<dsp:oparam name="output">	    
	    <h3>Small Img : <dsp:valueof param="smallImgUrl" /></h3>
	    <h3>Medium Img : <dsp:valueof param="mediumImgUrl" /></h3>
	    <h3>Img : <dsp:valueof param="defaultImgUrl" /></h3>
	   	<img src="//${defaultImUrl}" alt="${displayName}" id='<dsp:valueof param="imPath" />'/>
	   
	</dsp:oparam>
	<dsp:oparam name="empty">
	    No Image Path
	</dsp:oparam>
</dsp:droplet>




</dsp:page>