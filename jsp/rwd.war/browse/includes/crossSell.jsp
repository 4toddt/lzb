<%--
    - File Name: crossSell.jsp
    - Author(s): DMI UX Team
    - Copyright Notice:
    - Description: This page lays out the Cross Sell Products for You Might Also Like(YMAL) feature for the product and cart pages.
    - Required Parameters:
		- productId: the product record data,
 		- displayHeading: heading text to display,
    - Optional Parameters:
		- relatedProductSet
--%>
<dsp:page>
	<%-- Imports --%>
	<dsp:importbean bean="/com/lzb/droplet/LZBYMLDisplayDroplet" />
	<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
	<dsp:importbean bean="/atg/userprofiling/Profile" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig" />

	<%-- Page Variables --%>
	<dsp:getvalueof var="productId" param="productId"/>
	<dsp:getvalueof var="displayHeading" param="displayHeading"/>
	<dsp:getvalueof var="relatedProductSet" param="relatedProductSet"/>
	<dsp:getvalueof var="dealerId" bean="Profile.currentDealerId" />


	<%-- Render Cross Sell Products --%>
	<dsp:droplet name="LZBYMLDisplayDroplet">
		<dsp:param name="productId" value="${productId}" />
		<dsp:param name="relatedProductSet" value="${relatedProductSet}" />
		<dsp:param name="dealerId" value="${dealerId}" />
		<dsp:oparam name="output">
			<dsp:getvalueof var="crossSellRecords" param="records"/>

			<div class="cross-sell section-row">
				<div class="section-title">
		            <h2>${displayHeading}</h2>
		        </div>

				<div class="section-content slider-content">
					<div class="product-tile-slider">
						<c:forEach var="record" items="${crossSellRecords}" varStatus="status">
							<div>
								<%-- Render Product Tile --%>
								<dsp:include page="/browse/includes/productTile.jsp">
									<dsp:param name="record" value="${record}"/>
					    		</dsp:include>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</dsp:oparam>
		<dsp:oparam name="empty"></dsp:oparam>
	</dsp:droplet>

</dsp:page>