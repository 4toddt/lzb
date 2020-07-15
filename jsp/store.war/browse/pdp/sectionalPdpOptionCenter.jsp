<dsp:page>
	<dsp:importbean bean="/com/lzb/droplet/LZBSectionalDisplayDroplet" />
	<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
	<dsp:importbean bean="/atg/commerce/catalog/SKULookup" />
	<dsp:importbean bean="/atg/store/LZBStoreConfiguration" />
	<dsp:importbean bean="/atg/dynamo/droplet/Switch" />
	<dsp:importbean	bean="/com/lzb/commerce/pricing/droplet/LZBSectionalPDPPriceDroplet" />
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="buildName" param="buildName" />


	<%-- XXXXXXXXXXXXX CENTER CHOICE START XXXXXXXXXXXXXXXX --%>
				<fieldset class="pdp-sectional-pieces-options" id="sectionalCenterOptions">
					<nav class="step-nav">
						<ul>
							<li class="success"><p>1</p><span>Right pieces</span></li>
							<li class="current"><p>2</p><span>Middle pieces</span></li>
							<li><p>3</p><span>Left pieces</span></li>
						</ul>
					</nav>
					<b><p class="padded">Pick multiple center pieces to add to your sectional. Corner pieces are limited to quantity of 3.</p></b>
					<div id="sectionalPiecesConfigCenter" class="sectional-pieces-config" data-module="carousel-sectional-config">

						<dsp:droplet name="ForEach">
							<dsp:param name="array" param="middleUnits" />
							<dsp:param name="elementName" value="middle" />
							<dsp:oparam name="output">
							<dsp:getvalueof var="optionSkuCount" param="index" />
							<dsp:getvalueof var="imagePath" bean="LZBStoreConfiguration.imagePath" />
							<dsp:getvalueof var="thumbImg" param="middle.cdpDefaultImage" />
							<dsp:getvalueof var="imgHostName" bean="LZBStoreConfiguration.contentHostName" />
							<dsp:getvalueof var="sectionalImageId" param="middle.sectionalImageId" />
							<dsp:droplet name="LZBSectionalPDPPriceDroplet">
							<dsp:param name="PDPSectionUnitPrice" value="true" />
							<dsp:param name="subSkuId" param="middle.id" />
							<dsp:param name="dealerId" param="dealer" />
							<dsp:param name="coverId" param="defaultCover"/>
							<dsp:oparam name="output">
								<dsp:getvalueof var="listPrice" param="listPrice" />
								<dsp:getvalueof var="salePrice" param="salePrice" />
								<dsp:getvalueof var="onSale" param="hasSalePrice"/>
							</dsp:oparam>
						</dsp:droplet>
						<dsp:getvalueof var="skuID" param="middle.id" />
						<dsp:getvalueof var="middleDisplayName" param="middle.displayName" />
							<c:if test="${empty imgHostName}">
								<dsp:getvalueof var="imgHostName" value="http://${imgHostName}" />
							</c:if>
							<c:set var="optionSkuChecked" value="" />
							<c:set var="optionQuantity" value="" />
							<dsp:droplet name="ForEach">
								<dsp:param name="array" param="defaultSectStyleMiddle" />
								<dsp:param name="elementName" value="middledefaultUnit" />
								<dsp:oparam name="output">
									<dsp:getvalueof param="middledefaultUnit" var="middleUnit"/>
									<dsp:getvalueof var="middleSubSkuId" value="${middleUnit.subSkuId}" />
									<dsp:getvalueof var="middleQty" value="${middleUnit.qty}" />
										<c:if test="${skuID eq middleSubSkuId}" >
											<c:set var="optionSkuChecked" value="checked='checked'" />
											<c:set var="optionQuantity" value="value='${middleQty}'" />
										</c:if>
								</dsp:oparam>
							</dsp:droplet>
								<div>
									<figure>
										<label for="centerPiecesOpt${optionSkuCount}">
											<img src="http://content.la-z-boy.com/${imagePath}${thumbImg}" alt="thumb" />
										</label>
										<figcaption>
											<fieldset>
												<div class="price-wrapper">
													<p>${middleDisplayName }</p>
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
												<dsp:droplet name="/com/lzb/droplet/LZBCornerSkuLookUpDroplet">
													<dsp:param name="id" value="${sectionalImageId}"/>
													<dsp:param value="cornerImage" name="elementName"/>
													<dsp:oparam name="output">
														<dsp:getvalueof var="cornerElement" param="cornerImage.corner" />
														<div class="pieces-options-selector sectional-center-option">
															<label for="centerPiecesOpt${optionSkuCount}">Add</label>
															<input type="checkbox" id="centerPiecesOpt${optionSkuCount}" data-imageId="${sectionalImageId}" data-skuID="${skuID}" name="center-pieces-option" data-sectional-piece="${middleDisplayName}" data-corner="${cornerElement}" data-sectional-build="${buildName }" value="centerPiecesOpt${optionSkuCount}" ${optionSkuChecked} />
														</div>
														<fieldset class="qty">
															<label for="centerQty${optionSkuCount}">Qty</label>
															<input type="text" class="center-qty-input" id="centerQty${optionSkuCount}" name="center-pieces-qty" ${optionQuantity} data-sectional-piece="${middleDisplayName}" data-checkbox-id="centerPiecesOpt${optionSkuCount}" data-corner="${cornerElement}" data-sectional-build="${buildName }" />
														</fieldset>
														<dsp:getvalueof var="buildName" param="buildName" />
													</dsp:oparam>
												</dsp:droplet>
											</fieldset>
										</figcaption>
									</figure>
								</div>
							</dsp:oparam>
						</dsp:droplet>

					</div><%-- #sectionalPiecesConfigLeft --%>
					<div class="sectional-center-errmsg" style="display:none">You cannot have more than 12 center items.</div>
					<div class="sectional-corner-errmsg" style="display:none">You cannot have more than 3 corner items.</div>
					<div class="control-container">
						<a href="#" data-previous-step="sectionalRightOptions" data-current-step="sectionalCenterOptions">Previous step</a>
						<a class="next-step button secondary-btn" data-next-step="sectionalLeftOptions" data-current-step="sectionalCenterOptions" href="#">Next: Select left pieces</a>
					</div>
				</fieldset><%-- .pdp-sectional-pieces-options --%>

				<%--
				XXXXXXXXXXXX END CENTER XXXXXXXXXXXXXXXXXX
				 --%>

</dsp:page>
