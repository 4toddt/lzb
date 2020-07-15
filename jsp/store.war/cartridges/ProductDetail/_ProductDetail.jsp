<dsp:page>
	<dsp:importbean bean="/OriginatingRequest" var="originatingRequest" />
	<dsp:getvalueof var="content" vartype="com.endeca.infront.assembler.ContentItem" value="${originatingRequest.contentItem}" />
	<dsp:getvalueof var="productRecord" value="${content.record.attributes}" />
	<dsp:importbean bean="/com/lzb/service/SessionBean"/>
	<dsp:getvalueof var="currencyCode" bean="SessionBean.currencycode"/>
	<dsp:importbean bean="/atg/userprofiling/Profile" />
    <dsp:getvalueof var="dealerCountry" bean="Profile.currentStore.country"/>
    
	<section role="region">
		<c:if test="${content['@type'] eq 'ProductDetail'}">
			<c:if test="${not empty productRecord['product.displayName']}">
				<h1 class="pdp-title">${productRecord['product.displayName']}</h1>
			</c:if>
			<c:if test="${not empty productRecord['styleNumber']}">
				<p><b><fmt:message key="pdp.styleNumber" /> ${productRecord['styleNumber']}</b></p>
			</c:if>
		</c:if>
		<div id="pdpDescriptionBlock" class="pdp-block-container accordion" data-module="accordion">
			<h2 class="pdp-block-title"><b><fmt:message key="pdp.description" /></b></h2>
			<div id="pdpDescription" class="pdp-block">
				<p>${productRecord['sku.longDescription']}</p>
			</div>
		</div>
		<div id="pdpDimensionsBlock" class="pdp-block-container accordion" data-module="accordion">
			<h2 class="pdp-block-title"><b><fmt:message key="pdp.dimensions" /></b></h2> 
			<div id="pdpDimensions" class="pdp-block">
				<p>
					<fmt:message key="pdp.bodyDepth" /> ${productRecord['sku.exteriorDepth']} <br>
					<fmt:message key="pdp.bodyHeight" /> ${productRecord['sku.exteriorHeight']} <br>
					<fmt:message key="pdp.bodyWidth" /> ${productRecord['sku.exteriorWidth.prop']} <br> 
					<fmt:message key="pdp.seatDepth" /> ${productRecord['sku.interiorDepth']} <br>
					<fmt:message key="pdp.seatHeight" /> ${productRecord['sku.interiorHeight']} <br>
					<fmt:message key="pdp.seatWidth" /> ${productRecord['sku.interiorWidth']} <br>
				</p>
			</div>
		</div>
		${productRecord['product.promoBlockInfo']} <br />
		
		
	</section>
	<!-- Country = ${dealerCountry}  -->
	<section role="region">	
		<c:choose>
			<c:when test="${dealerCountry eq 'CA'}" >
				<span class="pdp-item-price on-sale">$${productRecord['P_LowestPriceCA']}</span> 
				<span class="pdp-sale-price-label">Now</span> 
				<span class="pdp-sale-price">$${productRecord['P_LowestSalePriceCA']}</span> 
				<span class="pdp-currency">${currencyCode}</span> 
				<div>
					<a href="#"><span class="pdp-charges-tooltip"><fmt:message key="pdp.delCharges" /></span></a>
					<a  title="<fmt:message key="cart.depBalanceInfo" />" class="tooltipster" data-tip="Delivery Charges" href="#">
						<div title="" class="tooltip-img"></div>
					</a>
				</div>			
			</c:when>
			<c:when test="${not empty productRecord['P_LowestSalePrice']}">
				<span class="pdp-item-price on-sale">$${productRecord['P_LowestPrice']}</span> 
				<span class="pdp-sale-price-label">Now</span> 
				<span class="pdp-sale-price">$${productRecord['P_LowestSalePrice']}</span> 
				<span class="pdp-currency">${currencyCode}</span> 
				<div>
					<a href="#"><span class="pdp-charges-tooltip"><fmt:message key="pdp.delCharges" /></span></a>
					<a  title="<fmt:message key="cart.depBalanceInfo" />" class="tooltipster" data-tip="Delivery Charges" href="#">
						<div title="" class="tooltip-img"></div>
					</a>
				</div>
			</c:when>
			<c:otherwise>
				<span class="pdp-sale-price">$1233.00${productRecord['P_LowestPrice']}</span>
				<span class="pdp-currency">${currencyCode}</span> 
				<div>
					<a href="#"><span class="pdp-charges-tooltip"><fmt:message key="pdp.delCharges" /></span></a>
					<a  title="<fmt:message key="cart.depBalanceInfo" />" class="tooltipster" data-tip="Delivery Charges" href="#">
						<div title="" class="tooltip-img"></div>
					</a>
				</div>
			</c:otherwise>
		</c:choose> 
		<span class="pdp-description-link">${productRecord['product.description']}Nothing makes relaxing more uplifting than Pinnacle's...</span>
		<a href="#pdpDescriptionBlock"><fmt:message key="pdp.seeDescription" /></a>
		
		<div class="add-to-cart">
			<form action="" data-module="cbox" data-transition="elastic" data-speed="350" data-initial-height="540">
			     <label for="qty">QTY</label>
			     <input type="text" value="1" name="qty" id="qty" />
			     <a href="/modals/pdp-modal.html" class="btn-primary modal">Add to Cart</a>
			</form>
			<%-- JIRA DMI-1763 Hide Wishlist UI
			<p class="add-to-wishlist"><img src="/img/heart.png" /> Add to Wishlist</p>
			--%>
			<div class="share-icons">
			     <ul>
			         <li><a href="#"><img src="/img/icon-share-pint.png" alt="Pinterest icon" /></a></li>
			         <li><a href=""><img src="/img/icon-share-print-pdp.png" alt="Print page" title=""/></a></li>
			         <li><img src="/img/icon-share-all-pdp.png" alt="Share icon" title=""/></li>
			     </ul>
			</div>
        </div>

		<b><fmt:message key="pdp.selectedSku" /></b>&lt;selected sku details&gt;<br />

		<div data-module="tabs">
			<div>
				<ul class="tabs">
					<li data-rel="pdpCoverSelection" class="active">
						<fmt:message key="pdp.coverSelection" /> 
					</li>
					<li>
						<fmt:message key="pdp.optionsAndUpgrades" />
					</li>
				</ul>
			</div>
			<div id="pdpCoverSelection" class="pdp-block tab-content active">
				<c:if test="${not empty productRecord['sku.cover']}">
					<b>${productRecord['sku.noOfCovers']}</b>
					<fmt:message key="pdp.coversAvailable" />
					<span class="right"> 
						<input type="checkbox" value="false"><fmt:message key="pdp.showFavouriteCovers" /></input>
					</span>
					<br />
					<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
						<dsp:param name="skuCoverList" value="${productRecord['sku.cover'] }" />
						<dsp:oparam name="output">
							<dsp:getvalueof param="coverType" var="coverType" />
							<dsp:getvalueof param="coverColor" var="coverColor" />
							<dsp:getvalueof param="coverPattern" var="coverPattern" />
							<select name="coverType">
								<option value="coverType"><fmt:message key="pdp.coverType" /></option>
								<c:forEach items="${coverType}" var="type">
									<option value="${type }">${type }</option>
								</c:forEach>
							</select>
							<select name="color">
								<option value="color"><fmt:message key="pdp.color" /></option>
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
							<input type="text" value="Search cover SKU" name="searchCover" />
							<dsp:getvalueof param="coverOptionList" var="coverOptionList" />
							<table>
								<c:forEach items="${coverOptionList}" var="priceGrade">
									<tr>
										<td>${priceGrade.key}</td>
										<td>
											<c:forEach var="colorSwatch" items="${priceGrade.value}">
												<a href="${colorSwatch[0]}">${colorSwatch[1]}</a>
											</c:forEach>
										</td>
									</tr>
								</c:forEach>
							</table>
						</dsp:oparam>
						<dsp:oparam name="empty">
							Empty
						</dsp:oparam>
					</dsp:droplet>
				</c:if>
				<ul>
					<c:forEach items="${fn:split(productRecord['sku.configurableOptionNames'],'|')}" var="parentOptionName">
						<c:if test="${parentOptionName ne 'cover'}">
							<c:set var="option" value="${productRecord[parentOptionName]}" />
							<li>
								${parentOptionName}
								<ul>
									<c:forEach items="${fn:split(option,'+')}" var="subOption">
										<li>
											<c:out value="${fn:split(subOption,'=')[0] }" /> 
											<c:forEach var="optionVal" items="${fn:split(fn:split(subOption,'=')[1],'|') }">
												<c:choose>
													<c:when test="${not empty fn:split(optionVal,'~')[3]}">
														<c:set var="optionCoverName" value="${fn:split(optionVal,'~')[3]}" />
														<ul>
															<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
																<dsp:param name="skuCoverList" value="${productRecord[optionCoverName]}" />
																<dsp:param name="optionCovers" value="true" />
																<dsp:oparam name="output">
																	<dsp:getvalueof param="coverColor" var="coverColor" />
																	<dsp:getvalueof param="coverPattern" var="coverPattern" />
																	<select name="color">
																		<option value="color">
																			<fmt:message key="pdp.color" />
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
																	<dsp:getvalueof param="coverOptionList" var="coverOptionList" />
																	<c:forEach items="${fn:split(productRecord[optionCoverName],'|')}" var="optionCover">
																		<li>
																			<a href="${fn:split(optionCover,'~')[0]}">
																				${fn:split(optionCover,'~')[1]}
																			</a>
																		</li>
																	</c:forEach>
																</dsp:oparam>
																<dsp:oparam name="empty">
																	Empty
																</dsp:oparam>
															</dsp:droplet>
														</ul>
													</c:when>
													<c:otherwise>
														<a href="${fn:split(optionVal,'~')[0]}">${fn:split(optionVal,'~')[1]}</a>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</li>
									</c:forEach>
								</ul>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			<div>
				
			</div>
		</div>

	</section>
	
	<div id="pdpAdditionalInfoBlock" class="pdp-block-container clear accordion" data-module="accordion">
		<h2 class="pdp-block-title"><b><fmt:message key="pdp.additionalInfo" /></b></h2>
		<div id="pdpAdditionalInfo" class="pdp-block">
			<p>${productRecord['product.additionalInfo']}</p>
		</div>		
	</div>
	
	<div class="pdpReviewBlock pdp-block-container accordion" data-module="accordion">
		<h2 class="pdp-block-title"><b><fmt:message key="pdp.productReviews" /></b></h2>
		<div class="pdp-block" id="productReviews">
			<dsp:include src="${pageContext.request.contextPath}/global/pdp/_bv_showReviews.jsp">
				<dsp:param name="productId" value="${productRecord['product.repositoryId'] }" />
			</dsp:include>
		</div>
	</div>

</dsp:page>