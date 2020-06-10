<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="buildName" param="buildName" />
	<dsp:getvalueof var="leftUnit" param="defaultSectStyleLeft" />

<%-- XXXXXXXXXXXXX LEFT CHOICE START XXXXXXXXXXXXXXXX --%>
				<fieldset class="pdp-sectional-pieces-options" id="sectionalLeftOptions">
					<nav class="step-nav">
						<ul>
							<li class="success"><p>1</p><span>Right pieces</span></li>
							<li class="success"><p>2</p><span>Middle pieces</span></li>
							<li class="current"><p>3</p><span>Left pieces</span></li>
						</ul>
					</nav>
					<b><p class="padded">Pick only one (1) left piece to add to your sectional.</p></b>
					<div id="sectionalPiecesConfigLeft" class="sectional-pieces-config" data-module="carousel-sectional-config">


					<dsp:droplet name="ForEach">
						<dsp:param name="array" param="leftUnits" />
						<dsp:param name="elementName" value="left" />
						<dsp:oparam name="output">

							<dsp:getvalueof var="optionSkuCount" param="index" />
							<dsp:getvalueof var="optionSkuCount" value="${optionSkuCount + 1}" />
							<dsp:getvalueof var="imagePath" bean="LZBStoreConfiguration.imagePath" />
							<dsp:getvalueof var="thumbImg" param="left.cdpDefaultImage" />
							<dsp:getvalueof var="imgHostName" bean="LZBStoreConfiguration.contentHostName" />
							<dsp:getvalueof var="sectionalImageId" param="left.sectionalImageId" />

							<dsp:droplet name="LZBSectionalPDPPriceDroplet">
								<dsp:param name="PDPSectionUnitPrice" value="true" />
								<dsp:param name="subSkuId" param="left.id" />
								<dsp:param name="dealerId" param="dealer" />
								<dsp:param name="coverId" param="defaultCover"/>
								<dsp:oparam name="output">
									<dsp:getvalueof var="listPrice" param="listPrice" />
									<dsp:getvalueof var="salePrice" param="salePrice" />
									<dsp:getvalueof var="onSale" param="hasSalePrice"/>
								</dsp:oparam>
							</dsp:droplet>




							<dsp:getvalueof var="skuID" param="left.id" />
							<dsp:getvalueof var="leftDisplayName" param="left.displayName" />


							<c:if test="${empty imgHostName}">
								<dsp:getvalueof var="imgHostName" value="http://${imgHostName}" />
							</c:if>

							<c:set var="optionSkuChecked" value="" />

							<%-- /////leftUnit = ${leftUnit.subSkuId}<br>
							/////left id = ${skuID} --%>

<!-- skuId = ${skuID} : leftUnit.subSkuId = ${leftUnit.subSkuId} -->

							<c:choose>
								<c:when test="${not empty leftUnit}">
									<c:if test="${skuID eq leftUnit.subSkuId}" >
										<c:set var="optionSkuChecked" value="checked='checked'" />
									</c:if>
								</c:when>
								<c:otherwise>
									<c:if test="${optionSkuCount eq 1}" >
										<c:set var="optionSkuChecked" value="checked='checked'" />
									</c:if>
								</c:otherwise>
							</c:choose>

								<div>
									<figure>
										<label for="left-pieces-opt${optionSkuCount}">
											<img src="http://content.la-z-boy.com/${imagePath}${thumbImg}" alt="thumb" />
										</label>
										<figcaption>
											<fieldset>
												<div class="price-wrapper">
													<p>${leftDisplayName }</p>
													<c:choose>
													<c:when test="${onSale}">
													<span class="pdp-item-price-label on-sale"><dsp:valueof value="${listPrice}" converter="currency" /></span>
													<span class="pdp-sale-price-label">Now</span> <span class="pdp-sale-price"><dsp:valueof value="${salePrice}" converter="currency" /></span>
													</c:when>
													<c:otherwise>
													<span class="pdp-sale-price"><dsp:valueof value="${listPrice}" converter="currency" /></span>
													</c:otherwise>
													</c:choose>
												</div>
												<div class="pieces-options-selector sectional-left-option">
													<label for="left-pieces-opt${optionSkuCount}">Add</label>
													<input type="radio" id="left-pieces-opt${optionSkuCount}" data-imageId="${sectionalImageId}" data-skuID="${skuID}" data-sectional-piece="${leftDisplayName}" data-sectional-build="${buildName }" name="left-pieces-option" value="left-pieces-option${optionSkuCount}" ${optionSkuChecked} />
												</div>
											</fieldset>
										</figcaption>
									</figure>
								</div>
							</dsp:oparam>

						</dsp:droplet><%-- for each --%>


					</div><%-- #sectionalPiecesConfigLeft --%>
					<div class="control-container">
						<a href="#" data-previous-step="sectionalCenterOptions" data-current-step="sectionalLeftOptions">Previous step</a>
					</div>
				</fieldset><%-- .pdp-sectional-pieces-options --%>

				<%--XXXXXXXXXXXX END LEFT XXXXXXXXXXXXXXXXXX--%>

</dsp:page>
