<%@ page contentType="application/json" %>

<dsp:page>
<dsp:importbean bean="/com/lzb/commerce/storeLocator/droplet/LZBStoreLocatorByCoordinatesDroplet"/>	
<dsp:droplet name="LZBStoreLocatorByCoordinatesDroplet">
	<dsp:param name="longitude" param="longitude"  />
	<dsp:param name="latitude" param="latitude"/>
	<dsp:param name="distance" param="distance"/>
	<dsp:param name="sortOption" param="sortOption"/>
		<dsp:oparam name="output">

			<dsp:getvalueof var="nearest" param="nearestStoreJson" />
			<dsp:getvalueof var="sorted" param="sortedStoreJson" />

			[
				{
					"map" : ${nearest}

},{

					"stores" : ${sorted}

				}
			]


		</dsp:oparam>

</dsp:droplet>
</dsp:page>