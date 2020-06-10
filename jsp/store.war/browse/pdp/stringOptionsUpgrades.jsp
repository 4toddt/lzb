<dsp:page>
<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
<dsp:importbean bean="/atg/commerce/order/purchase/CartModifierFormHandler" />

<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:importbean bean="/atg/commerce/pricing/priceLists/PriceListManager" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/com/lzb/droplet/LZBItemJsonRequestDroplet" />
<dsp:importbean bean="/com/lzb/droplet/LZBPDPURLDroplet" />
<dsp:importbean bean="/atg/commerce/gifts/GiftlistFormHandler" />
<dsp:importbean bean="/com/lzb/service/SessionBean"/>
<dsp:importbean bean="/com/lzb/droplet/LZBSKUCoverParserDroplet"/>
<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
<dsp:getvalueof var="cotextPath" value="${originatingRequest.ContextPath}" />
<dsp:getvalueof value="${storeConfig.defaultUSDealer}" var="defaultUSDealer"/>
<dsp:getvalueof value="${storeConfig.defaultCANDealer}" var="defaultCANDealer"/>
<dsp:getvalueof var="currentLocale" vartype="java.lang.String" bean="/atg/dynamo/servlet/RequestLocale.localeString"/>
<dsp:getvalueof var="dealerId" bean="/atg/userprofiling/ProfileTools.priceListId" />
<dsp:getvalueof var="productRecord" param="productRecord" />

