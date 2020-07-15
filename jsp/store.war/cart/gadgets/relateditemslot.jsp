<dsp:page>

	<dsp:droplet name="/com/lzb/droplet/LZBCrossSellUpSellItemsDroplet">
		<dsp:oparam name="empty">
			<!-- empty  -->
		</dsp:oparam>
	  <dsp:oparam name="output">
			<dsp:include page="/browse/ymal.jsp">
				<dsp:param name="relatedProductSet" param="products"/>
				<dsp:param name="displayMessage" value="Customers Also Liked"/>
				<dsp:param name="cartRequest" value="${true}"/>
				<dsp:param name="numToShow" value="3" />
				<dsp:param name="numToScroll" value="3" />
			</dsp:include>
		</dsp:oparam>
	</dsp:droplet>

</dsp:page>

