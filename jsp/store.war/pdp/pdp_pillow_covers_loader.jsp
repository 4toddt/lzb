<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<dsp:importbean bean="/atg/store/LZBStoreConfiguration" var="storeConfig"/>
<dsp:getvalueof var="swatchSet" param="swatchSet" />
<dsp:getvalueof param="optionCoverItems" var="optionCoverItems"/>
<dsp:getvalueof param="isProductCoverAvailabe" var="isProductCoverAvailabe" />
<c:set var="contentHostName" value="//content.la-z-boy.com"/>
				<c:if test="${not empty optionCoverItems}">
					<dsp:droplet name="/com/lzb/droplet/LZBSKUOptionSeparator">
						<dsp:param name="skuOptionCover" value="${optionCoverItems}" />
						<dsp:param name="optionCovers" value="true" />
						<dsp:oparam name="output">
							<dsp:getvalueof param="coverColor" var="coverColor" />
							<dsp:getvalueof param="coverPattern" var="coverPattern" />
							<dsp:getvalueof param="coverOptionList" var="coverOptionListMaps" />
							<c:forEach items="${coverOptionListMaps}" var="firstCoverOptionListMap" varStatus="metaCount">
								<c:set var="numberOfCover" value="${fn:length(firstCoverOptionListMap.value)}" />
							</c:forEach>
							<div class="custom-swatch-options option-cover-items-div" data-optionname="">
								<div class="instructions">
									<p>Select a contrasting fabric below</p>
								</div>
								<c:if test="${ not empty numberOfCover}">
									<p>${numberOfCover}&nbsp;${configOptionName}&nbsp;available</p>
								</c:if>
								<form action="#">
									<select name="color">
										<option value="color"><fmt:message key="pdp.color" /></option>
										<c:forEach items="${coverColor }" var="color">
											<option value="${color }">${color }</option>
										</c:forEach>
									</select> <select name="pattern">
										<option value="pattern"><fmt:message key="pdp.pattern" /></option>
										<c:forEach items="${coverPattern }" var="pattern">
											<option value="${pattern}">${pattern }</option>
										</c:forEach>
									</select>
								</form>
								<div class="swatch-options custom">
									<div class="wrapper2 color-swatch-option-div">
										<c:forEach items="${coverOptionListMaps}" var="coverOptionListMap" varStatus="metaCount">
											<c:forEach items="${coverOptionListMap.value}" var="optionCover" varStatus="i">
												<dsp:param name="swatchIndex" param="count" />
												<c:if test="${i.index eq 0 }">
													<section class="swatches options" style="width: 400px; height: 500px; margin-left:30px;">
												</c:if>
												
												<c:set var="fnSplit" value="${fn:split(optionCover,'~')[0]}" />
												<c:set var="baseChecked" value="" />
												<c:if test="${isProductCoverAvailabe eq false && i.index eq 0}">
													<c:set var="baseChecked" value="checked" />
												</c:if>
												<div style="width: 100px; float: left;">
													<input type="radio" class="option-pillow-swatch-radio" data-type="optionCover" name="pillow-swatch-${swatchSet}" data-value="${fn:split(optionCover,'~')[0]}" value="${fn:split(optionCover,'~')[0]}" ${baseChecked}> 
													<label>
														<img class="swatch-image" src="${contentHostName}${storeConfig.coverThumbnailBaseUrl }${fn:split(optionCover,'~')[0]}.jpg"
															height="50" width="50" alt="${fn:split(optionCover,'~')[2]}" />
													</label>
												</div>

												<c:if test="${i.index ne 0 and (i.index%30 eq 0 )}">
													</section>
													<section class="swatches options" style="width: 400px; height: 500px; margin-left:30px;">
												</c:if>
											</c:forEach>
											</section>
										</c:forEach>
									</div><%-- .wrapper --%>
								</div><%-- .swatch-options custom --%>
							</div><%-- .custom-swatch-options --%>
						</dsp:oparam>
						<dsp:oparam name="empty">
							Empty
						</dsp:oparam>
					</dsp:droplet>
				</c:if>