<c:set var="contentHostName" value="//content.la-z-boy.com"/>
<div id="optionsUpgrades" class="tab-content" data-module="showPDPOptionSwatches">
	<c:forEach items="${fn:split(productRecord['sku.configurableOptionNames'],'|')}" var="parentOptionName">
		<c:if test="${parentOptionName ne 'Cover'}">
			<div class="pdp-block-container accordion" data-module="accordion">
				<c:set var="option" value="${productRecord[parentOptionName]}" />
				<h2 class="pdp-block-title" data-optionname="${parentOptionName}">${parentOptionName}</h2>
				<div class="pdp-block options-upgrades">
					<c:forEach items="${fn:split(option,'++')}" var="subOption" varStatus="i">
						<dsp:valueof param="configOptionGroupOption.sku.displayName" />
						<c:choose>
							<c:when test="${fn:contains(subOption,'=') eq true }">
								<c:if test="${parentOptionName eq 'Pillow Options' and i.index eq 0}">
									<p><strong>Select option for included pillows</strong></h4>
									<p>Inform the shopper that they can customize the set of pillows that are included with the product</p>
									<div class="pillow-options-sets" data-module="toggle" style="position:relative;">
										<p class="set toggle minus"><strong>SET 1</strong></p>
										<div>
											<h4><strong>PILLOW FABRIC</strong></h4>
											<p>Short instruction on how to select the pillow edge treatment</p>
											<input class="option same-as-coverfabric" name="same-as-coverfabric" type="checkbox" value="true" checked data-module="toggle" />
											<label for="same-as-coverfabric">Same as the selected cover fabric</label>
											<hr />
											<section class="pillow-fabric-selection pillow-fabric-selection-P1">
								</c:if>
								<c:if test="${parentOptionName eq 'Pillow Options' and i.index eq 1}">
									<div class="pillow-options-sets" data-module="toggle">
										<p class="set toggle"><strong>SET 2</strong></p>
										<div>
											<h4><strong>PILLOW FABRIC</strong></h4>
											<p>Short instruction on how to select the pillow edge treatment</p>
											<input class="option same-as-coverfabric" name="same-as-coverfabric" type="checkbox" value="true" checked data-module="toggle" />
											<label for="same-as-coverfabric">Same as the selected cover fabric</label>
											<hr />
											<section class="pillow-fabric-selection pillow-fabric-selection-P2">
								</c:if>
								<h3 data-optionitem="${fn:split(subOption,'~')[0] }"><c:out value="${fn:split(subOption,'~')[0] }" /></h3>
								<c:if test ="${not empty fn:split(subOption,'~')[1] && fn:split(subOption,'~')[1] ne 'null'}">
									<p><c:out value="${fn:split(subOption,'~')[1] }"/></p>
								</c:if>
								<div class="swatch-options custom" data-module="pdp-carousel" data-slides-to-show="3" data-slide="figure" data-slides-to-scroll="3">
									<div class="wrapper">
										<c:forEach var="optionVal" items="${fn:split(fn:split(subOption,'=')[1],'|') }">
											<c:choose>
												<c:when test="${not empty fn:split(optionVal,'~')[7] && 'null' ne fn:split(optionVal,'~')[7] }">
													<%-- Finish option start --%>
													<c:set var="finishOptionsName" value="${fn:split(optionVal,'~')[7]}" />
													<c:set var="finishOptionsSkuId" value="${fn:split(optionVal,'~')[0]}" />
													<c:set var="finishOptions"  value="${productRecord[finishOptionsName]}" />
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />

													<figure class="options">
														<c:set var="optionName" value="${fn:split(optionVal,'~')[2]}" />
														<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
															<img src="${fn:split(finishOption,'~')[3]}" alt="" />
														</c:if>

														<input type="radio" name="Finish Options" class="option" data-price="${optionPromoValPrice}" data-type="optionFinish"
															data-value="${finishOptionsSkuId}" value="${finishOptionsSkuId}"
															<c:if test="${fn:contains(optionName, 'Standard') and optionValPrice eq '0'}">
																checked="true"
															</c:if>
														/>
														<label>
															${fn:split(optionVal,'~')[2]}&nbsp;${fn:split(optionVal,'~')[3]}
															<c:choose>
																<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																	<strong>${formatOptionPromoValPrice}</strong>
																</c:when>
																<c:otherwise>
																	<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																		<strong>${formatOptionValPrice}</strong>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</label>
													</figure>
													<c:forEach items="${fn:split(finishOptions,'|') }" var="finishOption">
														<c:set var="optionName" value="${fn:split(finishOption,'~')[1]}" />
														<figure class="options">
															<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
																<img src="${fn:split(finishOption,'~')[3]}" alt="" />
															</c:if>
															<input type="radio" name="Finish Options" class="option" data-price="${optionPromoValPrice}" data-type="optionFinish"
																data-value="${fn:split(finishOption,'~')[0]}" value="${finishOptionsSkuId}"
																<c:if test="${fn:contains(optionName, 'Standard') and optionValPrice eq '0'}">
																	checked="true"
																</c:if>
															/>
															<label>
																${fn:split(finishOption,'~')[1]}
																<c:choose>
																	<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																		<strong>${formatOptionPromoValPrice}</strong>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																			<strong>${formatOptionValPrice}</strong>
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</label>
														</figure>
													</c:forEach>

													<%-- Finish option end --%>

												</c:when><%-- not empty fn:split(optionVal,'~')[7] && 'null' ne fn:split(optionVal,'~')[7]  --%>
												<c:when test="${not empty fn:split(optionVal,'~')[8] && 'null' ne fn:split(optionVal,'~')[8] }">
													<c:set var="optionValuesName" value="${fn:split(optionVal,'~')[8]}" />
													<c:set var="optionValues"  value="${productRecord[optionValuesName]}" />
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />
													<c:set var="optionName" value="${fn:split(optionVal,'~')[2]}" />
													<figure class="options">
														<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
															<img src="${fn:split(finishOption,'~')[3]}" alt="" />
														</c:if>
														<input type="radio" name="${optionValuesName}" class="option" data-value="${fn:split(optionVal,'~')[0]}" value="${fn:split(optionVal,'~')[0]}"
															<c:if test="${fn:contains(optionName, 'Standard') and optionValPrice eq '0'}">
																checked="true"
															</c:if>
														/>
														<label for="optionskuid">
															${fn:split(optionVal,'~')[2]}&nbsp;${fn:split(optionVal,'~')[3]}
															<img src="${fn:split(optionVal,'~')[5]}" alt="" />
															<c:choose>
																<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																	<strong>${formatOptionPromoValPrice}</strong>
																</c:when>
																<c:otherwise>
																	<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																		<strong>${formatOptionValPrice}</strong>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</label>
													</figure>
													<c:forEach items="${fn:split(optionValues,'|') }" var="optionValuesItem">
													<c:if test="${not empty optionValuesItem}">
														<figure class="options">
															<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
																<img src="${fn:split(finishOption,'~')[3]}" alt="" />
															</c:if>
															<input type="radio" name="${optionValuesName}" class="option" data-value="${optionValPrice}" value="${optionValPrice}"
																<c:if test="${fn:contains(optionValuesItem, 'Standard') and optionValPrice eq '0'}">
																	checked="true"
																</c:if>
															/>
															<label for="optionskuid">
																${optionValuesItem}
																<c:choose>
																	<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																		<strong>${formatOptionPromoValPrice}</strong>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																			<strong>${formatOptionValPrice}</strong>
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</label>
														</figure>
														</c:if>
													</c:forEach>
												</c:when><%-- not empty fn:split(optionVal,'~')[8] && 'null' ne fn:split(optionVal,'~')[8] --%>
												<c:otherwise>
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />
													<c:set var="optionName" value="${fn:split(optionVal,'~')[2]}" />
													<figure class="options otherwise">
														<input type="radio" name="${fn:split(subOption,'~')[0] }"  class="option" data-price="${optionPromoValPrice}" data-value="${fn:split(optionVal,'~')[0]}"
																value="${fn:split(optionVal,'~')[0]}" data-parentoption="${parentOptionName}"
															<c:if test="${fn:contains(optionName, 'Standard') or fn:contains(optionName, 'None') and optionValPrice eq '0'}">
																checked="true"
															</c:if>
														/>
														<c:if test="${not empty fn:split(optionVal,'~')[5] and fn:split(optionVal,'~')[5] ne 'null'}">
															<img src="${fn:split(optionVal,'~')[5]}" alt="${fn:split(optionVal,'~')[2]}" />
														</c:if>
														<label for="${fn:split(subOption,'~')[0] }">
															${fn:split(optionVal,'~')[2]}
															<c:choose>
																<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																	<strong>${formatOptionPromoValPrice}</strong>
																</c:when>
																<c:otherwise>
																	<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																		<strong>${formatOptionValPrice}</strong>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</label>
													</figure>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
								<c:forEach var="optionVal" items="${fn:split(fn:split(subOption,'=')[1],'|') }">
									<c:set var="optionCode"  value="${fn:split(optionVal,'~')[1]}" />
									<c:choose>
										<c:when test="${not empty fn:split(optionVal,'~')[6] && 'null' ne fn:split(optionVal,'~')[6] }">
											<c:set var="optionCoverName"  value="${fn:split(optionVal,'~')[6]}" />
											<dsp:getvalueof value="${optionCoverName}.noOfCovers"  var="numberOfCover" />

											<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
												<dsp:param name="skuCoverList" value="${productRecord[optionCoverName]}" />
												<dsp:param name="optionCovers" value="true" />
												<dsp:oparam name="output">
													<dsp:getvalueof param="coverColor" var="coverColor" />
													<dsp:getvalueof param="coverPattern"  var="coverPattern" />
													<div class="custom-swatch-options" data-optionname="${fn:split(optionVal,'~')[0]}">
														<div class="instructions">
															<p>Select a contrasting fabric below</p>
														</div>
														<c:if test="${ not empty productRecord[numberOfCover]}">
															<p>${productRecord[numberOfCover]}&nbsp;${parentOptionName}&nbsp;available</p>
														</c:if>
														<form action="#">
															<select name="color">
																<option value="color"><fmt:message  key="pdp.color" /></option>
																<c:forEach items="${coverColor }" var="color">
																	<option value="${color }">${color }</option>
																</c:forEach>
															</select>
															<select name="pattern">
																<option value="pattern"><fmt:message key="pdp.pattern" /></option>
																<c:forEach items="${coverPattern }" var="pattern">
																	<option value="${pattern }">${pattern }</option>
																</c:forEach>
															</select>
														</form>
														<div class="swatch-options custom" data-module="pdp-carousel" data-slides-to-show="1" data-slide="section" data-slides-to-scroll="1">
															<div class="wrapper">
																<dsp:getvalueof param="coverOptionList"  var="coverOptionList" />
																<c:forEach items="${fn:split(productRecord[optionCoverName],'|')}" var="optionCover" varStatus="i">
																	<c:if test="${i.index eq 0 }">
																		<section class="swatches options" style="width:400px;height:500px;">
																	</c:if>

																	<div style="width:100px;float:left;">
																		<input type="radio" class="option" data-type="optionCover" name="Welt" data-value="${fn:split(optionCover,'~')[0]}" value="${fn:split(optionCover,'~')[0]}">
																		<label>
																			<img class="swatch-image" src="${contentHostName }${storeConfig.coverThumbnailBaseUrl }${fn:split(optionCover,'~')[0]}.jpg" height="50" width="50" alt="${fn:split(optionCover,'~')[2]}" />
																		</label>
																		<!-- <img src="${storeConfig.hostName }${storeConfig.coverLargeviewBaseUrl }${fn:split(optionCover,'~')[0]}.jpg" height="50" width="50" alt="${fn:split(optionCover,'~')[2]}" /> -->
																	</div>

																	<c:if test="${i.index ne 0 and (i.index%30 eq 0 )}">
																		</section>
																		<section class="swatches options" style="width:400px;height:500px;">
																	</c:if>
																</c:forEach>
															</div>
														</div>
													</div>
												</dsp:oparam>
												<dsp:oparam name="empty">
													Empty
												</dsp:oparam>
											</dsp:droplet>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${parentOptionName eq 'Pillow Options' and (i.index eq 0 or i.index eq 1)}">
											</section>
										</div>
									</div>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:forEach var="optionVal" items="${fn:split(subOption,'|') }">
									<c:choose>
										<c:when test="${not empty fn:split(optionVal,'~')[6] && 'null' ne fn:split(optionVal,'~')[6] }">
											<c:set var="optionCoverName"  value="${fn:split(optionVal,'~')[6]}" />
											<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
												<dsp:param name="skuCoverList" value="${productRecord[optionCoverName]}" />
												<dsp:param name="optionCovers" value="true" />
												<dsp:oparam name="output">
													<dsp:getvalueof param="coverColor" var="coverColor" />
													<dsp:getvalueof param="coverPattern"  var="coverPattern" />
													<form action="">
														<select name="color">
															<option value="color">
																<fmt:message  key="pdp.color" />
															</option>
															<c:forEach items="${coverColor }" var="color">
																<option value="${color }">${color }</option>
															</c:forEach>
														</select>
														<select name="pattern">
															<option value="pattern">
																<fmt:message key="pdp.pattern" />
															</option>
															<c:forEach items="${coverPattern }" var="pattern">
																<option value="${pattern }">${pattern }</option>
															</c:forEach>
														</select>
													</form>
													<dsp:getvalueof param="coverOptionList"  var="coverOptionList" />
													<div class="swatch-options custom" data-module="pdp-carousel" data-slides-to-show="3" data-slide="figure" data-slides-to-scroll="1">
														<div class="wrapper">
															<c:forEach items="${fn:split(productRecord[optionCoverName],'|')}" var="optionCover">
																<a  href="javascript:void(0)" class="option" id="${fn:split(optionCover,'~')[0]}"
																	data-type="optionCover" data-value="${fn:split(optionCover,'~')[0]}"
																	value="${fn:split(optionCover,'~')[0]}"
																	title="${fn:split(optionCover,'~')[0]}" style="text-decoration:none"  >
																	<img src="${contentHostName }${storeConfig.coverThumbnailBaseUrl }${fn:split(optionCover,'~')[0]}.jpg" height="50" width="50" alt="${fn:split(optionCover,'~')[2]}"/>
																	<img src="${contentHostName}${storeConfig.coverLargeviewBaseUrl }${fn:split(optionCover,'~')[0]}.jpg" height="50" width="50" alt="${fn:split(optionCover,'~')[2]}" style="display:none;"/>
																</a>&nbsp;&nbsp;
															</c:forEach>
														</div>
													</div>
												</dsp:oparam>
												<dsp:oparam name="empty">
													Empty
												</dsp:oparam>
											</dsp:droplet>
										</c:when>
									</c:choose>
								</c:forEach>
								<div class="swatch-options custom" data-module="pdp-carousel" data-slides-to-show="3" data-slide="figure" data-slides-to-scroll="1">
									<div class="wrapper">
										<c:forEach var="optionVal" items="${fn:split(subOption,'|') }">
											<c:choose>
												<c:when test="${not empty fn:split(optionVal,'~')[7] && 'null' ne fn:split(optionVal,'~')[7] }">

													<c:set var="finishOptionsName" value="${fn:split(optionVal,'~')[7]}" />
													<c:set var="finishOptions"  value="${productRecord[finishOptionsName]}" />
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />
													<figure class="options">
														<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
															<img src="${fn:split(finishOption,'~')[3]}" alt="" />
														</c:if>
														<input type="radio" name="Finish Options" class="option" data-price="${optionPromoValPrice}" data-type="optionFinish"
															data-value="${fn:split(finishOption,'~')[0]}" value="${fn:split(finishOption,'~')[0]}" />
														<label>
															${fn:split(optionVal,'~')[2]}&nbsp;${fn:split(optionVal,'~')[3]}
															<c:choose>
																<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																	<strong>${formatOptionPromoValPrice}</strong>
																</c:when>
																<c:otherwise>
																	<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																		<strong>${formatOptionValPrice}</strong>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</label>
													</figure>
													<c:forEach items="${fn:split(finishOptions,'|') }" var="finishOption">
														<figure class="options">
															<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
																<img src="${fn:split(finishOption,'~')[3]}" alt="" />
															</c:if>
															<input type="radio" name="Finish Options" class="option" data-price="${optionPromoValPrice}" data-type="optionFinish"
																data-value="${fn:split(finishOption,'~')[0]}" value="${fn:split(finishOption,'~')[0]}" />
															<label>
																${fn:split(finishOption,'~')[1]}
																<c:choose>
																	<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																		<strong>${formatOptionPromoValPrice}</strong>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																			<strong>${formatOptionValPrice}</strong>
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</label>
														</figure>
													</c:forEach>
												</c:when>
												<c:when test="${not empty fn:split(optionVal,'~')[8] && 'null' ne fn:split(optionVal,'~')[8]}">
													<c:set var="optionValuesName" value="${fn:split(optionVal,'~')[8]}" />
													<c:set var="optionValues"  value="${productRecord[optionValuesName]}" />
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />
													<figure class="options">
														<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
															<img src="${fn:split(finishOption,'~')[3]}" alt="" />
														</c:if>
														<input type="radio" name="${optionValuesName}" class="option" data-value="${optionValuesItem}" value="${optionValuesItem}"/>
														<label for="optionskuid">
															${fn:split(optionVal,'~')[2]}&nbsp;${fn:split(optionVal,'~')[3]}
															<c:if test="${not empty fn:split(optionVal,'~')[4] && fn:split(optionVal,'~')[4] ne 'null'}">
																${fn:split(optionVal,'~')[4]}
															</c:if>
														</label>
													</figure>
													<c:forEach items="${fn:split(optionValues,'|') }" var="optionValuesItem">
														<figure class="options">
															<c:if test="${not empty fn:split(finishOption,'~')[3] and fn:split(finishOption,'~')[3] ne 'null'}">
																<img src="${fn:split(finishOption,'~')[3]}" alt="" />
															</c:if>
															<input type="radio" name="${optionValuesName}" class="option" data-value="${optionValuesItem}" value="${optionValuesItem}"/>
															<label for="optionskuid">
																${optionValuesItem}
																<c:choose>
																	<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																		<strong>${formatOptionPromoValPrice}</strong>
																	</c:when>
																	<c:otherwise>
																		<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																			<strong>${formatOptionValPrice}</strong>
																		</c:if>
																	</c:otherwise>
																</c:choose>
															</label>
														</figure>
													</c:forEach>
												</c:when>
												<c:otherwise>
												<%-- this sectiona is rendering the logic which is of configurableProperty type for Ex: Cushion option,Nail Head option --%>
													<fmt:parseNumber var="optionValPrice" value="${fn:split(optionVal,'~')[3]}"/>
													<fmt:formatNumber var="formatOptionValPrice" value="${optionValPrice}" type="currency" />
													<fmt:parseNumber var="optionPromoValPrice" value="${fn:split(optionVal,'~')[4]}"/>
													<fmt:formatNumber var="formatOptionPromoValPrice" value="${optionPromoValPrice}" type="currency" />
													<c:set var="optionName" value="${fn:split(optionVal,'~')[2]}" />
													<figure class="options otherwise">
														<input type="radio" name="${fn:split(subOption,'~')[0] }"  class="option" data-price="${optionPromoValPrice}" data-value="${fn:split(optionVal,'~')[0]}"
															value="${fn:split(optionVal,'~')[0]}" data-parentoption="${parentOptionName}"
															<c:if test="${fn:contains(optionName, 'Standard') and optionValPrice eq '0'}">
																checked="true"
															</c:if>
														/>
														<c:if test="${not empty fn:split(optionVal,'~')[5] and fn:split(optionVal,'~')[5] ne 'null'}">
															<img src="${fn:split(optionVal,'~')[5]}" alt="${fn:split(optionVal,'~')[2]}" />
														</c:if>
														<label for="${fn:split(subOption,'~')[0] }">
															${fn:split(optionVal,'~')[2]}
															<c:choose>
																<c:when test="${formatOptionPromoValPrice ne '$0.00' and formatOptionPromoValPrice ne null}">
																	<strong>${formatOptionPromoValPrice}</strong>
																</c:when>
																<c:otherwise>
																	<c:if test="${formatOptionValPrice ne '$0.00' and formatOptionValPrice ne null}">
																		<strong>${formatOptionValPrice}</strong>
																	</c:if>
																</c:otherwise>
															</c:choose>
														</label>
													</figure>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${parentOptionName eq 'Pillow Options' }">
						<c:if test="${not empty productRecord['configurableSku.addPillowSet1'] && not empty productRecord['configurableSku.addPillowSet2'] }">
							<h3>Additional Pillows</h3>
							<form action="">
								<input type="radio" value="false" name="additional-pillow" checked></input> <label for="additional-pillow">No</label>
								<input type="radio" value="true" name="additional-pillow"></input> <label for="additional-pillow">Yes</label><br/>
								<p><b>Pillow Style</b></p>
								<input type="radio" value="${productRecord['configurableSku.addPillowSet1'] }" name="additional-pillow-style" checked></input> <label for="additional-pillow-style">Same as Set 1 style</label>
								<input type="radio" value="${productRecord['configurableSku.addPillowSet2'] }" name="additional-pillow-style"></input> <label for="additional-pillow-style">Same as Set 2 style</label>
								<select name="pillowQuantity" >
									<option name="">Quantity</option>>
									<option name="2">2</option>
									<option name="3">3</option>
									<option name="4">4</option>
									<option name="5">5</option>
									<option name="6">6</option>
									<option name="7">7</option>
									<option name="8">8</option>
									<option name="9">9</option>
									<option name="10">10</option>
								</select>
							</form>
						</c:if>
					</c:if>
				</div>
			</div>
		</c:if>

	</c:forEach>
</div><%-- optionsUpgrades --%>





</dsp:page>